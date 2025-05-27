import 'package:spam_delection_app/lib.dart';

abstract class ContactDBState extends Equatable {
  const ContactDBState();

  @override
  List<Object> get props => [];
}

class ContactDBInitial extends ContactDBState {}

class ContactDBLoading extends ContactDBState {}

class ContactDBLoaded extends ContactDBState {
  final List<ContactData> contacts;

  const ContactDBLoaded(this.contacts);

  @override
  List<Object> get props => [contacts];
}

class ContactUpdated extends ContactDBState {
  final Response value;

  const ContactUpdated(this.value);

  @override
  List<Object> get props => [value];
}

class ContactDBLoadedById extends ContactDBState {
  final ContactData contact;

  const ContactDBLoadedById(this.contact);

  @override
  List<Object> get props => [contact];
}

class ContactDBError extends ContactDBState {
  final String message;
  final Object exception;

  const ContactDBError(this.message, this.exception);

  @override
  List<Object> get props => [message, exception];
}

class ContactAdded extends ContactDBState {
  final AddContactResponse value;

  const ContactAdded(this.value);

  @override
  List<Object> get props => [value];
}
