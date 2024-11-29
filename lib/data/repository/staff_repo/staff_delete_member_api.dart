import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spam_delection_app/models/common_response_model.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';
import '../../../models/family_delete_member_model.dart';

Future<CommonResponse> staffDeleteMember({
  required staffId,

}) async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointFamilyEditMember),
    headers: await ApiUrlConstants.headers(),
    body: {
      'staff_id': staffId,
    },
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return CommonResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
