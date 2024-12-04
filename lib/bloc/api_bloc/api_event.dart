import 'package:spam_delection_app/lib.dart';

abstract class ApiEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDeviceContactEvent extends ApiEvent {}

class GetContactEvent extends ApiEvent {}

class GetCategoryListEvent extends ApiEvent {}

class GetSpamEvent extends ApiEvent {}

class SyncContactEvent extends ApiEvent {
  final List<Contact> contacts;

  SyncContactEvent({
    required this.contacts,
  });

  @override
  List<Object?> get props => [contacts];
}

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

//yha phle event create krege

// ye parameters pass kar diye
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

class GetDeviceCallLogEvent extends ApiEvent {}

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

class UpdateProfileEvent extends ApiEvent {
  final User? user;

  UpdateProfileEvent({required this.user});
  @override
  List<Object?> get props => [user];
}

class GetUserProfileEvent extends ApiEvent {}

class GetFamilyMemberListEvent extends ApiEvent {}

class GetFamilyMemberDetailEvent extends ApiEvent {}

class FamilyAddMemberEvent extends ApiEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String relation;
  final String supportpin;
  final String phone;
  final String countrycode;

  FamilyAddMemberEvent({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.relation,
    required this.supportpin,
    required this.phone,
    required this.countrycode,
  });
  @override
  List<Object?> get props => [
        email,
        firstName,
        lastName,
        relation,
        supportpin,
        phone,
        countrycode,
        password
      ];
}

class FamilyEditMemberEvent extends ApiEvent {
  final String firstName;
  final String lastName;
  final String relation;
  final String familyId;
  final String supportpin;
  FamilyEditMemberEvent({
    required this.firstName,
    required this.lastName,
    required this.relation,
    required this.supportpin,
    required this.familyId,
  });
  @override
  List<Object?> get props =>
      [firstName, lastName, relation, supportpin, familyId];
}

class FamilyDeleteMemberEvent extends ApiEvent {
  final String familyId;

  FamilyDeleteMemberEvent({
    required this.familyId,
  });
  @override
  List<Object?> get props => [familyId];
}

class GetPlanListEvent extends ApiEvent {}

class GetCallDurationEvent extends ApiEvent {}

class GetNumberTypeEvent extends ApiEvent {}

class GetCallTypeEvent extends ApiEvent {}

class GetBlockContactEvent extends ApiEvent {}

class UnBlockEvent extends ApiEvent {
  final String contactId;
  final String comments;

  UnBlockEvent({
    required this.contactId,
    required this.comments,
  });
  @override
  List<Object?> get props => [contactId, comments];
}

class CorporateEditProfileEvent extends ApiEvent {
  final UserData? user;

  CorporateEditProfileEvent({required this.user});
  @override
  List<Object?> get props => [user];
}

class GetStaffMemberListEvent extends ApiEvent {}

// Staff member Detail
class GetStaffMemberDetailEvent extends ApiEvent {}

class StaffAddMemberEvent extends ApiEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String relation;
  final String supportpin;
  final String phone;
  final String countrycode;

  StaffAddMemberEvent({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.relation,
    required this.supportpin,
    required this.phone,
    required this.countrycode,
  });
  @override
  List<Object?> get props => [
        email,
        firstName,
        lastName,
        relation,
        supportpin,
        phone,
        countrycode,
        password
      ];
}

class StaffEditMemberEvent extends ApiEvent {
  final String firstName;
  final String lastName;
  final String position;
  final String staffId;
  final String supportpin;
  final String photo;

  StaffEditMemberEvent({
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.supportpin,
    required this.staffId,
    required this.photo,
  });

  @override
  List<Object?> get props =>
      [firstName, lastName, position, supportpin, staffId, photo];
}

class StaffDeleteMemberEvent extends ApiEvent {
  final String staffId;

  StaffDeleteMemberEvent({
    required this.staffId,
  });

  @override
  List<Object?> get props => [staffId];
}

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
  final String id;

  DeleteCallLogEvent({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}

class DeleteAllCallLogEvent extends ApiEvent {}

// notification
// notification list
/*class NotificationListEvent extends ApiEvent {

}
    NotificationListEvent({
  required this.notificationPush,
});

@override
List<Object?> get props => [notificationPush];
}

 */
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
