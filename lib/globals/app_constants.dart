import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_bloc.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_state.dart';
import 'package:spam_delection_app/bloc/shared_pref_bloc/shared_pref_bloc.dart';
import 'package:spam_delection_app/bloc/shared_pref_bloc/shared_pref_state.dart';

int language = 0;
var userBloc = ApiBloc(ApiBlocInitialState());
var sharedPrefBloc = SharedPrefBloc(SharedPrefInitialState());
var contactListBloc = ApiBloc(ApiBlocInitialState());

class AppConstant {
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
}
