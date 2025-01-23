import 'package:direct_call_plus/direct_call_plus.dart';
import 'package:spam_delection_app/lib.dart';

class ContactDetail extends StatefulWidget {
  final ContactData? contact;

  const ContactDetail({super.key, this.contact});

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  final double expandedHeight = 280.0;
  final double collapsedHeight = 100.0;

  ContactData? contact;

  var contactDetailBloc = ApiBloc(ApiBlocInitialState());
  var markSpamBloc = ApiBloc(ApiBlocInitialState());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      var argument = args(context) as ContactDetail;
      contact = argument.contact;
      contactDetailBloc.add(CheckSpamEvent(
          callLogs: CallLogData.fromJson(contact?.toJson() ?? {})));
    });
  }

  @override
  Widget build(BuildContext context) {
    var argument = args(context) as ContactDetail;
    const expandedHeight = 300.0;
    const collapsedHeight = 60.0;
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
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
              callLogsListBloc.add(GetCallLogsEvent());
              contactDetailBloc.add(CheckSpamEvent(
                  callLogs: CallLogData.fromJson(contact?.toJson() ?? {})));
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
                    dialogType: DialogType.failed,
                    subTitle: state.value.message);
              }
              callLogsListBloc.add(GetCallLogsEvent());
              contactDetailBloc.add(CheckSpamEvent(
                  callLogs: CallLogData.fromJson(contact?.toJson() ?? {})));
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
              callLogsListBloc.add(GetCallLogsEvent());
              contactDetailBloc.add(CheckSpamEvent(
                  callLogs: CallLogData.fromJson(contact?.toJson() ?? {})));
            }
          },
          builder: (context, markSpamBlocState) {
            return BlocConsumer(
                bloc: contactDetailBloc,
                listener: (context, state) {
                  if (state is CheckSpamState) {
                    if (state.value.statusCode == 200) {
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
                },
                builder: (context, state) {
                  if (state is CheckSpamState) {
                    var contact =
                        state.value.phonespamdetails ?? argument.contact;
                    return ModalProgressHUD(
                      progressIndicator: const Loader(),
                      inAsyncCall: state is ApiLoadingState ||
                          markSpamBlocState is ApiLoadingState,
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
                                child: Image.asset(
                                  IconConstants.icBacKCircle,
                                  color: AppColor.secondryColor,
                                )),
                            backgroundColor: AppColor.secondryColor,
                            flexibleSpace: FlexibleSpaceBar(
                              collapseMode: CollapseMode.pin,
                              background: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                          color: contact?.isSpam == 1
                                              ? AppColor.redColor
                                              : AppColor.greenColor),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 85,
                                    // bottom: 3,
                                    //bottom: collapsedHeight + 30,
                                    // left: MediaQuery.of(context).size.width / 2 - 50,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: const ShapeDecoration(
                                            color: AppColor.secondryColor,
                                            shape: CircleBorder(),
                                          ),
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage(
                                                contact?.isSpam == 1
                                                    ? IconConstants.icFraud
                                                    : IconConstants.icAvatar),
                                            radius: 45,
                                          ),
                                        ),
                                        Text(
                                          (contact?.name?.isNotEmpty ?? false)
                                              ? contact?.name ?? ""
                                              : contact?.countryCode
                                                          ?.isNotEmpty ??
                                                      false
                                                  ? "+${contact?.countryCode} ${contact?.mobileNo ?? ""}"
                                                  : contact?.mobileNo ?? "",
                                          style: const TextStyle(
                                              color: AppColor.primaryColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        if ((contact?.lastSeen?.isNotEmpty ??
                                                false) ||
                                            contact?.isOnline == "1")
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Circle(
                                                color: contact?.isOnline == "1"
                                                    ? Colors.green
                                                    : Colors.grey,
                                              ),
                                              Text(
                                                contact?.isOnline == "1"
                                                    ? "Online"
                                                    : "Last seen ${contact?.lastSeen}",
                                                style: textTheme(context)
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ActionButton(
                                              onTap: () {
                                                launchSms(context,
                                                    contact?.mobileNo ?? "");
                                              },
                                              label: appLocalization(context)
                                                  .message,
                                              icon: Icons.message,
                                            ),
                                            contact?.isSpam == 1
                                                ? ActionButton(
                                                    onTap: () {
                                                      markSpamBloc.add(
                                                          RemoveSpamEvent(
                                                              contactId: contact
                                                                      ?.mobileNo ??
                                                                  ""));
                                                    },
                                                    label:
                                                        appLocalization(context)
                                                            .unmarkSpam,
                                                    icon: Icons.check_circle)
                                                : ActionButton(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        backgroundColor:
                                                            AppColor
                                                                .secondryColor,
                                                        context: context,
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.vertical(
                                                                  top: Radius
                                                                      .circular(
                                                                          20.0)),
                                                        ),
                                                        builder: (BuildContext
                                                            context) {
                                                          return ReportView(
                                                            // contact: contact!,
                                                            contact: contact!,
                                                          );
                                                        },
                                                      );
                                                    },
                                                    label:
                                                        appLocalization(context)
                                                            .reportText,
                                                    icon: Icons.report),
                                            ActionButton(
                                                onTap: () {
                                                  markSpamBloc.add(
                                                      BlockUnBlockEvent(
                                                          contactId: contact
                                                                  ?.mobileNo ??
                                                              "",
                                                          comments:
                                                              appLocalization(
                                                                      context)
                                                                  .unblock));
                                                },
                                                label: contact?.isBlocked == 1
                                                    ? appLocalization(context)
                                                        .unblock
                                                    : appLocalization(context)
                                                        .block,
                                                icon: Icons.block)
                                          ],
                                        ),
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
                                  color: AppColor.fillColor,
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
                                leading: const Icon(Icons.phone,
                                    color: AppColor.primaryColor),
                                title: Text(
                                  (contact?.countryCode?.isNotEmpty ?? false)
                                      ? "+${contact?.countryCode ?? ""} ${contact?.mobileNo ?? ""}"
                                      : contact?.mobileNo ?? "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle:
                                    (contact?.numberType?.isNotEmpty ?? false)
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
                                    color: AppColor.fillColor,
                                  )),
                              child: IntrinsicHeight(
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
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
                                                const Text(StringConstants
                                                    .spamreportext),
                                                Text(
                                                  contact!.spamReport ?? "",
                                                  style: const TextStyle(
                                                      color:
                                                          AppColor.primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily:
                                                          AppFont.fontFamily),
                                                ),
                                              ],
                                            ),
                                            const Divider(),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    StringConstants.usallytext,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    contact.usuallyCalls ?? "",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: AppColor
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            AppFont.fontFamily),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              StringConstants.callactivitytext,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: AppColor.primaryColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily:
                                                      AppFont.fontFamily),
                                            ),
                                            Text(contact.callActivity ?? ""),
                                          ],
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.planType);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border:
                                        Border.all(color: AppColor.fillColor)),
                                child: ListTile(
                                  leading: const Icon(Icons.location_on,
                                      color: AppColor.primaryColor),
                                  title: Text(
                                    appLocalization(context).moreAvailable,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(appLocalization(context)
                                      .upgradePremiumView),
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
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: contact.callHistory?.length,
                              itemBuilder: (context, index) => CallLogListItem(
                                  callLog: contact.callHistory![index],
                                  showPopupMenuBtn: false,
                                  onTap: () {}),
                            )
                          ])),
                        ],
                      ),
                    );
                  }
                  return const Loader();
                });
          }),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final void Function()? onTap;

  const ActionButton({
    super.key,
    required this.label,
    required this.icon,
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
            radius: 30,
            backgroundColor: Colors.grey.shade300,
            child: Icon(icon,
                color: AppColor.redColor, size: 28), // Icon size adjusted
          ),
          const SizedBox(height: 8),
          DefaultTextStyle(
            style: const TextStyle(
                color: AppColor.primaryColor,
                fontSize: 12,
                fontFamily: AppFont.fontFamily,
                fontWeight: FontWeight.w600),
            child: Text(label),
          )
        ],
      ),
    );
  }
}
