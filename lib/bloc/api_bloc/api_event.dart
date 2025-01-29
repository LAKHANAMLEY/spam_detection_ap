import 'package:spam_delection_app/lib.dart';

abstract class ApiEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDeviceContactEvent extends ApiEvent {}

class GetContactEvent extends ApiEvent {}

class GetCategoryListEvent extends ApiEvent {}

class GetSpamEvent extends ApiEvent {}

// sync contact
class SyncContactEvent extends ApiEvent {
  final List<Contact> contacts;

  SyncContactEvent({
    required this.contacts,
  });

  @override
  List<Object?> get props => [contacts];
}

// Change password
class ChangePasswordEvent extends ApiEvent {
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;

  ChangePasswordEvent({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  @override
  List<Object?> get props => [
        currentPassword,
        newPassword,
        confirmNewPassword,
      ];
}

// Change security
class ChangeSecurityEvent extends ApiEvent {
  final String currentPin;
  final String newPin;
  final String confirmNewPin;

  ChangeSecurityEvent({
    required this.currentPin,
    required this.newPin,
    required this.confirmNewPin,
  });

  @override
  List<Object?> get props => [
        currentPin,
        newPin,
        confirmNewPin,
      ];
}

//Mark Spam

class MarkSpamEvent extends ApiEvent {
  final String contactId;
  final String comment;
  final String numberType;
  final String categoryId;
  final String phone;

  MarkSpamEvent({
    required this.contactId,
    required this.comment,
    required this.numberType,
    required this.categoryId,
    required this.phone,
  });

  @override
  List<Object?> get props =>
      [contactId, comment, numberType, categoryId, phone];
}

// remove spam
class RemoveSpamEvent extends ApiEvent {
  final String contactId;

  RemoveSpamEvent({
    required this.contactId,
  });

  @override
  List<Object?> get props => [
        contactId,
      ];
}

// Device callLog
class GetDeviceCallLogEvent extends ApiEvent {
  final String? number;
  final DateTime? dateTimeFrom;
  final DateTime? dateTimeTo;

  GetDeviceCallLogEvent({
    this.number,
    this.dateTimeFrom,
    this.dateTimeTo,
  });

  @override
  List<Object?> get props => [number, dateTimeFrom, dateTimeTo];
}

// Social SignUp
class SocialSignupEvent extends ApiEvent {
  final String email;
  final String signupMethod;
  final String firstName;
  final String lastName;

  SocialSignupEvent(
      {required this.email,
      required this.signupMethod,
      required this.firstName,
      required this.lastName});

  @override
  List<Object?> get props => [email, signupMethod, firstName, lastName];
}

//Update Profile
class UpdateProfileEvent extends ApiEvent {
  final User? user;

  UpdateProfileEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

// user profile
class GetUserProfileEvent extends ApiEvent {}

// family member list
class GetFamilyMemberListEvent extends ApiEvent {}

// family member details
class GetFamilyMemberDetailEvent extends ApiEvent {
  final String id;

  GetFamilyMemberDetailEvent(this.id);

  @override
  List<Object?> get props => [id];
}

// add family member
class FamilyAddMemberEvent extends ApiEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String relation;
  final String supportPin;
  final String phone;
  final String countryCode;
  final XFile? photoFile;

  FamilyAddMemberEvent({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.relation,
    required this.supportPin,
    required this.phone,
    required this.countryCode,
    this.photoFile,
  });

  @override
  List<Object?> get props => [
        email,
        firstName,
        lastName,
        relation,
        supportPin,
        phone,
        countryCode,
        password,
        photoFile,
      ];
}

// edit family member
class FamilyEditMemberEvent extends ApiEvent {
  final FamilyMember user;

  FamilyEditMemberEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

// family delete member
class FamilyDeleteMemberEvent extends ApiEvent {
  final String id;

  FamilyDeleteMemberEvent({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}

// plan list
class GetPlanListEvent extends ApiEvent {}

class GetCallDurationEvent extends ApiEvent {}

class GetNumberTypeEvent extends ApiEvent {}

class GetCallTypeEvent extends ApiEvent {}

class GetBlockContactEvent extends ApiEvent {}

class BlockUnBlockEvent extends ApiEvent {
  final String contactId;
  final String comments;

  BlockUnBlockEvent({
    required this.contactId,
    required this.comments,
  });

  @override
  List<Object?> get props => [contactId, comments];
}

// corporate Edit
class CorporateEditProfileEvent extends ApiEvent {
  final CorporateData? user;

  CorporateEditProfileEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

class GetStaffMemberListEvent extends ApiEvent {}

// Staff member Detail
class GetStaffMemberDetailEvent extends ApiEvent {
  final String id;

  GetStaffMemberDetailEvent(this.id);

  @override
  List<Object?> get props => [id];
}

// staff Add member
class StaffAddMemberEvent extends ApiEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String relation;
  final String supportPin;
  final String phone;
  final String countryCode;
  final XFile? photoFile;

  StaffAddMemberEvent({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.relation,
    required this.supportPin,
    required this.phone,
    required this.countryCode,
    this.photoFile,
  });

  @override
  List<Object?> get props => [
        email,
        firstName,
        lastName,
        relation,
        supportPin,
        phone,
        countryCode,
        password,
        photoFile,
      ];
}

class StaffEditMemberEvent extends ApiEvent {
  final StaffMember user;

  StaffEditMemberEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

// staff delete member

class StaffDeleteMemberEvent extends ApiEvent {
  final String id;

  StaffDeleteMemberEvent({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}

// sync call log
class SyncCallLogEvent extends ApiEvent {
  final List<CallLogEntry> callLogs;

  SyncCallLogEvent({
    required this.callLogs,
  });

  @override
  List<Object?> get props => [callLogs];
}

class GetCallLogsEvent extends ApiEvent {}

class DeleteCallLogEvent extends ApiEvent {
  final CallLogData callLog;

  DeleteCallLogEvent({
    required this.callLog,
  });

  @override
  List<Object?> get props => [callLog];
}

class DeleteAllCallLogEvent extends ApiEvent {}

// notification
// notification list
class NotificationListEvent extends ApiEvent {}

// notification enabled
class EnabledNotificationEvent extends ApiEvent {
  final String notificationOne;
  final String notificationReceive;
  final String notificationPush;

  EnabledNotificationEvent({
    required this.notificationOne,
    required this.notificationReceive,
    required this.notificationPush,
  });

  @override
  List<Object?> get props =>
      [notificationOne, notificationReceive, notificationPush];
}
// notification type

class NotificationTypeEvent extends ApiEvent {}

class GetLanguageListEvent extends ApiEvent {}

// class GetContactDetailEvent extends ApiEvent {
//   final String mobileNo;

//   GetContactDetailEvent({
//     required this.mobileNo,
//   });

//   @override
//   List<Object?> get props => [mobileNo];
// }
// forgot password
class ForgetPasswordEvent extends ApiEvent {
  final String email;

  ForgetPasswordEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

// reset password
class ResetPasswordEvent extends ApiEvent {
  final String email;
  final String code;
  final String password;
  final String confirmPassword;

  ResetPasswordEvent(
      {required this.email,
      required this.password,
      required this.code,
      required this.confirmPassword});

  @override
  List<Object?> get props => [email, password, code, confirmPassword];
}

class LoginWithEmailAndPasswordEvent extends ApiEvent {
  final String email;
  final String password;

  LoginWithEmailAndPasswordEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

// manually
class SyncCallLogManuallyEvent extends ApiEvent {
  final CallLogEntry callLogs;

  SyncCallLogManuallyEvent({
    required this.callLogs,
  });

  @override
  List<Object?> get props => [callLogs];
}

class CheckSpamEvent extends ApiEvent {
  final CallLogData callLogs;

  CheckSpamEvent({
    required this.callLogs,
  });

  @override
  List<Object?> get props => [callLogs];
}

// add Contact
class AddContactEvent extends ApiEvent {
  final ContactData contact;

  AddContactEvent({required this.contact});

  @override
  List<Object?> get props => [contact];
}

// corporate login
class CorporateLoginEvent extends ApiEvent {
  final String email;
  final String password;
  final String corporateId;

  CorporateLoginEvent(
      {required this.email, required this.password, required this.corporateId});

  @override
  List<Object?> get props => [email, password, corporateId];
}

// Register
class RegisterEvent extends ApiEvent {
  final String email;
  final String phone;
  final String password;
  final String countryCode;
  final String firstName;
  final String lastName;
  final String dateOfBirth;

  RegisterEvent(
      {required this.email,
      required this.phone,
      required this.countryCode,
      required this.firstName,
      required this.lastName,
      required this.password,
      required this.dateOfBirth});

  @override
  List<Object?> get props =>
      [email, password, phone, countryCode, firstName, lastName, dateOfBirth];
}

class SetUserOnlineOfflineEvent extends ApiEvent {
  ///pass 1 for online 0 for offline
  final String isOnline;

  SetUserOnlineOfflineEvent({required this.isOnline});

  @override
  List<Object?> get props => [isOnline];
}

class LogoutEvent extends ApiEvent {}

// delete contact
class DeleteContactEvent extends ApiEvent {
  final ContactData contact;

  DeleteContactEvent({required this.contact});

  @override
  List<Object?> get props => [contact];
}

class CountryListEvent extends ApiEvent {}

class DashboardStatisticsEvent extends ApiEvent {
  final String days;

  DashboardStatisticsEvent({required this.days});

  @override
  List<Object?> get props => [days];
}

class GetDeviceMessagesEvent extends ApiEvent {}

//edit contact
// class EditContactEvent extends ApiEvent {
//   final String contactId;
//   final String name;
//   final String numberType;
//   final String countryCode;
//   final String email;
//
//   // final String phone;
//
//   EditContactEvent({
//     required this.contactId,
//     required this.name,
//     required this.numberType,
//     required this.countryCode,
//     required this email
//     //required this.phone,
//   });
//
//   @override
//   List<Object?> get props => [contactId, name, numberType, countryCode,email];
// }

// sync sms
class SyncSmsEvent extends ApiEvent {
  final List<SmsMessage> smsLogs;

  SyncSmsEvent({
    required this.smsLogs,
  });

  @override
  List<Object?> get props => [smsLogs];
}

// sms list
class SmsListEvent extends ApiEvent {}

//
class SmsSeenEvent extends ApiEvent {
  final String messageId;

  SmsSeenEvent({required this.messageId});

  @override
  List<Object?> get props => [messageId];
}

class SmsDeleteConversationEvent extends ApiEvent {
  final SmsLog sms;

  SmsDeleteConversationEvent({required this.sms});

  @override
  List<Object?> get props => [sms];
}

class SmsSpamListEvent extends ApiEvent {}

class MarkSpamSmsEvent extends ApiEvent {
  final String address;
  final String comment;
  final String numberType;
  final String category;

  MarkSpamSmsEvent({
    required this.address,
    required this.comment,
    required this.numberType,
    required this.category,
  });

  @override
  List<Object?> get props => [address, comment, numberType, category];
}

class RemoveSpamSmsEvent extends ApiEvent {
  final String address;

  RemoveSpamSmsEvent({
    required this.address,
  });

  @override
  List<Object?> get props => [
        address,
      ];
}

//class SmsSpamEvent extends ApiEvent {}

class DeleteConversationEvent extends ApiEvent {
  final String address;

  DeleteConversationEvent({
    required this.address,
  });

  @override
  List<Object?> get props => [
        address,
      ];
}

class SmsDeleteEvent extends ApiEvent {
  final String id;

  SmsDeleteEvent({
    required this.id,
  });

  @override
  List<Object?> get props => [
        id,
      ];
}

class EditContactEvent extends ApiEvent {
  final ContactData contact;

  EditContactEvent({required this.contact});

  @override
  List<Object?> get props => [contact];
}

class ForgetPasswordPhoneEvent extends ApiEvent {
  final String phone;
  final String countryCode;

  ForgetPasswordPhoneEvent({required this.phone, required this.countryCode});

  @override
  List<Object?> get props => [phone];
}

class ResetPasswordPhoneEvent extends ApiEvent {
  final String phone;
  final String countryCode;
  final String code;
  final String password;
  final String confirmPassword;

  ResetPasswordPhoneEvent(
      {required this.phone,
      required this.countryCode,
      required this.password,
      required this.code,
      required this.confirmPassword});

  @override
  List<Object?> get props =>
      [phone, countryCode, password, code, confirmPassword];
}
