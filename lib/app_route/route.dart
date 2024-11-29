import 'package:flutter/material.dart';
import 'package:spam_delection_app/screens/bottom_navigation.dart';
import 'package:spam_delection_app/screens/contact_detail_screen.dart';
import 'package:spam_delection_app/screens/contact_list_screen.dart';
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
  static const bottomNavigation = "/bottomNavigation";
  static const callLogs = "/callLogs";
  static const contactList = "/contactList";
  static const contactDetail = "/contactDetail";
  static const planType = "/planType";
  static const register = "/register";
  static const forgotPwd = "/forgotPwd";
  static const forgotOTPVerification = "/forgotOTPVerification";
  static const resetPassword = "/resetPassword";
  static const loginWithGoogle = "/loginWithGoogle";
  static const registerWithGoogle = "/registerWithGoogle";
  static const loginSuccess = "/loginSuccess";
  static const otpVerification = "/otpVerification";
}

final Map<String, WidgetBuilder> routes = {
  AppRoutes.splash: (context) => const Splash(),
  AppRoutes.welcome: (context) => const Welcome(),
  AppRoutes.protectionType: (context) => const ProtectionType(),
  AppRoutes.bottomNavigation: (context) => const BottomNavigation(),
  AppRoutes.callLogs: (context) => const DeviceCallLogs(),
  AppRoutes.contactList: (context) => const ContactList(),
  AppRoutes.contactDetail: (context) => const ContactDetail(),
  AppRoutes.planType: (context) => const PlanType(),
  AppRoutes.register: (context) => const Register(),
  AppRoutes.forgotPwd: (context) => const ForgotPassword(),
  AppRoutes.forgotOTPVerification: (context) => const ForgotOtpVerify(),
  AppRoutes.resetPassword: (context) => const ResetPassword(),
  AppRoutes.loginWithGoogle: (context) => const LoginGoogle(),
  AppRoutes.registerWithGoogle: (context) => const RegisterGoogle(),
  AppRoutes.loginSuccess: (context) => const LoginSuccessful(),
  AppRoutes.otpVerification: (context) => const OtpVerify(),
};
