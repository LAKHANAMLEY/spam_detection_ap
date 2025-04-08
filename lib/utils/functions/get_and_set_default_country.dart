import 'dart:developer';

import 'package:spam_delection_app/lib.dart';

Future<CountryData?> getAndSetDefaultCountry() async {
  var countryListResp = await getCountries();
  AppConstants.countryList = countryListResp.countrylist ?? [];
  var filteredCountries =
      countryListResp.countrylist?.where((e) => e.phonecode == "1");
  if (filteredCountries?.isNotEmpty ?? false) {
    AppConstants.selectedCountry = filteredCountries?.first;
  } else {
    AppConstants.selectedCountry = countryListResp.countrylist?.first;
  }
  log("Country ${AppConstants.selectedCountry?.name}");
  return AppConstants.selectedCountry;
}
