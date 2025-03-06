import 'dart:developer';

import 'package:spam_delection_app/lib.dart';

// extension CountryHelper on CountryData {
CountryData? getCountryByNameOrDialCode(
    {String? countryName, String? dialCode, String? countryId}) {
  var filteredCountries = AppConstants.countryList.where((e) =>
      ((e.name == countryName) ||
          (e.phonecode == dialCode) ||
          (e.id == countryId)));
  log("${filteredCountries.length}");
  if (filteredCountries.isNotEmpty) {
    var selectedCountry = filteredCountries.first;
    print(selectedCountry.code ?? "");
    return selectedCountry;
  } else {
    print(AppConstants.selectedCountry?.code ?? "");
    return AppConstants.selectedCountry;
  }
}
// }
