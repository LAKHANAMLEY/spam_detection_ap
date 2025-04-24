import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<SpamContactListResponse> getSpamContacts() async {
  print(await ApiUrlConstants.headers());
  final response = await http.get(
    Uri.parse(ApiUrlConstants.spamContactList),
    headers: await ApiUrlConstants.headers(),
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return SpamContactListResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
