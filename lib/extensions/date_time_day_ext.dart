// import 'package:intl/intl.dart';
//
// extension DateTimeDayExt on DateTime {
//   String formatDateTime() => DateFormat("EEEE, d MMM YYYY", 'en').format(this);
//
//   String formatDate() => DateFormat('h:mm a').format(this);
//
//   // String formatTime() => DateFormat('hh:mm a').format(this);
//
//   String formatRelativeDateDay() => isToday
//       ? "Today"
//       : isYesterday
//           ? "Yesterday"
//           : formatDateTime();
//
//   bool get isToday {
//     final now = DateTime.now();
//     return now.day == day && now.month == month && now.year == year;
//   }
//
//   bool get isYesterday {
//     final yesterday = DateTime.now().subtract(const Duration(days: 1));
//     return yesterday.day == day &&
//         yesterday.month == month &&
//         yesterday.year == year;
//   }
// }
import 'package:intl/intl.dart';

extension DateTimeDayExt on DateTime {
  // Formats the date and time, e.g., "Tuesday, 21 Jan 2025"
  String formatDateTime() => DateFormat("EEEE, d MMM y", 'en').format(this);

  // Formats the time, e.g., "3:45 PM"
  String formatTime() => DateFormat('h:mm a').format(this);

  // Formats relative dates, e.g., "Today", "Yesterday", or a full date
  String formatRelativeDateDay() => isToday
      ? "Today"
      : isYesterday
          ? "Yesterday"
          : formatDateTime();

  // Check if the date is today
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  // Check if the date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }
}
// void main() {
//   final dateTime = DateTime(2025, 1, 22, 15, 45);
//
//   // Using the extension methods
//   print(dateTime.formatDateTime());       // Output: "Wednesday, 22 Jan 2025"
//   print(dateTime.formatTime());          // Output: "3:45 PM"
//   print(dateTime.formatRelativeDateDay()); // Output: "Today" (if run on Jan 22, 2025)
//
//   final yesterday = DateTime.now().subtract(const Duration(days: 1));
//   print(yesterday.formatRelativeDateDay()); // Output: "Yesterday"
//
//   final randomDate = DateTime(2024, 12, 31);
//   print(randomDate.formatRelativeDateDay()); // Output: "Tuesday, 31 Dec 2024"
// }
