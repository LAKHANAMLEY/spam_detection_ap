import 'package:flutter/material.dart';
import 'package:spam_delection_app/data/repository/auth_repo/corporate_login_api.dart';
import 'package:spam_delection_app/globals/appbutton.dart';
import 'package:spam_delection_app/screens/login_succesful_screen.dart';

import '../constants/icons_constants.dart';
import '../constants/string_constants.dart';
import '../globals/app_fonts.dart';
import '../globals/colors.dart';



class CorpoateLogin extends StatefulWidget {
  const CorpoateLogin({super.key});

  @override
  State<CorpoateLogin> createState() => _CorpoateLoginState();
}

class _CorpoateLoginState extends State<CorpoateLogin> {
  final TextEditingController corpoarteidController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
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
          title: Image.asset(
            IconConstants.icBroadlogo,
            height: MediaQuery.of(context).size.height * 5 / 100,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 8 / 100,
          ),
          const Center(
              child: Text(
            StringConstants.logintext,
            style: TextStyle(
                color: AppColor.bluelightColor,
                fontSize: 35,
                fontFamily: AppFont.fontFamily,
                fontWeight: FontWeight.w600),
          )),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                        child: Text(
                          StringConstants.corporateId,// this one
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColor.verifyColor,
                              fontFamily: AppFont.fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 5/ 100,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 90 / 100,
                    child: TextFormField(
                      controller: corpoarteidController,
                      decoration: InputDecoration(
                        hintText: StringConstants.corporateIdtext,
                        hintStyle: const TextStyle(
                            color: AppColor.lightfillColor,
                            fontFamily: AppFont.fontFamily,
                            fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: const BorderSide(
                              width: 1.5, color: AppColor.fillColor),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                          BorderSide(color: AppColor.fillColor, width: 1.5),
                          borderRadius:
                          BorderRadius.all(Radius.circular(2)),
                        ),
                        filled: true,
                        fillColor: AppColor.fillColor.withOpacity(0.2),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            IconConstants
                                .iccorporateSuff, // Adjust the path as necessary
                            width: MediaQuery.of(context).size.width * 3 / 100,
                            height: MediaQuery.of(context).size.height * 3 / 100,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 3 / 100,
                  ),

                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 90 / 100,
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: StringConstants.emailadresstext,
                        hintStyle: const TextStyle(
                            color: AppColor.lightfillColor,
                            fontFamily: AppFont.fontFamily,
                            fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: const BorderSide(
                              width: 1.5, color: AppColor.fillColor),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                          BorderSide(color: AppColor.fillColor, width: 1.5),
                          borderRadius:
                          BorderRadius.all(Radius.circular(2)),
                        ),
                        filled: true,
                        fillColor: AppColor.fillColor.withOpacity(0.2),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            IconConstants
                                .icEmailadd, // Adjust the path as necessary
                            width: MediaQuery.of(context).size.width * 3 / 100,
                            height: MediaQuery.of(context).size.height * 3 / 100,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 3 / 100,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 90 / 100,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                              color: AppColor.lightfillColor,
                              fontWeight: FontWeight.w800,
                              fontFamily: AppFont.fontFamily),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2),
                            borderSide: const BorderSide(
                                width: 1.5, color: AppColor.fillColor),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                            BorderSide(color: AppColor.fillColor, width: 1.5),
                            borderRadius:
                            BorderRadius.all(Radius.circular(2)),
                          ),
                          filled: true,
                          fillColor: AppColor.fillColor.withOpacity(0.2),
                          counterText: '',
                          suffixIcon: Image.asset(IconConstants.icLockadd)),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 5 / 100,
                  ),
                  if (_errorMessage != null)
                    Text(_errorMessage!,
                        style: const TextStyle(color: Colors.red)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : AppButton(
                    text: StringConstants.logintext,
                    onPress: () {
                      final corporateid=corpoarteidController.text;
                      final email = emailController.text;
                      final password = passwordController.text;
                      if (email.isNotEmpty && password.isNotEmpty) {
                        setState(() {
                          _isLoading = true;
                        });
                        corporatelogin(email: email, password: password,corporateid:corporateid)
                            .then((CorporateResponse) {
                          setState(() {
                            _isLoading = false;
                          });
                          if (CorporateResponse.statusCode == 200) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginSuccessful(),
                            ));
                          } else {
                            setState(() {
                              _errorMessage =
                              CorporateResponse.message.toString();
                            });
                          }
                        });
                      } else {
                        setState(() {
                          _errorMessage =
                          'Please enter all fields';
                        });
                      }
                    },
                  ),
                ]
                )
            )
        )
    );
  }
}
