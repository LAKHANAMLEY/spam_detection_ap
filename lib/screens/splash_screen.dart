import 'package:flutter/material.dart';
import 'package:spam_delection_app/constants/icons_constants.dart';
import 'package:spam_delection_app/constants/image_constants.dart';
import 'package:spam_delection_app/globals/colors.dart';
import 'welcome_screen.dart';

class Splash extends StatefulWidget {
  Splash({super.key});
  static String routeName = './Splash';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
          () =>
       Navigator.push(
       context,
        MaterialPageRoute(builder: (context) => Welcome()),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      body: SafeArea(

        child: Center(
            child: Image.asset(
              IconConstants.icBroadlogo,
              height: MediaQuery.of(context).size.height * 20 / 100,
              width: MediaQuery.of(context).size.width * 50/ 100,

            ),

        ),
      ),
    );
  }
}
