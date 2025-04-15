import 'package:spam_delection_app/lib.dart';

extension StringExt on String {
  String splitFirstBy(String pattern) => split(pattern).first;

  PhoneData separatePhoneAndPhoneCode() {
    //TODO: get countries list by server
    var filteredCountries =
        AppConstants.countryList.where((e) => contains("+${e.phonecode}"));
    if (filteredCountries.isNotEmpty) {
      var country = filteredCountries.first;
      var phone = split("+${country.phonecode}").last;
      return PhoneData(phone: phone, phoneCode: country.phonecode);
    } else {
      return PhoneData(phone: this, phoneCode: "");
    }
  }

  String? convertInMinSec() {
    Duration duration = Duration(seconds: int.tryParse(this) ?? 0);
    return duration.inMinutes > 0
        ? "${duration.inMinutes} min ${duration.inSeconds % 60} sec"
        : "${duration.inSeconds % 60} sec";
  }
}
