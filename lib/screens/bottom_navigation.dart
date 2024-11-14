import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:spam_delection_app/constants/icons_constants.dart';
import 'package:spam_delection_app/globals/colors.dart';
import 'package:spam_delection_app/screens/call_log_screen.dart';
import 'package:spam_delection_app/screens/chat_screen.dart';
import 'package:spam_delection_app/screens/home_screen.dart';
import 'package:spam_delection_app/screens/premium_plan.dart';
import 'package:spam_delection_app/screens/setting_screen.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_page],
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _page,
          height: 75,
          items: <Widget>[
            Image.asset(
              IconConstants.icHome,
              height: MediaQuery.of(context).size.height * 6 / 100,
              width: MediaQuery.of(context).size.width * 6 / 100,
            ),
            Image.asset(
              IconConstants.icChat,
              height: MediaQuery.of(context).size.height * 6 / 100,
              width: MediaQuery.of(context).size.width * 6 / 100,
            ),
            Image.asset(
              IconConstants.icPhone,
              height: MediaQuery.of(context).size.height * 6 / 100,
              width: MediaQuery.of(context).size.width * 6 / 100,
            ),
            Image.asset(
              IconConstants.icPremium,
              height: MediaQuery.of(context).size.height * 6 / 100,
              width: MediaQuery.of(context).size.width * 6 / 100,
            ),
            Image.asset(
              IconConstants.icSetting,
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
}
