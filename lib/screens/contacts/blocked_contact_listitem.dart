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
        backgroundImage: AssetImage(IconConstants.icSpamCircle),
      ),
      title: Text(
        (contact.name?.isNotEmpty ?? false)
            ? (contact.name ?? "")
            : (contact.mobileNo ?? ""),
        style: textTheme(context).titleMedium,
      ),
      subtitle:
          (contact.name?.isEmpty ?? true) ? null : Text(contact.mobileNo ?? ""),
      trailing: InkWell(
          onTap: () {
            markSpamBloc.add(BlockUnBlockEvent(
                contactId: contact.mobileNo ?? "",
                comments: appLocalization(context).unblock));
          },
          child: const Icon(Icons.delete)),
      // subtitle: Text(contact.phone),
    );
  }
}
