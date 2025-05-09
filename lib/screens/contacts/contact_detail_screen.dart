import 'package:direct_call_plus/direct_call_plus.dart';
import 'package:spam_delection_app/lib.dart';

class ContactDetail extends StatelessWidget {
  final ContactData? contact;

  const ContactDetail({super.key, this.contact});

  @override
  Widget build(BuildContext context) {
    var markSpamBloc = ApiBloc(ApiBlocInitialState());
    var arg = args(context) as ContactDetail;
    ContactData? contact = arg.contact;
    // context
    //     .read<ContactDBBloc>()
    //     .add(LoadDBContactById(id: contact?.mobileNo ?? ""));
    context
        .read<CallLogDBBloc>()
        .add(GetDBCallLog(mobileNo: contact?.mobileNo ?? ""));
    context
        .read<CallLogDBBloc>()
        .add(SyncDBCallLogHistory(mobileNo: contact?.mobileNo ?? ""));

    const expandedHeight = 330.0;
    const collapsedHeight = 120.0;
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: BlocConsumer(
        bloc: markSpamBloc,
        listener: (context, state) {
          if (state is MarkSpamState) {
            if (state.value.statusCode == 200) {
              showCustomDialog(
                context,
                dialogType: DialogType.success,
                subTitle: state.value.message,
              );
            } else if (state.value.statusCode ==
                HTTPStatusCodes.sessionExpired) {
              sessionExpired(context, state.value.message ?? "");
            } else {
              showCustomDialog(
                context,
                dialogType: DialogType.failed,
                subTitle: state.value.message,
              );
            }
            // context.read<CallLogDBBloc>().add(SyncDBCallLogs());
            // callLogsListBloc.add(GetCallLogsEvent());

            context
                .read<CallLogDBBloc>()
                .add(SyncDBCallLogHistory(mobileNo: contact?.mobileNo ?? ""));

            // contactDetailBloc.add(CheckSpamEvent(
            //     callLogs: [CallLogData.fromJson(contact?.toJson() ?? {})]));
          }
          if (state is RemoveSpamState) {
            if (state.value.statusCode == 200) {
              showCustomDialog(context,
                  dialogType: DialogType.success,
                  subTitle: state.value.message);
            } else if (state.value.statusCode ==
                HTTPStatusCodes.sessionExpired) {
              sessionExpired(context, state.value.message);
            } else {
              showCustomDialog(context,
                  dialogType: DialogType.failed, subTitle: state.value.message);
            }
            // callLogsListBloc.add(GetCallLogsEvent());
            // context.read<CallLogDBBloc>().add(SyncDBCallLogs());

            context
                .read<CallLogDBBloc>()
                .add(SyncDBCallLogHistory(mobileNo: contact?.mobileNo ?? ""));

            // contactDetailBloc.add(CheckSpamEvent(
            //     callLogs: [CallLogData.fromJson(contact?.toJson() ?? {})]));
          }
          if (state is BlockUnBlockState) {
            if (state.value.statusCode == 200) {
              showCustomDialog(context,
                  dialogType: DialogType.success,
                  subTitle: state.value.message);
            } else if (state.value.statusCode ==
                HTTPStatusCodes.sessionExpired) {
              sessionExpired(context, state.value.message);
            } else {
              showCustomDialog(context,
                  dialogType: DialogType.failed,
                  subTitle: state.value.message.toString());
            }
            // callLogsListBloc.add(GetCallLogsEvent());
            // context.read<CallLogDBBloc>().add(SyncDBCallLogs());

            context
                .read<CallLogDBBloc>()
                .add(SyncDBCallLogHistory(mobileNo: contact?.mobileNo ?? ""));

            // contactDetailBloc.add(CheckSpamEvent(
            //     callLogs: [CallLogData.fromJson(contact?.toJson() ?? {})]));
          }
        },
        builder: (context, markSpamBlocState) {
          return BlocConsumer<CallLogDBBloc, CallLogDBState>(
              listener: (context, state) {
            if (state is CallLogDBLoadedById) {
              contact = state.callLog.contactData ?? contact;
            }
            if (state is SyncDBCallLogHistoryState) {
              if (state.value.statusCode == 200) {
                contact = state.value.phonespamdetails ?? contact;
                // showCustomDialog(context,
                //     dialogType: DialogType.success,
                //     subTitle: state.value.message);
              } else if (state.value.statusCode ==
                  HTTPStatusCodes.sessionExpired) {
                sessionExpired(context, state.value.message);
              } else {
                showCustomDialog(context,
                    dialogType: DialogType.failed,
                    subTitle: state.value.message.toString());
              }
            }
            // context.read<CallLogDBBloc>().add(
            //     SyncDBCallLogHistory(mobileNo: contact?.mobileNo ?? ""));
            // context
            //     .read<ContactDBBloc>()
            //     .add(LoadDBContactById(id: contact?.mobileNo ?? ""));
          }, builder: (context, state) {
            // if (state is CheckSpamState) {
            // var contact =
            //     state.value.phonespamdetails ?? argument.contact;
            return ModalProgressHUD(
              progressIndicator: const Loader(),
              inAsyncCall: (
                  //state is ApiLoadingState ||
                  markSpamBlocState is ApiLoadingState),
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverAppBar(
                    expandedHeight: expandedHeight,
                    collapsedHeight: collapsedHeight,
                    floating: true,
                    pinned: true,
                    snap: true,
                    leading: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      // child: Image.asset(
                      //   IconConstants.icBacKCircle,
                      //   color: AppColor.whiteColor,
                      // ),
                    ),
                    backgroundColor: AppColor.whiteColor,
                    actions: [
                      PopupMenuButton(
                        iconColor: Colors.white,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text(appLocalization(context).editContact),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.editContact,
                                  arguments: EditContact(
                                    contactData: contact,
                                  ));
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
                          actions(context, contact),
                        ],
                      ),
                      centerTitle: true,
                      collapseMode: CollapseMode.pin,
                      // expandedTitleScale: 1.2,
                      background: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                  color: contact?.isSpam == 1
                                      ? AppColor.redColor
                                      : AppColor.themeOrangeColor),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 100,
                            // bottom: 3,
                            //bottom: collapsedHeight + 30,
                            // left: MediaQuery.of(context).size.width / 2 - 50,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const ShapeDecoration(
                                    color: AppColor.whiteColor,
                                    shape: CircleBorder(),
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        contact?.isSpam == 1
                                            ? IconConstants.icSpamCircle
                                            : IconConstants.icUsername4X),
                                    radius: 45,
                                  ),
                                ),
                                // header(context),
                                // if ((contact?.lastSeen?.isNotEmpty ??
                                //         false) ||
                                //     contact?.isOnline == "1")
                                //   subHeader(context),
                                // const SizedBox(
                                //   height: 10,
                                // ),
                                // actions(context),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: AppColor.lightBrownColor,
                        ),
                      ),
                      child: ListTile(
                        onTap: () async {
                          await DirectCallPlus.makeCall((contact
                                      ?.countryCode?.isNotEmpty ??
                                  false)
                              ? "+${contact?.countryCode ?? ""} ${contact?.mobileNo ?? ""}"
                              : contact?.mobileNo ?? "");
                        },
                        leading:
                            const Icon(Icons.phone, color: AppColor.blackColor),
                        title: Text(
                          (contact?.countryCode?.isNotEmpty ?? false)
                              ? "+${contact?.countryCode ?? ""} ${contact?.mobileNo ?? ""}"
                              : contact?.mobileNo ?? "",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: (contact?.numberType?.isNotEmpty ?? false)
                            ? Text(
                                contact?.numberType ?? "",
                                style: textTheme(context)
                                    .bodySmall
                                    ?.copyWith(color: Colors.grey),
                              )
                            : null,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColor.lightBrownColor,
                          )),
                      child: IntrinsicHeight(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(appLocalization(context)
                                            .spamReport),
                                        Text(
                                          contact?.spamReport ?? "",
                                          style: const TextStyle(
                                              color: AppColor.blackColor,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: AppFont.fontFamily),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            appLocalization(context)
                                                .usuallyCalls,
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            contact?.usuallyCalls ?? "",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: AppColor.blackColor,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: AppFont.fontFamily),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                              const VerticalDivider(),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      appLocalization(context).callActivity,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: AppColor.blackColor,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: AppFont.fontFamily),
                                    ),
                                    Text(contact?.callActivity ?? ""),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.planList);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border:
                                Border.all(color: AppColor.lightBrownColor)),
                        child: ListTile(
                          leading: const Icon(Icons.location_on,
                              color: AppColor.blackColor),
                          title: Text(
                            appLocalization(context).moreAvailable,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle:
                              Text(appLocalization(context).upgradePremiumView),
                        ),
                      ),
                    ),
                    10.height(),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        appLocalization(context).callHistoryText,
                        style: textTheme(context).titleMedium,
                      ),
                    ),
                    if (contact?.callHistory?.isNotEmpty ?? false)
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: contact?.callHistory?.length,
                        itemBuilder: (context, index) => CallLogListItem(
                            callLog: contact!.callHistory![index],
                            showPopupMenuBtn: false,
                            fromDetail: true,
                            onTap: () {}),
                      )
                  ])),
                ],
              ),
            );
            // }
            // return const Loader();
          });
        },
      ),
    );
  }

  Text header(BuildContext context, ContactData? contact) {
    return Text(
      (contact?.name?.isNotEmpty ?? false)
          ? contact?.name ?? ""
          : contact?.countryCode?.isNotEmpty ?? false
              ? "+${contact?.countryCode} ${contact?.mobileNo ?? ""}"
              : contact?.mobileNo ?? "",
      style: textTheme(context).titleMedium,
    );
  }

  Row subHeader(BuildContext context, ContactData? contact) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Circle(
          color: contact?.isOnline == "1" ? Colors.green : Colors.grey,
        ),
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
  }

  Row actions(BuildContext context, ContactData? contact) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ActionButton(
          onTap: () {
            launchSms(context, contact?.mobileNo ?? "");
          },
          label: appLocalization(context).message,
          icon: Icons.message,
          color: contact?.isSpam == 1 ? Colors.red : AppColor.themeOrangeColor,
        ),
        contact?.markspambyuser == 1
            ? ActionButton(
                onTap: () {
                  markSpamBloc
                      .add(RemoveSpamEvent(contactId: contact?.mobileNo ?? ""));
                },
                label: appLocalization(context).notSpam,
                icon: Icons.check_circle,
                color: contact?.isSpam == 1
                    ? Colors.red
                    : AppColor.themeOrangeColor,
              )
            : ActionButton(
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
                        // contact: contact!,
                        contact: contact!,
                      );
                    },
                  );
                },
                label: appLocalization(context).reportText,
                icon: Icons.report,
                color: contact?.isSpam == 1
                    ? Colors.red
                    : AppColor.themeOrangeColor,
              ),
        ActionButton(
          onTap: () {
            markSpamBloc.add(BlockUnBlockEvent(
                contactId: contact?.mobileNo ?? "",
                comments: appLocalization(context).unblock));
          },
          label: contact?.isBlocked == 1
              ? appLocalization(context).unblock
              : appLocalization(context).block,
          icon: Icons.block,
          color: contact?.isSpam == 1 ? Colors.red : AppColor.themeOrangeColor,
        )
      ],
    );
  }
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
