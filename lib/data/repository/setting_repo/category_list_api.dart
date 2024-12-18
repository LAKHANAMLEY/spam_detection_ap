import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';
import '../../../models/category_list_model.dart';
class ApiService {

 static Future<CategoryListResponse> fetchCategories() async {
    final url = Uri.parse(ApiUrlConstants.endPointCategoryList);
    try {
      final response = await http.get(url, headers:await ApiUrlConstants.headers());

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
        return CategoryListResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (error) {
      throw Exception('Error fetching categories: $error');
    }
  }

}