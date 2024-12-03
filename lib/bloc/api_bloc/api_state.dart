import 'package:spam_delection_app/lib.dart';

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

class GetCategoryListState extends ApiState {
  final CategoryListResponse value;

  GetCategoryListState(this.value);

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

class MarkSpamState extends ApiState {
  final MarkSpamResponse value;

  MarkSpamState(this.value);

  @override
  List<Object?> get props => [value];
}

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

class SocialSignUpState extends ApiState {
  final SignUpResponse value;

  SocialSignUpState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetUserProfileState extends ApiState {
  final Response value;

  GetUserProfileState(this.value);

  @override
  List<Object?> get props => [value];
}

class UpdateProfileState extends ApiState {
  final EditProfileResponse value;

  UpdateProfileState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetFamilyMemberListState extends ApiState {
  final FamilyMemberListResponse value;
  GetFamilyMemberListState(this.value);
  @override
  List<Object?> get props => [value];
}

class GetFamilyMemberDetailState extends ApiState {
  final Response value;
  GetFamilyMemberDetailState(this.value);
  @override
  List<Object?> get props => [value];
}

// add member
class FamilyAddMemberState extends ApiState {
  final FamilyMemberAddResponse value;
  FamilyAddMemberState(this.value);

  @override
  List<Object?> get props => [value];
}

// edit member
class FamilyEditMemberState extends ApiState {
  final FamilyEditMemberResponse value;
  FamilyEditMemberState(this.value);

  @override
  List<Object?> get props => [value];
}

// delete member
class FamilyDeleteMemberState extends ApiState {
  final FamilyDeleteMemberResponse value;
  FamilyDeleteMemberState(this.value);

  @override
  List<Object?> get props => [value];
}

// Plan List
class GetPlanListState extends ApiState {
  final PlanListResponse value;
  GetPlanListState(this.value);
  @override
  List<Object?> get props => [value];
}

// setting
// call duration
class GetCallDurationState extends ApiState {
  final CallDurationResponse value;
  GetCallDurationState(this.value);
  @override
  List<Object?> get props => [value];
}

// Number type

class GetNumberTypeState extends ApiState {
  final NumberTypeResponse value;
  GetNumberTypeState(this.value);
  @override
  List<Object?> get props => [value];
}
// call type

class GetCallTypeState extends ApiState {
  final CallTypeResponse value;
  GetCallTypeState(this.value);
  @override
  List<Object?> get props => [value];
}

class GetBlockContactState extends ApiState {
  final BlockedContactListResponse value;
  GetBlockContactState(this.value);
  @override
  List<Object?> get props => [value];
}

// unBlock
class UnBlockState extends ApiState {
  final Response value;
  UnBlockState(this.value);
  @override
  List<Object?> get props => [value];
}
//corporate

class CorporateEditProfileState extends ApiState {
  final Response value;
  CorporateEditProfileState(this.value);
  @override
  List<Object?> get props => [value];
}

// staff member list
class GetStaffMemberListState extends ApiState {
  final StaffMemberListResponse value;

  GetStaffMemberListState(this.value);

  @override
  List<Object?> get props => [value];
}

// staff  member
class GetStaffAddMemberListState extends ApiState {
  final Response value;

  GetStaffAddMemberListState(this.value);

  @override
  List<Object?> get props => [value];
}

class StaffAddMemberState extends ApiState {
  final Response value;
  StaffAddMemberState(this.value);
  @override
  List<Object?> get props => [value];
}

class StaffEditMemberState extends ApiState {
  final Response value;
  StaffEditMemberState(this.value);
  @override
  List<Object?> get props => [value];
}

class StaffDeleteMemberState extends ApiState {
  final Response value;
  StaffDeleteMemberState(this.value);
  @override
  List<Object?> get props => [value];
}

class SyncCallLogState extends ApiState {
  final Response value;
  SyncCallLogState(this.value);
  @override
  List<Object?> get props => [value];
}

class GetCallLogsState extends ApiState {
  final CallLogsListResponse value;
  GetCallLogsState(this.value);
  @override
  List<Object?> get props => [value];
}

class DeleteCallLogState extends ApiState {
  final Response value;
  DeleteCallLogState(this.value);
  @override
  List<Object?> get props => [value];
}

class DeleteAllCallLogState extends ApiState {
  final Response value;
  DeleteAllCallLogState(this.value);
  @override
  List<Object?> get props => [value];
}
