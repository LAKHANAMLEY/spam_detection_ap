import 'package:spam_delection_app/lib.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc(super.initialState) {
    on(eventHandler);
  }

  FutureOr<void> eventHandler(ApiEvent event, Emitter<ApiState> emit) async {
    if (event is GetDeviceContactEvent) {
      emit(ApiLoadingState());
      await getLocalContacts().then((value) {
        emit(GetDeviceContactState(value));
      });
    }
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
// change Password
    if (event is ChangePasswordEvent) {
      emit(ApiLoadingState());
      await changePassword(
              currentPassword: event.currentPassword,
              newPassword: event.newPassword,
              confirmNewPassword: event.confirmNewPassword)
          .then((value) {
        emit(ChangePasswordState(value));
      });
    }
// change security pin
    if (event is ChangeSecurityEvent) {
      emit(ApiLoadingState());
      await changeSecurityPin(
              currentPin: event.currentPin,
              newPin: event.newPin,
              confirmNewPin: event.confirmNewPin)
          .then((value) {
        emit(ChangeSecurityState(value));
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
      await getFamilyDetail(event.id).then((value) {
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
        photoFile: event.photoFile,
      ).then((value) {
        emit(FamilyAddMemberState(value));
      });
    }
    // family edit member
    if (event is FamilyEditMemberEvent) {
      emit(ApiLoadingState());
      await familyEditMember(familyMember: event.user).then((value) {
        emit(FamilyEditMemberState(value));
      });
    }
    //  delete member
    if (event is FamilyDeleteMemberEvent) {
      emit(ApiLoadingState());
      await familyDeleteMember(id: event.id).then((value) {
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
    if (event is BlockUnBlockEvent) {
      emit(ApiLoadingState());
      await blockUnblockContact(
        contactId: event.contactId,
        comment: event.comments,
      ).then((value) {
        emit(BlockUnBlockState(value));
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

    // staff
    //get staff member list
    if (event is GetStaffMemberListEvent) {
      emit(ApiLoadingState());
      await getStaffList().then((value) {
        emit(GetStaffMemberListState(value));
      });
    }

    //get staff member Details
    if (event is GetStaffMemberDetailEvent) {
      emit(ApiLoadingState());
      await getStaffDetail(event.id).then((value) {
        emit(GetStaffMemberDetailState(value));
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
      await staffEditMember(staffMember: event.user).then((value) {
        emit(StaffEditMemberState(value));
      });
    }
    if (event is StaffDeleteMemberEvent) {
      emit(ApiLoadingState());
      await staffDeleteMember(id: event.id).then((value) {
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

    if (event is DeleteCallLogEvent) {
      emit(ApiLoadingState());
      await deleteCallLog(id: event.id).then((value) {
        emit(DeleteCallLogState(value));
      });
    }

    if (event is DeleteAllCallLogEvent) {
      emit(ApiLoadingState());
      await deleteAllCallLogs().then((value) {
        emit(DeleteAllCallLogState(value));
      });
    }

    // notifications
    // notification list
    if (event is NotificationListEvent) {
      emit(ApiLoadingState());
      await notificationList().then((value) {
        emit(NotificationListState(value));
      });
    }

    //notification Enabled
    if (event is EnabledNotificationEvent) {
      emit(ApiLoadingState());
      await enableNotification(
              notificationOne: event.notificationOne,
              notificationReceive: event.notificationReceive,
              notificationPush: event.notificationPush)
          .then((value) {
        emit(EnabledNotificationState(value));
      });
    }

    // notification Type
    if (event is NotificationTypeEvent) {
      emit(ApiLoadingState());
      await notificationType().then((value) {
        emit(NotificationTypeState(value));
      });
    }

    // notification Type
    if (event is GetLanguageListEvent) {
      emit(ApiLoadingState());
      await fetchLanguages().then((value) {
        emit(GetLanguageListState(value));
      });
    }

    if (event is GetContactDetailEvent) {
      emit(ApiLoadingState());
      await getContactDetail(mobileNo: event.mobileNo).then((value) {
        emit(GetContactDetailState(value));
      });
    }

    if (event is LoginWithEmailAndPasswordEvent) {
      emit(ApiLoadingState());
      await login(email: event.email, password: event.password).then((value) {
        emit(LoginWithEmailAndPasswordState(value));
      });
    }
  }
}
