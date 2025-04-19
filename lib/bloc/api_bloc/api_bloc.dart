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
    // get contact
    if (event is GetContactEvent) {
      emit(ApiLoadingState());
      await getContacts().then((value) {
        emit(GetContactState(value));
      });
    }
// get category list
    if (event is GetCategoryListEvent) {
      emit(ApiLoadingState());
      await getCategories().then((value) {
        emit(GetCategoryListState(value));
      });
    }
// sync Contact
    if (event is SyncContactEvent) {
      emit(ApiLoadingState());
      await syncContacts(event.contacts).then((value) {
        emit(SyncContactState(value));
      });
    }
// Spam call
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
// mark number as a spam
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
// remove number as a spam
    if (event is RemoveSpamEvent) {
      emit(ApiLoadingState());
      await removeSpam(contactId: event.contactId).then((value) {
        emit(RemoveSpamState(value));
      });
    }
// Call Log
    if (event is GetDeviceCallLogEvent) {
      emit(ApiLoadingState());
      await getDeviceCallLogs(
        number: event.number,
        dateTimeFrom: event.dateTimeFrom,
        dateTimeTo: event.dateTimeTo,
      ).then((value) {
        emit(GetDeviceCallLogState(value));
      });
    }
// Social signup
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
// User profile
    if (event is GetUserProfileEvent) {
      emit(ApiLoadingState());
      await getUserProfile().then((value) {
        emit(GetUserProfileState(value));
      });
    }
// update user profile
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
      await familyAddMember(
        email: event.email,
        firstname: event.firstName,
        lastname: event.lastName,
        password: event.password,
        relation: event.relation,
        supportPin: event.supportPin,
        phone: event.phone,
        countryCode: event.countryCode,
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

    if (event is PurchasePlanEvent) {
      emit(ApiLoadingState());
      await purchasePlan(purchasePlanData: event.purchasePlanData)
          .then((value) {
        emit(PurchasePlanState(value));
      });
    }

    if (event is CancelPlanEvent) {
      emit(ApiLoadingState());
      await cancelPlan().then((value) {
        emit(CancelPlanState(value));
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
      await corporateEditProfile(user: event.user).then((value) {
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
        relation: event.relation,
        supportPin: event.supportPin,
        phone: event.phone,
        countryCode: event.countryCode,
        photoFile: event.photoFile,
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
// sync call log
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
// delete call logs
    if (event is DeleteCallLogEvent) {
      emit(ApiLoadingState());
      await deleteCallLog(callLog: event.callLog).then((value) {
        emit(DeleteCallLogState(value));
      });
    }
// delete all  call logs
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

    if (event is ReadNotificationEvent) {
      emit(ApiLoadingState());
      await readNotification(event.notificationId).then((value) {
        emit(ReadNotificationState(value));
      });
    }

    if (event is ClearAllNotificationEvent) {
      emit(ApiLoadingState());
      await clearAllNotification().then((value) {
        emit(ClearAllNotificationState(value));
      });
    }

    //notification Enabled/disable
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

    // if (event is GetContactDetailEvent) {
    //   emit(ApiLoadingState());
    //   await getContactDetail(mobileNo: event.mobileNo).then((value) {
    //     emit(GetContactDetailState(value));
    //   });
    // }
// forgot password
    if (event is ForgetPasswordEvent) {
      emit(ApiLoadingState());
      await forgotPassword(email: event.email).then((value) {
        emit(ForgetPasswordState(value));
      });
    }
// reset password
    if (event is ResetPasswordEvent) {
      emit(ApiLoadingState());
      await resetPassword(
              email: event.email,
              code: event.code,
              password: event.password,
              confirmPassword: event.confirmPassword)
          .then((value) {
        emit(ResetPasswordState(value));
      });
    }
    // login using email and password
    if (event is LoginWithEmailAndPasswordEvent) {
      emit(ApiLoadingState());
      await login(email: event.email, password: event.password).then((value) {
        emit(LoginWithEmailAndPasswordState(value));
      });
    }
    // manually
    if (event is SyncCallLogManuallyEvent) {
      emit(ApiLoadingState());
      await syncCallLogManually(
        callLogs: event.callLogs,
      ).then((value) {
        emit(SyncCallManuallyState(value));
      });
    }
    // check Spam
    if (event is CheckSpamEvent) {
      emit(ApiLoadingState());
      await checkSpam(log: event.callLogs).then((value) {
        emit(CheckSpamState(value));
      });
    }
// add Contact
    if (event is AddContactEvent) {
      emit(ApiLoadingState());
      await addContact(contact: event.contact).then((value) {
        emit(AddContactState(value));
      });
    }
    // corporate login
    if (event is CorporateLoginEvent) {
      emit(ApiLoadingState());
      await corporateLogin(
              email: event.email,
              password: event.password,
              corporateId: event.corporateId)
          .then((value) {
        emit(CorporateLoginState(value));
      });
    }

    // register
    if (event is RegisterEvent) {
      emit(ApiLoadingState());
      await signup(
              email: event.email,
              countryCode: event.countryCode,
              password: event.password,
              firstname: event.firstName,
              lastname: event.lastName,
              phoneNumber: event.phone,
              dateOfBirth: event.dateOfBirth)
          .then((value) {
        emit(RegisterState(value));
      });
    }

    if (event is EditContactEvent) {
      emit(ApiLoadingState());
      await editContact(user: event.user).then((value) {
        emit(EditContactState(value));
      });
    }

    if (event is DeleteContactEvent) {
      emit(ApiLoadingState());
      await deleteContact(contact: event.contact).then((value) {
        emit(DeleteContactState(value));
      });
    }
    // user online
    if (event is SetUserOnlineOfflineEvent) {
      emit(ApiLoadingState());
      await setUserOnlineOrOffline(
        isOnline: event.isOnline,
      ).then((value) {
        emit(SetUserOnlineOrOfflineState(value));
      });
    }
    if (event is LogoutEvent) {
      emit(ApiLoadingState());
      await logout().then((value) {
        emit(LogoutState(value));
      });
    }
    if (event is CountryListEvent) {
      emit(ApiLoadingState());
      await getCountries().then((value) {
        emit(CountryListState(value));
      });
    }
    if (event is DashboardStatisticsEvent) {
      emit(ApiLoadingState());
      await getDashboardStatistics(days: event.days).then((value) {
        emit(DashboardStatisticsState(value));
      });
    }

    if (event is ListenMessagesStreamEvent) {
      add(GetDeviceMessagesEvent());
      // emit(ApiLoadingState());
      // await getSms().then((value) {
      //   emit(GetDeviceMessagesState(value));
      // });
    }

    if (event is GetDeviceMessagesEvent) {
      emit(ApiLoadingState());
      await getDeviceSms().then((value) {
        emit(GetDeviceMessagesState(value));
      });
    }

    if (event is SmsListEvent) {
      emit(ApiLoadingState());
      await smsList().then((value) {
        emit(SmsListState(value));
      });
    }

    if (event is SyncSmsEvent) {
      emit(ApiLoadingState());
      await syncSmsWithServer(
        smsLogs: event.smsLogs,
      ).then((value) {
        emit(SyncSmsState(value));
      });
    }
    if (event is SmsSeenEvent) {
      emit(ApiLoadingState());
      await smsSeen(
        messageId: event.messageId,
      ).then((value) {
        emit(SmsSeenState(value));
      });
    }
    if (event is MarkSpamSmsEvent) {
      emit(ApiLoadingState());
      await markSpamSms(
        address: event.address,
        comment: event.comment,
        numberType: event.numberType,
        category: event.category,
      ).then((value) => emit(MarkSpamSmsState(value)));
    }
    if (event is RemoveSpamSmsEvent) {
      emit(ApiLoadingState());
      await removeSpamSms(address: event.address).then((value) {
        emit(RemoveSmsSpamState(value));
      });
    }
    if (event is SmsSpamListEvent) {
      emit(ApiLoadingState());
      await smsSpamList().then((value) {
        emit(SmsSpamListState(value));
      });
    }
    if (event is DeleteConversationEvent) {
      emit(ApiLoadingState());
      await deleteConversation(address: event.address).then((value) {
        emit(DeleteConversationState(value));
      });
    }
    if (event is SmsDeleteEvent) {
      emit(ApiLoadingState());
      await smsDelete(messageId: event.id).then((value) {
        emit(SmsDeleteState(value));
      });
    }

    if (event is AddContactEvent) {
      emit(ApiLoadingState());
      await addContact(contact: event.contact).then((value) {
        emit(AddContactState(value));
      });
    }

    if (event is ForgetPasswordPhoneEvent) {
      emit(ApiLoadingState());
      await forgotPasswordWithPhone(
              phoneNumber: event.phone, countryCode: event.countryCode)
          .then((value) {
        emit(ForgetPasswordPhoneState(value));
      });
    }
    if (event is ResetPasswordPhoneEvent) {
      emit(ApiLoadingState());
      await resetPasswordWithPhone(
        phoneNumber: event.phone,
        countryCode: event.countryCode,
        code: event.code,
        password: event.password,
        confirmPassword: event.confirmPassword,
      ).then((value) {
        emit(ResetPasswordState(value));
      });
    }
    if (event is GetContactDetailEvent) {
      emit(ApiLoadingState());
      await getContactDetail(mobileNo: event.mobileNo).then((value) {
        emit(GetContactDetailState(value));
      });
    }
    if (event is GetTransactionListEvent) {
      emit(ApiLoadingState());
      await getTransactionList().then((value) {
        emit(GetTransactionListState(value));
      });
    }
  }
}
