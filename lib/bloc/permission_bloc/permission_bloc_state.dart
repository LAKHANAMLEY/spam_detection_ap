// --- States ---
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionState {
  final Map<Permission, PermissionStatus> statuses;

  PermissionState({required this.statuses});
}

class PermissionInitialState extends PermissionState {
  PermissionInitialState() : super(statuses: {});
}

class PermissionLoadingState extends PermissionState {
  PermissionLoadingState({required Map<Permission, PermissionStatus> statuses})
      : super(statuses: statuses);
}

class SinglePermissionStatusLoadedState extends PermissionState {
  SinglePermissionStatusLoadedState({
    required Permission permission,
    required PermissionStatus status,
    required Map<Permission, PermissionStatus> allStatuses,
  }) : super(statuses: {...allStatuses, permission: status});
}

class MultiplePermissionsStatusLoadedState extends PermissionState {
  MultiplePermissionsStatusLoadedState({
    required Map<Permission, PermissionStatus> statuses,
  }) : super(statuses: statuses);
}

class PermissionsRequestedState extends PermissionState {
  PermissionsRequestedState(
      {required Map<Permission, PermissionStatus> statuses})
      : super(statuses: statuses);
}

class PermissionErrorState extends PermissionState {
  final String message;
  PermissionErrorState(
      {required this.message,
      required Map<Permission, PermissionStatus> statuses})
      : super(statuses: statuses);
}
