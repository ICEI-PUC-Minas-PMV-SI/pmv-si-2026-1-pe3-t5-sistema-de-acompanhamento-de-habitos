import 'dart:async';
import 'dart:convert';

import 'package:hive/hive.dart';

import '../discord/discord_logger.dart';
import '../models/audit_log.dart';
import 'audit_context.dart';
import 'hive_keys.dart';

class AuditLogger {
  static Future<void> log({
    required AuditEventType tipo,
    required String evento,
    String? userId,
    String? userNome,
    String? userEmail,
    Map<String, String>? metadata,
  }) async {
    final id = 'log_${DateTime.now().microsecondsSinceEpoch}';
    final entry = AuditLog(
      id: id,
      tipoEvento: tipo,
      evento: evento,
      data: DateTime.now(),
      userId: userId,
      userNome: userNome,
      userEmail: userEmail,
      route: AuditContext.currentRoute,
      ipAddress: AuditContext.ipAddress,
      platform: AuditContext.platform,
      metadata: metadata,
    );
    await Hive.box<String>(HiveBoxes.auditLogs).put(id, jsonEncode(entry.toJson()));
    unawaited(DiscordLogger.send(entry));
  }
}
