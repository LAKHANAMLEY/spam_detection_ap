import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_event.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_state.dart';
import 'package:spam_delection_app/data/repository/contact/get_contacts_api.dart';
import 'package:spam_delection_app/data/repository/contact/sync_contacts_api.dart';
import 'package:spam_delection_app/data/repository/spam_repo/mark_spam_contacts_api.dart';
import 'package:spam_delection_app/data/repository/user_repo/change_password_api.dart';
import 'package:spam_delection_app/models/response.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc(super.initialState) {
    on(eventHandler);
  }

  FutureOr<void> eventHandler(ApiEvent event, Emitter<ApiState> emit) async {
    if (event is GetContactEvent) {
      await getContacts().then((value) {
        emit(GetContactState(value));
      });
    }

    if (event is SyncContactEvent) {
      await syncContacts(event.contacts).then((value) {
        emit(SyncContactState(value));
      });
    }

    if (event is ChangePasswordEvent) {
      await changePassword(
              currentPassword: event.currentPassword,
              newPassword: event.newPassword,
              confirmNewPassword: event.confirmNewPassword)
          .then((value) {
        emit(ChangePasswordState(value as Response));
      });
    }

    //yaha handle karege event ko or state emit karege

    if (event is MarkSpamEvent) {
      //yaha loader state hit kr dete h
      emit(ApiLoadingState());
      await markSpam(
              contactId: event.contactId,
              comment: event.comment,
              numberType: event.numberType,
              categoryId: event.categoryId, phone: event.phone)
          .then((value) => emit(MarkSpamState(value)));// comment mat hatana sir ok
      //wait abhi ayega
      //jab ham Markspam event hit karege btn pr
      //to markspam api call hogi
      //iske bad is api ka jo response hoga wo hm state k sath emit karege
      //state hame ui me milegi bloc builder me uske through hm response ka use karege ui me
   //ye hoga hmara state event or bloc ka pura code ab ui me bs event hit krna h
    }
  }
}
