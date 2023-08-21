import 'package:intl/intl.dart';

extension LoomiDateTime on DateTime {
  /// Returns a formatted representation of the last seen date as a string.
  ///
  /// Example usage:
  /// ```dart
  /// String lastSeen = someDateTime.formatLastSeenDate;
  /// ```
  String get formatLastSeenDate => _getFormatLastSeenDate();

  /// Checks if the current date is the same day as the given [other] date.
  ///
  /// Returns `true` if the year, month, and day of the current date match the
  /// corresponding values of the [other] date; otherwise, returns `false`.
  ///

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// Checks if the current date is the same month as the given [other] date.
  ///
  /// Returns `true` if the year and month of the current date match the
  /// corresponding values of the [other] date; otherwise, returns `false`.
  ///

  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }

  /// Checks if the current date is the same year as the given [other] date.
  ///
  /// Returns `true` if the year of the current date matches the year of the [other] date;
  /// otherwise, returns `false`.
  /// 
  bool isSameYear(DateTime other) {
    return year == other.year;
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

  /// Returns a formatted representation of the date as a string.
  ///
  ///  - [format]: An optional string that defines the desired format for the
  ///               formatted representation of the date. The format follows the
  ///               conventions of the [DateFormat] class from the 'intl' package
  ///               in Flutter. If no format is provided, the default format
  ///               'dd/MM/yy' will be applied. For more details on formatting
  ///               options, refer to the [DateFormat documentation]
  ///               (https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html).
  ///
  /// Usage examples:
  ///   ```
  ///   String date = DateTime.now().formatedDateString(); // Using the default format
  ///   String customDate = DateTime.now().formatedDateString(format: 'dd MM yy'); // Using a custom format
  ///   ```

  String formatedDateString({String? format}) {
    return DateFormat(format ?? "dd/MM/yy").format(this);
  }
}
