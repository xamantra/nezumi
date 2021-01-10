import 'package:intl/intl.dart';

DateTime parseDate(String date, {String format}) {
  try {
    if (format != null) {
      return DateFormat(format).parse(date);
    }
    return DateTime.parse(date);
  } catch (e) {
    return null;
  }
}
