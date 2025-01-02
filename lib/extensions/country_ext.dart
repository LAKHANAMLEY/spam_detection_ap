import 'package:spam_delection_app/lib.dart';

// extension CountryHelper on CountryData {
CountryData? getCountryByNameOrDialCode(
    {String? countryName, String? dialCode}) {
  var filteredCountries = AppConstants.countryList.where((e) =>
      (e.name?.contains(countryName ?? "") ?? false) ||
      (e.name?.contains(dialCode ?? "") ?? false));
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
