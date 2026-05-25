import '../../../../core/utils/base_list_controller.dart';
import '../../../../core/utils/result.dart';
import '../../../../data/events/categories_bus.dart';
import '../../../../data/models/category.dart';
import '../../../../data/repositories/category_repository.dart';

class UserCategoriesController extends BaseListController<Category> {
  final CategoryRepository _repo;
  final CategoriesBus _bus;
  final String userId;
  Map<String, int> habitCounts = {};

  UserCategoriesController(
    this._repo, {
    required this.userId,
    required CategoriesBus bus,
  }) : _bus = bus {
    load();
  }

  List<Category> get categories => items;

  List<Category> get personal =>
      items.where((c) => !c.isGlobal && c.userId == userId).toList();

  List<Category> get globals => items.where((c) => c.isGlobal).toList();

  @override
  Future<Result<List<Category>>> fetchItems() => _repo.listForUser(userId);

  @override
  Future<void> load() async {
    await super.load();
    final counts = <String, int>{};
    for (final cat in items) {
      final r = await _repo.countHabitsLinked(cat.id);
      counts[cat.id] = r.fold(onSuccess: (n) => n, onFailure: (_) => 0);
    }
    habitCounts = counts;
    notifyListeners();
  }

  Future<bool> create(Category category) async {
    final result = await _repo.create(category);
    return result.fold(
      onSuccess: (_) {
        load();
        _bus.notifyChanged();
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
        _bus.notifyChanged();
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
        _bus.notifyChanged();
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
        _bus.notifyChanged();
        return true;
      },
      onFailure: (_) => false,
    );
  }
}
