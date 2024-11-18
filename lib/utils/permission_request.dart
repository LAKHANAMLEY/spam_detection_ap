import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<PermissionStatus?> permissionRequest(Permission permission) async {
  var status = await permission.status;
  switch (status) {
    case PermissionStatus.denied:
      debugPrint("$status");
      status = await permission.request();
    case PermissionStatus.granted:
      debugPrint("$status");
    case PermissionStatus.restricted:
      debugPrint("$status");
      status = await permission.request();
    case PermissionStatus.limited:
      debugPrint("$status");
    case PermissionStatus.permanentlyDenied:
      debugPrint("$status");
    case PermissionStatus.provisional:
      debugPrint("$status");
  }
  return status;
}
