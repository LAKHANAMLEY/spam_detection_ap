import 'dart:developer';

import 'package:spam_delection_app/lib.dart';

Future<CountryData?> getAndSetDefaultCountry() async {
  try {
    var countryListResp = await getCountries();
    AppConstants.countryList = countryListResp.countrylist ?? [];
    List<CountryData> filteredCountries = [];
    var countryName = await SharedPref.getCountry();
    var country = getCountryByNameOrDialCode(countryName: countryName);
    if (country != null) {
      filteredCountries = [country];
    } else {
      filteredCountries = countryListResp.countrylist
              ?.where((e) => e.phonecode == "1" && e.name == "United States")
              .toList() ??
          [];
    }
    // var filteredCountries =
    //     countryListResp.countrylist?.where((e) => e.phonecode == "1",where((e))=>e.name=="United States");
    if (filteredCountries.isNotEmpty) {
      AppConstants.selectedCountry = filteredCountries.first;
    } else {
      AppConstants.selectedCountry = countryListResp.countrylist?.first;
    }
    log("Country ${AppConstants.selectedCountry?.name}");
    return AppConstants.selectedCountry;
  } catch (e) {
    throw Exception(e);
  }
}
