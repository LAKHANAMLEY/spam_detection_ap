import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_event.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_state.dart';
import 'package:spam_delection_app/data/repository/auth_repo/social_signup_api.dart';
import 'package:spam_delection_app/data/repository/call_log_repo/get_device_call_logs.dart';
import 'package:spam_delection_app/data/repository/contact/get_contacts_api.dart';
import 'package:spam_delection_app/data/repository/contact/sync_contacts_api.dart';
import 'package:spam_delection_app/data/repository/spam_repo/mark_spam_contacts_api.dart';
import 'package:spam_delection_app/data/repository/spam_repo/remove_mark_spam_contacts_api.dart';
import 'package:spam_delection_app/data/repository/spam_repo/spam_list_api.dart';
import 'package:spam_delection_app/data/repository/user_repo/change_password_api.dart';
import 'package:spam_delection_app/data/repository/user_repo/edit_profile_api.dart';
import 'package:spam_delection_app/data/repository/user_repo/get_user_profile_api.dart';
import 'package:spam_delection_app/models/response.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc(super.initialState) {
    on(eventHandler);
  }

  FutureOr<void> eventHandler(ApiEvent event, Emitter<ApiState> emit) async {
    if (event is GetContactEvent) {
      emit(ApiLoadingState());
      await getContacts().then((value) {
        emit(GetContactState(value));
      });
    }

    if (event is SyncContactEvent) {
      emit(ApiLoadingState());
      await syncContacts(event.contacts).then((value) {
        emit(SyncContactState(value));
      });
    }

    if (event is GetSpamEvent) {
      emit(ApiLoadingState());
      await getSpams().then((value) => emit(GetSpamState(value)));
    }

    if (event is ChangePasswordEvent) {
      emit(ApiLoadingState());
      await changePassword(
              currentPassword: event.currentPassword,
              newPassword: event.newPassword,
              confirmNewPassword: event.confirmNewPassword)
          .then((value) {
        emit(ChangePasswordState(value as Response));
      });
    }

    if (event is MarkSpamEvent) {
      emit(ApiLoadingState());
      await markSpam(
              contactId: event.contactId,
              comment: event.comment,
              numberType: event.numberType,
              categoryId: event.categoryId,
              phone: event.phone)
          .then((value) => emit(MarkSpamState(value)));
    }

    if (event is RemoveSpamEvent) {
      emit(ApiLoadingState());
      await removeSpam(contactId: event.contactId).then((value) {
        emit(RemoveSpamState(value));
      });
    }

    if (event is GetDeviceCallLogEvent) {
      emit(ApiLoadingState());
      await getDeviceCallLogs().then((value) {
        emit(GetDeviceCallLogState(value));
      });
    }

    if (event is SocialSignupEvent) {
      emit(ApiLoadingState());
      await socialSignUp(
              email: event.email,
              signupMethod: event.signupMethod,
              firstName: event.firstName,
              lastName: event.lastName)
          .then((value) {
        emit(SocialSignUpState(value));
      });
    }

    if (event is GetUserProfileEvent) {
      emit(ApiLoadingState());
      await getUserProfile().then((value) {
        emit(GetUserProfileState(value));
      });
    }

    if (event is UpdateProfileEvent) {
      emit(ApiLoadingState());
      await editProfile(user: event.user).then((value) {
        emit(UpdateProfileState(value));
      });
    }
  }
}
