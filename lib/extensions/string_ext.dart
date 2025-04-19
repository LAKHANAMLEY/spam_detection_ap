import 'package:spam_delection_app/lib.dart';

extension StringExt on String {
  bool get isNumber => num.tryParse(this) != null;
  String splitFirstBy(String pattern) => split(pattern).first;

  PhoneData separatePhoneAndPhoneCode() {
    // var country = lib.CountryWithPhoneCode.us();
    // final formattedNumber = lib.formatNumberSync(this);
    // // log("Lib phonenumber formatted number: $formattedNumber");
    // try {
    //   var phone = PhoneNumber.parse(
    //     formattedNumber,
    //     // callerCountry:
    //     //     IsoCode.fromJson(AppConstants.selectedCountry?.code ?? ""),
    //   );
    //   // log("Phone number parser number ${phone.countryCode} ${phone.nsn}");
    //   // log("$country $this --> $formattedNumber ---> ${phone.countryCode} ${phone.nsn}");
    //   return PhoneData(phone: phone.nsn, phoneCode: phone.countryCode);
    // } catch (e) {
    //   return PhoneData(phone: formattedNumber, phoneCode: "");
    // }

    // TODO: get countries list by server
    // var filteredCountries =
    //     AppConstants.countryList.where((e) => contains("+${e.phonecode}"));
    // if (filteredCountries.isNotEmpty) {
    //   var country = filteredCountries.first;
    //   var phone = split("+${country.phonecode}").last;
    //   return PhoneData(phone: phone, phoneCode: country.phonecode);
    // } else {
    //   return PhoneData(phone: this, phoneCode: "");
    // }

    ///Chat GPT
    // Ensure the number starts with '+'
    // String normalizedNumber = startsWith('+') ? this : '+$this';
    // log(normalizedNumber);

    var filteredCountries =
        AppConstants.countryList.where((e) => startsWith("+${e.phonecode}"));

    if (filteredCountries.isNotEmpty) {
      var country = filteredCountries.first;
      var phoneCode = country.phonecode;
      var phone = substring(("+$phoneCode").length);

      return PhoneData(phone: phone, phoneCode: phoneCode);
    } else {
      return PhoneData(phone: this, phoneCode: "");
    }

    ///Chat GPT modified
    // Remove any non-digit characters just to be safe (e.g., spaces, dashes)
    // String cleaned = replaceAll(RegExp(r'[^\d+]'), '');

    // // Normalize by ensuring it starts with +
    // String normalizedNumber = cleaned.startsWith('+') ? cleaned : '+$cleaned';

    // // Sort country list by phone code length descending to match longest code first
    // var sortedCountries = AppConstants.countryList.toList()
    //   ..sort((a, b) =>
    //       b.phonecode?.length.compareTo(a.phonecode?.length ?? 0) ?? 0);

    // for (var country in sortedCountries) {
    //   String code = "+${country.phonecode}";
    //   if (normalizedNumber.startsWith(code)) {
    //     // Make sure the remaining part is of reasonable mobile number length
    //     String remaining = normalizedNumber.substring(code.length);
    //     if (remaining.length >= 6) {
    //       return PhoneData(phone: remaining, phoneCode: country.phonecode);
    //     }
    //   }
    // }

    // // No match found – assume it's a local number without country code
    // return PhoneData(phone: this, phoneCode: "");
  }

  String? convertInMinSec() {
    Duration duration = Duration(seconds: int.tryParse(this) ?? 0);
    return duration.inMinutes > 0
        ? "${duration.inMinutes} min ${duration.inSeconds % 60} sec"
        : "${duration.inSeconds % 60} sec";
  }
}
