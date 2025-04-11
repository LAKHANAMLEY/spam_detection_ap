import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<TransactionHistoryDetailsResponse> getTransactionList() async {
  final response = await http.post(
    Uri.parse(ApiUrlConstants.transactionHistory),
    headers: await ApiUrlConstants.headers(),
  );
  print(response.body);
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return TransactionHistoryDetailsResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
