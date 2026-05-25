import 'dart:io';
import 'package:hive/hive.dart';
import 'package:sah/data/local/hive_keys.dart';

late Directory _tempDir;

Future<void> setUpHive() async {
  _tempDir = Directory.systemTemp.createTempSync('sah_test_');
  Hive.init(_tempDir.path);
  await Future.wait([
    Hive.openBox<String>(HiveBoxes.users),
    Hive.openBox<String>(HiveBoxes.credentials),
    Hive.openBox<String>(HiveBoxes.session),
    Hive.openBox<String>(HiveBoxes.categories),
    Hive.openBox<String>(HiveBoxes.habits),
    Hive.openBox<String>(HiveBoxes.executionLogs),
    Hive.openBox<String>(HiveBoxes.auditLogs),
    Hive.openBox<String>(HiveBoxes.appMeta),
    Hive.openBox<String>(HiveBoxes.passwordResetTokens),
  ]);
}

Future<void> tearDownHive() async {
  await Hive.close();
  try {
    _tempDir.deleteSync(recursive: true);
  } catch (_) {}
}

Future<void> clearAllBoxes() async {
  await Future.wait([
    Hive.box<String>(HiveBoxes.users).clear(),
    Hive.box<String>(HiveBoxes.credentials).clear(),
    Hive.box<String>(HiveBoxes.session).clear(),
    Hive.box<String>(HiveBoxes.categories).clear(),
    Hive.box<String>(HiveBoxes.habits).clear(),
    Hive.box<String>(HiveBoxes.executionLogs).clear(),
    Hive.box<String>(HiveBoxes.auditLogs).clear(),
    Hive.box<String>(HiveBoxes.appMeta).clear(),
    Hive.box<String>(HiveBoxes.passwordResetTokens).clear(),
  ]);
}
