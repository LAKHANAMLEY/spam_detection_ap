import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<BlockedContactListResponse> blockContact() async {
  final response = await http.get(
    Uri.parse(ApiUrlConstants.endPointBlockContactsList),
    headers: await ApiUrlConstants.headers(),
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return BlockedContactListResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
