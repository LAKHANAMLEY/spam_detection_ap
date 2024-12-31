import 'package:spam_delection_app/lib.dart';

class ContactListItem extends StatefulWidget {
  final ContactData contact;

  const ContactListItem({
    super.key,
    required this.contact,
  });

  @override
  State<ContactListItem> createState() => _ContactListItemState();
}

class _ContactListItemState extends State<ContactListItem> {
  ContactData? contact;

  late List<ContactData> filteredContacts;

  @override
  void initState() {
    contact = widget.contact;
    super.initState();
  }

// sir ek baar check kr lo ye device wala
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
          backgroundImage: AssetImage(contact?.isSpam == 1
              ? IconConstants.icFraud
              : IconConstants.icCallRegular),
        ),
        title: Text(
          contact?.name ?? "",
          style: textTheme(context).titleMedium,
        ),
        subtitle: Text(contact?.mobileNo ?? ""),
        trailing: PopupMenuButton(
            itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text(appLocalization(context).reportText),
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: AppColor.secondryColor,
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20.0)),
                        ),
                        builder: (BuildContext context) {
                          return ReportView(
                            contact: contact!,
                          );
                        },
                      );
                    },
                  ),
                  PopupMenuItem(
                      child: Text(appLocalization(context).delete),
                      onTap: () {
                        //deleteDeviceContact(
                        // id:contact?.id
                        // );
                        contactListBloc.add(DeleteContactEvent(
                            contact: ContactData(id: contact?.id)));
                      }
                      //contactListBloc
                      )
                ]));
  }
}
