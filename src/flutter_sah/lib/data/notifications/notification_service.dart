import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../models/habit.dart';

// Fuso fixo para o app (app local, sem necessidade de detectar timezone do device).
const _kTz = 'America/Sao_Paulo';
const _kChannelId = 'sah_habits_v1';

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(_kTz));
    await _plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );
  }

  Future<bool> requestPermission() async {
    try {
      final android = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      if (android != null) {
        final granted = await android.requestNotificationsPermission() ?? false;
        if (!granted) return false;
      }
      final ios = _plugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
      if (ios != null) {
        final granted = await ios.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        ) ?? false;
        if (!granted) return false;
      }
      return true;
    } on PlatformException {
      return false;
    }
  }

  Future<void> cancelForHabit(String habitId) async {
    final pending = await _plugin.pendingNotificationRequests();
    // IDs para este hábito estão no range [base, base + 100)
    final base = habitId.hashCode.abs() % 100000 * 100;
    for (final p in pending) {
      if (p.id >= base && p.id < base + 100) {
        await _plugin.cancel(p.id);
      }
    }
  }

  Future<void> scheduleForHabit(Habit habit) async {
    await cancelForHabit(habit.id);
    if (!habit.ativo || habit.arquivado || habit.lembretes.isEmpty) return;

    await requestPermission();

    for (final dow in habit.frequencia) {
      for (var i = 0; i < habit.lembretes.length; i++) {
        final parts = habit.lembretes[i].split(':');
        final h = int.parse(parts[0]);
        final m = int.parse(parts[1]);
        final id = habit.id.hashCode.abs() % 100000 * 100 + dow * 10 + i;
        try {
          await _plugin.zonedSchedule(
            id,
            habit.nome,
            'Hora do seu hábito!',
            _nextInstance(dow, h, m),
            const NotificationDetails(
              android: AndroidNotificationDetails(
                _kChannelId,
                'Lembretes de hábitos',
                importance: Importance.high,
                priority: Priority.high,
              ),
              iOS: DarwinNotificationDetails(),
            ),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
          );
        } on PlatformException {
          // Permissão de alarme exato negada; ignora silenciosamente.
        }
      }
    }
  }

  // dow: 0=dom..6=sab → DateTime.weekday: 1=seg..7=dom
  tz.TZDateTime _nextInstance(int dow, int hour, int minute) {
    final targetWeekday = dow == 0 ? DateTime.sunday : dow;
    final now = tz.TZDateTime.now(tz.local);
    var dt = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    while (dt.weekday != targetWeekday || dt.isBefore(now)) {
      dt = dt.add(const Duration(days: 1));
    }
    return dt;
  }
}
