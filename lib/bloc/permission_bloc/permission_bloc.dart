import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spam_delection_app/bloc/permission_bloc/permission_bloc_event.dart';
import 'package:spam_delection_app/bloc/permission_bloc/permission_bloc_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(PermissionInitialState()) {
    on<RequestSinglePermissionEvent>(_onRequestSinglePermission);
    on<GetSinglePermissionStatusEvent>(_onGetSinglePermissionStatus);
    on<RequestMultiplePermissionsEvent>(_onRequestMultiplePermissions);
    on<GetMultiplePermissionsStatusEvent>(_onGetMultiplePermissionsStatus);
  }

  Future<void> _onRequestSinglePermission(
    RequestSinglePermissionEvent event,
    Emitter<PermissionState> emit,
  ) async {
    emit(PermissionLoadingState(statuses: state.statuses));
    final status = await event.permission.request();
    emit(SinglePermissionStatusLoadedState(
      permission: event.permission,
      status: status,
      allStatuses: {...state.statuses, event.permission: status},
    ));
    log('${event.permission}: $status (requested)');
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  Future<void> _onGetSinglePermissionStatus(
    GetSinglePermissionStatusEvent event,
    Emitter<PermissionState> emit,
  ) async {
    emit(PermissionLoadingState(statuses: state.statuses));
    final status = await event.permission.status;
    emit(SinglePermissionStatusLoadedState(
      permission: event.permission,
      status: status,
      allStatuses: {...state.statuses, event.permission: status},
    ));
    log('${event.permission}: $status (status checked)');
  }

  Future<void> _onRequestMultiplePermissions(
    RequestMultiplePermissionsEvent event,
    Emitter<PermissionState> emit,
  ) async {
    emit(PermissionLoadingState(statuses: state.statuses));
    final statuses = await event.permissions.request();
    statuses.forEach((permission, status) {
      log('$permission: $status (requested)');
      if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    });
    emit(PermissionsRequestedState(statuses: statuses));
  }

  Future<void> _onGetMultiplePermissionsStatus(
    GetMultiplePermissionsStatusEvent event,
    Emitter<PermissionState> emit,
  ) async {
    emit(PermissionLoadingState(statuses: state.statuses));
    final Map<Permission, PermissionStatus> statuses = {};
    for (final permission in event.permissions) {
      statuses[permission] = await permission.status;
      log('$permission: ${statuses[permission]} (status checked)');
    }
    emit(MultiplePermissionsStatusLoadedState(statuses: statuses));
  }
}
