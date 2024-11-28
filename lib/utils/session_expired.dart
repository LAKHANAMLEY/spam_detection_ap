import 'package:flutter/material.dart';
import 'package:spam_delection_app/app_route/route.dart';
import 'package:spam_delection_app/data/shared_pref/shared_pref.dart';
import 'package:spam_delection_app/utils/toast.dart';

sessionExpired(context, String msg) {
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
