import 'package:flutter/material.dart';
import 'package:spam_delection_app/constants/icons_constants.dart';
import 'package:spam_delection_app/constants/string_constants.dart';
import 'package:spam_delection_app/screens/edit_profile_screen.dart';

import '../globals/app_fonts.dart';
import '../globals/appbutton.dart';
import '../globals/colors.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});
  static String routeName = './Welcome';

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  String? _selectedItem;
  final List<String> _items = ['English', 'Spanish', 'French'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 5 / 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 25 / 100,
                      height: MediaQuery.of(context).size.height * 4 / 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColor.yellowlightColor, width: 1.5),
                        borderRadius: BorderRadius.circular(3),
                        color: AppColor.secondryColor.withOpacity(0.2),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: DropdownButton<String>(
                          value: _selectedItem,
                          icon: Image.asset(
                            IconConstants.icdrowback,
                            width: MediaQuery.of(context).size.width * 2 / 100,
                            height:
                                MediaQuery.of(context).size.height * 2 / 100,
                          ),
                          hint: const Center(
                            child: Text(
                              StringConstants.englishtext,
                              style: TextStyle(
                                  color: AppColor.fillColor,
                                  fontSize: 14,
                                  fontFamily: AppFont.fontFamily,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          items: _items.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedItem = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 5 / 100,
                ),
                Image.asset(IconConstants.icBroadlogo,
                    height: MediaQuery.of(context).size.height * 8 / 100,
                    width: MediaQuery.of(context).size.width * 50 / 100),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 5 / 100,
                ),
                const Text(
                  StringConstants.weltext,
                  style: TextStyle(
                      color: AppColor.bluelightColor,
                      fontSize: 35,
                      fontFamily: AppFont.fontFamily,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 5 / 100),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Center(
                    child: Text(
                      StringConstants.welcometext,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColor.lightblurColor,
                          fontSize: 15,
                          fontFamily: AppFont.fontFamily),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 8 / 100,
                ),
                AppButton(
                    text: StringConstants.getstarted,
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfile()));

                      // forgotPasswordUserValidation(
                      //    emailTextEditingController.text);
                    }),
                /*Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(IconConstants.icGoogle,height:MediaQuery.of(context).size.height*10/100 ),
                  SizedBox(width: MediaQuery.of(context).size.width*2/100 ),
                  Image.asset(IconConstants.icMac,height:MediaQuery.of(context).size.height*10/100 ,),
          
                ],
              ),
          
               */
              ],
            ),
          ),
        ));
  }
}
