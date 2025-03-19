import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String formattedDate(String format) {
    return DateFormat(format).format(this);
  }

  bool get isDateInCurrentWeek {
    // Get the current date
    DateTime now = DateTime.now();

    // Calculate the start of the current week (assuming week starts on Monday)
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    // Calculate the end of the current week
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    // Check if the given date is within this week
    return isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
        isBefore(endOfWeek.add(const Duration(days: 1)));
  }
}
