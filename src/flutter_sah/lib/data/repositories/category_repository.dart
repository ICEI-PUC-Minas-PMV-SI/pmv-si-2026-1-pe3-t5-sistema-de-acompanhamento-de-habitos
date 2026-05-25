import '../../core/utils/result.dart';
import '../models/category.dart';

abstract interface class CategoryRepository {
  Future<Result<List<Category>>> listGlobal();
  Future<Result<List<Category>>> listForUser(String userId);
  Future<Result<int>> countHabitsLinked(String categoryId);
  Future<Result<Category>> create(Category category);
  Future<Result<Category>> update(Category category);
  Future<Result<void>> delete(String id, {bool force = false});
}
