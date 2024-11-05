/*import 'package:flutter/material.dart';

import '../constants/icons_constants.dart';
import '../constants/string_constants.dart';
import '../globals/app_fonts.dart';
import '../globals/colors.dart';


class ProtectionType extends StatefulWidget {
  const ProtectionType({super.key});
  static String routeName = './ProtectionType';

  @override
  State<ProtectionType> createState() => _ProtectionTypeState();
}

class _ProtectionTypeState extends State<ProtectionType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      appBar: AppBar(
        backgroundColor: AppColor.secondryColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(IconConstants.backIcon,
              ),
            ),
            height: MediaQuery
                .of(context)
                .size
                .height * 2 / 100,
          ),
        ),
        title: Image.asset(IconConstants.icBroadlogo, height: MediaQuery
            .of(context)
            .size
            .height * 5 / 100,),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 100,
          ),
          const Center(
              child: Text(
                StringConstants.protectiontext,
                style: TextStyle(
                    color: AppColor.bluelightColor,
                    fontSize: 35,
                    fontFamily: AppFont.fontFamily,
                    fontWeight: FontWeight.w600),
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 100,
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Center(
                child: Text(
                  StringConstants.selectaccountext,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.verifyColor,
                      fontFamily: AppFont.fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
*/