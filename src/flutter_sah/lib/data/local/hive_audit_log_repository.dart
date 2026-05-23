import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
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
    final logs = <AuditLog>[];
    final corruptedKeys = <dynamic>[];
    for (final key in _box.keys) {
      final raw = _box.get(key);
      if (raw == null) continue;
      try {
        logs.add(AuditLog.fromJson(jsonDecode(raw) as Map<String, dynamic>));
      } catch (e) {
        corruptedKeys.add(key);
        if (kDebugMode) {
          debugPrint('HiveAuditLogRepository: log $key corrompido — $e');
        }
      }
    }

    // Limpeza preguiçosa de entries que não dão para desserializar (legado
    // antes do fix do ErrorReporter). Evita a tela quebrar a cada abertura.
    if (corruptedKeys.isNotEmpty) {
      unawaited(_box.deleteAll(corruptedKeys));
    }

    var filtered = logs;
    if (from != null) {
      filtered = filtered.where((l) => !l.data.isBefore(from)).toList();
    }
    if (to != null) {
      filtered = filtered.where((l) => !l.data.isAfter(to)).toList();
    }
    if (eventType != null) {
      filtered = filtered.where((l) => l.tipoEvento == eventType).toList();
    }
    if (userId != null) {
      filtered = filtered.where((l) => l.userId == userId).toList();
    }

    filtered.sort((a, b) => b.data.compareTo(a.data));
    return Success(filtered.skip(offset).take(limit).toList());
  }
}
