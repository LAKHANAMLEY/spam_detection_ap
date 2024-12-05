import 'package:spam_delection_app/lib.dart';

class ThemeConstants {
  static const BoxDecoration decoration = BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10)));

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.whiteLight,
    // color: Colors.white,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColor.whiteLight,
    // color: Colors.white,
  );
}
