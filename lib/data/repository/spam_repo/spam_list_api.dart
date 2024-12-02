import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<SpamListResponse> getSpams() async {
  print(await ApiUrlConstants.headers());
  final response = await http.get(
    Uri.parse(ApiUrlConstants.endPointSpamList),
    headers: await ApiUrlConstants.headers(),
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return SpamListResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
