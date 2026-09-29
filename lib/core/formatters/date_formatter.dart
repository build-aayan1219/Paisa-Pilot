import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static final DateFormat _dayMonthFormat = DateFormat('d MMM');
  static final DateFormat _dayMonthYearFormat = DateFormat('d MMM yyyy');
  static final DateFormat _timeFormat = DateFormat('h:mm a');

  static String formatShort(DateTime date) {
    return _dayMonthFormat.format(date);
  }

  static String formatDateWithYear(DateTime date) {
    return _dayMonthYearFormat.format(date);
  }

  static String formatTime(DateTime date) {
    return _timeFormat.format(date);
  }

  static String formatDayHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);

    final difference = today.difference(target).inDays;
    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (date.year == now.year) {
      return _dayMonthFormat.format(date);
    } else {
      return _dayMonthYearFormat.format(date);
    }
  }

  static String formatRelative(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);

    final difference = today.difference(target).inDays;
    if (difference == 0) {
      return 'Today, ${_timeFormat.format(date)}';
    } else if (difference == 1) {
      return 'Yesterday, ${_timeFormat.format(date)}';
    } else {
      return _dayMonthFormat.format(date);
    }
  }

  static String formatCycle(DateTime start, DateTime end) {
    return 'Cycle: ${_dayMonthFormat.format(start)} - ${_dayMonthFormat.format(end)}';
  }
}
