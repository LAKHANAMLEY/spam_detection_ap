import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spam_delection_app/lib.dart';

int language = 0;
var userBloc = ApiBloc(ApiBlocInitialState());
var sharedPrefBloc = SharedPrefBloc(SharedPrefInitialState());
var contactListBloc = ApiBloc(ApiBlocInitialState());
var callLogsListBloc = ApiBloc(ApiBlocInitialState());
final localizationBloc =
    LocalizationBloc(ChangeLocaleState(const Locale("en")));

Size screenSize(BuildContext context) => MediaQuery.of(context).size;
bool isDarkMode(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;
TextTheme textTheme(context) => Theme.of(context).textTheme;
AppLocalizations appLocalization(context) => AppLocalizations.of(context)!;
S getText(context) => S.of(context);

class AppConstants {
  static const String projectName = "Spam detector";

  static const int appStatus = 0;
  static const TextStyle appBarTitleStyle = TextStyle(
    fontSize: 22,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
  static final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static const TextStyle textFilledStyle =
      TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 14);

  // Definition of max length
  static const int emailMaxLength = 50;
  static const int passwordMaxLength = 16;
  static const int fullNameText = 50;
  static const int mobileMaxLength = 15;
  static const int messageMaxLength = 250;

  static const TextStyle textFilledHeading =
      TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500);
  static const SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );

  static CountryData? selectedCountry;
}
