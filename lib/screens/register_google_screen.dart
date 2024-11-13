import 'package:flutter/material.dart';
import 'package:spam_delection_app/screens/login_google_screen.dart';
import 'package:spam_delection_app/screens/login_screen.dart';
import 'package:spam_delection_app/screens/register_screen.dart';

import '../constants/icons_constants.dart';
import '../constants/image_constants.dart';
import '../constants/string_constants.dart';
import '../globals/app_fonts.dart';
import '../globals/appbutton.dart';
import '../globals/colors.dart';



class RegisterGoogle extends StatefulWidget {
  const RegisterGoogle({super.key});
  static String routeName = './RegisterFirst';

  @override
  State<RegisterGoogle> createState() => _RegisterFirstState();
}

class _RegisterFirstState extends State<RegisterGoogle> {
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
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 6 / 100,
                  ),
                  Center(
                      child: Text(
                        StringConstants.registertext,
                        style: TextStyle(
                            color: AppColor.bluelightColor,
                            fontSize: 35,
                            fontFamily: AppFont.fontFamily,
                            fontWeight: FontWeight.w600),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 8 / 100,
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 90/ 100,
                      height:MediaQuery.sizeOf(context).height * 8/ 100,
                      decoration: BoxDecoration(
                        color: AppColor.fillColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color:AppColor.fillColor),

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 10/ 100,
                            height: MediaQuery.sizeOf(context).height * 6/ 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:AssetImage(IconConstants.icgoogleLogo),
                                  fit:BoxFit.cover),
                              shape:BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width*4/100,),
                          Text(StringConstants.loginGoogletext,style: TextStyle(color: AppColor.gracyColor,fontFamily: AppFont.fontFamily,fontSize: 18,fontWeight: FontWeight.w600),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 4/ 100,),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 90/ 100,
                      height:MediaQuery.sizeOf(context).height * 8/ 100,
                      decoration: BoxDecoration(
                        color: AppColor.fillColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color:AppColor.fillColor),

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 10/ 100,
                            height: MediaQuery.sizeOf(context).height * 6/ 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:AssetImage(IconConstants.icappleLogo),
                                  fit:BoxFit.cover),
                              shape:BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width*4/100,),
                          Text(StringConstants.loginAppletext,style: TextStyle(color: AppColor.gracyColor,fontFamily: AppFont.fontFamily,fontSize: 18,fontWeight: FontWeight.w600),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height:  MediaQuery.of(context).size.height*8/100,),
                  Row(children: <Widget>[
                    Expanded(
                      child: new Container(
                          width:  MediaQuery.sizeOf(context).width * 6/ 100,
                          margin: const EdgeInsets.only(left: 50.0, right: 10.0),
                          child: Divider(
                            color:AppColor.gracyColor,
                            height: MediaQuery.sizeOf(context).height * 6/ 100,
                          )),
                    ),
                    Text("or",style: TextStyle(color:AppColor.primaryColor,fontWeight: FontWeight.w600,fontSize: 18),),
                    Expanded(
                      child: new Container(
                          margin: const EdgeInsets.only(left: 10, right: 50),
                          child: Divider(
                            color: AppColor.gracyColor,
                            height: MediaQuery.sizeOf(context).height * 6/ 100,
                          )),
                    ),
                  ]),
                  SizedBox(height:  MediaQuery.of(context).size.height*8/100,),
                  AppButton(
                      text: StringConstants.registerwithEmail, onPress: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));

                  }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 10/ 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(StringConstants.alreadyHaveAnAccount,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFont.fontFamily,
                            color: AppColor.greylightColor,fontSize: 15),

                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 1 / 100),
                      InkWell(
                        onTap: () {
                           Navigator.push(
                              context,
                             MaterialPageRoute(
                                builder: (BuildContext context) => LoginGoogle()));
                        },
                        child: Text(StringConstants.logintext,
                            style: TextStyle(
                                color: AppColor.yellowlightColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 5 / 100),



                ])))
    );
  }
}
