import 'package:equatable/equatable.dart';
import 'package:fast_contacts/src/model/contact.dart';

abstract class ApiEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetContactEvent extends ApiEvent {}

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
