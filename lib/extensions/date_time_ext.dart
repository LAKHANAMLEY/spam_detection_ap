import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String format() => DateFormat('dd MMM yyyy hh:mm a').format(this);
}
