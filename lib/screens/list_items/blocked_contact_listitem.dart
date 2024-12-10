import 'package:spam_delection_app/lib.dart';

class BlockedContactListItem extends StatelessWidget {
  final BlockedContact contact;
  const BlockedContactListItem({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.contactDetail,
            arguments: ContactDetail(
              contact: ContactData(
                id: contact.id,
                mobileNo: contact.mobileNo,
                name: contact.name,
                isBlocked: 1,
              ),
            ));
      },
      leading: const CircleAvatar(
        backgroundImage: AssetImage(IconConstants.icspamCircle),
      ),
      title: Text(
        contact.name ?? "",
        style: textTheme(context).titleMedium,
      ),
      subtitle: Text(contact.mobileNo ?? ""),
      trailing: InkWell(
          onTap: () {
            markSpamBloc.add(BlockUnBlockEvent(
                contactId: contact.mobileNo ?? "", comments: "unblock"));
          },
          child: const Icon(Icons.delete)),
      // subtitle: Text(contact.phone),
    );
  }
}
