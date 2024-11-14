import 'dart:ui';

import 'package:equatable/equatable.dart';

abstract class LocalizationBlocState extends Equatable {}

class LocalizationBlocInitialState extends LocalizationBlocState {
  @override
  List<Object?> get props => [];
}

class LocalizationBlocLoadingState extends LocalizationBlocState {
  @override
  List<Object?> get props => [];
}

class ChangeLocaleState extends LocalizationBlocState {
  final Locale locale;
  ChangeLocaleState(this.locale);
  @override
  List<Object?> get props => [locale];
}
