import 'package:spam_delection_app/lib.dart';

class SpamListItem extends StatelessWidget {
  final SpamData spamContact;
  const SpamListItem({super.key, required this.spamContact});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.contactDetail,
            arguments: ContactDetail(
              contact: ContactData(
                id: spamContact.id,
                mobileNo: spamContact.spamNo,
                name: spamContact.name,
                isSpam: 1,
              ),
            ));
      },
      leading: const CircleAvatar(
        backgroundImage: AssetImage(IconConstants.icFraud),
      ),
      title: Text(
        spamContact.name ?? "",
        style: textTheme(context).titleMedium,
      ),
      subtitle: Text(
        spamContact.categoryName ?? "",
        style: textTheme(context).bodySmall,
      ),
      trailing: PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            child: const Text("Remove spam"),
            onTap: () {
              markSpamBloc
                  .add(RemoveSpamEvent(contactId: spamContact.spamNo ?? ""));
            },
          ),
        ],
      ),
    );
  }
}
