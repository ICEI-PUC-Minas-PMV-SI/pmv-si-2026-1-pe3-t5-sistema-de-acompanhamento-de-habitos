import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/local/hive_keys.dart';

/// Persistência e troca de idioma do app.
///
/// `null` significa "usar o idioma do sistema".
class LocaleController extends ChangeNotifier {
  static const _key = 'app_locale';
  static const supported = [
    Locale('pt', 'BR'),
    Locale('en'),
    Locale('es'),
  ];

  Locale? _locale;
  Locale? get locale => _locale;

  Future<void> load() async {
    final box = Hive.box<String>(HiveBoxes.appMeta);
    final raw = box.get(_key);
    if (raw == null || raw == 'system') {
      _locale = null;
    } else {
      final parts = raw.split('_');
      _locale = parts.length == 2
          ? Locale(parts[0], parts[1])
          : Locale(parts[0]);
    }
    notifyListeners();
  }

  Future<void> setLocale(Locale? locale) async {
    if (_locale == locale) return;
    _locale = locale;
    final box = Hive.box<String>(HiveBoxes.appMeta);
    if (locale == null) {
      await box.put(_key, 'system');
    } else {
      final value = locale.countryCode != null
          ? '${locale.languageCode}_${locale.countryCode}'
          : locale.languageCode;
      await box.put(_key, value);
    }
    notifyListeners();
  }
}
