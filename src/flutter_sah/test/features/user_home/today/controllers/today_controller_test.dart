import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:sah/data/events/habits_bus.dart';
import 'package:sah/data/local/hive_category_repository.dart';
import 'package:sah/data/local/hive_execution_log_repository.dart';
import 'package:sah/data/local/hive_habit_repository.dart';
import 'package:sah/data/local/hive_keys.dart';
import 'package:sah/data/models/habit.dart';
import 'package:sah/features/user_home/today/controllers/today_controller.dart';

import '../../../../helpers/fakes.dart';
import '../../../../helpers/hive_test_helper.dart';

void main() {
  late FakeNotificationService fakeNotifications;
  late FakeHomeWidgetService fakeWidget;
  late FakeAutoBackupService fakeAutoBackup;

  setUpAll(() async {
    await setUpHive();
  });

  tearDownAll(() async {
    await tearDownHive();
  });

  setUp(() async {
    await clearAllBoxes();
    fakeNotifications = FakeNotificationService();
    fakeWidget = FakeHomeWidgetService();
    fakeAutoBackup = FakeAutoBackupService();
  });

  Future<void> seedHabit({
    required String id,
    String userId = 'u1',
    List<int> frequencia = const [0, 1, 2, 3, 4, 5, 6],
    bool arquivado = false,
  }) async {
    final h = Habit(
      id: id,
      userId: userId,
      nome: 'Hábito $id',
      frequencia: frequencia,
      arquivado: arquivado,
    );
    await Hive.box<String>(HiveBoxes.habits).put(id, jsonEncode(h.toJson()));
  }

  TodayController buildController({String userId = 'u1'}) {
    return TodayController(
      userId: userId,
      habitRepo: HiveHabitRepository(),
      execRepo: HiveExecutionLogRepository(),
      catRepo: HiveCategoryRepository(),
      widget: fakeWidget,
      autoBackup: fakeAutoBackup,
      notifications: fakeNotifications,
      bus: HabitsBus(),
    );
  }

  // Helper para esperar load inicial assíncrono terminar
  Future<void> waitForLoad(TodayController ctrl) async {
    while (ctrl.status == TodayStatus.loading) {
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  }

  group('TodayController.load', () {
    test('filtra hábitos pelo dia da semana atual', () async {
      final todayWeekday = DateTime.now().weekday % 7;
      final otherDay = (todayWeekday + 1) % 7;

      await seedHabit(id: 'h_today', frequencia: [todayWeekday]);
      await seedHabit(id: 'h_other', frequencia: [otherDay]);

      final ctrl = buildController();
      await waitForLoad(ctrl);

      expect(ctrl.entries.length, 1);
      expect(ctrl.entries.first.habit.id, 'h_today');
    });

    test('hasAnyHabit reflete total de hábitos não arquivados', () async {
      await seedHabit(id: 'h1');
      await seedHabit(id: 'h2', arquivado: true);

      final ctrl = buildController();
      await waitForLoad(ctrl);

      expect(ctrl.hasAnyHabit, isTrue);
    });

    test('hasAnyHabit é false quando todos os hábitos estão arquivados', () async {
      await seedHabit(id: 'h1', arquivado: true);

      final ctrl = buildController();
      await waitForLoad(ctrl);

      expect(ctrl.hasAnyHabit, isFalse);
      expect(ctrl.entries, isEmpty);
    });

    test('atualiza widget e dispara reagendamento na primeira load', () async {
      await seedHabit(id: 'h1');

      final ctrl = buildController();
      await waitForLoad(ctrl);
      // Espera o post-load assíncrono (pushToday + rescheduleAll)
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(fakeWidget.pushCount, greaterThanOrEqualTo(1));
      expect(fakeNotifications.rescheduleAllCalled, isTrue);
    });
  });

  group('TodayController.toggle', () {
    test('marca hábito pendente como feito', () async {
      final todayWeekday = DateTime.now().weekday % 7;
      await seedHabit(id: 'h1', frequencia: [todayWeekday]);

      final ctrl = buildController();
      await waitForLoad(ctrl);
      expect(ctrl.entries.first.doneToday, isFalse);

      await ctrl.toggle('h1');

      expect(ctrl.entries.first.doneToday, isTrue);
      expect(ctrl.completedCount, 1);
    });

    test('desmarca hábito feito', () async {
      final todayWeekday = DateTime.now().weekday % 7;
      await seedHabit(id: 'h1', frequencia: [todayWeekday]);

      final ctrl = buildController();
      await waitForLoad(ctrl);
      await ctrl.toggle('h1');
      expect(ctrl.entries.first.doneToday, isTrue);

      await ctrl.toggle('h1');
      expect(ctrl.entries.first.doneToday, isFalse);
    });
  });
}
