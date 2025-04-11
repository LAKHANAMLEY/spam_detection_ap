import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

Future<PermissionStatus?> permissionRequest(Permission permission) async {
  var status = await permission.status;
  switch (status) {
    case PermissionStatus.denied:
      status = await permission.request();
    case PermissionStatus.granted:
    case PermissionStatus.restricted:
      status = await permission.request();
    case PermissionStatus.limited:
    case PermissionStatus.permanentlyDenied:
      var isGranted = await openAppSettings();
      status = await permission.status;
    // if (isGranted) {
    //   status = PermissionStatus.granted;
    // } else {
    //   status = PermissionStatus.permanentlyDenied;
    // }
    case PermissionStatus.provisional:
  }
  log("$status");
  return status;
}

Future<Map<Permission, PermissionStatus>> requestMultiplePermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.contacts,
    Permission.sms,
    Permission.systemAlertWindow,
    Permission.notification,
    Permission.camera,
    Permission.photos,
    Permission.storage,
  ].request();

  statuses.forEach((permission, status) {
    log('$permission: $status');
    if (status.isGranted) {
    } else if (status.isDenied) {
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  });
  return statuses;
}
