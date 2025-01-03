import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/models/dashboard_statistics_model.dart';

Future<DashboardStatisticsResponse> getDashboardStatistics(
    {required String days}) async {
  final response = await http.post(
      Uri.parse(ApiUrlConstants.dashboardStatistics),
      headers: await ApiUrlConstants.headers(),
      body: {'days': days});
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return DashboardStatisticsResponse.fromJson(jsonData);
  } else {
    throw Exception(response.body);
  }
}
