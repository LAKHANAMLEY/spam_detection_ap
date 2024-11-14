import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_event.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_state.dart';
import 'package:spam_delection_app/data/repository/contact/get_contacts_api.dart';

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
  }
}
