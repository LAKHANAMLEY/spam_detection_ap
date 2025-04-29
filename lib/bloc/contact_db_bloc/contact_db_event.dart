import 'package:spam_delection_app/lib.dart';

abstract class ContactDBEvent extends Equatable {
  const ContactDBEvent();

  @override
  List<Object> get props => [];
}

class AddDBContact extends ContactDBEvent {
  final ContactData contact;

  const AddDBContact(this.contact);

  @override
  List<Object> get props => [contact];
}

class UpdateDBContact extends ContactDBEvent {
  final ContactData contact;

  const UpdateDBContact(this.contact);

  @override
  List<Object> get props => [contact];
}

class DeleteDBContact extends ContactDBEvent {
  final String contactId;

  const DeleteDBContact(this.contactId);

  @override
  List<Object> get props => [contactId];
}

class LoadDBContacts extends ContactDBEvent {}

class LoadDBContactById extends ContactDBEvent {
  final String id;

  const LoadDBContactById({required this.id});

  @override
  List<Object> get props => [id];
}

class SyncDBContacts extends ContactDBEvent {}

class DeleteDBContacts extends ContactDBEvent {}
