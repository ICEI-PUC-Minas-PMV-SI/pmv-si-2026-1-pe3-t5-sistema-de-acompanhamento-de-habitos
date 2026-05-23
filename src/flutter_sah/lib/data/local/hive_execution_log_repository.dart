import 'dart:convert';
import 'package:hive/hive.dart';
import '../../core/utils/result.dart';
import '../models/execution_log.dart';
import '../models/habit.dart';
import '../repositories/execution_log_repository.dart';
import 'hive_keys.dart';

class HiveExecutionLogRepository implements ExecutionLogRepository {
  Box<String> get _box => Hive.box<String>(HiveBoxes.executionLogs);
  Box<String> get _habits => Hive.box<String>(HiveBoxes.habits);

  List<ExecutionLog> get _all => _box.values
      .map((j) => ExecutionLog.fromJson(jsonDecode(j) as Map<String, dynamic>))
      .toList();

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Future<Result<List<ExecutionLog>>> listForHabit(
    String habitId, {
    DateTime? from,
    DateTime? to,
  }) async {
    final list = _all.where((l) {
      if (l.habitId != habitId) return false;
      if (from != null && l.dataHora.isBefore(from)) return false;
      if (to != null && l.dataHora.isAfter(to)) return false;
      return true;
    }).toList();
    return Success(list);
  }

  @override
  Future<Result<List<ExecutionLog>>> listForUserOnDate(
    String userId,
    DateTime date,
  ) async {
    final userHabitIds = _habits.values
        .map((j) => Habit.fromJson(jsonDecode(j) as Map<String, dynamic>))
        .where((h) => h.userId == userId)
        .map((h) => h.id)
        .toSet();

    final list = _all.where((l) {
      return userHabitIds.contains(l.habitId) && _sameDay(l.dataHora, date);
    }).toList();
    return Success(list);
  }

  @override
  Future<Result<ExecutionLog>> create(String habitId, DateTime when) async {
    // idempotente: retorna existente se já marcado nesse dia
    final existing = _all.where(
      (l) => l.habitId == habitId && _sameDay(l.dataHora, when),
    );
    if (existing.isNotEmpty) return Success(existing.first);

    final id = 'el_${DateTime.now().microsecondsSinceEpoch}';
    final log = ExecutionLog(id: id, habitId: habitId, dataHora: when);
    await _box.put(id, jsonEncode(log.toJson()));
    return Success(log);
  }

  @override
  Future<Result<void>> deleteForHabitOnDate(String habitId, DateTime date) async {
    final toRemove = _all.where(
      (l) => l.habitId == habitId && _sameDay(l.dataHora, date),
    );
    for (final l in toRemove) {
      await _box.delete(l.id);
    }
    return const Success(null);
  }

  @override
  Future<Result<void>> deleteAllForHabit(String habitId) async {
    final toRemove = _all.where((l) => l.habitId == habitId).toList();
    for (final l in toRemove) {
      await _box.delete(l.id);
    }
    return const Success(null);
  }
}
