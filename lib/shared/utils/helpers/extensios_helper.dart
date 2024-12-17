import 'package:flutter_leap_v2/shared/utils/misc.dart';

// String
extension StringExtensions on String {
  /// Checks if the String is a valid email:
  bool get isValidEmail {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(this);
  }

  /// Removes spaces at the beginning and end of a String:
  String get trimSpaces => trim();

  /// Check if the String is empty or contains only spaces:
  bool get isBlank => trim().isEmpty;

  /// Removes all characters other than numbers:
  String get onlyDigits => replaceAll(RegExp(r'\D'), '');

  ///Return string with first letter in upper case
  String capitalize({
    String delimiter = ' ',
    List<String> exceptions = const [],
  }) {
    return toLowerCase()
        .trim()
        .split(delimiter)
        .map((e) => e.isEmpty
            ? e
            : exceptions.contains(e)
                ? e
                : e[0].toUpperCase() + e.substring(1))
        .toList()
        .join(delimiter);
  }

  ///Return string in format camel case
  String get toCamelCase {
    String text = this;
    text = text.replaceAll(RegExp(r'[^a-zA-Z0-9]+'), ' ').toLowerCase();

    List<String> palavras = text.split(' ');
    String camelCase = palavras.first.toLowerCase();
    for (int i = 1; i < palavras.length; i++) {
      camelCase += palavras[i].capitalize();
    }
    return camelCase;
  }

  ///Replace all letters with accents for the same ones without
  String get removeAccentInWord {
    String text = this;
    text = text.replaceAllMapped(
        RegExp(r'[áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ]'), (match) {
      return mapAccents[match.group(0)]!;
    });

    return text;
  }
}

//String?
extension StringNullExtensions on String? {
  /// Checks is the string is not null nor empty
  bool get isNotNullNorEmpty {
    return this != null && this!.isNotEmpty;
  }
}

// Int
extension IntExtensions on int {
  /// Calculate whether a number is even:
  bool get isEven => this % 2 == 0;

  /// Convert seconds to minute format:
  String get toMinutes {
    final minutes = (this ~/ 60).toString().padLeft(2, '0');
    final seconds = (this % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  /// Transforms seconds into a time format:
  String get toTimeString {
    final hours = (this ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((this % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (this % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  /// Transforms an integer into a formatted string:
  String toDecimalString(int decimals) {
    return toDouble().toStringAsFixed(decimals);
  }

  /// Formats the number as storage size:
  String get toFileSize {
    if (this < 1024) return '$this B';
    final kb = this / 1024;
    if (kb < 1024) return '${kb.toStringAsFixed(2)} KB';
    final mb = kb / 1024;
    if (mb < 1024) return '${mb.toStringAsFixed(2)} MB';
    final gb = mb / 1024;
    return '${gb.toStringAsFixed(2)} GB';
  }
}

// Double
extension DoubleToCurrency on double {
  /// Formats the number as a monetary value:
  String toCurrency({String symbol = 'R\$', int decimals = 2}) {
    return '$symbol${toStringAsFixed(decimals).replaceAll('.', ',')}';
  }

  /// Transforms the double into the nearest integer:
  int get rounded => round();
}

// List<num>
extension ListExtensions on List<num> {
  /// Calculate the average of the elements in a list of numbers:
  double get average => isNotEmpty ? (reduce((a, b) => a + b) / length) : 0.0;
}

// List?
extension ListNullExtensions on List? {
  /// Checks is the list is not null nor empty
  bool get isNotNullNorEmpty {
    return this != null && this!.isNotEmpty;
  }
}

// Datetime
extension DateTimeFormatting on DateTime {
  /// Format date in readable string:
  String get formatted =>
      "${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year";
}

// Bool
extension BoolExtensions on bool {
  /// Turn bool into text:
  String get toText => this ? "Sim" : "Não";
}
