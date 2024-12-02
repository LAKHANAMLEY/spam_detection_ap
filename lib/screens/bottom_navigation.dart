import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spam_delection_app/app_route/route.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_event.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_state.dart';
import 'package:spam_delection_app/bloc/shared_pref_bloc/shared_pref_event.dart';
import 'package:spam_delection_app/bloc/shared_pref_bloc/shared_pref_state.dart';
import 'package:spam_delection_app/constants/icons_constants.dart';
import 'package:spam_delection_app/constants/image_constants.dart';
import 'package:spam_delection_app/data/repository/contact/get_device_contacts.dart';
import 'package:spam_delection_app/globals/app_constants.dart';
import 'package:spam_delection_app/globals/colors.dart';
import 'package:spam_delection_app/screens/blocked_number_screen.dart';
import 'package:spam_delection_app/screens/chat_screen.dart';
import 'package:spam_delection_app/screens/device_call_logs.dart';
import 'package:spam_delection_app/screens/home_screen.dart';
import 'package:spam_delection_app/screens/loader.dart';
import 'package:spam_delection_app/screens/premium_plan.dart';
import 'package:spam_delection_app/screens/profile_screen.dart';
import 'package:spam_delection_app/screens/setting_screen.dart';
import 'package:spam_delection_app/screens/widgets/custom_app_bar.dart';
import 'package:spam_delection_app/screens/widgets/custom_drawer.dart';
import 'package:spam_delection_app/utils/api_constants/http_status_codes.dart';
import 'package:spam_delection_app/utils/session_expired.dart';
import 'package:spam_delection_app/utils/toast.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final List<Widget> _pages = [
    const HomeScreen(),
    const ChatScreen(),
    // const ContactList(),
    const DeviceCallLogs(showAppBar: false),
    const PremiumPlan(),
    const Setting(),
  ];
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  StreamSubscription<ApiState>? streamSubs;

  @override
  void initState() {
    sharedPrefBloc.add(GetUserDataFromLocalEvent());
    getAndSyncContacts();
    super.initState();
  }

  @override
  void dispose() {
    streamSubs?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Profile()));
                      },
                      child: (photo?.isNotEmpty ?? false)
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(photo ?? ""))
                          : const CircleAvatar(
                              backgroundImage:
                                  AssetImage(ImageConstants.imageProfile)),
                    );
                  }
                  return const Loader();
                }),
            actions: [
              Image.asset(
                IconConstants.icNotification,
                height: MediaQuery.of(context).size.height * 3 / 100,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 5 / 100,
              ),
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.callLogs);
                    },
                    child: Row(
                      children: [
                        Image.asset(IconConstants.icOutgoing),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 5 / 100,
                        ),
                        const Text(
                          'Outgoing Calls',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Image.asset(
                          IconConstants.icIncoming,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 5 / 100,
                        ),
                        const Text('Incomig Calls',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Image.asset(IconConstants.icMissedCall),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 5 / 100,
                        ),
                        const Text('Missed Calls',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BlockedNumber()));
                      },
                      child: Row(
                        children: [
                          Image.asset(IconConstants.icBlockCall),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 5 / 100,
                          ),
                          const Text('Blocked Calls',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600))
                        ],
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Image.asset(IconConstants.icDelete),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 5 / 100,
                        ),
                        const Text('Delete all Calls',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  )
                ],
              ),
              // GestureDetector(
              //   onTap: () {
              //     showDialog(
              //         context: context,
              //         builder: (BuildContext context) {
              //           return AlertDialog(
              //             shape: const RoundedRectangleBorder(
              //               borderRadius: BorderRadius.all(Radius.circular(8)),
              //             ),
              //             backgroundColor: AppColor.callUpdateColor,
              //             content: Align(
              //               alignment: Alignment.topRight,
              //               child: SizedBox(
              //                 height:
              //                     MediaQuery.of(context).size.height * 40 / 100,
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     SizedBox(
              //                       height: MediaQuery.of(context).size.height *
              //                           3 /
              //                           100,
              //                     ),
              //                     // Row(
              //                     //   children: [
              //                     //     Image.asset(IconConstants.icOutgoing),
              //                     //     SizedBox(
              //                     //       width:
              //                     //           MediaQuery.of(context).size.width *
              //                     //               5 /
              //                     //               100,
              //                     //     ),
              //                     //     const Text(
              //                     //       'Outgoing Calls',
              //                     //       style: TextStyle(
              //                     //           color: Colors.black,
              //                     //           fontSize: 18,
              //                     //           fontWeight: FontWeight.w600),
              //                     //     )
              //                     //   ],
              //                     // ),
              //                     // SizedBox(
              //                     //   height: MediaQuery.of(context).size.height *
              //                     //       4 /
              //                     //       100,
              //                     // ),
              //                     // Row(
              //                     //   children: [
              //                     //     Image.asset(
              //                     //       IconConstants.icIncoming,
              //                     //     ),
              //                     //     SizedBox(
              //                     //       width:
              //                     //           MediaQuery.of(context).size.width *
              //                     //               5 /
              //                     //               100,
              //                     //     ),
              //                     //     const Text('Incomig Calls',
              //                     //         style: TextStyle(
              //                     //             color: Colors.black,
              //                     //             fontSize: 18,
              //                     //             fontWeight: FontWeight.w600))
              //                     //   ],
              //                     // ),
              //                     // SizedBox(
              //                     //   height: MediaQuery.of(context).size.height *
              //                     //       4 /
              //                     //       100,
              //                     // ),
              //                     // Row(
              //                     //   children: [
              //                     //     Image.asset(IconConstants.icMissedCall),
              //                     //     SizedBox(
              //                     //       width:
              //                     //           MediaQuery.of(context).size.width *
              //                     //               5 /
              //                     //               100,
              //                     //     ),
              //                     //     const Text('Missed Calls',
              //                     //         style: TextStyle(
              //                     //             color: Colors.black,
              //                     //             fontSize: 18,
              //                     //             fontWeight: FontWeight.w600))
              //                     //   ],
              //                     // ),
              //                     // SizedBox(
              //                     //   height: MediaQuery.of(context).size.height *
              //                     //       4 /
              //                     //       100,
              //                     // ),
              //                     // Row(
              //                     //   children: [
              //                     //     Image.asset(IconConstants.icBlockCall),
              //                     //     SizedBox(
              //                     //       width:
              //                     //           MediaQuery.of(context).size.width *
              //                     //               5 /
              //                     //               100,
              //                     //     ),
              //                     //     const Text('Blocked Calls',
              //                     //         style: TextStyle(
              //                     //             color: Colors.black,
              //                     //             fontSize: 18,
              //                     //             fontWeight: FontWeight.w600))
              //                     //   ],
              //                     // ),
              //                     // SizedBox(
              //                     //   height: MediaQuery.of(context).size.height *
              //                     //       4 /
              //                     //       100,
              //                     // ),
              //                     // Row(
              //                     //   children: [
              //                     //     Image.asset(IconConstants.icDelete),
              //                     //     SizedBox(
              //                     //       width:
              //                     //           MediaQuery.of(context).size.width *
              //                     //               5 /
              //                     //               100,
              //                     //     ),
              //                     //     const Text('Delete all Calls',
              //                     //         style: TextStyle(
              //                     //             color: Colors.black,
              //                     //             fontSize: 18,
              //                     //             fontWeight: FontWeight.w600))
              //                     //   ],
              //                     // ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           );
              //         });
              //   },
              //   child: Image.asset(
              //     IconConstants.icMoreDetails,
              //     height: MediaQuery.of(context).size.height * 3 / 100,
              //   ),
              // ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width * 6 / 100,
              // ),
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
          backgroundColor: AppColor.secondryColor,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
              // _pages = _page;
              //_pages[_page];
            });
          },
          letIndexChange: (index) => true,
        ));
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
    });
    getLocalContacts().then((contacts) {
      if (contacts != null) {
        contactListBloc.add(SyncContactEvent(contacts: contacts));
      } else {
        contactListBloc.add(GetContactEvent());
      }
    });
  }
}
