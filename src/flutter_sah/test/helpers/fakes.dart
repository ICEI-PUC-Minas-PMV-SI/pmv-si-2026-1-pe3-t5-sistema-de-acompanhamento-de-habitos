import 'package:sah/data/backup/auto_backup_service.dart';
import 'package:sah/data/models/habit.dart';
import 'package:sah/data/notifications/notification_service.dart';
import 'package:sah/data/widgets/home_widget_service.dart';
import 'package:sah/features/user_home/today/controllers/today_controller.dart';

class FakeNotificationService implements NotificationService {
  final List<String> scheduledHabitIds = [];
  final List<String> cancelledHabitIds = [];
  bool rescheduleAllCalled = false;
  bool showTestCalled = false;

  @override
  Future<void> init() async {}

  @override
  Future<bool> requestPermission() async => true;

  @override
  Future<void> cancelForHabit(String habitId) async {
    cancelledHabitIds.add(habitId);
  }

  @override
  Future<void> scheduleForHabit(Habit habit) async {
    scheduledHabitIds.add(habit.id);
  }

  @override
  Future<void> rescheduleAll(List<Habit> habits) async {
    rescheduleAllCalled = true;
    for (final h in habits) {
      scheduledHabitIds.add(h.id);
    }
  }

  @override
  Future<void> showTestNotification() async {
    showTestCalled = true;
  }
}

class FakeHomeWidgetService implements HomeWidgetService {
  int pushCount = 0;
  bool cleared = false;
  List<TodayHabitEntry>? lastEntries;

  @override
  Future<void> init() async {}

  @override
  Future<void> pushToday(List<TodayHabitEntry> entries) async {
    pushCount++;
    lastEntries = entries;
  }

  @override
  Future<void> clear() async {
    cleared = true;
  }
}

class FakeAutoBackupService implements AutoBackupService {
  bool ran = false;

  @override
  Future<void> maybeRun(String userId) async {
    ran = true;
  }

  @override
  DateTime? lastBackupAt(String userId) => null;
}
