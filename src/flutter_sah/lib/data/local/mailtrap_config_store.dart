import 'dart:convert';
import 'package:hive/hive.dart';
import '../models/mailtrap_config.dart';
import 'hive_keys.dart';

class MailtrapConfigStore {
  static const _key = 'mailtrap_config';

  Box<String> get _box => Hive.box<String>(HiveBoxes.appMeta);

  MailtrapConfig? read() {
    final raw = _box.get(_key);
    if (raw == null) return null;
    try {
      return MailtrapConfig.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  Future<void> write(MailtrapConfig cfg) async {
    await _box.put(_key, jsonEncode(cfg.toJson()));
  }

  Future<void> clear() async {
    await _box.delete(_key);
  }

  bool get isConfigured => read() != null;
}
