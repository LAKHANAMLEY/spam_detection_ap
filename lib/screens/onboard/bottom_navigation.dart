import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';
import 'package:spam_delection_app/lib.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  double scale = 3.5;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final List<Widget> _pages = [
    const SubscriptionScreen(),
    const MessagesScreen(),
    const DeviceCallLogs(
      showAppBar: false,
    ),
    // const PlanListScreen(
    //   showAppBar: false,
    // ),
    // const Setting(),
    const Profile(
      showAppBar: false,
    ),
  ];
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  StreamSubscription<ApiState>? streamSubs;
  StreamSubscription<ApiState>? streamSubsCallLog;

  StreamSubscription<PhoneState>? phoneStateStreamSubs;

  StreamSubscription<ApiState>? streamSubsMessage;

  phoneStateConfig() {
    ///listen phone states and show overlay
    phoneStateStreamSubs = PhoneState.stream.listen((state) async {
      if (state.status != PhoneStateStatus.NOTHING &&
          (state.number?.isNotEmpty ?? false)) {
        callLogsListBloc.add(GetCallLogsEvent());
        await permissionRequest(Permission.systemAlertWindow);
        showOverlay(
            callType: getCallTypeByPhoneState(state),
            number: state.number ?? "",
            duration: 0);
      }
      // switch (state.status) {
      //   case PhoneStateStatus.NOTHING:
      //   case PhoneStateStatus.CALL_INCOMING:
      //     await SystemAlertWindow.showSystemWindow(
      //       notificationTitle: AppConstants.projectName,
      //       notificationBody: "Incoming call ${state.number}",
      //     );
      //   // phoneStateBackgroundCallbackHandler(
      //   //     PhoneStateBackgroundEvent.incomingstart, state.number ?? "", 0);
      //   case PhoneStateStatus.CALL_STARTED:
      //   case PhoneStateStatus.CALL_ENDED:
      //     await SystemAlertWindow.showSystemWindow(
      //       notificationTitle: AppConstants.projectName,
      //       notificationBody: "Call ended ${state.number}",
      //     );
      // }
    });
  }

  @override
  void initState() {
    firebase(context);
    phoneStateConfig();
    sharedPrefBloc.add(GetUserDataFromLocalEvent());
    handleAppLifeCycle();
    getAndSyncContacts();
    getAndSyncCallLogs();
    getAndSyncMessages();
    super.initState();
  }

  @override
  void dispose() {
    streamSubs?.cancel();
    streamSubsCallLog?.cancel();
    phoneStateStreamSubs?.cancel();
    streamSubsMessage?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: bottomNavigationBloc,
        builder: (context, state) {
          if (state is SelectIntState) {
            int page = state.value;
            return Scaffold(
                key: _key,
                drawer: const CustomDrawer(),
                appBar: CustomAppBar(
                    centerTitle: false,
                    leading: InkWell(
                      onTap: () {
                        _key.currentState!.openDrawer();
                      },
                      child: Image.asset(
                        IconConstants.icDrawerDetails,
                        scale: 2,
                      ),
                    ),
                    title: "",
                    titleWidget: BlocBuilder(
                        bloc: sharedPrefBloc,
                        builder: (context, state) {
                          if (state is GetUserDataFromLocalState) {
                            var photo = state.user.photo;
                            return GestureDetector(
                              onTap: () {
                                bottomNavigationBloc.add(SelectIntEvent(3));
                              },
                              child: (photo?.isNotEmpty ?? false)
                                  ? CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(photo ?? ""))
                                  : const CircleAvatar(
                                      backgroundImage: AssetImage(
                                          ImageConstants.imageProfile)),
                            );
                          }
                          return const Loader();
                        }),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.notificationList);
                        },
                        child: Image.asset(
                          IconConstants.icNotificationBell,
                          scale: 3.5,
                        ),
                      ),
                      PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.callLogs,
                                  arguments: DeviceCallLogs(
                                      filterBy: CallType.outgoing.name));
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  IconConstants.icOutgoingCall,
                                  scale: 2.5,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      5 /
                                      100,
                                ),
                                Text(
                                  appLocalization(context).outgoingCalls,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.callLogs,
                                  arguments: DeviceCallLogs(
                                      filterBy: CallType.incoming.name));
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  IconConstants.icIncomingCall,
                                  scale: 2.5,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      5 /
                                      100,
                                ),
                                Text(appLocalization(context).incomingCalls,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.callLogs,
                                  arguments: DeviceCallLogs(
                                      filterBy: CallType.missed.name));
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  IconConstants.icMissCall,
                                  scale: 2.5,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      5 /
                                      100,
                                ),
                                Text(appLocalization(context).missedCalls,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.blockedCalls);
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  IconConstants.icBlockedCall,
                                  scale: 2.5,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      4 /
                                      100,
                                ),
                                Text(appLocalization(context).blockedCalls,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              callLogsListBloc.add(DeleteAllCallLogEvent());
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  IconConstants.icDeleteCall,
                                  scale: 2,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      5 /
                                      100,
                                ),
                                Text(appLocalization(context).deleteCalls,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
                body: _pages[page],
                bottomNavigationBar: CurvedNavigationBar(
                  key: _bottomNavigationKey,
                  index: page,
                  height: 75,
                  items: <Widget>[
                    Image.asset(
                      IconConstants.icHomeData,
                      color: getColor(0, page),
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      width: MediaQuery.of(context).size.width * 6 / 100,
                    ),
                    Image.asset(
                      IconConstants.icChatData,
                      color: getColor(1, page),
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      width: MediaQuery.of(context).size.width * 6 / 100,
                    ),
                    Image.asset(
                      IconConstants.icCallData,
                      color: getColor(2, page),
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      width: MediaQuery.of(context).size.width * 6 / 100,
                    ),
                    // Image.asset(
                    //   IconConstants.icPremiumData,
                    //   color: getColor(3, page),
                    //   height: MediaQuery.of(context).size.height * 6 / 100,
                    //   width: MediaQuery.of(context).size.width * 6 / 100,
                    // ),
                    Image.asset(
                      IconConstants.icSettingData,
                      color: getColor(3, page),
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      width: MediaQuery.of(context).size.width * 6 / 100,
                    ),
                  ],
                  color: AppColor.darkPurpleColor,
                  buttonBackgroundColor: AppColor.deepYellowColor,
                  backgroundColor: AppColor.whiteLightColor,
                  animationCurve: Curves.easeInOut,
                  animationDuration: const Duration(milliseconds: 600),
                  onTap: (index) {
                    bottomNavigationBloc.add(SelectIntEvent(index));
                  },
                  letIndexChange: (index) => true,
                ));
          }
          return const Loader();
        });
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await _googleSignIn.disconnect();

      await _googleSignIn.signOut();

      return true;
    } catch (e) {
      debugPrint('Error signing out from Google: $e');
      return false;
    }
  }

  Color? getColor(int i, page) {
    if (page == i) {
      return AppColor.whiteColor;
    }
    return AppColor.whiteColor;
  }

  void getAndSyncContacts() {
    streamSubs = contactListBloc.stream.listen((state) {
      if (state is GetContactState) {
        // filterSearchResults("");
        if (state.value.statusCode == 200) {
        } else if (state.value.statusCode == HTTPStatusCodes.sessionExpired) {
          sessionExpired(context, state.value.message ?? "");
        } else {
          showToast(state.value.message);
        }
      }
      if (state is SyncContactState) {
        if (state.value.statusCode == 200) {
          showToast(state.value.message);
        } else if (state.value.statusCode == HTTPStatusCodes.sessionExpired) {
          sessionExpired(context, state.value.message ?? "");
        } else {
          showToast(state.value.message);
        }
        contactListBloc.add(GetContactEvent());
      }
      if (state is GetDeviceContactState) {
        var contacts = state.value;
        if (contacts != null) {
          contactListBloc.add(SyncContactEvent(contacts: contacts));
        }
      }
    });
    contactListBloc.add(GetDeviceContactEvent());
  }

  void getAndSyncCallLogs() {
    streamSubsCallLog = callLogsListBloc.stream.listen((state) {
      if (state is GetCallLogsState) {
        // filterSearchResults("");
        if (state.value.statusCode == 200) {
        } else if (state.value.statusCode == HTTPStatusCodes.sessionExpired) {
          sessionExpired(context, state.value.message ?? "");
        } else {
          showToast(state.value.message);
        }
      }
      if (state is SyncCallLogState) {
        if (state.value.statusCode == 200) {
          showToast(state.value.message);
        } else if (state.value.statusCode == HTTPStatusCodes.sessionExpired) {
          sessionExpired(context, state.value.message ?? "");
        } else {
          showToast(state.value.message);
        }
        callLogsListBloc.add(GetCallLogsEvent());
      }
      if (state is GetDeviceCallLogState) {
        var deviceCallLogs = state.value;
        callLogsListBloc.add(SyncCallLogEvent(callLogs: deviceCallLogs));
      }
    });
    callLogsListBloc.add(GetDeviceCallLogEvent());
  }

  void getAndSyncMessages() {
    streamSubsMessage = messagesBloc.stream.listen((state) {
      if (state is SmsListState) {
        // filterSearchResults("");
        if (state.value.statusCode == 200) {
        } else if (state.value.statusCode == HTTPStatusCodes.sessionExpired) {
          sessionExpired(context, state.value.message ?? "");
        } else {
          showToast(state.value.message);
        }
      }
      if (state is SyncSmsState) {
        if (state.value.statusCode == 200) {
          showToast(state.value.message);
        } else if (state.value.statusCode == HTTPStatusCodes.sessionExpired) {
          sessionExpired(context, state.value.message ?? "");
        } else {
          showToast(state.value.message);
        }
        messagesBloc.add(SmsListEvent());
      }
      if (state is GetDeviceMessagesState) {
        var deviceCallLogs = state.value;
        messagesBloc.add(SyncSmsEvent(smsLogs: deviceCallLogs));
      }
    });
    messagesBloc.add(GetDeviceMessagesEvent());
  }
}
