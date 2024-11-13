import 'package:flutter/material.dart';
import 'package:spam_delection_app/globals/appbutton.dart';
import 'package:http/http.dart' as http;
import 'package:spam_delection_app/screens/register_screen.dart';
import 'package:spam_delection_app/utils/api_constants/api_uri_constants.dart';

import '../constants/icons_constants.dart';
import '../constants/image_constants.dart';
import '../constants/string_constants.dart';
import '../data/repository/auth_repo/reset_password_api.dart';
import '../globals/app_fonts.dart';
import '../globals/colors.dart';
import 'login_succesful_screen.dart';


class ResetPassword extends StatefulWidget {
  final String? email;
  final String? code;
  const ResetPassword({super.key,  this.email,  this.code});// ye h constructor ok jinko required kr dia h // itna clear??
  static String routeName = './ResetPassword';
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late String password;
  late String confirmPassword;
  bool _isLoading = false;
  String? _errorMessage;



  // final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Minimum 8 characters are required';
    } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
      return 'Must include an uppercase letter';
    } else if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
      return 'Must include a lowercase letter';
    } else if (!RegExp(r'(?=.*\W)').hasMatch(value)) {
      return 'Must include a special character';
    }
    return null;
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
            height: MediaQuery.of(context).size.height * 4/ 100,
          ),
              Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 60,right: 50),
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
            Padding(
              padding: const EdgeInsets.all(18),
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
              Container(
                width: MediaQuery.sizeOf(context).width * 90/ 100,
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
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
                      const BorderRadius.all(Radius.circular(2)),
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
                  validator: _validatePassword,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 4 / 100,),
              Container(
                width: MediaQuery.sizeOf(context).width * 90/ 100,
                child: TextFormField(
                  controller: confirmpasswordController,
                  obscureText: true,
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
                      const BorderRadius.all(Radius.circular(2)),
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
              if (_errorMessage != null)
                Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : AppButton(
                text: StringConstants.resetpasstext,
                onPress: () {
                  final password = passwordController.text;
                  final confirmPassword =confirmpasswordController.text;

                  if (password.isNotEmpty && confirmPassword.isNotEmpty) {
                    setState(() {
                      _isLoading = true;
                    });

                    resetPassword(
                      email: widget.email??"",
                      password: password,
                      code:widget.code??"",
                      confirmpassword: confirmPassword,
                    ).then((response) {
                      setState(() {
                        _isLoading = false;
                      });

                      if (response.statusCode == 200) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Register(),
                        ));
                      } else {
                        setState(() {
                          _errorMessage = '${response.message.toString()}';
                        });
                      }
                    });
                  } else {
                    setState(() {
                      _errorMessage = 'Please enter the all fields.';
                    });
                  }
                },
              ),
              ]
          ),
        ),
      )
    );
  }
}
