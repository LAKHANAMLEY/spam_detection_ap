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
      title: Row(
        children: [
          Expanded(
            child: Text(
              (spamContact.name?.isNotEmpty ?? false)
                  ? (spamContact.name ?? "")
                  : (spamContact.spamNo ?? ""),
              style: textTheme(context).titleMedium,
            ),
          ),
          10.width(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Text(
              spamContact.categoryName ?? "",
              style:
                  textTheme(context).bodySmall?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
      subtitle: (spamContact.name?.isEmpty ?? true)
          ? null
          : Text(
              spamContact.spamNo ?? "",
              style: textTheme(context).bodySmall,
            ),
      trailing: PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Text(appLocalization(context).removeSpam),
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
