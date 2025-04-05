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
      openAppSettings();
      debugPrint("$status");
    case PermissionStatus.provisional:
      debugPrint("$status");
  }
  return status;
}

Future<void> requestMultiplePermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.contacts,
    Permission.sms,
    Permission.systemAlertWindow,
    Permission.notification,
    Permission.camera,
    Permission.photos, // or Permission.storage for older versions
    Permission.storage, //For read and write external storage, if you need this.
  ].request();

  statuses.forEach((permission, status) {
    print('$permission: $status');
    if (status.isGranted) {
      print('$permission granted');
    } else if (status.isDenied) {
      print('$permission denied');
    } else if (status.isPermanentlyDenied) {
      print('$permission permanently denied');
      // Open app settings to allow the user to grant the permission manually.
      openAppSettings();
    }
  });
}
