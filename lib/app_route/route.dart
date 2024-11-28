import 'package:flutter/material.dart';
import 'package:spam_delection_app/screens/check_spam_screen.dart';
import 'package:spam_delection_app/screens/device_call_logs.dart';
import 'package:spam_delection_app/screens/forgot_otp_verify_screen.dart';
import 'package:spam_delection_app/screens/forgot_password_screen.dart';
import 'package:spam_delection_app/screens/login_google_screen.dart';
import 'package:spam_delection_app/screens/login_succesful_screen.dart';
import 'package:spam_delection_app/screens/otp_verify_screen.dart';
import 'package:spam_delection_app/screens/plans_type_screen.dart';
import 'package:spam_delection_app/screens/protection_type_screen.dart';
import 'package:spam_delection_app/screens/register_google_screen.dart';
import 'package:spam_delection_app/screens/register_screen.dart';
import 'package:spam_delection_app/screens/reset_password_screen.dart';
import 'package:spam_delection_app/screens/splash_screen.dart';
import 'package:spam_delection_app/screens/welcome_screen.dart';

class AppRoutes {
  static const splash = "/splash";
  static const welcome = "/welcome";
  static const protectionType = "/protectionType";
  static const callLogs = "/callLogs";
  static const contactDetail = "/contactDetail";
  static const planType = "/planType";
}

final Map<String, WidgetBuilder> routes = {
  AppRoutes.splash: (context) => const Splash(),
  AppRoutes.welcome: (context) => const Welcome(),
  AppRoutes.protectionType: (context) => const ProtectionType(),
  AppRoutes.callLogs: (context) => const DeviceCallLogs(),
  AppRoutes.contactDetail: (context) => const CheckSpam(),
  AppRoutes.planType: (context) => const PlanType(),
  Welcome.routeName: (context) => const Welcome(),
  Register.routeName: (context) => const Register(),
  ForgotPassword.routeName: (context) => const ForgotPassword(),
  ForgotOtpVerify.routeName: (context) => const ForgotOtpVerify(),
  ResetPassword.routeName: (context) => const ResetPassword(),
  LoginGoogle.routeName: (context) => const LoginGoogle(),
  RegisterGoogle.routeName: (context) => const RegisterGoogle(),
  LoginSuccessful.routeName: (context) => const LoginSuccessful(),
  OtpVerify.routeName: (context) => const OtpVerify(),
};
