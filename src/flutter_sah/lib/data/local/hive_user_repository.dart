import 'dart:convert';
import 'package:hive/hive.dart';
import '../../core/utils/result.dart';
import '../models/audit_log.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';
import 'audit_logger.dart';
import 'hive_keys.dart';

class HiveUserRepository implements UserRepository {
  Box<String> get _box => Hive.box<String>(HiveBoxes.users);

  List<User> get _all => _box.values
      .map((j) => User.fromJson(jsonDecode(j) as Map<String, dynamic>))
      .toList();

  @override
  Future<Result<List<User>>> list({String? query, UserStatusFilter? status}) async {
    var list = _all;
    if (query != null && query.isNotEmpty) {
      final q = query.toLowerCase();
      list = list.where((u) => u.nome.toLowerCase().contains(q) || u.email.toLowerCase().contains(q)).toList();
    }
    if (status != null) {
      list = switch (status) {
        UserStatusFilter.active => list.where((u) => !u.isBlocked).toList(),
        UserStatusFilter.blocked => list.where((u) => u.isBlocked).toList(),
        UserStatusFilter.all => list,
      };
    }
    return Success(list);
  }

  @override
  Future<Result<User>> getById(String id) async {
    final raw = _box.get(id);
    if (raw == null) return const Failure('Usuário não encontrado.');
    return Success(User.fromJson(jsonDecode(raw) as Map<String, dynamic>));
  }

  @override
  Future<Result<User>> block(String id, {required String motivo}) async {
    final result = await getById(id);
    if (result is Failure<User>) return result;
    final user = (result as Success<User>).value;
    final updated = user.copyWith(isBlocked: true);
    await _box.put(id, jsonEncode(updated.toJson()));
    await AuditLogger.log(
      tipo: AuditEventType.bloqueio,
      evento: 'Usuário bloqueado: ${user.nome} — $motivo',
      userId: id,
      userNome: user.nome,
    );
    return Success(updated);
  }

  @override
  Future<Result<User>> unblock(String id) async {
    final result = await getById(id);
    if (result is Failure<User>) return result;
    final user = (result as Success<User>).value;
    final updated = user.copyWith(isBlocked: false);
    await _box.put(id, jsonEncode(updated.toJson()));
    await AuditLogger.log(
      tipo: AuditEventType.desbloqueio,
      evento: 'Usuário desbloqueado: ${user.nome}',
      userId: id,
      userNome: user.nome,
    );
    return Success(updated);
  }

  @override
  Future<Result<User>> setAdmin(String id, {required bool isAdmin}) async {
    final result = await getById(id);
    if (result is Failure<User>) return result;
    final user = (result as Success<User>).value;
    if (!isAdmin && user.isOwner) {
      return const Failure('O owner do sistema não pode ser rebaixado.');
    }
    final updated = user.copyWith(isAdmin: isAdmin);
    await _box.put(id, jsonEncode(updated.toJson()));
    final acao = isAdmin ? 'Promovido a admin' : 'Privilégio admin removido';
    await AuditLogger.log(
      tipo: AuditEventType.adminAction,
      evento: '$acao: ${user.nome}',
      userId: id,
      userNome: user.nome,
    );
    return Success(updated);
  }

  @override
  Future<Result<void>> delete(String id) async {
    await _box.delete(id);
    return const Success(null);
  }

  @override
  Future<Result<User>> updateProfile(String id, {required String nome}) async {
    final result = await getById(id);
    if (result is Failure<User>) return result;
    final user = (result as Success<User>).value;
    final updated = user.copyWith(nome: nome.trim());
    await _box.put(id, jsonEncode(updated.toJson()));
    await AuditLogger.log(
      tipo: AuditEventType.profileUpdate,
      evento: 'Nome atualizado: ${updated.nome}',
      userId: id,
      userNome: updated.nome,
    );
    return Success(updated);
  }
}
