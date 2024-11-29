import 'package:call_log/call_log.dart';
import 'package:equatable/equatable.dart';
import 'package:spam_delection_app/models/add_member_model.dart';
import 'package:spam_delection_app/models/call_duration_model.dart';
import 'package:spam_delection_app/models/category_list_model.dart';
import 'package:spam_delection_app/models/common_response_model.dart';
import 'package:spam_delection_app/models/contact_list_response.dart';
import 'package:spam_delection_app/models/edit_profile_model.dart';
import 'package:spam_delection_app/models/family_delete_member_model.dart';
import 'package:spam_delection_app/models/family_edit_member_model.dart';
import 'package:spam_delection_app/models/family_member_list_model.dart';
import 'package:spam_delection_app/models/mark_spam_model.dart';
import 'package:spam_delection_app/models/plan_list_model.dart';
import 'package:spam_delection_app/models/response.dart';
import 'package:spam_delection_app/models/sign_up_model.dart';
import 'package:spam_delection_app/models/spam_list_model.dart';
import 'package:spam_delection_app/models/staff_member_list_model.dart';

import '../../models/call_type_model.dart';

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

// family member
//  family member list
class GetFamilyMemberListState extends ApiState {
  final FamilyMemberListResponse value;
  GetFamilyMemberListState(this.value);
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
// call type

class GetCallTypeState extends ApiState {
  final CallTypeResponse value;
  GetCallTypeState(this.value);
  @override
  List<Object?> get props => [value];
}

// contact
// unBlock
class UnBlockState extends ApiState {
  final CommonResponse value;
  UnBlockState(this.value);
  @override
  List<Object?> get props => [value];
}

// staff
// staff member list
class GetStaffMemberListState extends ApiState {
  final StaffMemberListResponse value;

  GetStaffMemberListState(this.value);

  @override
  List<Object?> get props => [value];
}

// staff  member
class GetStaffAddMemberListState extends ApiState {
  final CommonResponse value;

  GetStaffAddMemberListState(this.value);

  @override
  List<Object?> get props => [value];
}

// staff add member
class StaffAddMemberState extends ApiState {
  final CommonResponse value;
  StaffAddMemberState(this.value);
  @override
  List<Object?> get props => [value];
}

// staff edit member
class StaffEditMemberState extends ApiState {
  final CommonResponse value;
  StaffEditMemberState(this.value);
  @override
  List<Object?> get props => [value];
}

// staff delete member
class StaffDeleteMemberState extends ApiState {
  final CommonResponse value;
  StaffDeleteMemberState(this.value);
  @override
  List<Object?> get props => [value];
}
