import 'package:intl/intl.dart';

extension StringExt on String {
  DateTime parseDateTime(String format) {
    return DateFormat(format).parse(this);
  }
}
