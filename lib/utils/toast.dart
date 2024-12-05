import 'package:fluttertoast/fluttertoast.dart';

showToast(dynamic msg) => Fluttertoast.showToast(msg: msg?.toString() ?? "");
