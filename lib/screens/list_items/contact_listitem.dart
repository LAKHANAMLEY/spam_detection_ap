import 'package:spam_delection_app/lib.dart';

class ContactListItem extends StatefulWidget {
  final ContactData contact;
  final ApiBloc markSpamBloc;

  const ContactListItem({
    super.key,
    required this.contact,
    required this.markSpamBloc,
  });

  @override
  State<ContactListItem> createState() => _ContactListItemState();
}

class _ContactListItemState extends State<ContactListItem> {
  ContactData? contact;

  @override
  void initState() {
    contact = widget.contact;
    super.initState();
  }

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
            ? IconConstants.icspamCircle
            : IconConstants.icfluentCall),
      ),
      // leading: Image.network(
      //   contact?.name ?? "", //TODO: image path
      //   errorBuilder: (context, error, stackTrace) => const Icon(Icons.person),
      //   width: 50,
      //   height: 50,
      // ),
      title: Text(
        contact?.name ?? "",
        style: textTheme(context).titleMedium,
      ),
      subtitle: Text(contact?.mobileNo ?? ""),
      trailing: PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            child: const Text("Report"),
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
                    markSpamBloc: widget.markSpamBloc,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
