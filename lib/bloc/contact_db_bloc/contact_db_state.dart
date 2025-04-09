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

class ContactDBError extends ContactDBState {
  final String message;

  const ContactDBError(this.message);

  @override
  List<Object> get props => [message];
}
