
import 'package:flutter/material.dart';


import '../bloc/localization_bloc/localization_bloc.dart';
import '../bloc/localization_bloc/localization_bloc_states.dart';

class AppConstants {
  static const String projectName = "Spam detector";

  static TextTheme textTheme(context) => Theme.of(context).textTheme;
  static AppLocalizations appLocalization(context) =>
      AppLocalizations.of(context)!;
  static Size screenSize(BuildContext context) => MediaQuery.of(context).size;
  static bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}

class AppLocalizations {
  static of(context) {}
}

final localizationBloc =
LocalizationBloc(ChangeLocaleState(const Locale("en")));
