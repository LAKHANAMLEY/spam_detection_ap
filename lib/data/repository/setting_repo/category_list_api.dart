import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

import '../../../models/category_list_model.dart';

Future<CategoryListResponse> getCategories() async {
  final url = Uri.parse(ApiUrlConstants.endPointCategoryList);
  try {
    final response =
        await http.get(url, headers: await ApiUrlConstants.headers());
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return CategoryListResponse.fromJson(jsonResponse);
    } else {
      throw Exception(response.body);
    }
  } catch (error) {
    throw Exception('Error fetching categories: $error');
  }
}
