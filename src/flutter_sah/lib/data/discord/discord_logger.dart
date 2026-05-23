import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/audit_log.dart';

/// Envia cada audit log como embed bonito para um webhook do Discord.
///
/// Fire-and-forget: erros (rede, rate limit, webhook indisponível) são
/// silenciados — o log no Hive sempre acontece, independente do Discord.
///
/// A URL é injetada via `--dart-define=SAH_DISCORD_WEBHOOK=https://...`
/// (ou `--dart-define-from-file=.env.json`). Quando vazia, o envio
/// é desligado e nenhum payload é montado. Veja Makefile + README.
class DiscordLogger {
  static const String _webhookUrl =
      String.fromEnvironment('SAH_DISCORD_WEBHOOK');

  /// Throttle 3s por mensagem para evitar flood quando o ErrorReporter
  /// pegar um loop ou erros idênticos em sequência.
  static final Map<String, DateTime> _lastSentAt = {};
  static const _throttleWindow = Duration(seconds: 3);

  static final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    headers: {'Content-Type': 'application/json'},
  ));

  static Future<void> send(AuditLog log) async {
    if (_webhookUrl.isEmpty) return;

    final key = '${log.tipoEvento.name}|${log.evento}';
    final now = DateTime.now();
    final last = _lastSentAt[key];
    if (last != null && now.difference(last) < _throttleWindow) return;
    _lastSentAt[key] = now;
    _evictOldEntries(now);

    try {
      final payload = _buildPayload(log);
      await _dio.post<dynamic>(_webhookUrl, data: payload);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('DiscordLogger: falha no envio — $e');
      }
    }
  }

  /// Mantém o mapa pequeno: descarta entradas com mais de 1 minuto.
  static void _evictOldEntries(DateTime now) {
    if (_lastSentAt.length < 50) return;
    _lastSentAt.removeWhere(
      (_, ts) => now.difference(ts) > const Duration(minutes: 1),
    );
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
