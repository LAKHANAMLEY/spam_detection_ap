import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';
import 'package:spam_delection_app/lib.dart'; // Assuming this imports necessary constants and extensions
// import 'package:async/async.dart'; // If you use locks

extension ColorByIndex on int {
  Color? getColorForBottomNav(int page) {
    return this == page ? AppColor.whiteColor : AppColor.whiteColor;
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  StreamSubscription<PhoneState>? _phoneStateStreamSubs;
  bool _isProcessingCall = false; // To avoid showing the screen multiple times

  final List<Widget> _pages = const [
    SubscriptionScreen(),
    MessagesScreen(),
    DeviceCallLogs(showAppBar: false),
    Profile(showAppBar: false),
  ];

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
    _syncInitialData(context);
    _phoneStateListener();
    sharedPrefBloc.add(GetUserDataFromLocalEvent());
    handleAppLifeCycle();
    setDefaultSMSApp().whenComplete(() {
      CallController.setDefaultCallingApp();
    });
  }

  // Future<void> _checkUpdatedPermissions() async {
  //   final statuses = await <Permission>[
  //     Permission.contacts,
  //     Permission.sms,
  //     Permission.systemAlertWindow,
  //     Permission.notification,
  //     Permission.camera,
  //     Permission.photos,
  //     Permission.storage,
  //   ].request(); // Use .status to check the current state

  //   statuses.forEach((permission, status) {
  //     log('Updated $permission: $status');
  //     if (status.isGranted) {
  //       if (permission == Permission.phone) {
  //         context.read<CallLogDBBloc>().add(SyncDBCallLogs());
  //       }
  //       if (permission == Permission.contacts) {
  //         context.read<ContactDBBloc>().add(SyncDBContacts());
  //       }
  //       if (permission == Permission.sms) {
  //         context.read<MessageDBBloc>().add(SyncMessagesWithServer());
  //       }
  //     } else if (status.isDenied) {
  //     } else if (status.isPermanentlyDenied) {
  //       // Permission is still permanently denied, maybe show a message again
  //     }
  //   });
  // }

  handleAppLifeCycle() {
    // how to get in flutter user is online and offline
    AppLifecycleListener(
      onResume: () {
        _syncInitialData(context);
        userOnlineOfflineStatusBloc
            .add(SetUserOnlineOfflineEvent(isOnline: "1"));
      },
      onInactive: () {
        permissionStreamSubscription?.cancel();
        userOnlineOfflineStatusBloc
            .add(SetUserOnlineOfflineEvent(isOnline: "0"));
      },
    );
  }

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    permissionStreamSubscription?.cancel();
    context.read<SmsBloc>().add(CancelSmsListeningStream());
    _phoneStateStreamSubs?.cancel();
    super.dispose();
  }

  Future<void> _syncInitialData(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PermissionBloc>().add(GetMultiplePermissionsStatusEvent([
            Permission.phone,
            Permission.contacts,
            Permission.sms,
            Permission.notification,
            Permission.systemAlertWindow,
          ]));
    });

    permissionStreamSubscription =
        context.read<PermissionBloc>().stream.listen((state) {
      if (state is MultiplePermissionsStatusLoadedState) {
        if (mounted) {
          if (state.statuses[Permission.contacts] == PermissionStatus.granted) {
            context.read<ContactDBBloc>().add(SyncDBContacts());
          }
          if (state.statuses[Permission.phone] == PermissionStatus.granted) {
            context.read<CallLogDBBloc>().add(SyncDBCallLogs());
          }
          if (state.statuses[Permission.sms] == PermissionStatus.granted) {
            context.read<MessageDBBloc>().add(SyncMessagesWithServer());
          }
          if (state.statuses[Permission.notification] ==
              PermissionStatus.granted) {
            firebase(context);
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<SmsBloc>().add(StartListeningSms());
          });
        } else {
          log("Mounted : $mounted");
        }
      }
    });
  }

  void _phoneStateListener() {
    _phoneStateStreamSubs = PhoneState.stream.listen((state) async {
      log("${state.number} ${state.status.name} ${state.duration}");
      if (_isProcessingCall) {
        if (state.status == PhoneStateStatus.NOTHING) {
          _isProcessingCall = false;
        }
        return;
      }

      if (state.status != PhoneStateStatus.NOTHING &&
          state.number?.isNotEmpty == true) {
        _isProcessingCall = true;

        // Optionally, navigate to the full CallScreen as well
        // You might want to do this based on a specific condition or user preference
        if (state.status == PhoneStateStatus.CALL_STARTED ||
            state.status == PhoneStateStatus.CALL_ENDED ||
            state.status == PhoneStateStatus.CALL_INCOMING) {
          context.read<CallLogDBBloc>().add(SyncManuallyDBCallLog(
                callLogEntry: CallLogEntry(
                  number: state.number,
                  duration: state.duration?.inSeconds ?? 0,
                  timestamp: DateTime.now().millisecondsSinceEpoch,
                  callType: getCallLogType(state.status.name),
                ),
              ));

          // Call your existing showOverlay function
          showOverlay(
            callType: getCallLogType(state.status.name)?.name ?? "",
            number: state.number ?? "",
            duration: state.duration?.inSeconds ?? 0,
          );

          // /Check ig this is a default phone app
          // _showCallScreen(
          //   context: context,
          //   callType: getCallLogType(state.status.name)!,
          //   number: state.number ?? "",
          //   duration: state.duration?.inSeconds ?? 0,
          // );
          _isProcessingCall = false;
        }
      } else if (state.status == PhoneStateStatus.NOTHING) {
        _isProcessingCall = false;
      }
    });
  }

  void _showCallScreen({
    required BuildContext context,
    required CallType callType,
    required String number,
    required int duration,
  }) {
    Navigator.pushNamed(context, AppRoutes.defaultCall,
        arguments: DefaultCall(
          callType: callType,
          duration: duration,
          number: number,
        ));
  }

  static const _platform = MethodChannel("com.broadlink.protect/chat");

  StreamSubscription<PermissionState>? permissionStreamSubscription;

  Future<void> setDefaultSMSApp() async {
    try {
      await _platform.invokeMethod('setDefaultSms');
    } on PlatformException catch (e) {
      print("Error setting default SMS app: $e");
    }
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bottomNavigationBloc,
      builder: (context, state) {
        if (state is SelectIntState) {
          final currentPageIndex = state.value;
          return Scaffold(
            key: _key,
            drawer: const CustomDrawer(),
            appBar: CustomAppBar(
              centerTitle: false,
              leading: InkWell(
                onTap: () => _key.currentState?.openDrawer(),
                child: Image.asset(IconConstants.icDrawerDetails, scale: 2.5),
              ),
              title: "",
              titleWidget: BlocBuilder(
                bloc: sharedPrefBloc,
                builder: (context, userState) {
                  if (userState is GetUserDataFromLocalState) {
                    final photo = userState.user.photo;
                    return GestureDetector(
                      onTap: () => bottomNavigationBloc.add(SelectIntEvent(3)),
                      child: (photo?.isNotEmpty == true)
                          ? CircleAvatar(backgroundImage: NetworkImage(photo!))
                          : const CircleAvatar(
                              backgroundImage:
                                  AssetImage(IconConstants.icUsername4X)),
                    );
                  }
                  return const Loader();
                },
              ),
              actions: [
                IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.notificationList),
                  icon:
                      Image.asset(IconConstants.icNotificationBell, scale: 3.5),
                ),
                // const SizedBox(width: 15),
                if (currentPageIndex == 2)
                  IconButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.contactList),
                    icon: const Icon(Icons.perm_contact_calendar_outlined,
                        color: Color.fromRGBO(102, 106, 119, 1)),
                  ),
                // const SizedBox(width: 15),
                // Consider simplifying the PopupMenuButton if it becomes complex
              ],
            ),
            body: _pages[currentPageIndex],
            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: currentPageIndex,
              height: 65,
              items: <Widget>[
                Image.asset(IconConstants.icHomeData,
                    color: 0.getColorForBottomNav(currentPageIndex),
                    height: 0.06 * MediaQuery.of(context).size.height,
                    width: 0.06 * MediaQuery.of(context).size.width),
                Image.asset(IconConstants.icChatData,
                    color: 1.getColorForBottomNav(currentPageIndex),
                    height: 0.06 * MediaQuery.of(context).size.height,
                    width: 0.06 * MediaQuery.of(context).size.width),
                Image.asset(IconConstants.icCallData,
                    color: 2.getColorForBottomNav(currentPageIndex),
                    height: 0.06 * MediaQuery.of(context).size.height,
                    width: 0.06 * MediaQuery.of(context).size.width),
                Image.asset(IconConstants.icSettingData,
                    color: 3.getColorForBottomNav(currentPageIndex),
                    height: 0.06 * MediaQuery.of(context).size.height,
                    width: 0.06 * MediaQuery.of(context).size.width),
              ],
              color: AppColor.darkPurpleColor,
              buttonBackgroundColor: AppColor.deepYellowColor,
              backgroundColor: AppColor.whiteLightColor,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 600),
              onTap: (index) => bottomNavigationBloc.add(SelectIntEvent(index)),
              letIndexChange: (index) => true,
            ),
          );
        }
        return const Loader();
      },
    );
  }
}
