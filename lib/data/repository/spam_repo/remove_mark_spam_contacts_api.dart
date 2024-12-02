import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

//remove dl// model create nhi kiya abhi//sabhi api k liye model banane ki need nhi// yes sir actual abhi status same ho tab
//model usi api ka banaya jayega jiska data hm use kree
//remove spam ka only statuscode chahiye 200 401 201 to iske liye hmne common model banaya h ""Response""
Future<Response> removeSpam({
  required String contactId,
}) async {
  var body = {
    'contacts_id': contactId,
  };

  final response = await http.post(
    Uri.parse(ApiUrlConstants.endPointRemoveMarkSpam),
    headers: await ApiUrlConstants.headers(),
    body: body,
  );
  //api work nahi kr rhi qki endpoint wrong h
  print(body);
  // print('response.body ${response.body}');
  if (response.statusCode == 200) {
    print(response.body);
    final data = json.decode(response.body);
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
