import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_event.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_state.dart';
import 'package:spam_delection_app/data/repository/auth_repo/social_signup_api.dart';
import 'package:spam_delection_app/data/repository/block_repo/block_unlock_contact_api.dart';
import 'package:spam_delection_app/data/repository/call_log_repo/get_call_logs.dart';
import 'package:spam_delection_app/data/repository/call_log_repo/get_device_call_logs.dart';
import 'package:spam_delection_app/data/repository/call_log_repo/sync_call_log.dart';
import 'package:spam_delection_app/data/repository/contact/get_contacts_api.dart';
import 'package:spam_delection_app/data/repository/contact/sync_contacts_api.dart';
import 'package:spam_delection_app/data/repository/plans_repo/plans_list_api.dart';
import 'package:spam_delection_app/data/repository/setting_repo/call_duration_unit_api.dart';
import 'package:spam_delection_app/data/repository/setting_repo/category_list_api.dart';
import 'package:spam_delection_app/data/repository/spam_repo/mark_spam_contacts_api.dart';
import 'package:spam_delection_app/data/repository/spam_repo/remove_mark_spam_contacts_api.dart';
import 'package:spam_delection_app/data/repository/spam_repo/spam_list_api.dart';
import 'package:spam_delection_app/data/repository/staff_repo/staff_add_member_api.dart';
import 'package:spam_delection_app/data/repository/user_repo/change_password_api.dart';
import 'package:spam_delection_app/data/repository/user_repo/edit_profile_api.dart';
import 'package:spam_delection_app/data/repository/user_repo/get_user_profile_api.dart';
import 'package:spam_delection_app/models/response.dart';

import '../../data/repository/block_repo/block_contact_list_api.dart';
import '../../data/repository/call_log_repo/get_call_log/get_call_log_list_api.dart';
import '../../data/repository/call_log_repo/get_call_log/syn_call_log_api.dart';
import '../../data/repository/corporate_repo/edit_profile_corporate_api.dart';
import '../../data/repository/family_member_repo/add_member_api.dart';
import '../../data/repository/family_member_repo/delete_member_api.dart';
import '../../data/repository/family_member_repo/edit_member_api.dart';
import '../../data/repository/family_member_repo/family_member_details_api.dart';
import '../../data/repository/family_member_repo/family_members_list_api.dart';
import '../../data/repository/setting_repo/call_type_api.dart';
import '../../data/repository/setting_repo/number_type_api.dart';
import '../../data/repository/staff_repo/staff_delete_member_api.dart';
import '../../data/repository/staff_repo/staff_edit_member_api.dart';
import '../../data/repository/staff_repo/staff_member_list_api.dart';
import '../../models/user_model.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc(super.initialState) {
    on(eventHandler);
  }

  FutureOr<void> eventHandler(ApiEvent event, Emitter<ApiState> emit) async {
    if (event is GetContactEvent) {
      emit(ApiLoadingState());
      await getContacts().then((value) {
        emit(GetContactState(value));
      });
    }

    if (event is GetCategoryListEvent) {
      emit(ApiLoadingState());
      await getCategories().then((value) {
        emit(GetCategoryListState(value));
      });
    }

    if (event is SyncContactEvent) {
      emit(ApiLoadingState());
      await syncContacts(event.contacts).then((value) {
        emit(SyncContactState(value));
      });
    }

    if (event is GetSpamEvent) {
      emit(ApiLoadingState());
      await getSpams().then((value) => emit(GetSpamState(value)));
    }

    if (event is ChangePasswordEvent) {
      emit(ApiLoadingState());
      await changePassword(
              currentPassword: event.currentPassword,
              newPassword: event.newPassword,
              confirmNewPassword: event.confirmNewPassword)
          .then((value) {
        emit(ChangePasswordState(value as Response));
      });
    }

    if (event is MarkSpamEvent) {
      emit(ApiLoadingState());
      await markSpam(
              contactId: event.contactId,
              comment: event.comment,
              numberType: event.numberType,
              categoryId: event.categoryId,
              phone: event.phone)
          .then((value) => emit(MarkSpamState(value)));
    }

    if (event is RemoveSpamEvent) {
      emit(ApiLoadingState());
      await removeSpam(contactId: event.contactId).then((value) {
        emit(RemoveSpamState(value));
      });
    }

    if (event is GetDeviceCallLogEvent) {
      emit(ApiLoadingState());
      await getDeviceCallLogs().then((value) {
        emit(GetDeviceCallLogState(value));
      });
    }

    if (event is SocialSignupEvent) {
      emit(ApiLoadingState());
      await socialSignUp(
              email: event.email,
              signupMethod: event.signupMethod,
              firstName: event.firstName,
              lastName: event.lastName)
          .then((value) {
        emit(SocialSignUpState(value));
      });
    }

    if (event is GetUserProfileEvent) {
      emit(ApiLoadingState());
      await getUserProfile().then((value) {
        emit(GetUserProfileState(value));
      });
    }

    if (event is UpdateProfileEvent) {
      emit(ApiLoadingState());
      await editProfile(user: event.user).then((value) {
        emit(UpdateProfileState(value));
      });
    }

    // family member
// get family member list
    if (event is GetFamilyMemberListEvent) {
      emit(ApiLoadingState());
      await getFamilyList().then((value) {
        emit(GetFamilyMemberListState(value));
      });
    }
// get family member details

    if (event is GetFamilyMemberDetailEvent) {
      emit(ApiLoadingState());
      await getFamilyDetail().then((value) {
        emit(GetFamilyMemberDetailState(value));
      });
    }



    // family add member
    if (event is FamilyAddMemberEvent) {
      emit(ApiLoadingState());
      await familyaddMember(
        email: event.email,
        firstname: event.firstName,
        lastname: event.lastName,
        password: event.password,
        relation: event.relation,
        supportpin: event.supportpin,
        phone: event.phone,
        countrycode: event.countrycode,
      ).then((value) {
        emit(FamilyAddMemberState(value));
      });
    }
    // family edit member
    if (event is FamilyEditMemberEvent) {
      emit(ApiLoadingState());
      await familyEditMember(
        firstname: event.firstName,
        lastname: event.lastName,
        relation: event.relation,
        supportpin: event.supportpin,
        familyId: event.familyId,
      ).then((value) {
        emit(FamilyEditMemberState(value));
      });
    }
    //  delete member
    if (event is FamilyDeleteMemberEvent) {
      emit(ApiLoadingState());
      await familyDeleteMember(
        familyId: event.familyId,
      ).then((value) {
        emit(FamilyDeleteMemberState(value));
      });
    }

    //  plan list
    if (event is GetPlanListEvent) {
      emit(ApiLoadingState());
      await getPlanList().then((value) {
        emit(GetPlanListState(value));
      });
    }
    //setting
    // call duration unit
    if (event is GetCallDurationEvent) {
      emit(ApiLoadingState());
      await getCallDuration().then((value) {
        emit(GetCallDurationState(value));
      });
    }

    // Number type

    if (event is GetNumberTypeEvent) {
      emit(ApiLoadingState());
      await getNumberType().then((value) {
        emit(GetNumberTypeState(value));
      });
    }

    // call type

    if (event is GetCallTypeEvent) {
      emit(ApiLoadingState());
      await getCallTypes().then((value) {
        emit(GetCallTypeState(value));
      });
    }
    //contact
    // block

    if (event is GetBlockContactEvent) {
      emit(ApiLoadingState());
      await blockContact().then((value) {
        emit(GetBlockContactState(value));
      });
    }
    // unblock
    if (event is UnBlockEvent) {
      emit(ApiLoadingState());
      await unBlockContact(
        contactId: event.contactId,
        comment: event.comments,
      ).then((value) {
        emit(UnBlockState(value));
      });
    }
    //corporate
    // edit profile

    if (event is CorporateEditProfileEvent) {
      emit(ApiLoadingState());
      await corpoarteEditProfile(user: event.user).then((value) {
        emit(CorporateEditProfileState(value));
      });
    }
// call log
    //syn call log
    if (event is SyncCallLogEvent) {
      emit(ApiLoadingState());
      await syncCallLog(event.contacts).then((value) {
        emit(SyncCallLogState(value));
      });
    }
    // get call log list
    if (event is GetCallLogListEvent) {
      emit(ApiLoadingState());
      await getCallLog().then((value) {
        emit(GetCallLogListState(value));
      });
    }


    // staff
    //get staff member list
    if (event is GetStaffMemberListEvent) {
      emit(ApiLoadingState());
      await getStaffList().then((value) {
        emit(GetStaffMemberListState(value));
      });
    }

    // staff  Add member
    if (event is StaffAddMemberEvent) {
      emit(ApiLoadingState());
      await staffAddMember(
        firstname: event.firstName,
        lastname: event.lastName,
        email: event.email,
        password: event.password,
        position: event.relation,
        supportpin: event.supportpin,
        phone: event.phone,
        countrycode: event.countrycode,
      ).then((value) {
        emit(StaffAddMemberState(value));
      });
    }
    // staff edit member
    if (event is StaffEditMemberEvent) {
      emit(ApiLoadingState());
      await staffEditMember(
        firstname: event.firstName,
        lastname: event.lastName,
        position: event.position,
        supportpin: event.supportpin,
        photo: event.photo,
        staffId: event.staffId,
      ).then((value) {
        emit(StaffEditMemberState(value));
      });
    }
    //
    if (event is StaffDeleteMemberEvent) {
      emit(ApiLoadingState());
      await staffDeleteMember(
        staffId: event.staffId,
      ).then((value) {
        emit(StaffDeleteMemberState(value));
      });
    }

    if (event is SyncCallLogEvent) {
      emit(ApiLoadingState());
      await syncCallLog(
        callLogs: event.callLogs,
      ).then((value) {
        emit(SyncCallLogState(value));
      });
    }

    if (event is GetCallLogsEvent) {
      emit(ApiLoadingState());
      await getCallLogs().then((value) {
        emit(GetCallLogsState(value));
      });
    }
  }
}
