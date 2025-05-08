import 'package:spam_delection_app/data/repository/contact/contacts_controller.dart';
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
              ? IconConstants.icSpamCircle
              : IconConstants.icCallRegular),
        ),
        title: Text(
          (contact.name?.isNotEmpty ?? false)
              ? contact.name ?? ""
              : ((contact.countryCode?.isNotEmpty ?? false)
                  ? "+${contact.countryCode} ${contact.mobileNo ?? ""}"
                  : contact.mobileNo ?? ""),
          style: textTheme(context).titleMedium,
        ),
        subtitle: contact.name?.isNotEmpty ?? false
            ? Text(contact.countryCode?.isNotEmpty ?? false
                ? "+${contact.countryCode} ${contact.mobileNo ?? ""}"
                : contact.mobileNo ?? "")
            : null,
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
                        Future.delayed(Duration.zero, () {
                          showCustomDialog(context,
                              dialogType: DialogType.delete,
                              title: appLocalization(context).deleteMember,
                              subTitle:
                                  appLocalization(context).areYouWantDelete,
                              showCancelBtn: true,
                              okBtnTxt: appLocalization(context).delete,
                              cancelBtnTxt: appLocalization(context).cancel,
                              okBtnColor: Colors.red, onOkPressed: () {
                            ContactsController.deleteDeviceContact(
                                id: contact.id ?? "",
                                number: contact.mobileNo ?? "");
                            context
                                .read<ContactDBBloc>()
                                .add(DeleteDBContact(contact.id ?? ""));
                            Navigator.pop(context);
                            // familyBloc.add(
                            //     FamilyDeleteMemberEvent(
                            //         id: filteredContacts[index]
                            //                 .userId ??
                            //             ""));
                          });
                        });
                        // deleteDeviceContact(
                        //     id: contact.id ?? "",
                        //     number: contact.mobileNo ?? "");
                        // context
                        //     .read<ContactDBBloc>()
                        //     .add(DeleteDBContact(contact.id ?? ""));

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
