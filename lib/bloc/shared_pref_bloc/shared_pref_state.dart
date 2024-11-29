import 'package:equatable/equatable.dart';
import 'package:spam_delection_app/models/user_model.dart';

class SharedPrefState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SharedPrefInitialState extends SharedPrefState {}

class SharedPrefLoadingState extends SharedPrefState {}

class SharedPrefErrorState extends SharedPrefState {}

class GetUserDataFromLocalState extends SharedPrefState {
  final User user;
  GetUserDataFromLocalState(this.user);
  @override
  List<Object?> get props => [user];
}
