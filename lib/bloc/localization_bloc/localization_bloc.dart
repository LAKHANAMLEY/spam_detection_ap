import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'localization_bloc_events.dart';
import 'localization_bloc_states.dart';
//import 'package:spam_detector/bloc/localization_bloc/localization_bloc_events.dart';
//import 'package:spam_detector/bloc/localization_bloc/localization_bloc_states.dart';

class LocalizationBloc
    extends Bloc<LocalizationBlocEvent, LocalizationBlocState> {
  LocalizationBloc(super.initialState) {
    on(eventHandler);
  }

  FutureOr<void> eventHandler(
      LocalizationBlocEvent event, Emitter<LocalizationBlocState> emit) {
    if (event is ChangeLocaleEvent) {
      emit(ChangeLocaleState(event.locale));
    }
  }
}
