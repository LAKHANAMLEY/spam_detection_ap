import 'package:shared_preferences/shared_preferences.dart';
import 'package:spam_delection_app/models/user_model.dart';

class SharedPref {
  static const String _isLogin = "isLogin";
  static const String _firstName = "firstName";
  static const String _lastName = "lastName";
  static const String _email = "email";
  static const String _phone = "phone";
  static const String _photo = "photo";
  static const String _userId = "userId";
  static const String _corporateId = "corporateId";
  static const String _crn = "corporateId";
  static const String _userName = "userName";
  static const String _name = "name";
  static const String _userRole = "userRole";
  static const String _token = "token";
  static const String _address = "address";
  static const String _address2 = "address2";
  static const String _city = "city";
  static const String _country = "country";
  static const String _countryCode = "countryCode";
  static const String _countryId = "countryId";
  static const String _state = "state";
  static const String _zip = "zip";
  static const String _gender = "gender";
  static const String _dob = "dob";

  // static Future<SharedPreferences> get pref async =>
  //     await SharedPreferences.getInstance();

  static saveUserData(User? user) async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool(_isLogin, true);
    pref.setString(_firstName, user?.firstName ?? "");
    pref.setString(_lastName, user?.lastName ?? "");
    pref.setString(_email, user?.email ?? "");
    pref.setString(_phone, user?.phone ?? "");
    pref.setString(_photo, user?.photo ?? "");
    pref.setString(_userId, user?.userId ?? "");
    pref.setString(_corporateId, user?.corporateId ?? "");
    pref.setString(_crn, user?.crn ?? "");
    pref.setString(_userName, user?.userName ?? "");
    pref.setString(_name, user?.name ?? "");
    pref.setString(_userRole, user?.userRole ?? "");
    if (user?.token?.isNotEmpty ?? false) {
      pref.setString(_token, user?.token ?? "");
    }
    pref.setString(_address, user?.address ?? "");
    pref.setString(_address2, user?.address2 ?? "");
    pref.setString(_city, user?.city ?? "");
    pref.setString(_country, user?.country ?? "");
    pref.setString(_countryCode, user?.countryCode ?? "");
    pref.setString(_countryId, user?.countryId ?? "");
    pref.setString(_state, user?.state ?? "");
    pref.setString(_zip, user?.zip ?? "");
    pref.setString(_gender, user?.gender ?? "");
    pref.setString(_dob, user?.dob.toString() ?? "");
  }

  static Future<bool> clearAll() async {
    var pref = await SharedPreferences.getInstance();
    return pref.clear();
  }

  static Future<bool> getIsLogin() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getBool(_isLogin) ?? false;
  }

  static Future<String> getUserId() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_userId) ?? "";
  }

  static Future<String> getCorporateId() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_corporateId) ?? "";
  }

  static Future<String> getCrn() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_crn) ?? "";
  }

  static Future<String> getToken() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_token) ?? "";
  }

  static Future<String> getName() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_name) ?? "";
  }

  static Future<String> getUserName() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_userName) ?? "";
  }

  static Future<String> getFirstName() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_firstName) ?? "";
  }

  static Future<String> getLastName() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_lastName) ?? "";
  }

  static Future<String> getEmail() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_email) ?? "";
  }

  static Future<String> getPhone() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_phone) ?? "";
  }

  static Future<String> getPhoto() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_photo) ?? "";
  }

  static Future<String> getGender() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_gender) ?? "";
  }

  static Future<String> getDOB() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_dob) ?? "";
  }

  static Future<String> getCountry() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_country) ?? "";
  }

  static Future<String> getCountryCode() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_countryCode) ?? "";
  }

  static Future<String> getCountryId() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_countryId) ?? "";
  }

  static Future<String> getState() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_state) ?? "";
  }

  static Future<String> getCity() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_city) ?? "";
  }

  static Future<String> getZip() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_zip) ?? "";
  }

  static Future<String> getAddress() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_address) ?? "";
  }

  static Future<String> getAddress2() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_address2) ?? "";
  }
}
