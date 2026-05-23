import '../../core/utils/result.dart';
import '../models/habit.dart';

abstract interface class HabitRepository {
  Future<Result<List<Habit>>> listForUser(String userId, {bool includeArchived = false});
  Future<Result<Habit>> getById(String id);
  Future<Result<Habit>> create(Habit habit);
  Future<Result<Habit>> update(Habit habit);
  Future<Result<void>> delete(String id);
  Future<Result<Habit>> archive(String id);
  Future<Result<Habit>> unarchive(String id);
}
