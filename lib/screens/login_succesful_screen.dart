import 'package:flutter/material.dart';
import 'package:spam_delection_app/globals/appbutton.dart';
import 'package:spam_delection_app/screens/bottom_navigation.dart';

import '../constants/icons_constants.dart';
import '../constants/string_constants.dart';
import '../globals/app_fonts.dart';
import '../globals/colors.dart';

class LoginSuccessful extends StatefulWidget {
  const LoginSuccessful({super.key});
  static String routeName = './LoginSuccessful';

  @override
  State<LoginSuccessful> createState() => _LoginSuccessfulState();
}

class _LoginSuccessfulState extends State<LoginSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondryColor,
        appBar: AppBar(
          backgroundColor: AppColor.secondryColor,
          leading: GestureDetector(
            onTap: () {},
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.asset(
                  IconConstants.backIcon,
                ),
              ),
            ),
          ),
          title: Image.asset(
            IconConstants.icBroadlogo,
            height: MediaQuery.of(context).size.height * 5 / 100,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 10 / 100,
          ),
          const Center(
              child: Text(
            StringConstants.successfultext,
            style: TextStyle(
                color: AppColor.bluelightColor,
                fontSize: 35,
                fontFamily: AppFont.fontFamily,
                fontWeight: FontWeight.w600),
          )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 100,
          ),
          const Text(
            StringConstants.yeytext,
            style: TextStyle(
                color: AppColor.yellowlightColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 100,
          ),
          const Text(
            StringConstants.fromtext,
            style: TextStyle(color: AppColor.gracyColor),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 5 / 100,
          ),
          Image.asset(
            IconConstants.icsuccesfulLogo,
            height: MediaQuery.of(context).size.height * 20 / 100,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 5 / 100),
          AppButton(
              text: StringConstants.exploretext,
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNavigation()));
              })
        ]))));
  }
}
