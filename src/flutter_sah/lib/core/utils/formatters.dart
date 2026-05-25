import 'package:intl/intl.dart';

abstract final class SahFormatters {
  static String date(DateTime dt) => DateFormat('dd/MM/yyyy', 'pt_BR').format(dt);

  static String dateTime(DateTime dt) =>
      DateFormat('dd MMM HH:mm', 'pt_BR').format(dt);

  static String dateTimeFull(DateTime dt) =>
      DateFormat('dd/MM/yyyy HH:mm:ss', 'pt_BR').format(dt);

  static String relativeDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return 'Agora mesmo';
    if (diff.inMinutes < 60) return 'Há ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'Há ${diff.inHours}h';
    if (diff.inDays == 1) return 'Ontem';
    if (diff.inDays < 7) return 'Há ${diff.inDays} dias';
    return date(dt);
  }

  static String compact(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return n.toString();
  }
}
