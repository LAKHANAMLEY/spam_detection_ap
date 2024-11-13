import 'package:flutter/material.dart';
import 'package:spam_delection_app/globals/appbutton.dart';
import 'package:spam_delection_app/screens/forgot_otp_verify_screen.dart';

import '../constants/icons_constants.dart';
import '../constants/string_constants.dart';
import '../globals/app_fonts.dart';
import '../globals/colors.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});
  static String routeName = './ForgotPassword';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> forgotPasswordUserValidation(
      BuildContext context,
      String email,
      ) async {
    // Check if the email is empty
    if (email.isEmpty) {
      SnackBarToastMessage.showSnackBar(
          context, StringConstants.emailMessage);
      return false;
    }

    // Check if the email format is valid
    var emailValidatorRegExp;
    if (!Constants.emailValidatorRegExp.hasMatch(email)) {
      SnackBarToastMessage.showSnackBar(
          context, StringConstants.emailvalidMessage);
      return false;
    }

    // If all validations pass, call the API
    await forgotPasswordUserApiCall(email);

    return true; // Return true if everything is successful
  }


  forgotPasswordUserApiCall(
      String email,
      ) async {
   // Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotOtpVerify()),
   // );
    //print("Call Update Api");
  }

  @override
  // Widget build(BuildContext context) {
  //   return ProgressHUD(
  //       inAsyncCall: isApiCalling,
  //       opacity: 0.5,
  //       child: _buildUIScreen(context));
  // }

  @override
  void dispose() {
    super.dispose();
  }
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
          height: MediaQuery.of(context).size.height * 8 / 100,
              ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 50,right: 50),
                    child: Text(
                                StringConstants.forgottext,textAlign: TextAlign.center,
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
                    StringConstants.emailtext,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.verifyColor,
                        fontFamily: AppFont.fontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*4/100,),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 90/ 100,
                  child: TextFormField(
                    decoration: InputDecoration(
          
                      hintText: StringConstants.emailadresstext,
                      hintStyle: const TextStyle(color: AppColor.lightfillColor,fontFamily: AppFont.fontFamily,fontWeight: FontWeight.w600),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: const BorderSide(
                            width: 1.5, color: AppColor.fillColor),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor.fillColor, width: 1.5),
                        borderRadius:
                        BorderRadius.all(Radius.circular(2)),
                      ),
                      filled: true,
                      fillColor: AppColor.fillColor.withOpacity(0.2),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          IconConstants.icEmailadd, // Adjust the path as necessary
                          width:MediaQuery.of(context).size.width*3/100,
                          height: MediaQuery.of(context).size.height*3/100,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 5 / 100,),
                const Text(StringConstants.checkmailtext,style: TextStyle(color: AppColor.remainColor,fontFamily: AppFont.fontFamily,fontWeight: FontWeight.w600),),
                SizedBox(height: MediaQuery.of(context).size.height * 5 / 100,),
                AppButton(
                    text: StringConstants.continutext,
                    onPress: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>const ForgotOtpVerify()) );
          
                    }
                ),
            ]),
        ),
      ));
  }
}

class Constants {
  static var emailValidatorRegExp;
}

class SnackBarToastMessage {
  static void showSnackBar(BuildContext context, emailMessage) {}
}
