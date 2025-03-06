import 'package:spam_delection_app/lib.dart';

sessionExpired(context, String? msg) {
  showToast(msg);
  // ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(content: Text(msg ?? "")),
  // );
  SharedPref.clearAll();
  Navigator.of(context).pushNamedAndRemoveUntil(
    AppRoutes.welcome,
    (route) => false,
  );
}
