import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/local/hive_keys.dart';

class ThemeController extends ChangeNotifier {
  static const _key = 'theme_mode';
  ThemeMode _mode = ThemeMode.system;
  ThemeMode get mode => _mode;

  Future<void> load() async {
    final box = Hive.box<String>(HiveBoxes.appMeta);
    final raw = box.get(_key);
    _mode = switch (raw) {
      'light' => ThemeMode.light,
      'dark'  => ThemeMode.dark,
      _       => ThemeMode.system,
    };
    notifyListeners();
  }

  Future<void> setMode(ThemeMode mode) async {
    if (_mode == mode) return;
    _mode = mode;
    final box = Hive.box<String>(HiveBoxes.appMeta);
    await box.put(_key, switch (mode) {
      ThemeMode.light  => 'light',
      ThemeMode.dark   => 'dark',
      ThemeMode.system => 'system',
    });
    notifyListeners();
  }
}
