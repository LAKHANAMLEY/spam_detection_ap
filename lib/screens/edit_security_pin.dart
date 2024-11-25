import 'package:flutter/material.dart';

import '../constants/icons_constants.dart';
import '../constants/string_constants.dart';
import '../globals/app_fonts.dart';
import '../globals/appbutton.dart';
import '../globals/colors.dart';



class EditSecurityPin extends StatefulWidget {
  const EditSecurityPin({super.key});

  @override
  State<EditSecurityPin> createState() => _EditSecurityPinState();
}

class _EditSecurityPinState extends State<EditSecurityPin> {
  final TextEditingController currentpinController = TextEditingController();
  final TextEditingController newpinController = TextEditingController();
  final TextEditingController confirmnewpinController = TextEditingController();
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
                    padding: EdgeInsets.only(left: 60, right: 50),
                    child: Text(
                      StringConstants.changeSecurity,
                      textAlign: TextAlign.center,
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
                  StringConstants.pinMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.verifyColor,
                      fontFamily: AppFont.fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 4 / 100,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 90 / 100,
                child: TextFormField(
                  controller: currentpinController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Current pin',
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide:
                      const BorderSide(width: 0.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.fillColor, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        IconConstants.icLockadd, // Adjust the path as necessary
                        width: MediaQuery.of(context).size.width * 3 / 100,
                        height: MediaQuery.of(context).size.height * 3 / 100,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 4 / 100,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 90 / 100,
                child: TextFormField(
                  controller: newpinController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'New security pin',
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide:
                      const BorderSide(width: 0.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.fillColor, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
          
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        IconConstants.icLockadd, // Adjust the path as necessary
                        width: MediaQuery.of(context).size.width * 3 / 100,
                        height: MediaQuery.of(context).size.height * 3 / 100,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 4 / 100,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 90 / 100,
                child: TextFormField(
                  controller: confirmnewpinController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Confirm security pin",
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide:
                      const BorderSide(width: 0.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.fillColor, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        IconConstants.icLockadd, // Adjust the path as necessary
                        width: MediaQuery.of(context).size.width * 3 / 100,
                        height: MediaQuery.of(context).size.height * 3 / 100,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 4 / 100,
              ),
              AppButton(text: "Change Security Pin", onPress: (){})
            ],
          ),
        ),
      ),
    );
  }
}
