import 'package:spam_delection_app/lib.dart';

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
  static const familyMemberList = "/familyMemberList";
  static const familyAddMember = "/familyAddMember";
  static const familyEditMember = "/familyEditMember";
  static const staffMember = "/staffMember";
  static const editStaffMember = "/editStaffMember";
  static const alternativeEmail = "/alternativeEmail";
  static const notificationList = "/notificationList";
  static const planDetail = "/planDetail";

// static const contactDetail = "/contactDetail";
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
  AppRoutes.familyMemberList: (context) => const FamilyMemberList(),
  AppRoutes.familyAddMember: (context) => const AddFamilyMember(),
  AppRoutes.familyEditMember: (context) => const EditFamilyMember(),
  AppRoutes.staffMember: (context) => const StaffMemberList(),
  AppRoutes.editStaffMember: (context) => const EditStaffMember(),
  AppRoutes.alternativeEmail: (context) => const AlternativeEmail(),
  AppRoutes.notificationList: (context) => const NotificationList(),
  AppRoutes.planDetail: (context) => const PlanDetail(),

  // AppRoutes.contactDetail: (context) => const ContactDetail(),
};
