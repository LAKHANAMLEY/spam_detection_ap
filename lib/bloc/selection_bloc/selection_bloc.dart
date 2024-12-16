import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spam_delection_app/bloc/selection_bloc/selection_bloc_events.dart';
import 'package:spam_delection_app/bloc/selection_bloc/selection_bloc_states.dart';

//import 'package:spam_detector/bloc/selection_bloc/selection_bloc_events.dart';
//import 'package:spam_detector/bloc/selection_bloc/selection_bloc_states.dart';

class SelectionBloc extends Bloc<SelectionBlocEvent, SelectionBlocState> {
  SelectionBloc(super.initialState) {
    on(eventHandler);
  }

  FutureOr<void> eventHandler(
      SelectionBlocEvent event, Emitter<SelectionBlocState> emit) {
    if (event is SelectThemeEvent) {
      emit(SelectThemeState(event.themeMode));
    }
    if (event is SelectStringEvent) {
      emit(SelectStringState(event.value));
    }
    if (event is SelectBoolEvent) {
      emit(SelectBoolState(event.value));
    }

    if (event is SelectIntEvent) {
      emit(SelectIntState(event.value));
    }

    if (event is SelectDateRangeEvent) {
      emit(SelectDateRangeState(event.value));
    }

    if (event is SelectFileEvent) {
      emit(SelectFileState(event.value));
    }
  }
}
