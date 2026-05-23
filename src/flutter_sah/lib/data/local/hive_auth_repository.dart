import 'dart:convert';

import 'package:hive/hive.dart';

import '../../core/utils/result.dart';
import '../http/mailtrap_client.dart';
import '../models/audit_log.dart';
import '../models/user.dart';
import '../notifications/notification_service.dart';
import '../repositories/auth_repository.dart';
import '../repositories/category_repository.dart';
import '../repositories/execution_log_repository.dart';
import '../repositories/habit_repository.dart';
import '../repositories/user_repository.dart';
import 'audit_logger.dart';
import 'hive_keys.dart';
import 'login_attempt_store.dart';
import 'mailtrap_config_store.dart';
import 'password_hasher.dart';
import 'password_reset_token_store.dart';

// credentials box: email → { 'user_id': String, 'hash': String }

class HiveAuthRepository implements AuthRepository {
  final UserRepository _userRepo;
  final HabitRepository _habitRepo;
  final CategoryRepository _catRepo;
  final ExecutionLogRepository _execLogRepo;
  final NotificationService _notifications;
  final MailtrapConfigStore _mailtrapStore;
  final MailtrapClient _mailtrapClient;
  final PasswordResetTokenStore _tokenStore;
  final LoginAttemptStore _loginAttempts;

  HiveAuthRepository({
    required UserRepository userRepo,
    required HabitRepository habitRepo,
    required CategoryRepository catRepo,
    required ExecutionLogRepository execLogRepo,
    required NotificationService notifications,
    required MailtrapConfigStore mailtrapStore,
    required MailtrapClient mailtrapClient,
    required PasswordResetTokenStore tokenStore,
    required LoginAttemptStore loginAttempts,
  })  : _userRepo = userRepo,
        _habitRepo = habitRepo,
        _catRepo = catRepo,
        _execLogRepo = execLogRepo,
        _notifications = notifications,
        _mailtrapStore = mailtrapStore,
        _mailtrapClient = mailtrapClient,
        _tokenStore = tokenStore,
        _loginAttempts = loginAttempts;

  Box<String> get _users => Hive.box<String>(HiveBoxes.users);
  Box<String> get _credentials => Hive.box<String>(HiveBoxes.credentials);
  Box<String> get _session => Hive.box<String>(HiveBoxes.session);

  @override
  Future<Result<User>> login(String email, String password) async {
    final key = email.trim().toLowerCase();

    // Rate limit: bloqueio temporário após N tentativas
    final remainingLock = _loginAttempts.remainingLock(key);
    if (remainingLock != null) {
      final minutes = remainingLock.inMinutes + 1;
      return Failure(
        'Conta temporariamente bloqueada. Tente novamente em $minutes minuto${minutes == 1 ? '' : 's'}.',
      );
    }

    final credRaw = _credentials.get(key);
    if (credRaw == null) {
      await _loginAttempts.registerFailure(key);
      return const Failure('E-mail ou senha incorretos.');
    }
    final cred = jsonDecode(credRaw) as Map<String, dynamic>;
    final storedHash = cred['hash'] as String;
    if (!PasswordHasher.verify(password, storedHash)) {
      await _loginAttempts.registerFailure(key);
      return const Failure('E-mail ou senha incorretos.');
    }

    final userId = cred['user_id'] as String;
    final raw = _users.get(userId);
    if (raw == null) return const Failure('Usuário não encontrado.');
    final user = User.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    if (user.isBlocked) {
      return const Failure('Sua conta está bloqueada. Entre em contato com o administrador.');
    }

    // Migração silenciosa: se a senha estava em SHA-256 legado, rehasher para bcrypt
    if (PasswordHasher.needsRehash(storedHash)) {
      cred['hash'] = PasswordHasher.hash(password);
      await _credentials.put(key, jsonEncode(cred));
    }

    // Login bem-sucedido: zera contador de tentativas
    await _loginAttempts.reset(key);

    await _session.put('user_id', userId);
    await AuditLogger.log(
      tipo: AuditEventType.login,
      evento: 'Login realizado por ${user.nome}',
      userId: user.id,
      userNome: user.nome,
    );
    return Success(user);
  }

  @override
  Future<Result<User>> signup({
    required String nome,
    required String email,
    required String password,
  }) async {
    final key = email.trim().toLowerCase();
    if (_credentials.containsKey(key)) {
      return const Failure('Este e-mail já está em uso.');
    }
    final isAdmin = _users.isEmpty;
    final id = 'u_${DateTime.now().millisecondsSinceEpoch}';
    final user = User(
      id: id,
      nome: nome.trim(),
      email: email.trim(),
      isAdmin: isAdmin,
      createdAt: DateTime.now(),
    );
    await _users.put(id, jsonEncode(user.toJson()));
    await _credentials.put(
      key,
      jsonEncode({'user_id': id, 'hash': PasswordHasher.hash(password)}),
    );
    await _session.put('user_id', id);
    await AuditLogger.log(
      tipo: AuditEventType.cadastro,
      evento: 'Cadastro realizado: ${user.nome} (${user.email})',
      userId: id,
      userNome: user.nome,
    );
    return Success(user);
  }

  @override
  Future<Result<void>> logout() async {
    final userId = _session.get('user_id');
    if (userId != null) {
      final raw = _users.get(userId);
      if (raw != null) {
        final user = User.fromJson(jsonDecode(raw) as Map<String, dynamic>);
        await AuditLogger.log(
          tipo: AuditEventType.logout,
          evento: 'Logout realizado por ${user.nome}',
          userId: userId,
          userNome: user.nome,
        );
      }
    }
    await _session.delete('user_id');
    return const Success(null);
  }

  @override
  Future<Result<User?>> currentUser() async {
    final userId = _session.get('user_id');
    if (userId == null) return const Success(null);
    final raw = _users.get(userId);
    if (raw == null) {
      await _session.delete('user_id');
      return const Success(null);
    }
    return Success(User.fromJson(jsonDecode(raw) as Map<String, dynamic>));
  }

  @override
  Future<Result<void>> changePassword({
    required String userId,
    required String currentPassword,
    required String newPassword,
  }) async {
    final userRes = await _userRepo.getById(userId);
    if (userRes is Failure<User>) return Failure(userRes.message);
    final user = (userRes as Success<User>).value;
    final emailKey = user.email.toLowerCase();
    final credRaw = _credentials.get(emailKey);
    if (credRaw == null) return const Failure('Credenciais não encontradas.');
    final cred = jsonDecode(credRaw) as Map<String, dynamic>;
    if (!PasswordHasher.verify(currentPassword, cred['hash'] as String)) {
      return const Failure('Senha atual incorreta.');
    }
    cred['hash'] = PasswordHasher.hash(newPassword);
    await _credentials.put(emailKey, jsonEncode(cred));
    await AuditLogger.log(
      tipo: AuditEventType.passwordChanged,
      evento: 'Senha alterada pelo próprio usuário',
      userId: userId,
      userNome: user.nome,
    );
    return const Success(null);
  }

  @override
  Future<Result<void>> requestPasswordReset(String email) async {
    final cfg = _mailtrapStore.read();
    if (cfg == null) {
      return const Failure('Integração de e-mail não configurada. Contate um administrador.');
    }
    final emailLc = email.trim().toLowerCase();
    final credRaw = _credentials.get(emailLc);
    if (credRaw == null) return const Success(null); // não revelar enumeração
    final cred = jsonDecode(credRaw) as Map<String, dynamic>;
    final userRes = await _userRepo.getById(cred['user_id'] as String);
    if (userRes is Failure<User>) return const Success(null);
    final user = (userRes as Success<User>).value;
    final token = PasswordResetTokenStore.generate();
    await _tokenStore.save(token, email: emailLc);
    return _mailtrapClient.sendPasswordReset(
      toEmail: user.email,
      toName: user.nome,
      token: token,
      config: cfg,
    );
  }

  @override
  Future<Result<void>> confirmPasswordReset({
    required String token,
    required String newPassword,
  }) async {
    final record = _tokenStore.read(token.trim());
    if (record == null) return const Failure('Código inválido ou já utilizado.');
    if (DateTime.now().isAfter(record.expiresAt)) {
      await _tokenStore.consume(token.trim());
      return const Failure('Código expirado. Solicite um novo.');
    }
    final credRaw = _credentials.get(record.email);
    if (credRaw == null) return const Failure('Conta não encontrada.');
    final cred = jsonDecode(credRaw) as Map<String, dynamic>;
    cred['hash'] = PasswordHasher.hash(newPassword);
    await _credentials.put(record.email, jsonEncode(cred));
    await _tokenStore.consume(token.trim());
    await AuditLogger.log(
      tipo: AuditEventType.passwordReset,
      evento: 'Senha redefinida via reset',
      userId: cred['user_id'] as String,
      userNome: null,
    );
    return const Success(null);
  }

  @override
  Future<Result<void>> deleteAccount({required String userId}) async {
    final userRes = await _userRepo.getById(userId);
    if (userRes is Failure<User>) return Failure(userRes.message);
    final user = (userRes as Success<User>).value;

    if (user.isOwner) {
      return const Failure('O owner do sistema não pode excluir a própria conta.');
    }

    // Log de exclusão precisa sobreviver à cascata — gravar antes de apagar nada.
    await AuditLogger.log(
      tipo: AuditEventType.contaExcluida,
      evento: 'Conta excluída pelo próprio usuário: ${user.nome} (${user.email})',
      userId: userId,
      userNome: user.nome,
    );

    // Hábitos + execution logs + notificações agendadas
    final habitsRes = await _habitRepo.listForUser(userId, includeArchived: true);
    final habits = habitsRes.valueOrNull ?? [];
    for (final h in habits) {
      await _notifications.cancelForHabit(h.id);
      await _execLogRepo.deleteAllForHabit(h.id);
      await _habitRepo.delete(h.id);
    }

    // Categorias custom do usuário (globais não têm userId == userId)
    final catsRes = await _catRepo.listForUser(userId);
    final cats = catsRes.valueOrNull ?? [];
    for (final c in cats) {
      if (c.userId == userId) {
        await _catRepo.delete(c.id, force: true);
      }
    }

    final emailLc = user.email.toLowerCase();
    await _credentials.delete(emailLc);
    await _tokenStore.clearForEmail(emailLc);
    await _userRepo.delete(userId);
    await _session.delete('user_id');

    return const Success(null);
  }
}
