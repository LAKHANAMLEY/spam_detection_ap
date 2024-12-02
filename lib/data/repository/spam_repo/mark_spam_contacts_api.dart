import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<MarkSpamResponse> markSpam({
  required String contactId,
  required String comment,
  required String numberType,
  required String categoryId,
  required String phone,
}) async {
  var body = {
    'contacts_id': contactId,
    'comments': comment,
    'number_type': numberType,
    'category_id': categoryId,
    'phone': phone,
  };

  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointMarkSpamContacts),
    headers: await ApiUrlConstants.headers(),
    body: body,
  );
  //api work nahi kr rhi qki endpoint wrong h
  print(body);
  // print('response.body ${response.body}');
  if (response.statusCode == 200) {
    print(response.body);
    final data = json.decode(response.body);
    return MarkSpamResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
