import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spam_delection_app/lib.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailTextEditingController = TextEditingController();

  final _emailController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> ForgotPassword() async {
    final email = _emailController.text;

    String url = ApiUrlConstants.endPointForgotPassword;

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              data['message'] ?? 'Check your email for reset instructions.'),
        ));
      } else {
        final errorData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorData['error'] ?? 'Failed to send reset email.'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('An error occurred. Please try again.'),
      ));
    }

    setState(() {
      _isLoading = false;
    });
  }

  /*@override
  void initState() {
    super.initState();
  }

  Future<bool> forgotPasswordUserValidation(
      BuildContext context,
      String email,
      ) async {

    if (email.isEmpty) {
      SnackBarToastMessage.showSnackBar(
          context, StringConstants.emailMessage);
      return false;
    }


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

   */
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
            height: MediaQuery.of(context).size.height * 38 / 100,
            width: MediaQuery.of(context).size.width * 38 / 100,
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
                  child: Padding(
                padding: EdgeInsets.only(left: 50, right: 50),
                child: Text(
                  StringConstants.forgottext,
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
                  StringConstants.emailtext,
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
                  controller: _emailController,
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
                      borderRadius: BorderRadius.all(Radius.circular(2)),
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
                height: MediaQuery.of(context).size.height * 5 / 100,
              ),
              const Text(
                StringConstants.checkmailtext,
                style: TextStyle(
                    color: AppColor.remainColor,
                    fontFamily: AppFont.fontFamily,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 5 / 100,
              ),
              if (_errorMessage != null)
                Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : AppButton(
                      text: StringConstants.continutext,
                      onPress: () {
                        final email = _emailController.text;
                        if (email.isNotEmpty) {
                          setState(() {
                            _isLoading = true;
                          });
                          forgotPassword(
                            email: email,
                          ).then((response) {
                            setState(() {
                              _isLoading = false;
                            });
                            // class SignUpResponse
                            //var response
                            if (response.statusCode == 200) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ForgotOtpVerify(
                                  email: email,
                                ),
                              ));
                            } else {
                              setState(() {
                                _errorMessage = response.message.toString();
                              });
                            }
                          });
                        } else {
                          setState(() {
                            _errorMessage = 'Please enter email address';
                          });
                        }
                      },
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
