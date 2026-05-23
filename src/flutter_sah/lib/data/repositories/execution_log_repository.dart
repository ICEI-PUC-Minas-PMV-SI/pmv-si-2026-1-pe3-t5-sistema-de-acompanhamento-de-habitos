import '../../core/utils/result.dart';
import '../models/execution_log.dart';

abstract interface class ExecutionLogRepository {
  Future<Result<List<ExecutionLog>>> listForHabit(
    String habitId, {
    DateTime? from,
    DateTime? to,
  });

  Future<Result<List<ExecutionLog>>> listForUserOnDate(
    String userId,
    DateTime date,
  );

  Future<Result<ExecutionLog>> create(
    String habitId,
    DateTime when, {
    bool frozen = false,
    String? nota,
  });

  Future<Result<ExecutionLog>> upsertNoteForDate(
    String habitId,
    DateTime date,
    String? nota,
  );

  Future<Result<void>> deleteForHabitOnDate(String habitId, DateTime date);

  Future<Result<void>> deleteAllForHabit(String habitId);
}
