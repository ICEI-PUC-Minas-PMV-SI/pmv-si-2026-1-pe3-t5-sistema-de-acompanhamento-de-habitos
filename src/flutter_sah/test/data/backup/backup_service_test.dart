import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:sah/core/utils/result.dart';
import 'package:sah/data/backup/backup_service.dart';
import 'package:sah/data/local/hive_category_repository.dart';
import 'package:sah/data/local/hive_execution_log_repository.dart';
import 'package:sah/data/local/hive_habit_repository.dart';
import 'package:sah/data/local/hive_keys.dart';
import 'package:sah/data/local/hive_user_repository.dart';
import 'package:sah/data/models/category.dart';
import 'package:sah/data/models/execution_log.dart';
import 'package:sah/data/models/habit.dart';
import 'package:sah/data/models/user.dart';

import '../../helpers/fakes.dart';
import '../../helpers/hive_test_helper.dart';

void main() {
  late BackupService service;
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
    service = BackupService(
      userRepo: HiveUserRepository(),
      habitRepo: HiveHabitRepository(),
      catRepo: HiveCategoryRepository(),
      execLogRepo: HiveExecutionLogRepository(),
      notifications: fakeNotifications,
    );
  });

  Future<void> seedUser(String id) async {
    final user = User(
      id: id,
      nome: 'Teste',
      email: '$id@sah.app',
      createdAt: DateTime.utc(2026, 1, 1),
    );
    await Hive.box<String>(HiveBoxes.users).put(id, jsonEncode(user.toJson()));
    await Hive.box<String>(HiveBoxes.credentials).put(
      user.email.toLowerCase(),
      jsonEncode({'user_id': id, 'hash': 'fake_hash_value'}),
    );
  }

  Future<void> seedHabit(String userId, {required String id, required String nome}) async {
    final h = Habit(id: id, userId: userId, nome: nome);
    await Hive.box<String>(HiveBoxes.habits).put(id, jsonEncode(h.toJson()));
  }

  Future<void> seedCategory({required String id, String? userId}) async {
    final c = Category(
      id: id,
      nome: 'Cat $id',
      cor: '#000000',
      isGlobal: userId == null,
      userId: userId,
    );
    await Hive.box<String>(HiveBoxes.categories).put(id, jsonEncode(c.toJson()));
  }

  Future<void> seedLog(String habitId, DateTime when) async {
    final l = ExecutionLog(id: 'log_${when.microsecondsSinceEpoch}', habitId: habitId, dataHora: when);
    await Hive.box<String>(HiveBoxes.executionLogs).put(l.id, jsonEncode(l.toJson()));
  }

  group('BackupService.export', () {
    test('inclui hábitos, categorias custom e logs do usuário', () async {
      await seedUser('u1');
      await seedHabit('u1', id: 'h1', nome: 'Meditar');
      await seedHabit('u1', id: 'h2', nome: 'Ler');
      await seedCategory(id: 'cat_custom', userId: 'u1');
      await seedLog('h1', DateTime(2026, 5, 1, 10));

      final result = await service.export(userId: 'u1');
      expect(result, isA<Success<String>>());

      final json = jsonDecode(result.valueOrNull!) as Map<String, dynamic>;
      expect(json['version'], 1);
      expect((json['habits'] as List).length, 2);
      expect((json['categories'] as List).length, 1);
      expect((json['execution_logs'] as List).length, 1);
      expect((json['user'] as Map)['id'], 'u1');
    });

    test('não inclui hash de credenciais', () async {
      await seedUser('u1');
      final result = await service.export(userId: 'u1');
      final raw = result.valueOrNull!;
      expect(raw.contains('fake_hash_value'), isFalse);
      expect(raw.contains('credentials'), isFalse);
    });

    test('exclui categorias globais (apenas custom do usuário)', () async {
      await seedUser('u1');
      await seedCategory(id: 'global_1');
      await seedCategory(id: 'custom_1', userId: 'u1');
      final result = await service.export(userId: 'u1');
      final json = jsonDecode(result.valueOrNull!) as Map<String, dynamic>;
      final ids = (json['categories'] as List).map((c) => (c as Map)['id']).toList();
      expect(ids, ['custom_1']);
    });

    test('falha quando usuário não existe', () async {
      final result = await service.export(userId: 'inexistente');
      expect(result, isA<Failure<String>>());
    });
  });

  group('BackupService.import', () {
    test('JSON inválido retorna Failure', () async {
      await seedUser('u1');
      final result = await service.import(userId: 'u1', json: '{ not valid json');
      expect(result, isA<Failure<void>>());
    });

    test('versão diferente de 1 retorna Failure', () async {
      await seedUser('u1');
      final result = await service.import(userId: 'u1', json: '{"version": 99, "habits": [], "categories": [], "execution_logs": []}');
      expect(result, isA<Failure<void>>());
    });

    test('estrutura sem chaves esperadas retorna Failure', () async {
      await seedUser('u1');
      final result = await service.import(userId: 'u1', json: '{"version": 1}');
      expect(result, isA<Failure<void>>());
    });
  });

  group('BackupService round-trip', () {
    test('export e import restauram hábitos e categorias', () async {
      await seedUser('u1');
      await seedHabit('u1', id: 'h_old1', nome: 'Meditar');
      await seedHabit('u1', id: 'h_old2', nome: 'Correr');
      await seedCategory(id: 'cat1', userId: 'u1');

      final exportRes = await service.export(userId: 'u1');
      final json = exportRes.valueOrNull!;

      // Limpa dados antes do import
      await Hive.box<String>(HiveBoxes.habits).clear();
      await Hive.box<String>(HiveBoxes.categories).clear();
      await Hive.box<String>(HiveBoxes.executionLogs).clear();

      final importRes = await service.import(userId: 'u1', json: json);
      expect(importRes, isA<Success<void>>());

      final habitsBox = Hive.box<String>(HiveBoxes.habits);
      final names = habitsBox.values
          .map((j) => Habit.fromJson(jsonDecode(j) as Map<String, dynamic>).nome)
          .toSet();
      expect(names, {'Meditar', 'Correr'});

      final catsBox = Hive.box<String>(HiveBoxes.categories);
      expect(catsBox.length, 1);
    });
  });
}
