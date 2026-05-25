import 'dart:convert';
import 'package:home_widget/home_widget.dart';
import '../../features/user_home/today/controllers/today_controller.dart';

class HomeWidgetService {
  static const _androidWidget = 'SahHomeWidgetProvider';
  static const _payloadKey = 'today_payload';
  static const _appGroupId = 'app.sah.sah';

  Future<void> init() async {
    await HomeWidget.setAppGroupId(_appGroupId);
  }

  Future<void> pushToday(List<TodayHabitEntry> entries) async {
    final pending = entries.where((e) => !e.doneToday).toList()
      ..sort((a, b) => a.habit.nome.compareTo(b.habit.nome));
    final done = entries.where((e) => e.doneToday).toList()
      ..sort((a, b) => a.habit.nome.compareTo(b.habit.nome));

    final picks = [...pending, ...done].take(3).toList();

    final payload = {
      'count': '${done.length}/${entries.length}',
      'has_any': entries.isNotEmpty,
      'habits': picks
          .map((e) => {'nome': e.habit.nome, 'done': e.doneToday})
          .toList(),
    };

    await HomeWidget.saveWidgetData<String>(_payloadKey, jsonEncode(payload));
    await HomeWidget.updateWidget(androidName: _androidWidget);
  }

  Future<void> clear() async {
    await HomeWidget.saveWidgetData<String>(_payloadKey, null);
    await HomeWidget.updateWidget(androidName: _androidWidget);
  }
}
