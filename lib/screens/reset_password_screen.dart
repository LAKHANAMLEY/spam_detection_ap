import 'package:flutter/material.dart';
import 'package:spam_delection_app/globals/appbutton.dart';

import '../constants/icons_constants.dart';
import '../constants/string_constants.dart';
import '../globals/app_fonts.dart';
import '../globals/colors.dart';


class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});
  static String routeName = './ResetPassword';

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      appBar: AppBar(
        backgroundColor: AppColor.secondryColor,
        leading:GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(IconConstants.backIcon,
              ),

            ),
          ),
        ),
        title: Image.asset(IconConstants.icBroadlogo,height:MediaQuery.of(context).size.height * 5/ 100, ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
          
          SizedBox(
            height: MediaQuery.of(context).size.height * 4/ 100,
          ),
              const Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 60,right: 50),
                    child: Text(
                      StringConstants.resetpasstext,textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColor.bluelightColor,
                          fontSize: 35,
                          fontFamily: AppFont.fontFamily,
                          fontWeight: FontWeight.w600),
                    ),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
            const Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                StringConstants.resetMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColor.verifyColor,
                    fontFamily: AppFont.fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 4 / 100,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 90/ 100,
                child: TextFormField(
                  decoration: InputDecoration(
                    //labelText: StringConstants.phonetext,
                    //labelStyle: const TextStyle(
                       // color: AppColor.lightfillColor, fontWeight: FontWeight.w800),
                    hintText: StringConstants.passwordtext,
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: const BorderSide(
                          width: 0.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColor.fillColor, width: 1.0),
                      borderRadius:
                      BorderRadius.all(Radius.circular(2)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        IconConstants.icLockadd, // Adjust the path as necessary
                        width:MediaQuery.of(context).size.width*3/100,
                        height: MediaQuery.of(context).size.height*3/100,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 4 / 100,),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 90/ 100,
                child: TextFormField(
                  decoration: InputDecoration(
                  //  labelText: StringConstants.phonetext,
                   // labelStyle: const TextStyle(
                       // color: AppColor.lightfillColor, fontWeight: FontWeight.w800),
                    hintText: StringConstants.reentertext,
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: const BorderSide(
                          width: 0.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColor.fillColor, width: 1.0),
                      borderRadius:
                      BorderRadius.all(Radius.circular(2)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        IconConstants.icLockadd, // Adjust the path as necessary
                        width:MediaQuery.of(context).size.width*3/100,
                        height: MediaQuery.of(context).size.height*3/100,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*5/100,),
              AppButton(
                  text: StringConstants.resetpasstext , onPress: (){
          
              }),
              ]
          ),
        ),
      )
    );
  }
}
