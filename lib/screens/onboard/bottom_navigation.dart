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

  final List<Widget> _pages = const [
    SubscriptionScreen(),
    MessagesScreen(),
    DeviceCallLogs(showAppBar: false),
    Profile(showAppBar: false),
  ];

  @override
  void initState() {
    super.initState();
    _syncInitialData();
    _phoneStateListener();
    sharedPrefBloc.add(GetUserDataFromLocalEvent());
    handleAppLifeCycle();
    setDefaultSMSApp().whenComplete(() {
      setDefaultCallingApp();
    });
  }

  @override
  void dispose() {
    _phoneStateStreamSubs?.cancel();
    super.dispose();
  }

  Future<void> _syncInitialData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final permissions = await requestMultiplePermissions();
      if (mounted) {
        if (permissions[Permission.contacts]?.isGranted == true) {
          context.read<ContactDBBloc>().add(SyncDBContacts());
        }
        if (permissions[Permission.phone]?.isGranted == true) {
          context.read<CallLogDBBloc>().add(SyncDBCallLogs());
        }
        if (permissions[Permission.sms]?.isGranted == true) {
          context.read<MessageDBBloc>().add(SyncMessagesWithServer());
        }
        if (permissions[Permission.notification]?.isGranted == true) {
          firebase(context);
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<SmsBloc>().add(StartListeningSms());
        });
      } else {
        log("Mounted : $mounted");
      }
    });
  }

  bool _isProcessingCall = false;

  void _phoneStateListener() {
    _phoneStateStreamSubs = PhoneState.stream.listen((state) async {
      if (state.status != PhoneStateStatus.NOTHING &&
          state.number?.isNotEmpty == true) {
        _isProcessingCall = true;
        context.read<CallLogDBBloc>().add(SyncManuallyDBCallLog(
              callLogEntry: CallLogEntry(
                number: state.number,
                duration: state.duration?.inSeconds ?? 0,
                timestamp: DateTime.now().millisecondsSinceEpoch,
                callType: getCallLogType(getCallTypeByPhoneState(state)),
              ),
            ));
        showOverlay(
          callType: getCallTypeByPhoneState(state),
          number: state.number ?? "",
          duration: 0,
        );
        // You might need a way to reset _isProcessingCall when the call ends
        // This might involve listening for a specific PhoneStateStatus (e.g., NOTHING)
        // or using a timer.
      } else if (state.status == PhoneStateStatus.NOTHING) {
        _isProcessingCall = false; // Reset when call ends
      }
    });
  }

  static const _platform = MethodChannel("com.broadlink.protect/chat");
  static const _platformCall = MethodChannel("com.broadlink.protect/call");

  Future<void> setDefaultSMSApp() async {
    try {
      await _platform.invokeMethod('setDefaultSms');
    } on PlatformException catch (e) {
      print("Error setting default SMS app: $e");
    }
  }

  Future<void> setDefaultCallingApp() async {
    try {
      await _platformCall.invokeMethod('requestDefaultDialer');
    } on PlatformException catch (e) {
      print("Error setting default Calling app: $e");
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
                                  AssetImage(ImageConstants.imageProfile)),
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
