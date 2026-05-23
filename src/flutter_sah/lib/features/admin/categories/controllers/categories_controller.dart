import '../../../../core/utils/base_list_controller.dart';
import '../../../../core/utils/result.dart';
import '../../../../data/models/category.dart';
import '../../../../data/repositories/category_repository.dart';

class CategoriesController extends BaseListController<Category> {
  final CategoryRepository _repo;
  Map<String, int> habitCounts = {};

  CategoriesController(this._repo) {
    load();
  }

  List<Category> get categories => items;

  @override
  Future<Result<List<Category>>> fetchItems() => _repo.listGlobal();

  @override
  Future<void> load() async {
    await super.load();
    final counts = <String, int>{};
    for (final cat in items) {
      final result = await _repo.countHabitsLinked(cat.id);
      counts[cat.id] = result.fold(onSuccess: (n) => n, onFailure: (_) => 0);
    }
    habitCounts = counts;
    notifyListeners();
  }

  Future<bool> create(Category category) async {
    final result = await _repo.create(category);
    return result.fold(
      onSuccess: (_) {
        load();
        return true;
      },
      onFailure: (_) => false,
    );
  }

  Future<bool> update(Category category) async {
    final result = await _repo.update(category);
    return result.fold(
      onSuccess: (_) {
        load();
        return true;
      },
      onFailure: (_) => false,
    );
  }

  Future<({bool ok, bool hasLinked, String? error})> delete(String id) async {
    final countResult = await _repo.countHabitsLinked(id);
    final count = countResult.fold(onSuccess: (n) => n, onFailure: (_) => 0);

    if (count > 0) {
      return (ok: false, hasLinked: true, error: null);
    }

    final result = await _repo.delete(id);
    return result.fold(
      onSuccess: (_) {
        load();
        return (ok: true, hasLinked: false, error: null);
      },
      onFailure: (msg) => (ok: false, hasLinked: false, error: msg),
    );
  }

  Future<bool> forceDelete(String id) async {
    final result = await _repo.delete(id, force: true);
    return result.fold(
      onSuccess: (_) {
        load();
        return true;
      },
      onFailure: (_) => false,
    );
  }
}
