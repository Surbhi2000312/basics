import 'package:intl/intl.dart';
class DateUtility{
  static List<String> getIntervalLatest(DateTime actualIn24hr, int numberOfIntervals) {
    final DateFormat timeFormat = DateFormat('hh:mm a');
    DateTime startTime = actualIn24hr;
    DateTime endTime = actualIn24hr;
    endTime = endTime.add(const Duration(days: 1));
    Duration totalDuration = endTime.difference(startTime);
    Duration intervalDuration = totalDuration ~/ numberOfIntervals;
    DateTime currentTime = startTime;
    List<String> finalIntervals = [];
    for (int i = 0; i <= numberOfIntervals-1; i++) {
      print( 'Interval ${i + 1} Boundary: ${timeFormat.format(currentTime)}');
      finalIntervals.add(timeFormat.format(currentTime));
      currentTime = currentTime.add(intervalDuration);
    }
    return finalIntervals;
  }
}