import 'package:equatable/equatable.dart';
import 'package:fast_contacts/src/model/contact.dart';

abstract class ApiEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetContactEvent extends ApiEvent {}

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
