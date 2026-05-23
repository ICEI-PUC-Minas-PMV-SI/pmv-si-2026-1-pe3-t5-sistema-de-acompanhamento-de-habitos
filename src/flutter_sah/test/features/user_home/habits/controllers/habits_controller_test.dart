import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:sah/core/utils/base_list_controller.dart';
import 'package:sah/data/events/categories_bus.dart';
import 'package:sah/data/events/habits_bus.dart';
import 'package:sah/data/local/hive_category_repository.dart';
import 'package:sah/data/local/hive_execution_log_repository.dart';
import 'package:sah/data/local/hive_habit_repository.dart';
import 'package:sah/data/local/hive_keys.dart';
import 'package:sah/data/models/habit.dart';
import 'package:sah/features/user_home/habits/controllers/habits_controller.dart';

import '../../../../helpers/fakes.dart';
import '../../../../helpers/hive_test_helper.dart';

void main() {
  late FakeNotificationService fakeNotifications;

  setUpAll(() async {
    await setUpHive();
  });

  tearDownAll(() async {
    await tearDownHive();
  });

  setUp(() async {
    await clearAllBoxes();
    fakeNotifications = FakeNotificationService();
  });

  HabitsController buildController({String userId = 'u1'}) {
    return HabitsController(
      HiveHabitRepository(),
      userId: userId,
      catRepo: HiveCategoryRepository(),
      execRepo: HiveExecutionLogRepository(),
      notifications: fakeNotifications,
      bus: HabitsBus(),
      catBus: CategoriesBus(),
    );
  }

  Future<void> waitForLoad(HabitsController ctrl) async {
    while (ctrl.status == ListStatus.loading) {
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  }

  Future<void> seedHabit({
    required String id,
    String userId = 'u1',
    bool arquivado = false,
  }) async {
    final h = Habit(id: id, userId: userId, nome: 'Hábito $id', arquivado: arquivado);
    await Hive.box<String>(HiveBoxes.habits).put(id, jsonEncode(h.toJson()));
  }

  test('create agenda notificação para o hábito criado', () async {
    final ctrl = buildController();
    await waitForLoad(ctrl);

    final ok = await ctrl.create(const Habit(id: '', userId: 'u1', nome: 'Meditar'));

    expect(ok, isTrue);
    expect(fakeNotifications.scheduledHabitIds.length, 1);
    // O id é gerado pelo repo (hab_<microsec>), então só checa que houve agendamento
    expect(fakeNotifications.scheduledHabitIds.first, startsWith('hab_'));
  });

  test('update reagenda notificação do hábito', () async {
    await seedHabit(id: 'h1');
    final ctrl = buildController();
    await waitForLoad(ctrl);

    const updated = Habit(id: 'h1', userId: 'u1', nome: 'Novo nome');
    final ok = await ctrl.update(updated);

    expect(ok, isTrue);
    expect(fakeNotifications.scheduledHabitIds, contains('h1'));
  });

  test('delete cancela notificação do hábito', () async {
    await seedHabit(id: 'h1');
    final ctrl = buildController();
    await waitForLoad(ctrl);

    final ok = await ctrl.delete('h1');

    expect(ok, isTrue);
    expect(fakeNotifications.cancelledHabitIds, contains('h1'));
  });

  test('archive cancela notificação do hábito', () async {
    await seedHabit(id: 'h1');
    final ctrl = buildController();
    await waitForLoad(ctrl);

    final ok = await ctrl.archive('h1');

    expect(ok, isTrue);
    expect(fakeNotifications.cancelledHabitIds, contains('h1'));
  });

  test('unarchive reagenda notificação do hábito', () async {
    await seedHabit(id: 'h1', arquivado: true);
    final ctrl = buildController();
    await waitForLoad(ctrl);

    fakeNotifications.scheduledHabitIds.clear(); // ignora schedules anteriores se houver

    final ok = await ctrl.unarchive('h1');

    expect(ok, isTrue);
    expect(fakeNotifications.scheduledHabitIds, contains('h1'));
  });
}
