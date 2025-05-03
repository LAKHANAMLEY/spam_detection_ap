import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:spam_delection_app/lib.dart'
    hide getAndSetDefaultCountry; // adjust import

import 'country_service.dart';
import 'country_service_test.mocks.dart';

@GenerateMocks([CountryService])
void main() {
  group('getAndSetDefaultCountry', () {
    late MockCountryService mockService;

    setUp(() {
      mockService = MockCountryService();
    });

    test('returns saved country if available', () async {
      final mockCountries = [
        CountryData(name: "India", phonecode: "91"),
        CountryData(name: "United States", phonecode: "1"),
      ];

      when(mockService.fetchCountries()).thenAnswer(
          (_) async => CountriesResponse(countrylist: mockCountries));
      when(mockService.getSavedCountry()).thenAnswer((_) async => "India");

      final result = await getAndSetDefaultCountry(mockService);

      expect(result?.name, "India");
    });

    test('returns United States if no saved country', () async {
      final mockCountries = [
        CountryData(name: "India", phonecode: "91"),
        CountryData(name: "United States", phonecode: "1"),
      ];

      when(mockService.fetchCountries()).thenAnswer(
          (_) async => CountriesResponse(countrylist: mockCountries));
      when(mockService.getSavedCountry()).thenAnswer((_) async => null);

      final result = await getAndSetDefaultCountry(mockService);

      expect(result?.name, "United States");
    });

    test('falls back to first country if no match', () async {
      final mockCountries = [
        CountryData(name: "Canada", phonecode: "1"),
        CountryData(name: "Mexico", phonecode: "52"),
      ];

      when(mockService.fetchCountries()).thenAnswer(
          (_) async => CountriesResponse(countrylist: mockCountries));
      when(mockService.getSavedCountry()).thenAnswer((_) async => "Brazil");

      final result = await getAndSetDefaultCountry(mockService);

      expect(result?.name, "Canada");
    });
  });
}
