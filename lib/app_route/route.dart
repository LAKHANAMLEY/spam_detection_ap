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



final Map<String, WidgetBuilder> routes = {
  Splash.routeName: (context) => Splash(),
  Welcome.routeName: (context) => const Welcome(),
  Register.routeName: (context)=>const Register(),
  ForgotPassword.routeName:(context)=>const ForgotPassword(),
  ForgotOtpVerify.routeName:(context)=>const ForgotOtpVerify(),
  ResetPassword.routeName:(context)=>const ResetPassword(),
  LoginGoogle.routeName:(context)=>const LoginGoogle(),
  RegisterGoogle.routeName:(context)=>const RegisterGoogle(),
  LoginSuccessful.routeName:(context)=>const LoginSuccessful(),
  OtpVerify.routeName:(context)=> const OtpVerify(),


};


