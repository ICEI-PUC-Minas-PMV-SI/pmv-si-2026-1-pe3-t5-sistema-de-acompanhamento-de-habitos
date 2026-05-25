import 'dart:convert';
import 'package:hive/hive.dart';
import '../../core/utils/result.dart';
import '../models/habit.dart';
import '../repositories/habit_repository.dart';
import 'hive_keys.dart';

class HiveHabitRepository implements HabitRepository {
  Box<String> get _box => Hive.box<String>(HiveBoxes.habits);

  List<Habit> get _all => _box.values
      .map((j) => Habit.fromJson(jsonDecode(j) as Map<String, dynamic>))
      .toList();

  @override
  Future<Result<List<Habit>>> listForUser(String userId, {bool includeArchived = false}) async {
    final list = _all.where((h) {
      if (h.userId != userId) return false;
      if (!includeArchived && h.arquivado) return false;
      return true;
    }).toList();
    return Success(list);
  }

  @override
  Future<Result<Habit>> getById(String id) async {
    final raw = _box.get(id);
    if (raw == null) return const Failure('Hábito não encontrado.');
    return Success(Habit.fromJson(jsonDecode(raw) as Map<String, dynamic>));
  }

  @override
  Future<Result<Habit>> create(Habit habit) async {
    final id = habit.id.isEmpty
        ? 'hab_${DateTime.now().microsecondsSinceEpoch}'
        : habit.id;
    final withId = habit.copyWith(id: id);
    await _box.put(id, jsonEncode(withId.toJson()));
    return Success(withId);
  }

  @override
  Future<Result<Habit>> update(Habit habit) async {
    if (!_box.containsKey(habit.id)) return const Failure('Hábito não encontrado.');
    await _box.put(habit.id, jsonEncode(habit.toJson()));
    return Success(habit);
  }

  @override
  Future<Result<void>> delete(String id) async {
    await _box.delete(id);
    return const Success(null);
  }

  @override
  Future<Result<Habit>> archive(String id) async {
    final result = await getById(id);
    if (result is Failure<Habit>) return result;
    final updated = (result as Success<Habit>).value.copyWith(arquivado: true);
    await _box.put(id, jsonEncode(updated.toJson()));
    return Success(updated);
  }

  @override
  Future<Result<Habit>> unarchive(String id) async {
    final result = await getById(id);
    if (result is Failure<Habit>) return result;
    final updated = (result as Success<Habit>).value.copyWith(arquivado: false);
    await _box.put(id, jsonEncode(updated.toJson()));
    return Success(updated);
  }
}
