import 'package:shared_preferences/shared_preferences.dart';
import 'package:spam_delection_app/models/user_model.dart';

class SharedPref {
  static const String isLogin = "isLogin";
  static const String firstName = "firstName";
  static const String lastName = "lastName";
  static const String email = "email";
  static const String phone = "phone";
  static const String photo = "photo";
  static const String userId = "userId";
  static const String userName = "userName";
  static const String userRole = "userRole";
  static const String token = "token";
  static const String city = "city";
  static const String country = "country";
  static const String countryId = "countryId";
  static const String state = "state";
  static const String zip = "zip";

  static saveUserData(User? user) async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool(isLogin, true);
    pref.setString(firstName, user?.firstName ?? "");
    pref.setString(lastName, user?.lastName ?? "");
    pref.setString(email, user?.email ?? "");
    pref.setString(phone, user?.phone ?? "");
    pref.setString(photo, user?.photo ?? "");
    pref.setString(userId, user?.userId ?? "");
    pref.setString(userName, user?.userName ?? "");
    pref.setString(userRole, user?.userRole ?? "");
    if (user?.token?.isNotEmpty ?? false) {
      pref.setString(token, user?.token ?? "");
    }
    pref.setString(city, user?.city ?? "");
    pref.setString(country, user?.country ?? "");
    pref.setString(countryId, user?.countryId ?? "");
    pref.setString(state, user?.state ?? "");
    pref.setString(zip, user?.zip ?? "");
  }

  static Future<bool> clearAll() async {
    var pref = await SharedPreferences.getInstance();
    return pref.clear();
  }

  static Future<bool> getIsLogin() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getBool(isLogin) ?? false;
  }

  static Future<String> getUserId() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(userId) ?? "";
  }

  static Future<String> getToken() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(token) ?? "";
  }
}
