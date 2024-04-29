import 'package:intl/intl.dart';

String formatDateTime(String datetime) {
  return DateFormat('yyyy MMMM dd   hh:mm aaa')
      .format(DateTime.parse(datetime));
}

String formatDateTimeToHours(String datetime) {
  return DateFormat('hh:mm aaa').format(DateTime.parse(datetime));
}
