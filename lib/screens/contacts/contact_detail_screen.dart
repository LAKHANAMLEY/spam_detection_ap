import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/screens/contacts/comments_list.dart';

class ContactDetail extends StatelessWidget {
  final ContactData? contact;

  const ContactDetail({super.key, this.contact});

  @override
  Widget build(BuildContext context) {
    final arg = args(context) as ContactDetail;
    ContactData? contact = arg.contact;
    CallLogData? callLog = contact?.callHistory?.firstOrNull;

    final markSpamBloc = ApiBloc(ApiBlocInitialState());
    final callLogDBBloc = context.read<CallLogDBBloc>();

    callLogDBBloc
      ..add(GetDBCallLog(mobileNo: contact?.mobileNo ?? ""))
      ..add(SyncDBCallLogHistory(
        mobileNo: contact?.mobileNo ?? "",
        callLog: contact?.callHistory?.firstOrNull?.toCallLogEntry() ??
            CallLogEntry(
              number: contact?.mobileNo,
              name: contact?.name,
              callType: CallTypeHelper.getCallLogType(
                  contact?.callHistory?.firstOrNull?.callType ?? ""),
              timestamp: contact
                  ?.callHistory?.firstOrNull?.callTime?.millisecondsSinceEpoch,
              duration: int.tryParse(
                  contact?.callHistory?.firstOrNull?.callDuration ?? "0"),
              cachedNumberLabel: contact?.numberType,
            ),
      ));

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: BlocProvider.value(
        value: markSpamBloc,
        child: BlocConsumer<ApiBloc, ApiState>(
          bloc: markSpamBloc,
          listener: (context, state) {
            if (state is MarkSpamState || state is RemoveSpamState) {
              final response = (state as dynamic).value;
              if (response.statusCode == 200) {
                showCustomDialog(context,
                    dialogType: DialogType.success, subTitle: response.message);
              } else if (response.statusCode ==
                  HTTPStatusCodes.sessionExpired) {
                sessionExpired(context, response.message ?? "");
              } else {
                showCustomDialog(context,
                    dialogType: DialogType.failed, subTitle: response.message);
              }
              if (callLog != null) {
                callLogDBBloc.add(UpdateDBCallLog(callLog!));
              }
            }

            if (state is BlockUnBlockState) {
              final response = state.value;
              if (response.statusCode == 200) {
                showCustomDialog(context,
                    dialogType: DialogType.success, subTitle: response.message);
              } else if (response.statusCode ==
                  HTTPStatusCodes.sessionExpired) {
                sessionExpired(context, response.message);
              } else {
                showCustomDialog(context,
                    dialogType: DialogType.failed, subTitle: response.message);
              }
              callLogDBBloc.add(SyncDBCallLogHistory(
                mobileNo: contact?.mobileNo ?? "",
                callLog: contact?.callHistory?.firstOrNull?.toCallLogEntry() ??
                    CallLogEntry(
                      number: contact?.mobileNo,
                      name: contact?.name,
                      callType: CallTypeHelper.getCallLogType(
                          contact?.callHistory?.firstOrNull?.callType ?? ""),
                      timestamp: contact?.callHistory?.firstOrNull?.callTime
                          ?.millisecondsSinceEpoch,
                      duration: int.tryParse(
                          contact?.callHistory?.firstOrNull?.callDuration ??
                              "0"),
                      cachedNumberLabel: contact?.numberType,
                    ),
              ));
            }
          },
          builder: (context, markSpamBlocState) {
            return BlocConsumer<CallLogDBBloc, CallLogDBState>(
              listener: (context, state) {
                if (state is CallLogDBLoadedById) {
                  callLog = state.callLog;
                  contact = callLog?.contactData ?? contact;
                } else if (state is SyncDBCallLogHistoryState) {
                  if (state.value.statusCode == 200) {
                    contact = state.value.phonespamdetails ?? contact;
                  } else if (state.value.statusCode ==
                      HTTPStatusCodes.sessionExpired) {
                    sessionExpired(context, state.value.message);
                  } else {
                    showCustomDialog(context,
                        dialogType: DialogType.failed,
                        subTitle: state.value.message);
                  }
                }
              },
              builder: (context, state) {
                return ModalProgressHUD(
                  progressIndicator: const Loader(),
                  inAsyncCall: markSpamBlocState is ApiLoadingState,
                  child: CustomScrollView(
                    shrinkWrap: true,
                    slivers: [
                      buildSliverAppBar(context, contact, markSpamBloc),
                      buildSliverBody(context, contact, markSpamBloc),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  SliverAppBar buildSliverAppBar(
      BuildContext context, ContactData? contact, ApiBloc markSpamBloc) {
    return SliverAppBar(
      expandedHeight: 330,
      collapsedHeight: 120,
      floating: true,
      pinned: true,
      snap: true,
      leading: BackButton(color: Colors.white),
      backgroundColor: AppColor.whiteColor,
      actions: [
        PopupMenuButton(
          iconColor: Colors.white,
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text(appLocalization(context).editContact),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.editContact,
                    arguments: EditContact(contactData: contact));
              },
            ),
          ],
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            header(context, contact),
            if ((contact?.lastSeen?.isNotEmpty ?? false) ||
                contact?.isOnline == "1")
              subHeader(context, contact),
            10.height(),
            actions(context, contact, markSpamBloc),
          ],
        ),
        centerTitle: true,
        collapseMode: CollapseMode.pin,
        background: Stack(
          children: [
            Container(
              height: 150,
              color: contact?.isSpam == 1
                  ? AppColor.redColor
                  : AppColor.themeOrangeColor,
            ),
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    contact?.isSpam == 1
                        ? IconConstants.icSpamCircle
                        : IconConstants.icUsername4X,
                  ),
                  radius: 45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverList buildSliverBody(
      BuildContext context, ContactData? contact, ApiBloc markSpamBloc) {
    return SliverList(
      delegate: SliverChildListDelegate([
        contactInfoTile(context, contact),
        contactStatsCard(context, contact),
        if (contact?.spamComments?.isNotEmpty ?? false)
          _commentsView(contact, context),
        premiumSuggestionTile(context),
        10.height(),
        _callHistory(contact, context)
      ]),
    );
  }

  Widget contactInfoTile(BuildContext context, ContactData? contact) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppColor.lightBrownColor),
      ),
      child: ListTile(
        onTap: () => CallController.makeCall(
            contact?.countryCode?.isNotEmpty ?? false
                ? "+${contact?.countryCode ?? ""} ${contact?.mobileNo ?? ""}"
                : contact?.mobileNo ?? ""),
        leading: const Icon(Icons.phone, color: AppColor.blackColor),
        title: Text(
          contact?.countryCode?.isNotEmpty ?? false
              ? "+${contact?.countryCode} ${contact?.mobileNo}"
              : contact?.mobileNo ?? "",
          // style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: (contact?.numberType?.isNotEmpty ?? false)
            ? Text(contact!.numberType!,
                style:
                    textTheme(context).bodySmall?.copyWith(color: Colors.grey))
            : null,
      ),
    );
  }

  Widget contactStatsCard(BuildContext context, ContactData? contact) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.lightBrownColor),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(appLocalization(context).spamReport),
                  Text(contact?.spamReport ?? "", style: boldText()),
                  const Divider(),
                  Text(appLocalization(context).usuallyCalls),
                  Text(contact?.usuallyCalls ?? "",
                      textAlign: TextAlign.center, style: boldText()),
                ],
              ),
            ),
            const VerticalDivider(),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(appLocalization(context).callActivity,
                        style: boldText()),
                    Text(contact?.callActivity ?? ""),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget premiumSuggestionTile(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.planList),
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColor.lightBrownColor),
        ),
        child: ListTile(
          leading: const Icon(Icons.location_on, color: AppColor.blackColor),
          title: Text(appLocalization(context).moreAvailable,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(appLocalization(context).upgradePremiumView),
        ),
      ),
    );
  }

  TextStyle boldText() => const TextStyle(
        color: AppColor.blackColor,
        fontWeight: FontWeight.w600,
        fontFamily: AppFont.fontFamily,
      );

  Text header(BuildContext context, ContactData? contact) => Text(
        contact?.name?.isNotEmpty == true
            ? contact!.name!
            : contact?.countryCode?.isNotEmpty == true
                ? "+${contact!.countryCode} ${contact.mobileNo}"
                : contact?.mobileNo ?? "",
        style: textTheme(context).titleMedium,
      );

  Row subHeader(BuildContext context, ContactData? contact) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Circle(color: contact?.isOnline == "1" ? Colors.green : Colors.grey),
          Text(
            contact?.isOnline == "1"
                ? appLocalization(context).online
                : "${appLocalization(context).lastSeen} ${contact?.lastSeen}",
            style: textTheme(context)
                .bodySmall
                ?.copyWith(color: Colors.grey, fontSize: 8),
          ),
        ],
      );

  Row actions(
      BuildContext context, ContactData? contact, ApiBloc markSpamBloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ActionButton(
          onTap: () => launchSms(context, contact?.mobileNo ?? ""),
          label: appLocalization(context).message,
          icon: Icons.message,
          color: contact?.isSpam == 1 ? Colors.red : AppColor.themeOrangeColor,
        ),
        (contact?.isMarkedSpamByMe ?? false)
            ? ActionButton(
                onTap: () => markSpamBloc
                    .add(RemoveSpamEvent(contactId: contact?.mobileNo ?? "")),
                label: appLocalization(context).notSpam,
                icon: Icons.check_circle,
                color: AppColor.themeOrangeColor,
              )
            : ActionButton(
                onTap: () => showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  useSafeArea: true,
                  isScrollControlled: true,
                  backgroundColor: AppColor.whiteColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) => ReportView(contact: contact!),
                ),
                label: appLocalization(context).reportText,
                icon: Icons.report,
                color: AppColor.themeOrangeColor,
              ),
        ActionButton(
          onTap: () => markSpamBloc.add(
            BlockUnBlockEvent(
              contactId: contact?.mobileNo ?? "",
              comments: appLocalization(context).unblock,
            ),
          ),
          label: contact?.isBlocked == 1
              ? appLocalization(context).unblock
              : appLocalization(context).block,
          icon: Icons.block,
          color: AppColor.themeOrangeColor,
        ),
      ],
    );
  }

  Widget _commentsView(ContactData? contact, context) => Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColor.lightBrownColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  "${appLocalization(context).comment} (${contact?.spamComments?.length ?? 0})"),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: (contact?.spamComments?.length ?? 0) < 3
                  ? contact?.spamComments?.length
                  : 3,
              itemBuilder: (context, index) =>
                  CommentListItem(comment: contact?.spamComments?[index]),
            ),
            if ((contact?.spamComments?.length ?? 0) > 3)
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.comments,
                      arguments: CommentsList(contact: contact));
                },
                child: Text(appLocalization(context).viewAll),
              )
          ],
        ),
      );

  _callHistory(ContactData? contact, BuildContext context) => Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColor.lightBrownColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                appLocalization(context).callHistoryText,
                // style: textTheme(context).titleMedium,
              ),
            ),
            if (contact?.callHistory?.isNotEmpty ?? false)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: contact?.callHistory?.length,
                itemBuilder: (context, index) => CallLogListItem(
                  callLog: contact!.callHistory![index],
                  showPopupMenuBtn: false,
                  fromDetail: true,
                  onTap: () {},
                ),
              ),
          ],
        ),
      );
}

class ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? color;
  final void Function()? onTap;

  const ActionButton({
    super.key,
    required this.label,
    required this.icon,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min, // Ensures buttons fit the row properly
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey.shade300,
            child: Icon(icon,
                color: color ?? AppColor.redColor,
                size: 18), // Icon size adjusted
          ),
          const SizedBox(height: 8),
          DefaultTextStyle(
            style: textTheme(context).titleSmall!.copyWith(fontSize: 8),
            child: Text(label),
          )
        ],
      ),
    );
  }
}
