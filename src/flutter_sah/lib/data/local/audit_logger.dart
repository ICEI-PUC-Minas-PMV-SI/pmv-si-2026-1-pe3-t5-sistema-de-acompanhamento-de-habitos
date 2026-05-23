import 'dart:convert';
import 'package:hive/hive.dart';
import '../models/audit_log.dart';
import 'hive_keys.dart';

class AuditLogger {
  static Future<void> log({
    required AuditEventType tipo,
    required String evento,
    String? userId,
    String? userNome,
  }) async {
    final id = 'log_${DateTime.now().microsecondsSinceEpoch}';
    final entry = AuditLog(
      id: id,
      tipoEvento: tipo,
      evento: evento,
      data: DateTime.now(),
      userId: userId,
      userNome: userNome,
    );
    await Hive.box<String>(HiveBoxes.auditLogs).put(id, jsonEncode(entry.toJson()));
  }
}
