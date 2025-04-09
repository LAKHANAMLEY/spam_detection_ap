import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/models/api_body_model/transaction_history_details_model.dart';

Future<TransactionHistoryDetailsResponse> getTransactionList() async {
  final response = await http.get(
    Uri.parse(ApiUrlConstants.transactionHistory),
    headers: await ApiUrlConstants.headers(),
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return TransactionHistoryDetailsResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
