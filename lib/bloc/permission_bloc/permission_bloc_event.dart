// --- Events ---
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionEvent {}

class RequestSinglePermissionEvent extends PermissionEvent {
  final Permission permission;

  RequestSinglePermissionEvent(this.permission);
}

class GetSinglePermissionStatusEvent extends PermissionEvent {
  final Permission permission;

  GetSinglePermissionStatusEvent(this.permission);
}

class RequestMultiplePermissionsEvent extends PermissionEvent {
  final List<Permission> permissions;

  RequestMultiplePermissionsEvent(this.permissions);
}

class GetMultiplePermissionsStatusEvent extends PermissionEvent {
  final List<Permission> permissions;

  GetMultiplePermissionsStatusEvent(this.permissions);
}
