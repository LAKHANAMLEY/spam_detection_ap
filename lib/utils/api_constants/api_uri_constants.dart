import 'package:spam_delection_app/lib.dart';

class ApiUrlConstants {
  static Future<Map<String, String>> headers() async => <String, String>{
        "X-API-KEY": ApiKeyConstants.apiKey,
        "Authorization": await SharedPref.getToken()
      };
  static String baseUrl = 'https://portal.broadlinkprotect.com/api/v1';

  static String loginWithEmailPassword =
      '$baseUrl/auth/login-with-email?lang=${AppConstants.selectedLanguage}';

  static String loinWithMobile =
      '$baseUrl/auth/login?lang=${AppConstants.selectedLanguage}';
  static String loginWithUserNameAndPassword =
      '$baseUrl/auth/login-with-username?lang=${AppConstants.selectedLanguage}';

  static String signUp =
      '$baseUrl/auth/signup?lang=${AppConstants.selectedLanguage}';

  static String socialSignup =
      '$baseUrl/auth/social-signup?lang=${AppConstants.selectedLanguage}';

  static String completeSignup =
      '$baseUrl/auth/completesignup?lang=${AppConstants.selectedLanguage}';

  static String logout =
      '$baseUrl/auth/logout?lang=${AppConstants.selectedLanguage}';

  static String forgotPassword =
      '$baseUrl/auth/forgetpassword?lang=${AppConstants.selectedLanguage}';

  static String forgotPasswordByOTP =
      '$baseUrl/auth/forgetpassword-by-otp?lang=${AppConstants.selectedLanguage}';

  static String resetPassword =
      '$baseUrl/auth/resetpassword?lang=${AppConstants.selectedLanguage}';

  static String resetPasswordByOTP =
      '$baseUrl/auth/resetpassword-by-otp?lang=${AppConstants.selectedLanguage}';
  static String endPointCountriesList = '$baseUrl/settings/get-country-list';

  static String languageList = '$baseUrl/settings/get-language-list';

  static String corporateLogin =
      '$baseUrl/auth/corporate-login?lang=${AppConstants.selectedLanguage}';

  static String setUserOnlineOffline =
      "$baseUrl/auth/set-user-online-or-offline";

  static String contactList = '$baseUrl/contacts/contacts-list';

  static String syncContacts = '$baseUrl/contacts/sync-contact';

  //static String changePassword = '$baseUrl/user/changepassword?lang=${AppConstants.selectedLanguage}';
  //basic
  static String editProfile =
      '$baseUrl/user/editprofile?lang=${AppConstants.selectedLanguage}';
  static String updateProfile =
      '$baseUrl/user/updateprofile?lang=${AppConstants.selectedLanguage}';
  static String changeSecurityPin =
      '$baseUrl/user/changesecuritypin?lang=${AppConstants.selectedLanguage}';
  static String changePassword =
      '$baseUrl/user/changepassword?lang=${AppConstants.selectedLanguage}';
  static String getUserDetails = '$baseUrl/user/getdetails/';

  //family_member
  static String familyMembersList = '$baseUrl/family/getmemberslist';
  static String familyMemberDetails = '$baseUrl/family/getmemberdetails/';
  static String addFamilyMember =
      '$baseUrl/family/add-member?lang=${AppConstants.selectedLanguage}';
  static String editFamilyMember =
      '$baseUrl/family/edit-member?lang=${AppConstants.selectedLanguage}';
  static String deleteFamilyMember =
      '$baseUrl/family/delete-member?lang=${AppConstants.selectedLanguage}';

  //plans
  static String plansList = '$baseUrl/plans/getlist';

  //setting
  static String categoryList = '$baseUrl/settings/get-category-list';
  static String numberType = '$baseUrl/settings/get-number-type';
  static String callDurationUnit = '$baseUrl/settings/get-call-duration-unit';
  static String callType = '$baseUrl/settings/get-call-type';

  //block
  static String blockContactsList = '$baseUrl/contacts/block-contacts-list';
  static String unblockContacts = '$baseUrl/contacts/block-unblock-contacts';

  // spam
  static String spamList = '$baseUrl/contacts/spam-contacts-list';
  static String markSpamContacts = '$baseUrl/contacts/mark-spam-contacts';
  static String removeSpam = '$baseUrl/contacts/remove-spam-contacts';

  //contact
  static String addContact = '$baseUrl/contacts/add-contacts';
  static String editContacts = '$baseUrl/contacts/edit-contacts';
  static String deleteContacts = '$baseUrl/contacts/delete-contacts';
  static String checkSpamContacts = '$baseUrl/contacts/is-phone-number-spam';
  static String contactDetail = '$baseUrl/contacts/contact-details';

  //call logs
  static String syncCallLogs = "$baseUrl/contacts/sync-call-log";
  static String getCallLogs = "$baseUrl/contacts/call-log-list";

  // corporate
  static String editCorporateProfile =
      '$baseUrl/corporate/editprofile?lang=${AppConstants.selectedLanguage}';

  //staff
  static String staffMemberList = '$baseUrl/staff/getmemberslist';
  static String staffMemberDetails = '$baseUrl/staff/getmemberdetails/';
  static String addStaffMember =
      '$baseUrl/staff/add-member?lang=${AppConstants.selectedLanguage}';
  static String editStaffMember =
      '$baseUrl/staff/edit-member?lang=${AppConstants.selectedLanguage}';
  static String deleteStaffMember =
      '$baseUrl/staff/delete-member?lang=${AppConstants.selectedLanguage}';

  //notification
  static String notificationList =
      '$baseUrl/notifications/get-notifications-list';
  static String enableDisableNotification =
      '$baseUrl/notifications/enable-disable-notifications';
  static String notificationType =
      '$baseUrl/notifications/get-notifications-types';

  // call
  static String syncCallLog = '$baseUrl/contacts/sync-call-log';
  static String getCallLogList = '$baseUrl/contacts/call-log-list';
  static String deleteCallLog =
      '$baseUrl/contacts/delete-call-log?lang=${AppConstants.selectedLanguage}';
  static String deleteAllCallLog =
      '$baseUrl/contacts/delete-all-call-log?lang=${AppConstants.selectedLanguage}';
  static String syncCallLogManually =
      '$baseUrl/contacts/sync-call-log-manually';
}
