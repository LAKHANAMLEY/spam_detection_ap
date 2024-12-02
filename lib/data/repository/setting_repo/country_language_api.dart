import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

class ApiService {
  static Future<CountryLanguageResponse> fetchLanguagies() async {
    final url = Uri.parse(ApiUrlConstants.endPointLanguageList);
    try {
      final response =
          await http.get(url, headers: await ApiUrlConstants.headers());

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse.toString());

        // if (jsonResponse.containsKey('data') && jsonResponse['data'] is List) {
        //   final List<dynamic> data = jsonResponse['data'];
        //   return data.map((json) => CategoryListResponse.fromJson(json))
        //       .toList();
        // } else {
        //   throw Exception('Unexpected response format');
        // }
        return CountryLanguageResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (error) {
      throw Exception('Error fetching categories: $error');
    }
  }
}
