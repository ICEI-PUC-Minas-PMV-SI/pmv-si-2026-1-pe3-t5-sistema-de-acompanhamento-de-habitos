import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/audit_log.dart';

/// Envia cada audit log como embed bonito para um webhook do Discord.
///
/// Fire-and-forget: erros (rede, rate limit, webhook indisponível) são
/// silenciados — o log no Hive sempre acontece, independente do Discord.
class DiscordLogger {
  static const String _webhookUrl =
      'https://discord.com/api/webhooks/1507775874454392874/WJCkxoGx_tHuRByh8TxWM6nemdbh0mjBfaBJCPz-NK05k_C5p7FHA_ecuYhxIm7enoAf';

  static final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    headers: {'Content-Type': 'application/json'},
  ));

  static Future<void> send(AuditLog log) async {
    try {
      final payload = _buildPayload(log);
      await _dio.post<dynamic>(_webhookUrl, data: payload);
    } catch (e) {
      // Webhook indisponível, sem internet, rate limit, etc. — não propaga.
      if (kDebugMode) {
        debugPrint('DiscordLogger: falha no envio — $e');
      }
    }
  }

  static Map<String, dynamic> _buildPayload(AuditLog log) {
    final type = log.tipoEvento;
    final fields = <Map<String, dynamic>>[];

    final userValue = _userField(log);
    if (userValue != null) {
      fields.add({'name': 'Usuário', 'value': userValue, 'inline': false});
    }
    if (log.route != null && log.route!.isNotEmpty) {
      fields.add({'name': 'Rota', 'value': '`${log.route}`', 'inline': true});
    }
    if (log.ipAddress != null && log.ipAddress!.isNotEmpty) {
      fields.add({'name': 'IP', 'value': '`${log.ipAddress}`', 'inline': true});
    }
    final platform = log.platform;
    if (platform != null && platform.isNotEmpty) {
      fields.add({'name': 'Plataforma', 'value': platform, 'inline': true});
    }
    final metadata = log.metadata;
    if (metadata != null && metadata.isNotEmpty) {
      final lines = metadata.entries
          .map((e) => '• **${e.key}**: ${_truncate(e.value, 200)}')
          .join('\n');
      fields.add({
        'name': 'Metadados',
        'value': _truncate(lines, 1000),
        'inline': false,
      });
    }

    return {
      'username': 'SAH Logger',
      'embeds': [
        {
          'title': _label(type),
          'description': _truncate(log.evento, 2000),
          'color': _color(type),
          'fields': fields.take(25).toList(),
          'timestamp': log.data.toUtc().toIso8601String(),
          'footer': {'text': 'log id: ${log.id}'},
        },
      ],
    };
  }

  static String? _userField(AuditLog log) {
    if (log.userNome == null && log.userEmail == null && log.userId == null) {
      return null;
    }
    final parts = <String>[];
    if (log.userNome != null) parts.add(log.userNome!);
    if (log.userEmail != null) parts.add('`${log.userEmail}`');
    if (log.userId != null) parts.add('_id ${log.userId}_');
    return parts.join(' · ');
  }

  static String _truncate(String s, int max) {
    if (s.length <= max) return s;
    return '${s.substring(0, max - 1)}…';
  }

  static String _label(AuditEventType t) {
    return switch (t) {
      AuditEventType.login => 'Login',
      AuditEventType.logout => 'Logout',
      AuditEventType.cadastro => 'Cadastro',
      AuditEventType.bloqueio => 'Bloqueio',
      AuditEventType.desbloqueio => 'Desbloqueio',
      AuditEventType.erroSistema => 'Erro de sistema',
      AuditEventType.adminAction => 'Ação de admin',
      AuditEventType.profileUpdate => 'Perfil atualizado',
      AuditEventType.passwordChanged => 'Senha alterada',
      AuditEventType.passwordReset => 'Senha redefinida',
      AuditEventType.contaExcluida => 'Conta excluída',
      AuditEventType.dataBackup => 'Backup',
    };
  }

  /// Cor do embed (decimal, ARGB sem alpha). Espelha SahColors.
  static int _color(AuditEventType t) {
    return switch (t) {
      AuditEventType.login || AuditEventType.desbloqueio => 0x4A7C59, // sage
      AuditEventType.logout => 0x6B655D, // muted
      AuditEventType.cadastro => 0x6B5B95, // accent
      AuditEventType.bloqueio ||
      AuditEventType.contaExcluida ||
      AuditEventType.erroSistema => 0xB8544A, // danger
      AuditEventType.adminAction => 0xC89B3C, // streak
      AuditEventType.profileUpdate || AuditEventType.dataBackup => 0x5B7FA8, // info
      AuditEventType.passwordChanged || AuditEventType.passwordReset => 0xC89B3C, // warning
    };
  }
}
