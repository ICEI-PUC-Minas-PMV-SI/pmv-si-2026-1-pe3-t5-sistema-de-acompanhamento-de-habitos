import 'dart:convert';
import 'package:hive/hive.dart';
import 'hive_keys.dart';

const _kMaxAttempts = 5;
const _kLockDuration = Duration(minutes: 5);

class LoginAttemptStore {
  Box<String> get _box => Hive.box<String>(HiveBoxes.appMeta);

  String _key(String email) => 'login_attempts_${email.toLowerCase()}';

  ({int failures, DateTime? lockedUntil}) read(String email) {
    final raw = _box.get(_key(email));
    if (raw == null) return (failures: 0, lockedUntil: null);
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      final lockedAt = map['locked_until'] as String?;
      return (
        failures: (map['failures'] as int?) ?? 0,
        lockedUntil: lockedAt == null ? null : DateTime.parse(lockedAt),
      );
    } catch (_) {
      return (failures: 0, lockedUntil: null);
    }
  }

  bool isLocked(String email) {
    final r = read(email);
    if (r.lockedUntil == null) return false;
    return DateTime.now().isBefore(r.lockedUntil!);
  }

  /// Retorna o quanto falta do bloqueio, ou null se não está bloqueado.
  Duration? remainingLock(String email) {
    final r = read(email);
    if (r.lockedUntil == null) return null;
    final remaining = r.lockedUntil!.difference(DateTime.now());
    return remaining.isNegative ? null : remaining;
  }

  Future<void> registerFailure(String email) async {
    final r = read(email);
    final newFailures = r.failures + 1;
    final lockedUntil = newFailures >= _kMaxAttempts
        ? DateTime.now().add(_kLockDuration)
        : null;
    await _box.put(_key(email), jsonEncode({
      'failures': newFailures,
      'locked_until': lockedUntil?.toIso8601String(),
    }));
  }

  Future<void> reset(String email) async {
    await _box.delete(_key(email));
  }
}
