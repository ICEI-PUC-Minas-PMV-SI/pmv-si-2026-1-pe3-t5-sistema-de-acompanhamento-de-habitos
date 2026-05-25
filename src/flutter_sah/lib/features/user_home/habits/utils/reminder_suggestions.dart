import '../../../../data/models/execution_log.dart';

class ReminderSuggestion {
  final String currentReminder; // 'HH:mm'
  final String suggestedReminder; // 'HH:mm'
  final int sampleSize;

  const ReminderSuggestion({
    required this.currentReminder,
    required this.suggestedReminder,
    required this.sampleSize,
  });

  int get diffMinutes {
    final c = _toMinutes(currentReminder);
    final s = _toMinutes(suggestedReminder);
    return (s - c).abs();
  }
}

int _toMinutes(String hhmm) {
  final p = hhmm.split(':');
  return int.parse(p[0]) * 60 + int.parse(p[1]);
}

String _formatHHmm(int totalMinutes) {
  final h = (totalMinutes ~/ 60) % 24;
  final m = totalMinutes % 60;
  return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
}

/// Sugere ajustar o horário do lembrete pra perto da hora média em que o
/// usuário realmente faz check-in. Retorna sugestão apenas se:
/// - há pelo menos 5 check-ins não-frozen
/// - a diferença é >= 30 minutos
/// - o lembrete atual existe
ReminderSuggestion? suggestReminderShift({
  required List<ExecutionLog> recentLogs,
  required List<String> currentReminders,
}) {
  if (currentReminders.isEmpty) return null;
  final nonFrozen = recentLogs.where((l) => !l.frozen).toList();
  if (nonFrozen.length < 5) return null;

  // Hora média (em minutos do dia) dos check-ins
  final minutes = nonFrozen
      .map((l) => l.dataHora.hour * 60 + l.dataHora.minute)
      .toList();
  final avg = minutes.reduce((a, b) => a + b) ~/ minutes.length;

  // Para cada lembrete existente, calcular distância e pegar o mais próximo
  String? closest;
  int closestDiff = 9999;
  for (final r in currentReminders) {
    final diff = (_toMinutes(r) - avg).abs();
    if (diff < closestDiff) {
      closestDiff = diff;
      closest = r;
    }
  }
  if (closest == null) return null;

  // Só sugere se diferença for >= 30 min
  if (closestDiff < 30) return null;

  return ReminderSuggestion(
    currentReminder: closest,
    suggestedReminder: _formatHHmm(avg),
    sampleSize: nonFrozen.length,
  );
}
