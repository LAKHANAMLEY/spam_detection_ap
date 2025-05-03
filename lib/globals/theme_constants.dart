import 'package:spam_delection_app/lib.dart';

class ThemeConstants {
  static const BoxDecoration decoration = BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10)));

  static ThemeData lightTheme() => ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColor.whiteLightColor,
      chipTheme: const ChipThemeData(
        selectedColor: AppColor.themeOrangeColor,
        // labelStyle: TextStyle(color: Colors.black),
      )
      // color: Colors.white,
      );

  static ThemeData darkTheme() => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColor.whiteLightColor,
        // color: Colors.white,
      );
}
