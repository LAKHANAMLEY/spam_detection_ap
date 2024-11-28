import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String formatDateTime() => DateFormat('dd MMM yyyy hh:mm a').format(this);

  String formatDate() => DateFormat('dd MMM yyyy').format(this);

  String formatTime() => DateFormat('hh:mm a').format(this);
}
