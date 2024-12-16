import 'package:spam_delection_app/lib.dart';

abstract class SelectionBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectThemeEvent extends SelectionBlocEvent {
  final ThemeMode themeMode;

  SelectThemeEvent(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

class SelectStringEvent extends SelectionBlocEvent {
  final String? value;

  SelectStringEvent(this.value);

  @override
  List<Object?> get props => [value];
}

class SelectBoolEvent extends SelectionBlocEvent {
  final bool value;

  SelectBoolEvent(this.value);

  @override
  List<Object?> get props => [value];
}

class SelectIntEvent extends SelectionBlocEvent {
  final int value;

  SelectIntEvent(this.value);

  @override
  List<Object?> get props => [value];
}

class SelectDateRangeEvent extends SelectionBlocEvent {
  final DateTimeRange value;

  SelectDateRangeEvent(this.value);

  @override
  List<Object?> get props => [value];
}

class SelectFileEvent extends SelectionBlocEvent {
  final XFile? value;

  SelectFileEvent(this.value);

  @override
  List<Object?> get props => [value];
}
