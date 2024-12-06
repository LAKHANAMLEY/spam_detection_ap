import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';
//isko v bloc event add kr dena
   Future<CountryLanguageResponse> fetchLanguages() async {
    final url = Uri.parse(ApiUrlConstants.endPointLanguageList);
    try {
      final response =
          await http.get(url, headers: await ApiUrlConstants.headers());

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return CountryLanguageResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (error) {
      throw Exception('Error fetching categories: $error');
    }
  }

