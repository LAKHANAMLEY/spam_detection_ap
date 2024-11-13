import 'package:flutter/material.dart';
import 'package:spam_delection_app/screens/forgot_otp_verify_screen.dart';
import 'package:spam_delection_app/screens/forgot_password_screen.dart';

import 'package:spam_delection_app/screens/login_google_screen.dart';
import 'package:spam_delection_app/screens/login_succesful_screen.dart';
import 'package:spam_delection_app/screens/otp_verify_screen.dart';
import 'package:spam_delection_app/screens/protection_type_screen.dart';
import 'package:spam_delection_app/screens/register_google_screen.dart';
import 'package:spam_delection_app/screens/register_screen.dart';
import 'package:spam_delection_app/screens/reset_password_screen.dart';
import 'package:spam_delection_app/screens/splash_screen.dart';

import 'package:spam_delection_app/screens/welcome_screen.dart';

class AppRoutes{
  static const splash = "/splash"; //ese banana h or
}

final Map<String, WidgetBuilder> routes = { // yes same error route the isliye mene hata diya tha sir
  Splash.routeName: (context) => Splash(),
  AppRoutes.splash: (context) => Splash(),// ese use krna h ok

  Welcome.routeName: (context) => const Welcome(),
  Register.routeName: (context)=>const Register(),
  ForgotPassword.routeName:(context)=>const ForgotPassword(),
  ForgotOtpVerify.routeName:(context)=>const ForgotOtpVerify(),// optional banana pdega
  ResetPassword.routeName:(context)=>const ResetPassword(),
  LoginGoogle.routeName:(context)=>const LoginGoogle(),
  RegisterGoogle.routeName:(context)=>const RegisterGoogle(),
  LoginSuccessful.routeName:(context)=>const LoginSuccessful(),
  OtpVerify.routeName:(context)=> const OtpVerify(),


};


