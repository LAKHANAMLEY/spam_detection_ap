import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SelectionBlocState extends Equatable {}

class SelectionBlocInitialState extends SelectionBlocState {
  @override
  List<Object?> get props => [];
}

class SelectionBlocLoadingState extends SelectionBlocState {
  @override
  List<Object?> get props => [];
}

class SelectThemeState extends SelectionBlocState {
  final ThemeMode themeMode;

  SelectThemeState(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

class SelectStringState extends SelectionBlocState {
  final String? value;
  SelectStringState(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectBoolState extends SelectionBlocState {
  final bool value;
  SelectBoolState(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectIntState extends SelectionBlocState {
  final int value;
  SelectIntState(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectDateRangeState extends SelectionBlocState {
  final DateTimeRange value;
  SelectDateRangeState(this.value);
  @override
  List<Object?> get props => [value];
}
