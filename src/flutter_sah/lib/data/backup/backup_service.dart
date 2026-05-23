import 'dart:convert';
import '../../core/utils/result.dart';
import '../local/audit_logger.dart';
import '../models/audit_log.dart';
import '../models/category.dart';
import '../models/execution_log.dart';
import '../models/habit.dart';
import '../models/user.dart';
import '../notifications/notification_service.dart';
import '../repositories/category_repository.dart';
import '../repositories/execution_log_repository.dart';
import '../repositories/habit_repository.dart';
import '../repositories/user_repository.dart';

const _kSchemaVersion = 1;

class BackupService {
  final UserRepository _userRepo;
  final HabitRepository _habitRepo;
  final CategoryRepository _catRepo;
  final ExecutionLogRepository _execLogRepo;
  final NotificationService _notifications;

  BackupService({
    required UserRepository userRepo,
    required HabitRepository habitRepo,
    required CategoryRepository catRepo,
    required ExecutionLogRepository execLogRepo,
    required NotificationService notifications,
  })  : _userRepo = userRepo,
        _habitRepo = habitRepo,
        _catRepo = catRepo,
        _execLogRepo = execLogRepo,
        _notifications = notifications;

  Future<Result<String>> export({required String userId}) async {
    final userRes = await _userRepo.getById(userId);
    if (userRes is Failure<User>) return Failure(userRes.message);
    final user = (userRes as Success<User>).value;

    final habitsRes = await _habitRepo.listForUser(userId, includeArchived: true);
    final habits = habitsRes.valueOrNull ?? [];

    final catsRes = await _catRepo.listForUser(userId);
    final cats = (catsRes.valueOrNull ?? [])
        .where((c) => c.userId == userId)
        .toList();

    final logs = <ExecutionLog>[];
    for (final h in habits) {
      final r = await _execLogRepo.listForHabit(h.id);
      logs.addAll(r.valueOrNull ?? []);
    }

    final payload = {
      'version': _kSchemaVersion,
      'exported_at': DateTime.now().toIso8601String(),
      'user': user.toJson(),
      'habits': habits.map((h) => h.toJson()).toList(),
      'categories': cats.map((c) => c.toJson()).toList(),
      'execution_logs': logs.map((l) => l.toJson()).toList(),
    };

    await AuditLogger.log(
      tipo: AuditEventType.dataBackup,
      evento: 'Backup exportado: ${habits.length} hábitos, ${logs.length} registros',
      userId: userId,
      userNome: user.nome,
    );

    return Success(const JsonEncoder.withIndent('  ').convert(payload));
  }

  Future<Result<void>> import({required String userId, required String json}) async {
    final Map<String, dynamic> parsed;
    try {
      parsed = jsonDecode(json) as Map<String, dynamic>;
    } catch (_) {
      return const Failure('Backup inválido: não é um JSON válido.');
    }

    final version = parsed['version'];
    if (version != _kSchemaVersion) {
      return Failure('Backup inválido: versão $version não suportada (esperada $_kSchemaVersion).');
    }

    final habitsJson = parsed['habits'];
    final catsJson = parsed['categories'];
    final logsJson = parsed['execution_logs'];
    if (habitsJson is! List || catsJson is! List || logsJson is! List) {
      return const Failure('Backup inválido: estrutura inesperada.');
    }

    final List<Habit> habits;
    final List<Category> cats;
    final List<ExecutionLog> logs;
    try {
      habits = habitsJson
          .map((j) => Habit.fromJson(j as Map<String, dynamic>))
          .toList();
      cats = catsJson
          .map((j) => Category.fromJson(j as Map<String, dynamic>))
          .toList();
      logs = logsJson
          .map((j) => ExecutionLog.fromJson(j as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return Failure('Backup inválido: erro ao ler entidades ($e).');
    }

    // Apaga dados atuais do usuário antes de popular
    final currentHabitsRes = await _habitRepo.listForUser(userId, includeArchived: true);
    final currentHabits = currentHabitsRes.valueOrNull ?? [];
    for (final h in currentHabits) {
      await _notifications.cancelForHabit(h.id);
      await _execLogRepo.deleteAllForHabit(h.id);
      await _habitRepo.delete(h.id);
    }
    final currentCatsRes = await _catRepo.listForUser(userId);
    final currentCats = (currentCatsRes.valueOrNull ?? [])
        .where((c) => c.userId == userId)
        .toList();
    for (final c in currentCats) {
      await _catRepo.delete(c.id, force: true);
    }

    // Reescreve categorias custom do user (force userId atual para evitar import cross-user)
    for (final c in cats) {
      await _catRepo.create(c.copyWith(userId: userId));
    }

    // Reescreve hábitos (force userId)
    for (final h in habits) {
      final created = await _habitRepo.create(h.copyWith(userId: userId, id: ''));
      final newHabit = created.valueOrNull;
      if (newHabit == null) continue;

      // Reagenda notificações
      await _notifications.scheduleForHabit(newHabit);

      // Importa logs do hábito antigo (mapeando para novo id)
      final oldId = h.id;
      for (final l in logs.where((x) => x.habitId == oldId)) {
        await _execLogRepo.create(newHabit.id, l.dataHora);
      }
    }

    final userRes = await _userRepo.getById(userId);
    final userNome = userRes.valueOrNull?.nome;
    await AuditLogger.log(
      tipo: AuditEventType.dataBackup,
      evento: 'Backup importado: ${habits.length} hábitos, ${logs.length} registros',
      userId: userId,
      userNome: userNome,
    );

    return const Success(null);
  }
}
