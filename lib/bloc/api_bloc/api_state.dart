import 'package:spam_delection_app/lib.dart';

abstract class ApiState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ApiBlocInitialState extends ApiState {}

class ApiLoadingState extends ApiState {}

class ApiErrorState extends ApiState {
  final String? value;

  ApiErrorState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetDeviceContactState extends ApiState {
  final List<Contact>? value;

  GetDeviceContactState(this.value);

  @override
  List<Object?> get props => [value];
}

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
  final FamilyMemberDetailsResponse value;

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
  final Response value;

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
class BlockUnBlockState extends ApiState {
  final Response value;

  BlockUnBlockState(this.value);

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

// staff add  member
class GetStaffAddMemberListState extends ApiState {
  final Response value;

  GetStaffAddMemberListState(this.value);

  @override
  List<Object?> get props => [value];
}

// staff member detail
class GetStaffMemberDetailState extends ApiState {
  final StaffMemberDetailsResponse value;

  GetStaffMemberDetailState(this.value);

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

// staff delete member
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

//  notification
// notification List
class NotificationListState extends ApiState {
  final NotificationListResponse value;

  NotificationListState(this.value);

  @override
  List<Object?> get props => [value];
}

// notification Enabled
class EnabledNotificationState extends ApiState {
  final EnabledNotificationResponse value;

  EnabledNotificationState(this.value);

  @override
  List<Object?> get props => [value];
}

class NotificationTypeState extends ApiState {
  final NotificationTypeResponse value;

  NotificationTypeState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetLanguageListState extends ApiState {
  final CountryLanguageResponse value;

  GetLanguageListState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetContactDetailState extends ApiState {
  final ContactDetailsResponse value;

  GetContactDetailState(this.value);

  @override
  List<Object?> get props => [value];
}

class LoginWithEmailAndPasswordState extends ApiState {
  final LoginResponse value;

  LoginWithEmailAndPasswordState(this.value);

  @override
  List<Object?> get props => [value];
}
