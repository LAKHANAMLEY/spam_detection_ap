import 'package:flutter/material.dart';
import 'package:spam_delection_app/constants/string_constants.dart';
import 'package:spam_delection_app/globals/app_fonts.dart';
import 'package:spam_delection_app/screens/change_password_screen.dart';
import 'package:spam_delection_app/screens/edit_profile_screen.dart';

import '../constants/icons_constants.dart';
import '../globals/colors.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<String> imageUrl=[
IconConstants.icspamCheck,
    IconConstants.icClock,
    IconConstants.icsearchCheck,
    IconConstants.icmessageCheck
  ];
  final List<String> cardTexts=[
    '3',
    '68s',
    '25',
    '38'

  ];
  final List<String> SpamTexts=[
    StringConstants.spamcallstext,
  StringConstants.timesavestext,
  StringConstants.unknowntext,
  StringConstants.messagestext,

  ];
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Image.asset(
              IconConstants.backIcon,
            ),
          ),
        ),
       actions: [
         Padding(
           padding: const EdgeInsets.only(right: 20),
           child: Image.asset(IconConstants.icsettingPro,height: MediaQuery.of(context).size.height*3/100,),
         )
       ],
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColor.secondryColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: CircleAvatar(
                    backgroundColor: AppColor.greylightColor,
                    radius: 45.0,
                    child: CircleAvatar(
                      radius: 48.0,
                      backgroundImage: const AssetImage(
                          IconConstants.icAvater),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          backgroundColor: AppColor.callColor,
                          radius: 12.0,
                          child: Image.asset(IconConstants.icCamera,height: MediaQuery.of(context).size.height*2/100,)
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: const Text(
                      'Micheal Smith',
                      style: TextStyle(
                        fontFamily: AppFont.fontFamily,
                        fontWeight: FontWeight.w700,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: const Text(
                      'Pin- *****47589',
                      style: TextStyle(
                        fontFamily: AppFont.fontFamily,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*2/100,),
                Container(
                  margin: const EdgeInsets.only(left: 20,right: 20),
                  height: MediaQuery.of(context).size.height*10/100,
                   width: MediaQuery.of(context).size.height*80/100,
                decoration: const BoxDecoration(
                  color: AppColor.callColor,
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(IconConstants.icpremiumStar,height: MediaQuery.of(context).size.height*5/100,width:MediaQuery.of(context).size.width*5/100 ,),
                    SizedBox(width: MediaQuery.of(context).size.width*4/100,),
                    const Text(StringConstants.upgradetext,style: TextStyle(color: AppColor.secondryColor,fontSize:20,fontFamily: AppFont.fontFamily,fontWeight: FontWeight.w700 ),)
                  ],
                ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*5/100,),
                Container(
                  height: MediaQuery.of(context).size.height*55/100,
                  width: MediaQuery.of(context).size.width*90/100,
                  decoration: BoxDecoration(
                    color: AppColor.whitedeep,
                    borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                    border: Border.all(color: AppColor.vanishColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(height:MediaQuery.of(context).size.height*2/100,),
                         const Align(
                           alignment: Alignment.centerLeft,
                             child: Text("Last 30 days",style: TextStyle(color: AppColor.lastColor,fontSize: 18,fontFamily: AppFont.fontFamily,fontWeight: FontWeight.w600),textAlign: TextAlign.start,)),
                        SizedBox(height: MediaQuery.of(context).size.height*2/100,),
                        GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio:1.2/1.2),
                          itemCount: 4,
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                  color: AppColor.secondryColor
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                          children: [
                                            Image.asset(imageUrl[index],height: MediaQuery.of(context).size.height*5/100,width: MediaQuery.of(context).size.width*5/100,),
                                            SizedBox(width: MediaQuery.of(context).size.height*2/100,),
                                            Text(cardTexts[index],style: const TextStyle(color: AppColor.borderstekColor,fontSize: 20,fontFamily: AppFont.fontFamily),)
                                          ]
                                      ),
                                      Text(SpamTexts[index],style: const TextStyle(color: AppColor.spelledColor,fontFamily: AppFont.fontFamily,fontSize: 16)),
                                    ],
                                  ),
                                ),


                              ),
                            );

                          },
                                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*4/100,),
                Container(
                  height: MediaQuery.of(context).size.height*7/100,
                  width: MediaQuery.of(context).size.height*90/100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(2.0)
                    ),
                    border: Border.all(color: AppColor.greyarrowColor,width: 1
                    ),
                    color: AppColor.secondryColor
            
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          IconConstants.icEdit,
                          height: MediaQuery.of(context).size.height * 5 / 100,
                          width: MediaQuery.of(context).size.width * 5 / 100,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 2 / 100,
                        ),
                        const Text(
                          'Edit Profile',
                          style: TextStyle(
                              color: AppColor.ThumbColor, fontSize: 18),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 46 / 100,
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()));
                          },
                          child: Image.asset(
                            IconConstants.icviewArrow,
                            height: MediaQuery.of(context).size.height * 6 / 100,
                            width: MediaQuery.of(context).size.width * 6 / 100,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*2/100,),
                Container(
                  height: MediaQuery.of(context).size.height*7/100,
                  width: MediaQuery.of(context).size.height*90/100,
                  decoration: BoxDecoration(
            
                      borderRadius: const BorderRadius.all(Radius.circular(2.0)
                      ),
                      border: Border.all(color: AppColor.greyarrowColor,width: 1
                      ),
                      color: AppColor.secondryColor
            
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(IconConstants.icEditSecurity,height: MediaQuery.of(context).size.height*5/100,width: MediaQuery.of(context).size.width*5/100,),
                        SizedBox(width: MediaQuery.of(context).size.width*2/100,),
                        const Text('Edit Security Pin',style: TextStyle(color: AppColor.ThumbColor,fontSize: 18),),
                        SizedBox(width: MediaQuery.of(context).size.width*34/100,),
                        Image.asset(IconConstants.icviewArrow,height: MediaQuery.of(context).size.height*6/100,width: MediaQuery.of(context).size.width*6/100,)
            
            
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*2/100,),
                Container(
                  height: MediaQuery.of(context).size.height*7/100,
                  width: MediaQuery.of(context).size.height*90/100,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(2.0)
                      ),
                      border: Border.all(color: AppColor.greyarrowColor,width: 1
                      ),
                      color: AppColor.secondryColor
            
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          IconConstants.icchangePass,
                          height: MediaQuery.of(context).size.height * 5 / 100,
                          width: MediaQuery.of(context).size.width * 5 / 100,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 2 / 100,
                        ),
                        const Text(
                          'Change Password',
                          style: TextStyle(
                              color: AppColor.ThumbColor, fontSize: 18),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 30 / 100,
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassword()));
                          },
                          child: Image.asset(
                            IconConstants.icviewArrow,
                            height: MediaQuery.of(context).size.height * 6 / 100,
                            width: MediaQuery.of(context).size.width * 6 / 100,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*2/100,),
                Container(
                  height: MediaQuery.of(context).size.height*7/100,
                  width: MediaQuery.of(context).size.height*90/100,
                  decoration: BoxDecoration(
            
                      borderRadius: const BorderRadius.all(Radius.circular(2.0)
                      ),
                      border: Border.all(color: AppColor.greyarrowColor,width: 1
                      ),
                      color: AppColor.secondryColor
            
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          IconConstants.icalternativeEmail,
                          height: MediaQuery.of(context).size.height*6/100,width: MediaQuery.of(context).size.width*6/100,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 2 / 100,
                        ),
                        const Text(
                          ' Add Alertantive Email',
                          style:
                              TextStyle(color: AppColor.ThumbColor, fontSize: 18),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 20 / 100,
                        ),
                        Image.asset(
                          IconConstants.icviewArrow,
                          height: MediaQuery.of(context).size.height * 6/ 100,width: MediaQuery.of(context).size.width*6/100,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*5/100,),
            
              ],
            ),
          ),
        ),

      ),
    );
  }
}
