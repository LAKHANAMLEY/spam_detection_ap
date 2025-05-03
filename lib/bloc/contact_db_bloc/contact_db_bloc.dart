import 'package:spam_delection_app/lib.dart';

class ContactDBBloc extends Bloc<ContactDBEvent, ContactDBState> {
  final ContactDBHelper _databaseHelper = ContactDBHelper.instance;

  ContactDBBloc() : super(ContactDBInitial()) {
    on<AddDBContact>(_onAddContact);
    on<UpdateDBContact>(_onUpdateContact);
    on<DeleteDBContact>(_onDeleteContact);
    on<LoadDBContacts>(_onLoadContacts);
    on<LoadDBContactById>(_onLoadContactsById);
    on<SyncDBContacts>(_onSyncContacts);
    on<DeleteDBContacts>(_onDeleteDBContacts);
  }

  Future<void> _onAddContact(
      AddDBContact event, Emitter<ContactDBState> emit) async {
    emit(ContactDBLoading());
    try {
      await _databaseHelper.insert(event.contact);
      final contacts = await _databaseHelper.getAllContacts();
      emit(ContactDBLoaded(contacts));
    } catch (e) {
      emit(ContactDBError('Failed to add contact: $e', e));
    }
  }

  Future<void> _onUpdateContact(
      UpdateDBContact event, Emitter<ContactDBState> emit) async {
    emit(ContactDBLoading());
    try {
      await _databaseHelper.update(event.contact);
      final contacts = await _databaseHelper.getAllContacts();
      emit(ContactDBLoaded(contacts));
    } catch (e) {
      emit(ContactDBError('Failed to update contact: $e', e));
    }
  }

  Future<void> _onDeleteContact(
      DeleteDBContact event, Emitter<ContactDBState> emit) async {
    emit(ContactDBLoading());
    try {
      await deleteContact(contact: ContactData(id: event.contactId));
      await _databaseHelper.delete(event.contactId);
      final contacts = await _databaseHelper.getAllContacts();
      emit(ContactDBLoaded(contacts));
    } catch (e) {
      emit(ContactDBError('Failed to delete contact: $e', e));
    }
  }

  Future<void> _onLoadContacts(
      LoadDBContacts event, Emitter<ContactDBState> emit) async {
    emit(ContactDBLoading());
    try {
      final contacts = await _databaseHelper.getAllContacts();
      emit(ContactDBLoaded(contacts));
    } catch (e) {
      emit(ContactDBError('Failed to load contacts: $e', e));
    }
  }

  Future<void> _onLoadContactsById(
      LoadDBContactById event, Emitter<ContactDBState> emit) async {
    emit(ContactDBLoading());
    try {
      final contacts = await _databaseHelper.getContact(event.id);
      if (contacts != null) emit(ContactDBLoadedById(contacts));
    } catch (e) {
      emit(ContactDBError('Failed to load contacts: $e', e));
    }
  }

  Future<void> _onSyncContacts(
      SyncDBContacts event, Emitter<ContactDBState> emit) async {
    emit(ContactDBLoading());
    try {
      final deviceContacts = await getLocalContacts();
      await syncContacts(deviceContacts!);
      var res = await getContacts();
      // var contacts = res.contactslist ?? [];
      final serverContactsMap = {
        for (ContactData contact in res.contactslist ?? [])
          contact.mobileNo: contact
      };

      var contacts = deviceContacts.map((e) {
        var phoneNumber = e.phones.firstOrNull?.number;
        var serverData =
            phoneNumber != null ? serverContactsMap[phoneNumber] : null;
        return ContactData.fromContact(e, serverData: serverData);
      }).toList();
      for (final contactData in contacts) {
        // var contactData = ContactData(
        //   id: contact.id,
        //   name: contact.displayName,
        //   mobileNo: contact.phones.isNotEmpty
        //       ? contact.phones.first.number.separatePhoneAndPhoneCode().phone
        //       : "",
        //   countryCode: contact.phones.isNotEmpty
        //       ? contact.phones.first.number
        //           .separatePhoneAndPhoneCode()
        //           .phoneCode
        //       : "",
        //   email: contact.emails.isNotEmpty ? contact.emails.first.address : "",
        //   numberType:
        //       contact.phones.isNotEmpty ? contact.phones.first.label : "",
        // );
        // Check if the contact already exists (e.g., by ID) before inserting
        final existingContact =
            await _databaseHelper.getContactByPhone(contactData.mobileNo ?? "");
        if (existingContact == null) {
          await _databaseHelper.insert(contactData);
        } else {
          // Optionally update the existing contact if needed
          await _databaseHelper.update(contactData);
        }
      }
      final updatedContacts = await _databaseHelper.getAllContacts();
      emit(ContactDBLoaded(updatedContacts));
    } catch (e) {
      emit(ContactDBError('Failed to sync and store contacts: $e', e));
    }
  }

  FutureOr<void> _onDeleteDBContacts(
      DeleteDBContacts event, Emitter<ContactDBState> emit) async {
    await deleteAllContact();
    await _databaseHelper.deleteDatabase1();
    emit(ContactDBInitial());
  }
}
