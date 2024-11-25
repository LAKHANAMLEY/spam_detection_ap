import 'package:flutter/material.dart';
import 'package:spam_delection_app/constants/string_constants.dart';
import 'package:spam_delection_app/globals/app_fonts.dart';
import 'package:spam_delection_app/screens/plan_details_screen.dart';

import '../constants/icons_constants.dart';
import '../globals/colors.dart';



class PlanType extends StatefulWidget {
  const PlanType({super.key});

  @override
  State<PlanType> createState() => _PlanTypeState();
}

class _PlanTypeState extends State<PlanType> {
  int Selectedtab = 0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
        title: Image.asset(IconConstants.icBroadlogo, height: MediaQuery.of(context).size.height * 35 / 100,
          width: MediaQuery.of(context).size.width * 35 / 100, ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 3 / 100),
              Image.asset(
                IconConstants.icsubsription,
                height: MediaQuery.of(context).size.height * 18 / 100,
              ),
              const Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 50,right: 50),
                    child: Text(
                      StringConstants.selectionplantext,textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColor.bluelightColor,
                          fontSize: 35,
                          fontFamily: AppFont.fontFamily,
                          fontWeight: FontWeight.w600),
                    ),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),
              const Text(
                StringConstants.blockspamtext,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColor.verifyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFont.fontFamily),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    Selectedtab = 0;
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PlanDetail()));
                  });

                },
                child: Container(
                  height: MediaQuery.of(context).size.height*18/100,
                  width: MediaQuery.of(context).size.width*90/100,
                 decoration: BoxDecoration(
                     color: Selectedtab == 0
                         ? AppColor.yellowdecentColor
                         : AppColor.secondryColor,
                       border: Border.all(color: Selectedtab == 0
                           ? AppColor.yellowColor
                           : AppColor.thumbColor,),
                   borderRadius: BorderRadius.circular(6)
                 ),
                  child:Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StringConstants.personalProtectiontext,
                          style: TextStyle(
                              color: AppColor.callColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFont.fontFamily),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5 / 100,
                        ),
                    Text(
                      StringConstants.callblockingtext,
                      style: TextStyle(
                          color: AppColor.borderstekColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFont.fontFamily),
                    ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5 / 100,
                        ),
                        Text(
                          StringConstants.dollartext,
                          style: TextStyle(
                              color: AppColor.callColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFont.fontFamily),
                        ),
                      ],
                    ),
                  ) ,
                  ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    Selectedtab = 1;
                  });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height*18/100,
                  width: MediaQuery.of(context).size.width*90/100,
                  decoration: BoxDecoration(
                      color: Selectedtab == 1
                          ? AppColor.yellowdecentColor
                          : AppColor.secondryColor,
                      border: Border.all(color: Selectedtab == 1
                          ? AppColor.yellowColor
                          : AppColor.thumbColor),
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child:Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StringConstants.callbunbletext,
                          style: TextStyle(
                              color: AppColor.callColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFont.fontFamily),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5 / 100,
                        ),
                        Text(
                          StringConstants.smsblockingtext,
                          style: TextStyle(
                              color: AppColor.borderstekColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFont.fontFamily),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5 / 100,
                        ),
                        Text(
                          StringConstants.dollarpointtext,
                          style: TextStyle(
                              color: AppColor.callColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFont.fontFamily),
                        ),
                      ],
                    ),
                  ) ,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2/ 100,
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    Selectedtab = 2;
                  });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height*18/100,
                  width: MediaQuery.of(context).size.width*90/100,
                  decoration: BoxDecoration(
                      color: Selectedtab == 2
                          ? AppColor.yellowdecentColor
                          : AppColor.secondryColor,
                      border: Border.all(color: Selectedtab == 2
                          ? AppColor.yellowColor
                          : AppColor.thumbColor),
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child:Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StringConstants.completebunbletext,
                          style: TextStyle(
                              color: AppColor.callColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFont.fontFamily),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5 / 100,
                        ),
                        Text(
                          StringConstants.emailblockingtext,
                          style: TextStyle(
                              color: AppColor.borderstekColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFont.fontFamily),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5 / 100,
                        ),
                        Text(
                          StringConstants.dollarhightext,
                          style: TextStyle(
                              color: AppColor.callColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFont.fontFamily),
                        ),
                      ],
                    ),
                  ) ,
                ),
              ),
          
            ],
          ),
        ),
      ),

    );
  }
}
