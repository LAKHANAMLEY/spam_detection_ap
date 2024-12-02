import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

Future<PlanListResponse> getPlanList() async {
  final response = await http.get(
    Uri.parse(ApiUrlConstants.endPointPlansList),
    headers: await ApiUrlConstants.headers(),
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return PlanListResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
