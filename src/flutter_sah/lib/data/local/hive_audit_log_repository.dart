import 'dart:convert';
import 'package:hive/hive.dart';
import '../../core/utils/result.dart';
import '../models/audit_log.dart';
import '../repositories/audit_log_repository.dart';
import 'hive_keys.dart';

class HiveAuditLogRepository implements AuditLogRepository {
  Box<String> get _box => Hive.box<String>(HiveBoxes.auditLogs);

  @override
  Future<Result<List<AuditLog>>> list({
    DateTime? from,
    DateTime? to,
    AuditEventType? eventType,
    String? userId,
    int limit = 50,
    int offset = 0,
  }) async {
    var logs = _box.values
        .map((j) => AuditLog.fromJson(jsonDecode(j) as Map<String, dynamic>))
        .toList();

    if (from != null) logs = logs.where((l) => !l.data.isBefore(from)).toList();
    if (to != null) logs = logs.where((l) => !l.data.isAfter(to)).toList();
    if (eventType != null) logs = logs.where((l) => l.tipoEvento == eventType).toList();
    if (userId != null) logs = logs.where((l) => l.userId == userId).toList();

    logs.sort((a, b) => b.data.compareTo(a.data));
    return Success(logs.skip(offset).take(limit).toList());
  }
}
