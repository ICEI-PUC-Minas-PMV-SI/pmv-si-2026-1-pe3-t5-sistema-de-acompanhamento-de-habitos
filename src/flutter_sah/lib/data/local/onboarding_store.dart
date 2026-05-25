import 'package:hive/hive.dart';
import 'hive_keys.dart';

class OnboardingStore {
  Box<String> get _box => Hive.box<String>(HiveBoxes.appMeta);

  String _key(String userId) => 'onboarded_$userId';

  bool isCompleted(String userId) => _box.get(_key(userId)) == 'true';

  Future<void> markCompleted(String userId) =>
      _box.put(_key(userId), 'true');
}
