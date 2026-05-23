import 'dart:async';

import 'package:flutter/foundation.dart' show ChangeNotifier;

import '../../../../core/utils/result.dart';
import '../../../../data/backup/auto_backup_service.dart';
import '../../../../data/events/habits_bus.dart';
import '../../../../data/models/category.dart';
import '../../../../data/models/execution_log.dart';
import '../../../../data/models/habit.dart';
import '../../../../data/notifications/notification_service.dart';
import '../../../../data/repositories/category_repository.dart';
import '../../../../data/repositories/execution_log_repository.dart';
import '../../../../data/repositories/habit_repository.dart';
import '../../../../data/widgets/home_widget_service.dart';
import '../../../user_home/habits/utils/streak_calculator.dart';

typedef TodayHabitEntry = ({
  Habit habit,
  Category? category,
  bool doneToday,
  bool frozenToday,
  String? notaToday,
  int streak,
});

enum TodayStatus { loading, loaded, error }

class TodayController extends ChangeNotifier {
  final HabitRepository _habitRepo;
  final ExecutionLogRepository _execRepo;
  final CategoryRepository _catRepo;
  final HomeWidgetService _widget;
  final AutoBackupService _autoBackup;
  final NotificationService _notifications;
  final HabitsBus _bus;
  final String userId;

  TodayStatus _status = TodayStatus.loading;
  List<TodayHabitEntry> _entries = [];
  int _totalHabits = 0;
  String? _error;
  bool _autoBackupRan = false;
  bool _notificationsRescheduled = false;

  TodayController({
    required this.userId,
    required HabitRepository habitRepo,
    required ExecutionLogRepository execRepo,
    required CategoryRepository catRepo,
    required HomeWidgetService widget,
    required AutoBackupService autoBackup,
    required NotificationService notifications,
    required HabitsBus bus,
  })  : _habitRepo = habitRepo,
        _execRepo = execRepo,
        _catRepo = catRepo,
        _widget = widget,
        _autoBackup = autoBackup,
        _notifications = notifications,
        _bus = bus {
    _bus.addListener(_onHabitsChanged);
    load();
  }

  void _onHabitsChanged() {
    load();
  }

  @override
  void dispose() {
    _bus.removeListener(_onHabitsChanged);
    super.dispose();
  }

  TodayStatus get status => _status;
  List<TodayHabitEntry> get entries => _entries;
  String? get error => _error;

  int get completedCount => _entries.where((e) => e.doneToday).length;
  int get totalCount => _entries.length;
  bool get hasAnyHabit => _totalHabits > 0;
  double get progress =>
      totalCount == 0 ? 0.0 : completedCount / totalCount;

  Future<void> load() async {
    _status = TodayStatus.loading;
    _error = null;
    notifyListeners();

    final today = DateTime.now();
    final todayWeekday = today.weekday % 7; // Dart: mon=1..sun=7 → 0=dom

    final habitsResult = await _habitRepo.listForUser(userId);
    final catsResult = await _catRepo.listGlobal();

    final habits = habitsResult.fold(
      onSuccess: (list) => list,
      onFailure: (_) => <Habit>[],
    );
    final cats = catsResult.fold(
      onSuccess: (list) => list,
      onFailure: (_) => <Category>[],
    );

    _totalHabits = habits.where((h) => !h.arquivado).length;

    // Filtrar apenas hábitos ativos agendados para hoje
    final todayHabits = habits
        .where((h) => !h.arquivado && h.frequencia.contains(todayWeekday))
        .toList();

    final logsResult = await _execRepo.listForUserOnDate(userId, today);
    final logsToday = logsResult.fold(
      onSuccess: (l) => l,
      onFailure: (_) => <ExecutionLog>[],
    );
    final logByHabitId = {for (final l in logsToday) l.habitId: l};

    // Calcular streaks para cada hábito
    final entries = <TodayHabitEntry>[];
    for (final habit in todayHabits) {
      final allLogsResult = await _execRepo.listForHabit(habit.id);
      final allLogs = allLogsResult.fold(
        onSuccess: (l) => l,
        onFailure: (_) => <ExecutionLog>[],
      );
      final streak = calculateStreak(allLogs, today);
      final Category? cat = cats.cast<Category?>().firstWhere(
            (c) => c?.id == habit.categoriaId,
            orElse: () => null,
          );
      final logToday = logByHabitId[habit.id];
      entries.add((
        habit: habit,
        category: cat,
        doneToday: logToday != null && !logToday.frozen,
        frozenToday: logToday?.frozen ?? false,
        notaToday: logToday?.nota,
        streak: streak,
      ));
    }

    _entries = entries;
    _status = TodayStatus.loaded;
    notifyListeners();
    await _widget.pushToday(entries);

    if (!_autoBackupRan) {
      _autoBackupRan = true;
      // fire-and-forget; falha silenciosamente
      unawaited(_autoBackup.maybeRun(userId));
    }

    // Reagenda notificações na primeira load da sessão. Cobre o caso de hábitos
    // criados antes de mudanças no timezone do device ou na lógica de agendamento.
    if (!_notificationsRescheduled) {
      _notificationsRescheduled = true;
      unawaited(_notifications.rescheduleAll(habits));
    }
  }

  Future<void> toggle(String habitId) async {
    final today = DateTime.now();
    final idx = _entries.indexWhere((e) => e.habit.id == habitId);
    if (idx == -1) return;

    final entry = _entries[idx];
    if (entry.doneToday || entry.frozenToday) {
      await _execRepo.deleteForHabitOnDate(habitId, today);
    } else {
      await _execRepo.create(habitId, today);
    }
    // Reload para recalcular streaks consistentemente
    await load();
  }

  /// "Pulei o dia de propósito" — não quebra streak mas também não conta como +1.
  Future<void> toggleFreeze(String habitId) async {
    final today = DateTime.now();
    final idx = _entries.indexWhere((e) => e.habit.id == habitId);
    if (idx == -1) return;

    final entry = _entries[idx];
    // Já está pulado → remove
    if (entry.frozenToday) {
      await _execRepo.deleteForHabitOnDate(habitId, today);
    } else {
      // Substitui qualquer log existente do dia por um freeze
      await _execRepo.deleteForHabitOnDate(habitId, today);
      await _execRepo.create(habitId, today, frozen: true);
    }
    await load();
  }

  Future<void> setNote(String habitId, String? nota) async {
    final today = DateTime.now();
    await _execRepo.upsertNoteForDate(habitId, today, nota);
    await load();
  }
}
