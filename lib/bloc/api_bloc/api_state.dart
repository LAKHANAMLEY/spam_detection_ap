import 'package:call_log/call_log.dart';
import 'package:equatable/equatable.dart';
import 'package:spam_delection_app/models/contact_list_response.dart';
import 'package:spam_delection_app/models/mark_spam_model.dart';
import 'package:spam_delection_app/models/response.dart';
import 'package:spam_delection_app/models/spam_list_model.dart';

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
  @override
  List<Object?> get props => [value];
}

class GetSpamState extends ApiState {
  final SpamListResponse value;
  GetSpamState(this.value);
  @override
  List<Object?> get props => [value];
}

class SyncContactState extends ApiState {
  final ContactListResponse value;
  SyncContactState(this.value);
  @override
  List<Object?> get props => [value];
}

class ChangePasswordState extends ApiState {
  final Response value;
  ChangePasswordState(this.value);
  @override
  List<Object?> get props => [value];
}

//yaha state create karege
class MarkSpamState extends ApiState {
  final MarkSpamResponse value;
  MarkSpamState(this.value);
  @override
  List<Object?> get props => [value];
}
//ye mene apko all thins type krke batai h aap uper wali state/event ko copy paste kr skte h ok

class RemoveSpamState extends ApiState {
  final Response value;
  RemoveSpamState(this.value);
  @override
  List<Object?> get props => [value];
}

class GetDeviceCallLogState extends ApiState {
  final List<CallLogEntry> value;
  GetDeviceCallLogState(this.value);
  @override
  List<Object?> get props => [value];
}
