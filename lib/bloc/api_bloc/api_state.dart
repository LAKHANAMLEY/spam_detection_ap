import 'package:equatable/equatable.dart';
import 'package:spam_delection_app/models/contact_list_response.dart';

abstract class ApiState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ApiBlocInitialState extends ApiState {}

class ApiLoadingState extends ApiState {}

class ApiErrorState extends ApiState {}

class GetContactState extends ApiState {
  final ContactListResponse value;
  GetContactState(this.value);
}
