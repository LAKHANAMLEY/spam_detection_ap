import 'package:spam_delection_app/lib.dart';

class ApiUrlConstants {
  static Future<Map<String, String>> headers() async => <String, String>{
        "X-API-KEY": ApiKeyConstants.apiKey,
        "Authorization": await SharedPref.getToken()
      };
  static String baseUrl = 'https://portal.broadlinkprotect.com/api/v1';

  static String endPointEmailPassword =
      '$baseUrl/auth/login-with-email?lang=en';

  static String endPointMobile = '$baseUrl/auth/login?lang=en';
  static String endPointUsername = '$baseUrl/auth/login-with-username?lang=en';

  static String endPointSignup = '$baseUrl/auth/signup?lang=en';

  static String endPointSocialSignup = '$baseUrl/auth/social-signup?lang=en';

  static String endPointCompleteSignup = '${baseUrl}uth/completesignup?lang=en';

  static String endPointLogout = '${{baseUrl}}/auth/logout?lang=en';

  static String endPointForgotPassword = '$baseUrl/auth/forgetpassword?lang=en';

  static String endPointForgotPasswordOTP =
      '$baseUrl/auth/forgetpassword-by-otp?lang=en';

  static String endPointResetPassword = '$baseUrl/auth/resetpassword?lang=en';

  static String endPointResetPasswordOTP =
      '$baseUrl/auth/resetpassword-by-otp?lang=en';
  static String endPointCountriesList = '$baseUrl/settings/get-country-list';

  static String endPointLanguageList = '$baseUrl/settings/get-language-list';

  static String endPointCorporateLogin =
      '$baseUrl/auth/corporate-login?lang=en';

  static String contactList = '$baseUrl/contacts/contacts-list';

  static String syncContacts = '$baseUrl/contacts/sync-contact';

  //static String changePassword = '$baseUrl/user/changepassword?lang=en';
  //basic
  static String endPointEditProfile = '$baseUrl/user/editprofile?lang=en';
  static String endPointUpdateProfile = '$baseUrl/user/updateprofile?lang=en';
  static String endPointChangeSecurityPin =
      '$baseUrl/user/changesecuritypin?lang=en';
  static String changePassword = '$baseUrl/user/changepassword?lang=en';
  static String getUserDetails = '$baseUrl/user/getdetails/';

  //family_member
  static String endPointFamilyMembersList = '$baseUrl/family/getmemberslist';
  static String endPointFamilyMemberDetails =
      '$baseUrl/family/getmemberdetails/49';
  static String endPointFamilyAddMember = '$baseUrl/family/add-member?lang=en';
  static String endPointFamilyEditMember =
      '$baseUrl/family/edit-member?lang=en';
  static String endPointFamilyDeleteMember =
      '$baseUrl/family/delete-member?lang=en';

  //plans
  static String endPointPlansList = '$baseUrl/plans/getlist';

  //setting
  static String endPointCategoryList = '$baseUrl/settings/get-category-list';
  static String endPointNumberType = '$baseUrl/settings/get-number-type';
  static String endPointCallDurationUnit =
      '$baseUrl/settings/get-call-duration-unit';
  static String endPointCallType = '$baseUrl/settings/get-call-type';

  //block
  static String endPointBlockContactsList =
      '$baseUrl/contacts/block-contacts-list';
  static String endPointUnblockContacts =
      '$baseUrl/contacts/block-unblock-contacts';

  // spam
  static String endPointSpamList = '$baseUrl/contacts/spam-contacts-list';
  static String endPointMarkSpamContacts =
      '$baseUrl/contacts/mark-spam-contacts';
  static String endPointRemoveMarkSpam =
      '$baseUrl/contacts/remove-spam-contacts';

  //contact
  static String addContact = '$baseUrl/contacts/add-contacts';
  static String endPointEditContacts = '$baseUrl/contacts/edit-contacts';
  static String endPointDeleteContacts = '$baseUrl/contacts/delete-contacts';
  static String endPointCheckSpamContacts =
      '$baseUrl/contacts/is-phone-number-spam';

  //call logs
  static String syncCallLogs = "$baseUrl/contacts/sync-call-log";
  static String getCallLogs = "$baseUrl/contacts/call-log-list";

  // corporate
  static String endPointCorporateEditProfile =
      '$baseUrl/corporate/editprofile?lang=en';

  //staff
  static String endPointStaffMemberList = '$baseUrl/staff/getmemberslist';
  static String endPointStaffMemberDetails =
      '$baseUrl/staff/getmemberdetails/49';
  static String endPointStaffAddMember = '$baseUrl/staff/add-member?lang=en';
  static String endPointStaffEditMember = '$baseUrl/staff/edit-member?lang=en';
  static String endPointStaffDeleteMember =
      '$baseUrl/staff/delete-member?lang=en';

  //notification
  static String endPointNotificationList =
      '$baseUrl/notifications/get-notifications-list';
  static String endPointEnabledDisabaled =
      '$baseUrl/notifications/enable-disable-notifications';
  static String endPointNotificationType =
      '$baseUrl/notifications/get-notifications-types';

  // call log
  static String endPointSyncCallLog = '$baseUrl/contacts/sync-call-log';
  static String endPointgetCallLogList = '$baseUrl/contacts/call-log-list';
  static String endPointDeleteCallLog =
      '$baseUrl/contacts/delete-call-log?lang=en';
  static String endPointDeleteAllCallLog =
      '$baseUrl/contacts/delete-all-call-log?lang=en';
}
