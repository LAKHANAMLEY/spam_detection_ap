import 'package:intl_phone_field/countries.dart';
import 'package:spam_delection_app/lib.dart';

extension StringExt on String {
  String splitFirstBy(String pattern) => split(pattern).first;
  PhoneData separeatePhoneAndPhoneCode() {
    //TODO: get countries list by server
    var filteredCountries = countries.where((e) => contains("+${e.dialCode}"));
    if (filteredCountries.isNotEmpty) {
      var country = filteredCountries.first;
      var phone = split("+${country.dialCode}").last;
      return PhoneData(phone: phone, phoneCode: country.dialCode);
    } else {
      return PhoneData(
          phone: this, phoneCode: AppConstants.selectedCountry?.phonecode);
    }
  }

  String convertInMinSec() {
    Duration duration = Duration(seconds: int.parse(this));
    return duration.inMinutes > 0
        ? "${duration.inMinutes} min ${duration.inSeconds % 60} sec"
        : "${duration.inSeconds % 60} sec";
  }
}
