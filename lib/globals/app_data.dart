import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


int language = 0;

class AppData {
  static const int appStatus = 0;
  static const TextStyle appBarTitleStyle = TextStyle(
    fontSize: 22,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
  static final RegExp emailValidatorRegExp =
  RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static const TextStyle textFilledStyle = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.w500,
      fontSize: 14);
  // Defination of max length
  static const int emailMaxLength = 50;
  static const int passwordMaxLength = 16;
  static const int fullNameText = 50;
  static const int mobileMaxLenth = 15;
  static const int messageMaxLenth = 250;

  static const TextStyle textFilledHeading =
  TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500);
  static const SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );
}

class SuccessClass {

  final String title;
  final String message;

  SuccessClass({required this.title, required this.message});
}


