import 'package:intl/intl.dart';

extension LoomiDateTime on DateTime {
  String get formatLastSeenDate => _getFormatLastSeenDate();

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  String _getFormatLastSeenDate() {
    final now = DateTime.now();
    final difference = now.difference(this).abs();

    if (difference.inMinutes < 60) {
      return "Há ${difference.inMinutes} minutos";
    } else if (difference.inHours == 1) {
      return "Há ${difference.inHours} hora";
    } else if (difference.inHours < 24) {
      return "Há ${difference.inHours} horas";
    } else {
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));

      if (isSameDay(today)) {
        return "às ${DateFormat("HH:mm").format(this)}";
      } else if (isSameDay(yesterday)) {
        return "ontem às ${DateFormat("HH:mm").format(this)}";
      } else {
        return "em ${DateFormat("dd/MM/yy").format(this)}";
      }
    }
  }

  String formatedDateString({String? format}) {
    return DateFormat(format ?? "dd/MM/yy").format(this);
  }
}
