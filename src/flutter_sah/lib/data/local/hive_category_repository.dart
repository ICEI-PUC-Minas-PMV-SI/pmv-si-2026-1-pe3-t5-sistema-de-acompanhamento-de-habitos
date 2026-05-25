import 'dart:convert';
import 'package:hive/hive.dart';
import '../../core/utils/result.dart';
import '../models/category.dart';
import '../models/habit.dart';
import '../repositories/category_repository.dart';
import 'hive_keys.dart';

class HiveCategoryRepository implements CategoryRepository {
  Box<String> get _box => Hive.box<String>(HiveBoxes.categories);
  Box<String> get _habits => Hive.box<String>(HiveBoxes.habits);

  List<Category> get _all => _box.values
      .map((j) => Category.fromJson(jsonDecode(j) as Map<String, dynamic>))
      .toList();

  @override
  Future<Result<List<Category>>> listGlobal() async {
    return Success(_all.where((c) => c.isGlobal).toList());
  }

  @override
  Future<Result<List<Category>>> listForUser(String userId) async {
    return Success(_all.where((c) => c.isGlobal || c.userId == userId).toList());
  }

  @override
  Future<Result<int>> countHabitsLinked(String categoryId) async {
    final count = _habits.values
        .map((j) => Habit.fromJson(jsonDecode(j) as Map<String, dynamic>))
        .where((h) => h.categoriaId == categoryId)
        .length;
    return Success(count);
  }

  @override
  Future<Result<Category>> create(Category category) async {
    final id = category.id.isEmpty
        ? 'cat_${DateTime.now().microsecondsSinceEpoch}'
        : category.id;
    final withId = category.copyWith(id: id);
    await _box.put(id, jsonEncode(withId.toJson()));
    return Success(withId);
  }

  @override
  Future<Result<Category>> update(Category category) async {
    if (!_box.containsKey(category.id)) {
      return const Failure('Categoria não encontrada.');
    }
    await _box.put(category.id, jsonEncode(category.toJson()));
    return Success(category);
  }

  @override
  Future<Result<void>> delete(String id, {bool force = false}) async {
    if (!force) {
      final count = (await countHabitsLinked(id)).valueOrNull ?? 0;
      if (count > 0) {
        return Failure('Esta categoria possui $count hábito(s) vinculado(s).');
      }
    }
    await _box.delete(id);
    return const Success(null);
  }
}
