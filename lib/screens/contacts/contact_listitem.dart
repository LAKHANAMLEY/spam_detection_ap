import 'package:spam_delection_app/lib.dart';

class ContactListItem extends StatelessWidget {
  final ContactData contact;

  const ContactListItem({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.contactDetail,
              arguments: ContactDetail(
                contact: contact,
              ));
        },
        leading: CircleAvatar(
          backgroundImage: AssetImage(contact.isSpam == 1
              ? IconConstants.icSpamCall
              : IconConstants.icCallRegular),
        ),
        title: Text(
          contact.name ?? "",
          style: textTheme(context).titleMedium,
        ),
        subtitle: Text(contact.countryCode?.isNotEmpty ?? false
            ? "+${contact.countryCode} ${contact.mobileNo ?? ""}"
            : contact.mobileNo ?? ""),
        trailing: PopupMenuButton(
            itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text(appLocalization(context).reportText),
                    onTap: () {
                      showModalBottomSheet(
                        showDragHandle: true,
                        useSafeArea: true,
                        isScrollControlled: true,
                        backgroundColor: AppColor.whiteColor,
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20.0)),
                        ),
                        builder: (BuildContext context) {
                          return ReportView(
                            contact: contact,
                          );
                        },
                      );
                    },
                  ),
                  PopupMenuItem(
                      child: Text(appLocalization(context).delete),
                      onTap: () {
                        deleteDeviceContact(
                            id: contact.id ?? "",
                            number: contact.mobileNo ?? "");
                        context
                            .read<ContactDBBloc>()
                            .add(DeleteDBContact(contact.id ?? ""));

                        // contactListBloc.add(DeleteContactEvent(
                        //     contact: ContactData(id: contact?.id)));
                      }
                      //contactListBloc
                      ),
                  PopupMenuItem(
                      child: Text(appLocalization(context).editContact),
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.editContact,
                            arguments: EditContact(contactData: contact));
                        // editDeviceContact(
                        //     contactId: contact?.id ?? "",
                        //     phone: contact?.mobileNo ?? "",
                        //     name: contact?.name ?? "",
                        //     email: contact?.email ?? "",
                        //     numberType: contact?.numberType ?? "");
                        //
                        // // contactListBloc.add(DeleteContactEvent(
                        // //     contact: ContactData(id: contact?.id)));
                      }
                      //contactListBloc
                      ),
                ]));
  }
}
