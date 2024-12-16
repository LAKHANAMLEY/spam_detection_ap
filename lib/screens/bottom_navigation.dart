import 'package:phone_state/phone_state.dart';
import 'package:spam_delection_app/lib.dart';
import 'package:system_alert_window/system_alert_window.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _page = 2;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final List<Widget> _pages = [
    const HomeScreen(),
    // const ChatScreen(),
    const MessagesScreen(),
    // const ContactList(),
    const DeviceCallLogs(
      showAppBar: false,
    ),
    const PlanType(
      showAppBar: false,
    ),
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

  phoneStateConfig() {
    ///listen phone states and show overlay
    phoneStateStreamSubs = PhoneState.stream.listen((state) async {
      switch (state.status) {
        case PhoneStateStatus.NOTHING:
        case PhoneStateStatus.CALL_INCOMING:
          await SystemAlertWindow.showSystemWindow(
            notificationTitle: AppConstants.projectName,
            notificationBody: "Incoming call ${state.number}",
          );
        // phoneStateBackgroundCallbackHandler(
        //     PhoneStateBackgroundEvent.incomingstart, state.number ?? "", 0);
        case PhoneStateStatus.CALL_STARTED:
        case PhoneStateStatus.CALL_ENDED:
          await SystemAlertWindow.showSystemWindow(
            notificationTitle: AppConstants.projectName,
            notificationBody: "Call ended ${state.number}",
          );
      }
    });
  }

  @override
  void initState() {
    phoneStateConfig();
    sharedPrefBloc.add(GetUserDataFromLocalEvent());
    getAndSyncContacts();
    getAndSyncCallLogs();
    super.initState();
  }

  @override
  void dispose() {
    streamSubs?.cancel();
    streamSubsCallLog?.cancel();
    phoneStateStreamSubs?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: bottomNavigationBloc,
        builder: (context, state) {
          if (state is SelectIntState) {
            _page = state.value;
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
                        IconConstants.icdrawer,
                        height: MediaQuery.of(context).size.height * 4 / 100,
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
                                bottomNavigationBloc.add(SelectIntEvent(4));
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => const Profile()));
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
                          IconConstants.icNotification,
                          height: MediaQuery.of(context).size.height * 3 / 100,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 5 / 100,
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
                                Image.asset(IconConstants.icOutgoing),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      5 /
                                      100,
                                ),
                                Text(
                                  appLocalization(context).outgoingCalls,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
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
                                  IconConstants.icIncoming,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      5 /
                                      100,
                                ),
                                Text(appLocalization(context).incomingCalls,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
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
                                Image.asset(IconConstants.icMissedCall),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BlockedNumber()));
                            },
                            child: Row(
                              children: [
                                Image.asset(IconConstants.icBlockCall),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      5 /
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
                                Image.asset(IconConstants.icDelete),
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
                          )
                        ],
                      ),
                    ]),
                body: _pages[_page],
                bottomNavigationBar: CurvedNavigationBar(
                  key: _bottomNavigationKey,
                  index: _page,
                  height: 75,
                  items: <Widget>[
                    Image.asset(
                      IconConstants.icHome,
                      color: getColor(0),
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      width: MediaQuery.of(context).size.width * 6 / 100,
                    ),
                    Image.asset(
                      IconConstants.icChat,
                      color: getColor(1),
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      width: MediaQuery.of(context).size.width * 6 / 100,
                    ),
                    Image.asset(
                      IconConstants.icPhone,
                      color: getColor(2),
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      width: MediaQuery.of(context).size.width * 6 / 100,
                    ),
                    Image.asset(
                      IconConstants.icPremium,
                      color: getColor(3),
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      width: MediaQuery.of(context).size.width * 6 / 100,
                    ),
                    Image.asset(
                      IconConstants.icSetting,
                      color: getColor(4),
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      width: MediaQuery.of(context).size.width * 6 / 100,
                    ),
                  ],
                  color: AppColor.callColor,
                  buttonBackgroundColor: AppColor.yellowdeep,
                  backgroundColor: AppColor.whiteLight,
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

  Color? getColor(int i) {
    if (_page == i) {
      return Colors.white;
    }
    return Colors.white;
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
}
