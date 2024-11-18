import 'package:spam_delection_app/data/shared_pref/shared_pref.dart';
import 'package:spam_delection_app/utils/api_keys/api_key_constants.dart';

class ApiUrlConstants {
  static Future<Map<String, String>> headers() async => <String, String>{
        "X-API-KEY": ApiKeyConstants.apiKey,
        "Authorization": await SharedPref.getToken()
      };
  static String baseUrl = 'https://broadlinkprotect.com/api/v1';

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

  static String endPointCorporateLogin =
      '$baseUrl/auth/corporate-login?lang=en';

  static String contactList = '$baseUrl/contacts/contacts-list';

  static String syncContacts = '$baseUrl/contacts/sync-contact';

  static String changePassword = '$baseUrl/user/changepassword?lang=en';
}
