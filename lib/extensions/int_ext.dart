import 'package:spam_delection_app/lib.dart';

extension IntExt on int {
  Widget height() => SizedBox(
        height: toDouble(),
      );

  Widget width() => SizedBox(
        width: toDouble(),
      );

  Widget space() => SizedBox(
        height: toDouble(),
        width: toDouble(),
      );
}
