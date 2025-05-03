import 'dart:developer';

import 'package:spam_delection_app/lib.dart';

Future<CountryData?> getAndSetDefaultCountry() async {
  try {
    var countryListResp = await getCountries();
    AppConstants.countryList = countryListResp.countrylist ?? [];

    var countryName = await SharedPref.getCountry();
    var country = getCountryByNameOrDialCode(countryName: countryName);

    CountryData? selected = country;

    selected ??= AppConstants.countryList.firstWhere(
      (e) => e.phonecode == "1" && e.name == "United States",
      orElse: () => AppConstants.countryList.first,
    );

    AppConstants.selectedCountry = selected;
    log("Country ${AppConstants.selectedCountry?.name}");
    return selected;
  } catch (e) {
    log('Error in getAndSetDefaultCountry: $e');
    rethrow;
  }
}
