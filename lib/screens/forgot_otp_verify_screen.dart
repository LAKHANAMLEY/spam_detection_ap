import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spam_delection_app/screens/reset_password_screen.dart';

import '../constants/icons_constants.dart';
import '../constants/image_constants.dart';
import '../constants/string_constants.dart';
import '../globals/app_fonts.dart';
import '../globals/appbutton.dart';
import '../globals/colors.dart';
import 'forgot_password_screen.dart';



class ForgotOtpVerify extends StatefulWidget {
  const ForgotOtpVerify({super.key});
  static String routeName = './ForgotOtpVerify';

  @override
  State<ForgotOtpVerify> createState() => _ForgotOtpVerifyState();
}

class _ForgotOtpVerifyState extends State<ForgotOtpVerify> {
  GlobalKey<FormState> _forgotOtpFormKey = new GlobalKey<FormState>();

  FocusNode? pin1FocusNode;
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  TextEditingController firstInputController = TextEditingController();
  TextEditingController secondInputController = TextEditingController();
  TextEditingController thirdInputController = TextEditingController();
  TextEditingController forthInputController = TextEditingController();

  String firstInput = '';
  String secondInput = '';
  String thirdInput = '';
  String forthInput = '';

  @override
  void initState() {
    super.initState();
    pin1FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  forgotOtpUserValidation(String firstInput, String secondInput,
      String thirdInput, String fourthInput) async {
    var otpInput = (firstInput + secondInput + thirdInput + fourthInput);
    if (otpInput.isEmpty) {
      SnackBarToastMessage.showSnackBar(
          context, StringConstants.otpMessage);
      return false;
    } else if (otpInput.length < 4) {
      SnackBarToastMessage.showSnackBar(
          context, StringConstants.otpMinLenthMessage);
      return false;
    } else {
      forgotOtpUserApiCall(firstInput, secondInput, thirdInput, fourthInput);
    }
  }

  forgotOtpUserApiCall(String firstInput, String secondInput, String thirdInput,
      String fourthInput) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword()),
    );
    print("Call Update Api");
  }

  @override
  void dispose() {
    super.dispose();
    pin1FocusNode!.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  void previousField(String value, FocusNode focusNode) {
    focusNode.requestFocus();
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
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(IconConstants.backIcon,
              ),

            ),
            height: MediaQuery.of(context).size.height * 2 / 100,
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
              Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50,right: 50),
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
              Padding(
                padding: const EdgeInsets.all(18),
                child: Center(
                  child: Text(
                    StringConstants.otpverifytext,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.verifyColor,
                        fontFamily: AppFont.fontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _forgotOtpFormKey,
                  child: Column(
                    //  crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 5 / 100,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 80 / 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              child: Center(
                                child: TextFormField(
                                  cursorColor: AppColor.yellowlightColor,
                                  autofocus: true,
                                  readOnly: false,
                                  focusNode: pin1FocusNode,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.fillColor, width: 1.5),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(2)),
                                    ),
                                    enabledBorder:  OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:  firstInputController.text.isNotEmpty
                                              ? AppColor.deepyelloeColor
                                              : AppColor.fillColor.withOpacity(0.2),
                                      width: 1.5),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(2)),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.fillColor, width: 1.5),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(2)),
                                    ),
                                    contentPadding: EdgeInsets.all((12)),
                                    fillColor: AppColor.fillColor.withOpacity(0.2),
                                    filled: true,
                                  ),
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500,
                                      color:
                                           AppColor.deepyelloeColor),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  onTap: () {
                                    pin1FocusNode!.requestFocus();
                                  },
                                  onChanged: (value) {
                                    print(firstInputController.text.length);
                                    print(firstInputController.text);
                                    firstInputController.text = value;
                                    nextField(value, pin2FocusNode!);
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: 60,
                              height: 60,
                              child: TextFormField(
                                cursorColor: AppColor.primaryColor,
                                maxLength: 1,
                                autofocus: true,
                                readOnly: false,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                textAlign: TextAlign.center,
                                focusNode: pin2FocusNode,
                                onTap: () {
                                  pin2FocusNode!.requestFocus();
                                },
                                onChanged: (value) {
                                  if (value.length == 0) {
                                    secondInputController.text = '';
                                    previousField(value, pin1FocusNode!);
                                  } else {
                                    secondInputController.text = value;
                                    nextField(value, pin3FocusNode!);
                                  }
                                },
                                decoration: InputDecoration(
                                  counterText: '',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.fillColor, width: 1.5),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(2.0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: secondInputController.text.isNotEmpty
                                            ? AppColor.deepyelloeColor
                                            : AppColor.fillColor.withOpacity(0.2),
                                        width: 1.5),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(2.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.fillColor, width: 1.5),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(2.0)),
                                  ),
                                  contentPadding: EdgeInsets.all((12)),
                                  fillColor: AppColor.fillColor.withOpacity(0.2),
                                  filled: true,
                                ),
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w500,
                                    color: (secondInputController.text.length > 0)
                                        ? AppColor.deepyelloeColor
                                        : AppColor.deepyelloeColor),
                              ),
                            ),
                            Container(
                              width: 60,
                              height: 60,
                              child: TextFormField(
                                cursorColor: AppColor.primaryColor,
                                maxLength: 1,
                                autofocus: true,
                                // readOnly: true,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  counterText: '',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.fillColor, width: 1.5),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(2.0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: (thirdInputController.text.isNotEmpty)
                                            ? AppColor.deepyelloeColor
                                            : AppColor.fillColor.withOpacity(0.2), width: 1.5),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(2.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.fillColor, width: 1.5),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(2.0)),
                                  ),
                                  contentPadding: EdgeInsets.all((12)),
                                  fillColor:
                                       AppColor.fillColor.withOpacity(0.2),
                                  filled: true,
                                ),
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    color: (thirdInputController.text.length > 0)
                                        ? AppColor.deepyelloeColor
                                        : AppColor.deepyelloeColor),
                                focusNode: pin3FocusNode,
                                onTap: () {
                                  pin3FocusNode!.requestFocus();
                                },
                                onChanged: (value) {
                                  print('hello');
                                  if (value.length == 0) {
                                    thirdInputController.text = '';
                                    previousField(value, pin2FocusNode!);
                                  } else {
                                    nextField(value, pin4FocusNode!);
                                    thirdInputController.text = value;
                                  }
                                },
                              ),
                            ),
                            Container(
                              width: 60,
                              height: 60,
                              child: TextFormField(
                                cursorColor: AppColor.yellowlightColor,
                                focusNode: pin4FocusNode,
                                autofocus: true,
                                readOnly: false,
                                maxLength: 1,
                                // obscureText: true,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  counterText: '',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.fillColor, width: 1.5),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(2.0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: (forthInputController.text.isNotEmpty)
                                            ? AppColor.deepyelloeColor
                                            : AppColor.fillColor.withOpacity(0.2),
                                         width: 1.5),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(2.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.fillColor, width: 1.5),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(2.0)),
                                  ),
                                  contentPadding: EdgeInsets.all((12)),
                                  fillColor:
                                       AppColor.fillColor.withOpacity(0.2),
                                  filled: true,
                                ),
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w500,
                                    color: (forthInputController.text.isNotEmpty)
                                        ? AppColor.deepyelloeColor
                                        : AppColor.deepyelloeColor),
                                onTap: () {
                                  pin4FocusNode?.requestFocus();
                                },
                                onChanged: (value) {
                                  if (value.length == 0) {
                                    forthInputController.text = '';
                                    previousField(value, pin3FocusNode!);
                                  } else {
                                    forthInputController.text = value;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 4 / 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(StringConstants.didtext,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: AppFont.fontFamily,
                                color: AppColor.greylightColor,fontSize: 15),

                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 2 / 100),
                          InkWell(
                            onTap: () {
                              // Navigator.push(
                              //    context,
                              //    MaterialPageRoute(
                              //       builder: (BuildContext context) => RegisterScreen()));
                            },
                            child: Text(StringConstants.resendtext,
                                style: TextStyle(
                                    color: AppColor.yellowlightColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 5 / 100),
                      AppButton(
                          text: StringConstants.continutext,
                          onPress: () {
                           /* forgotOtpUserValidation(
                                firstInputController.text,
                                secondInputController.text,
                                thirdInputController.text,
                                forthInputController.text);

                            */
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword()));
                          }),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 4 / 100,
                      ),
                    ],
                  ),
                ),
              ),
          
            ],
          ),
        ),
      ),


    );
  }
}
