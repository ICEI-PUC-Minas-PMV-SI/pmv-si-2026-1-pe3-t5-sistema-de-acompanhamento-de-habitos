import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../../core/utils/result.dart';
import '../local/hive_keys.dart';
import 'backup_service.dart';

const _kBackupInterval = Duration(days: 7);
const _kKeepBackups = 3;

class AutoBackupService {
  final BackupService _backup;

  AutoBackupService(this._backup);

  String _key(String userId) => 'last_auto_backup_$userId';

  DateTime? lastBackupAt(String userId) {
    final box = Hive.box<String>(HiveBoxes.appMeta);
    final raw = box.get(_key(userId));
    if (raw == null) return null;
    return DateTime.tryParse(raw);
  }

  Future<void> maybeRun(String userId) async {
    try {
      final last = lastBackupAt(userId);
      if (last != null &&
          DateTime.now().difference(last) < _kBackupInterval) {
        return;
      }

      final result = await _backup.export(userId: userId);
      final json = result.valueOrNull;
      if (json == null) return;

      final dir = await getApplicationDocumentsDirectory();
      final dateStr = DateTime.now()
          .toIso8601String()
          .substring(0, 10)
          .replaceAll('-', '');
      final file = File('${dir.path}/sah_backup_$dateStr.json');
      await file.writeAsString(json);

      await _rotate(dir.path);

      await Hive.box<String>(HiveBoxes.appMeta)
          .put(_key(userId), DateTime.now().toIso8601String());
    } catch (e, st) {
      debugPrint('AutoBackup falhou: $e\n$st');
    }
  }

  Future<void> _rotate(String dirPath) async {
    final dir = Directory(dirPath);
    if (!await dir.exists()) return;
    final backups = await dir
        .list()
        .where((f) =>
            f is File && f.path.contains('/sah_backup_') && f.path.endsWith('.json'))
        .cast<File>()
        .toList();
    if (backups.length <= _kKeepBackups) return;
    backups.sort((a, b) => b.path.compareTo(a.path)); // mais recente primeiro
    for (final f in backups.skip(_kKeepBackups)) {
      try {
        await f.delete();
      } catch (_) {}
    }
  }
}
