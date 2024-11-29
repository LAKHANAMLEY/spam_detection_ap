import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spam_delection_app/app_route/route.dart';
import 'package:spam_delection_app/constants/icons_constants.dart';
import 'package:spam_delection_app/constants/image_constants.dart';
import 'package:spam_delection_app/data/shared_pref/shared_pref.dart';
import 'package:spam_delection_app/globals/colors.dart';
import 'package:spam_delection_app/screens/blocked_number_screen.dart';
import 'package:spam_delection_app/screens/call_log_screen.dart';
import 'package:spam_delection_app/screens/chat_screen.dart';
import 'package:spam_delection_app/screens/home_screen.dart';
import 'package:spam_delection_app/screens/premium_plan.dart';
import 'package:spam_delection_app/screens/profile_screen.dart';
import 'package:spam_delection_app/screens/protection_type_screen.dart';
import 'package:spam_delection_app/screens/setting_screen.dart';
import 'package:spam_delection_app/screens/widgets/custom_dialog.dart';

import '../bloc/api_bloc/api_state.dart';
import '../utils/api_constants/http_status_codes.dart';
import '../utils/session_expired.dart';

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
    const CallLog(),
    const PremiumPlan(),
    const Setting(),
  ];
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        drawer: Drawer(
          backgroundColor: AppColor.callColor,
          child: ListView(
            children: [
              DrawerHeader(child: Image.asset(IconConstants.icBroadlogo)),
              ListTile(
                onTap: () async {
                  // bool signOutSuccess = await signOutFromGoogle();
                  // if (signOutSuccess) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(
                  //         content:
                  //             Text('Successfully signed out from Google.')),
                  //   );
                  // Navigate to login or home screen after sign out
                  SharedPref.clearAll().then((isCleared) {
                    if (isCleared) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const ProtectionType(),
                        ),
                        (route) => false,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Failed to sign out. Please try again.')),
                      );
                    }
                  });

                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const Welcome()));
                  // } else {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(
                  //       content:
                  //           Text('Failed to sign out. Please try again.')),
                  // );
                  // }
                },
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
            leading: InkWell(
              onTap: () {
                _key.currentState!.openDrawer();
              },
              child: Image.asset(
                IconConstants.icdrawer,
                height: MediaQuery.of(context).size.height * 4 / 100,
              ),
            ),
            title:
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Profile()));
              },
              child: Image.asset(ImageConstants.imageProfile,height:MediaQuery.of(context).size.height*8/100,width:MediaQuery.of(context).size.width*8/100 )
              ),

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
}
