import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/models/api_body_model/purchase_plan_model.dart';

Future<Response> purchasePlan(
    {required PurchasePlanModel purchasePlanData}) async {
  var body = purchasePlanData.toJson();
  final response = await http.post(
    Uri.parse(ApiUrlConstants.purchasePlan),
    headers: await ApiUrlConstants.headers(),
    body: body,
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return Response.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
