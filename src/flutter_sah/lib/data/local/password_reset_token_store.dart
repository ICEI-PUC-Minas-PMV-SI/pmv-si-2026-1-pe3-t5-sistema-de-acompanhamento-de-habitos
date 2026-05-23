import 'dart:convert';
import 'dart:math';
import 'package:hive/hive.dart';
import 'hive_keys.dart';

class PasswordResetTokenStore {
  Box<String> get _box => Hive.box<String>(HiveBoxes.passwordResetTokens);

  static String generate() {
    final rng = Random.secure();
    final bytes = List<int>.generate(32, (_) => rng.nextInt(256));
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  Future<void> save(
    String token, {
    required String email,
    Duration ttl = const Duration(minutes: 30),
  }) async {
    final expiresAt = DateTime.now().add(ttl);
    await _box.put(token, jsonEncode({
      'email': email,
      'expires_at': expiresAt.toIso8601String(),
    }));
  }

  ({String email, DateTime expiresAt})? read(String token) {
    final raw = _box.get(token);
    if (raw == null) return null;
    final map = jsonDecode(raw) as Map<String, dynamic>;
    return (
      email: map['email'] as String,
      expiresAt: DateTime.parse(map['expires_at'] as String),
    );
  }

  Future<void> consume(String token) async {
    await _box.delete(token);
  }

  Future<void> clearForEmail(String email) async {
    final target = email.toLowerCase();
    final toRemove = <String>[];
    for (final key in _box.keys) {
      final raw = _box.get(key);
      if (raw == null) continue;
      final map = jsonDecode(raw) as Map<String, dynamic>;
      if ((map['email'] as String?)?.toLowerCase() == target) {
        toRemove.add(key as String);
      }
    }
    for (final k in toRemove) {
      await _box.delete(k);
    }
  }
}
