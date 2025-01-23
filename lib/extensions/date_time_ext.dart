import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String formatDateTime() =>
      DateFormat('dd MMM yyyy hh:mm a', 'en').format(this);

  String formatDate() => DateFormat('dd MMM yyyy').format(this);

  String formatTime() => DateFormat('hh:mm a').format(this);

  String formatRelativeDateTime() => isToday
      ? "Today @ ${formatTime()}"
      : isYesterday
          ? "Yesterday @ ${formatTime()}"
          : formatDateTime();

  String formatRelativeDay() => isToday
      ? "Today"
      : isYesterday
          ? "Yesterday"
          : formatDateTime();

  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }
}
