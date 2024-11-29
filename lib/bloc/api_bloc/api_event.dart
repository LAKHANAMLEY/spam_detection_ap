import 'package:equatable/equatable.dart';
import 'package:fast_contacts/src/model/contact.dart';
import 'package:spam_delection_app/models/user_model.dart';

abstract class ApiEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

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

class GetUserProfileEvent extends ApiEvent {}

class UpdateProfileEvent extends ApiEvent {
  final User? user;

  UpdateProfileEvent({required this.user});
  @override
  List<Object?> get props => [user];
}
