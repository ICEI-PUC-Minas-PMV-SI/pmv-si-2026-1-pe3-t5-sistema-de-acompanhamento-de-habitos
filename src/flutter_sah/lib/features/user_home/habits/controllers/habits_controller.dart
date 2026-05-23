import '../../../../core/utils/base_list_controller.dart';
import '../../../../core/utils/result.dart';
import '../../../../data/events/habits_bus.dart';
import '../../../../data/models/category.dart';
import '../../../../data/models/execution_log.dart';
import '../../../../data/models/habit.dart';
import '../../../../data/notifications/notification_service.dart';
import '../../../../data/repositories/category_repository.dart';
import '../../../../data/repositories/execution_log_repository.dart';
import '../../../../data/repositories/habit_repository.dart';
import '../utils/streak_calculator.dart';

class HabitsController extends BaseListController<Habit> {
  final HabitRepository _repo;
  final CategoryRepository _catRepo;
  final ExecutionLogRepository _execRepo;
  final NotificationService _notifications;
  final HabitsBus _bus;
  final String userId;

  bool _showArchived = false;
  List<Category> _categories = [];
  Map<String, int> _streaks = {};

  HabitsController(
    this._repo, {
    required this.userId,
    required CategoryRepository catRepo,
    required ExecutionLogRepository execRepo,
    required NotificationService notifications,
    required HabitsBus bus,
  })  : _catRepo = catRepo,
        _execRepo = execRepo,
        _notifications = notifications,
        _bus = bus {
    load();
  }

  bool get showArchived => _showArchived;
  List<Habit> get habits => items;
  List<Category> get categories => _categories;
  Map<String, int> get streaks => _streaks;

  Category? categoryFor(String? id) =>
      id == null ? null : _categories.cast<Category?>().firstWhere(
            (c) => c?.id == id,
            orElse: () => null,
          );

  @override
  Future<Result<List<Habit>>> fetchItems() =>
      _repo.listForUser(userId, includeArchived: _showArchived);

  @override
  Future<void> load() async {
    await super.load();

    final catsResult = await _catRepo.listForUser(userId);
    _categories = catsResult.fold(onSuccess: (l) => l, onFailure: (_) => []);

    final now = DateTime.now();
    final streaks = <String, int>{};
    for (final habit in items) {
      final logsResult = await _execRepo.listForHabit(habit.id);
      final logs = logsResult.fold(
        onSuccess: (l) => l,
        onFailure: (_) => <ExecutionLog>[],
      );
      streaks[habit.id] = calculateStreak(logs, now);
    }
    _streaks = streaks;

    notifyListeners();
  }

  void toggleShowArchived() {
    _showArchived = !_showArchived;
    load();
  }

  Future<bool> create(Habit habit) async {
    final result = await _repo.create(habit);
    final created = result.valueOrNull;
    if (created == null) return false;
    await _notifications.scheduleForHabit(created);
    await load();
    _bus.notifyChanged();
    return true;
  }

  Future<bool> update(Habit habit) async {
    final result = await _repo.update(habit);
    final updated = result.valueOrNull;
    if (updated == null) return false;
    await _notifications.scheduleForHabit(updated);
    await load();
    _bus.notifyChanged();
    return true;
  }

  Future<bool> delete(String id) async {
    final result = await _repo.delete(id);
    if (result.isFailure) return false;
    await _notifications.cancelForHabit(id);
    await load();
    _bus.notifyChanged();
    return true;
  }

  Future<bool> archive(String id) async {
    final result = await _repo.archive(id);
    if (result.isFailure) return false;
    await _notifications.cancelForHabit(id);
    await load();
    _bus.notifyChanged();
    return true;
  }

  Future<bool> unarchive(String id) async {
    final result = await _repo.unarchive(id);
    final unarchived = result.valueOrNull;
    if (unarchived == null) return false;
    await _notifications.scheduleForHabit(unarchived);
    await load();
    _bus.notifyChanged();
    return true;
  }
}
