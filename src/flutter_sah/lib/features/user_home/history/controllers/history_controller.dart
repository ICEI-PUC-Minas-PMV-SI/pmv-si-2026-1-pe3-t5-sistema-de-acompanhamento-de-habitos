import 'package:flutter/foundation.dart';
import '../../../../core/utils/result.dart';
import '../../../../data/models/execution_log.dart';
import '../../../../data/models/habit.dart';
import '../../../../data/repositories/execution_log_repository.dart';
import '../../../../data/repositories/habit_repository.dart';
import '../utils/period_streak.dart';

class HistoryController extends ChangeNotifier {
  final HabitRepository _habitRepo;
  final ExecutionLogRepository _execRepo;
  final String userId;

  List<Habit> habits = [];
  String? selectedHabitId;
  int periodDays = 30; // 0 = Tudo
  List<ExecutionLog> logs = [];
  bool loading = false;
  String? error;

  HistoryController(this._habitRepo, this._execRepo, {required this.userId});

  Habit? get selectedHabit =>
      habits.cast<Habit?>().firstWhere((h) => h?.id == selectedHabitId, orElse: () => null);

  DateTime get _from {
    if (periodDays == 0) return DateTime(2000);
    final now = DateTime.now();
    final base = DateTime(now.year, now.month, now.day);
    return base.subtract(Duration(days: periodDays - 1, milliseconds: 1));
  }

  DateTime get _to {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 23, 59, 59, 999)
        .add(const Duration(milliseconds: 1));
  }

  int get checkInCount => logs.length;

  int get scheduledDays {
    final habit = selectedHabit;
    if (habit == null) return 0;
    final freq = habit.frequencia.toSet();
    int count = 0;
    var day = DateTime(_from.year, _from.month, _from.day + 1);
    final last = DateTime(_to.year, _to.month, _to.day);
    while (!day.isAfter(last)) {
      if (freq.contains(day.weekday % 7)) count++;
      day = day.add(const Duration(days: 1));
    }
    return count;
  }

  double get adherence {
    final scheduled = scheduledDays;
    if (scheduled == 0) return 0;
    return (checkInCount / scheduled).clamp(0.0, 1.0);
  }

  int get bestStreak {
    final habit = selectedHabit;
    if (habit == null) return 0;
    final daysWithLog = logs
        .map((l) => DateTime(l.dataHora.year, l.dataHora.month, l.dataHora.day))
        .toSet();
    return bestStreakInPeriod(
      daysWithLog: daysWithLog,
      frequencia: habit.frequencia.toSet(),
      from: _from,
      to: _to,
    );
  }

  // Agrupa logs por dia para a UI de lista
  Map<DateTime, List<ExecutionLog>> get logsByDay {
    final map = <DateTime, List<ExecutionLog>>{};
    for (final log in logs) {
      final day = DateTime(log.dataHora.year, log.dataHora.month, log.dataHora.day);
      map.putIfAbsent(day, () => []).add(log);
    }
    final sorted = map.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));
    return Map.fromEntries(sorted);
  }

  Future<void> load() async {
    loading = true;
    error = null;
    notifyListeners();

    final habitsResult = await _habitRepo.listForUser(userId);
    habitsResult.fold(
      onSuccess: (List<Habit> l) => habits = l,
      onFailure: (String msg) => error = msg,
    );

    if (selectedHabitId == null && habits.isNotEmpty) {
      selectedHabitId = habits.first.id;
    }
    if (habits.isEmpty || selectedHabitId == null) {
      logs = [];
      loading = false;
      notifyListeners();
      return;
    }

    await _fetchLogs();
  }

  Future<void> selectHabit(String id) async {
    selectedHabitId = id;
    await _fetchLogs();
  }

  Future<void> selectPeriod(int days) async {
    periodDays = days;
    await _fetchLogs();
  }

  Future<void> _fetchLogs() async {
    if (selectedHabitId == null) return;
    loading = true;
    notifyListeners();

    final result = await _execRepo.listForHabit(
      selectedHabitId!,
      from: _from,
      to: _to,
    );
    result.fold(
      onSuccess: (List<ExecutionLog> l) =>
          logs = l..sort((a, b) => b.dataHora.compareTo(a.dataHora)),
      onFailure: (String msg) {
        error = msg;
        logs = [];
      },
    );

    loading = false;
    notifyListeners();
  }
}
