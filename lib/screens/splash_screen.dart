import 'package:flutter/material.dart';
import 'package:spam_delection_app/constants/icons_constants.dart';
import 'package:spam_delection_app/constants/string_constants.dart';
import 'package:spam_delection_app/data/shared_pref/shared_pref.dart';
import 'package:spam_delection_app/globals/colors.dart';
import 'package:spam_delection_app/screens/bottom_navigation.dart';

import 'welcome_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    SharedPref.getIsLogin().then((isLogin) {
      Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  isLogin ? const BottomNavigation() : const Welcome()),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 40 / 100,
            ),
            Center(
              child: Image.asset(
                IconConstants.icBroadlogo,
                height: MediaQuery.of(context).size.height * 20 / 100,
                width: MediaQuery.of(context).size.width * 50 / 100,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 30 / 100,
            ),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(IconConstants.iccopyRight,
                      height: MediaQuery.of(context).size.height * 4 / 100,
                      width: MediaQuery.of(context).size.width * 4 / 100),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1 / 100,
                  ),
                  const Text(
                    StringConstants.copyrighttext,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.spelledColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
