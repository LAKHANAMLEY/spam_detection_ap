import 'dart:developer';

import 'package:spam_delection_app/data/repository/setting_repo/countries_api.dart';
import 'package:spam_delection_app/data/shared_pref/shared_pref.dart';
import 'package:spam_delection_app/extensions/country_ext.dart';
import 'package:spam_delection_app/globals/app_constants.dart';
import 'package:spam_delection_app/data/models/common/country_list_model.dart';

abstract class CountryService {
  Future<String?> getSavedCountry();
  Future<CountriesResponse> fetchCountries();
}

class DefaultCountryService implements CountryService {
  @override
  Future<String?> getSavedCountry() => SharedPref.getCountry();

  @override
  Future<CountriesResponse> fetchCountries() => getCountries();
}

Future<CountryData?> getAndSetDefaultCountry(CountryService service) async {
  try {
    var countryListResp = await service.fetchCountries();
    AppConstants.countryList = countryListResp.countrylist ?? [];

    var countryName = await service.getSavedCountry();
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
