import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../../data/local/hive_keys.dart';
import '../../data/models/audit_log.dart';
import '../design_system/tokens/sah_colors.dart';

/// Reporta erros não tratados:
/// - persiste em `auditLogs` (AuditEventType.erroSistema)
/// - mostra snackbar via `messengerKey` se houver um Scaffold montado
///
/// Singleton para que `FlutterError.onError` (que é uma função global) consiga
/// alcançar o estado da aplicação.
class ErrorReporter {
  ErrorReporter._();
  static final instance = ErrorReporter._();

  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  /// Throttling: se o mesmo erro for relatado N vezes em sequência, mostra
  /// snackbar só uma vez para não inundar o usuário.
  String? _lastMessage;
  DateTime? _lastShownAt;

  /// Registra handlers globais. Chamado uma vez em `main()` antes de runApp.
  void install() {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      report(
        details.exceptionAsString(),
        details.stack,
        userVisible: true,
      );
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      report(error.toString(), stack, userVisible: true);
      return true;
    };
  }

  /// Reporta um erro: loga e (opcionalmente) mostra snackbar.
  Future<void> report(
    String message,
    StackTrace? stack, {
    bool userVisible = false,
  }) async {
    debugPrint('[ErrorReporter] $message\n$stack');

    // Persiste no audit log se o Hive estiver pronto
    try {
      if (Hive.isBoxOpen(HiveBoxes.auditLogs)) {
        final id = 'err_${DateTime.now().microsecondsSinceEpoch}';
        final firstLine = message.split('\n').first;
        final stackPreview = stack == null
            ? ''
            : stack.toString().split('\n').take(5).join(' · ');
        final box = Hive.box<String>(HiveBoxes.auditLogs);
        final entry = AuditLog(
          id: id,
          tipoEvento: AuditEventType.erroSistema,
          evento: stackPreview.isEmpty
              ? 'Erro: $firstLine'
              : 'Erro: $firstLine — $stackPreview',
          data: DateTime.now(),
        );
        await box.put(id, jsonEncode(entry.toJson()));
      }
    } catch (_) {
      // Reporting não pode falhar; ignorar
    }

    if (userVisible) _showSnackbar(message);
  }

  void _showSnackbar(String message) {
    final messenger = messengerKey.currentState;
    if (messenger == null) return;

    // Throttling 3s para erro idêntico
    final now = DateTime.now();
    if (_lastMessage == message &&
        _lastShownAt != null &&
        now.difference(_lastShownAt!) < const Duration(seconds: 3)) {
      return;
    }
    _lastMessage = message;
    _lastShownAt = now;

    final friendly = _friendlyMessage(message);
    messenger.showSnackBar(SnackBar(
      content: Text(
        friendly,
        style: GoogleFonts.interTight(fontSize: 14),
      ),
      backgroundColor: SahColors.danger,
      duration: const Duration(seconds: 4),
    ));
  }

  String _friendlyMessage(String raw) {
    // Mostra só a primeira linha; evita stack traces gigantes.
    final firstLine = raw.split('\n').first;
    if (firstLine.length > 120) {
      return 'Algo deu errado. Por favor, tente novamente.';
    }
    return firstLine;
  }

}
