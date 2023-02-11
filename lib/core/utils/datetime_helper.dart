import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime timeAlarm(String time) {
    final now = DateTime.now();
    final dateFormat = DateFormat('y/M/d');
    final completeFormat = DateFormat('y/M/d H:m');

    final todayDate = dateFormat.format(now);
    final todayDateAndTime = "$todayDate $time";

    var alarmDateTime = completeFormat.parseStrict(todayDateAndTime);

    return alarmDateTime;
  }
}
