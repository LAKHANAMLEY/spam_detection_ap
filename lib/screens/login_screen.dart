import 'package:firebase_auth/firebase_auth.dart';
import 'package:spam_delection_app/lib.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int tabIndex = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? countryCode;

  Future<void> _verifyPhoneNumber() async {
    if (_formKey.currentState?.validate() ?? false) {
      await _auth.verifyPhoneNumber(
        phoneNumber: (countryCode ?? "") + phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text('Phone number automatically verified and signed in!')),
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Phone verification failed: ${e.message}')),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            // _verificationId = verificationId;
          });
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OtpVerify(
              verificationId: verificationId,
              phoneNumber: phoneController.text,
              countryCode: countryCode ?? "",
            ),
          ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // _verificationId = verificationId;
        },
      );
    }
  }

  final TextEditingController phoneController = TextEditingController(); //#2
  final TextEditingController countryController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondryColor,
        appBar: const CustomAppBar(),
        body: SafeArea(
          child: BlocConsumer(
              bloc: authBloc,
              listener: (context, state) {
                if (state is LoginWithEmailAndPasswordState) {
                  if (state.value.statusCode == 200) {
                    SharedPref.saveUserData(state.value.data);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            LoginSuccessful(user: state.value.data)));
                    // showCustomDialog(context,
                    //     dialogType: DialogType.success,
                    //     subTitle: state.value.message, onOkPressed: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) =>
                    //           LoginSuccessful(user: state.value.data)));
                    // });
                  } else if (state.value.statusCode ==
                      HTTPStatusCodes.sessionExpired) {
                    sessionExpired(context, state.value.message);
                  } else {
                    showCustomDialog(context,
                        dialogType: DialogType.failed,
                        subTitle: state.value.message);
                  }
                }
              },
              builder: (context, state) {
                return ModalProgressHUD(
                  progressIndicator: const Loader(),
                  inAsyncCall: state is ApiLoadingState,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        Center(
                            child: Text(
                          appLocalization(context).login,
                          style: const TextStyle(
                              color: AppColor.bluelightColor,
                              fontSize: 35,
                              fontFamily: AppFont.fontFamily,
                              fontWeight: FontWeight.w600),
                        )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Center(
                              child: Text(
                            appLocalization(context).pleaseVerify,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: AppColor.verifyColor,
                                fontFamily: AppFont.fontFamily,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                tabIndex = 0;
                              });
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        12 /
                                        100,
                                    width: MediaQuery.of(context).size.width *
                                        18 /
                                        100,
                                    child: Center(
                                      child: tabIndex == 1
                                          ? Image.asset(IconConstants
                                              .icphoneunSelect) // Show secondary image
                                          : Image.asset(IconConstants
                                              .icphoneSelect), // Show primary image
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        5 /
                                        100,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          tabIndex = 1;
                                        });
                                      },
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                12 /
                                                100,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                18 /
                                                100,
                                        child: Center(
                                          child: tabIndex == 1
                                              ? Image.asset(IconConstants
                                                  .icemailSelect) // Show secondary image
                                              : Image.asset(IconConstants
                                                  .icemailunSelect), // Show primary image
                                        ),
                                      )),
                                ])),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 5 / 100,
                        ),
                        if (tabIndex == 1) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: CustomTextField(
                              controller: emailController,
                              hintText: appLocalization(context).emailAddress,
                              suffix: Image.asset(
                                IconConstants.icEmailadd,
                                scale: 1.5,
                              ),
                              validator: (p0) {
                                if (p0?.isEmpty ?? false) {
                                  return "Please enter email address";
                                }
                                return null;
                              },

                              // decoration: InputDecoration(
                              //   hintText: appLocalization(context).emailAddress,
                              //   hintStyle: const TextStyle(
                              //       color: AppColor.lightfillColor,
                              //       fontFamily: AppFont.fontFamily,
                              //       fontWeight: FontWeight.w600),
                              //   enabledBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(2),
                              //     borderSide: const BorderSide(
                              //         width: 1.5, color: AppColor.fillColor),
                              //   ),
                              //   focusedBorder: const OutlineInputBorder(
                              //     borderSide:
                              //         BorderSide(color: AppColor.fillColor, width: 1.5),
                              //     borderRadius: BorderRadius.all(Radius.circular(2)),
                              //   ),
                              //   filled: true,
                              //   fillColor: AppColor.fillColor.withOpacity(0.2),
                              //   suffixIcon: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: Image.asset(
                              //       IconConstants
                              //           .icEmailadd, // Adjust the path as necessary
                              //       width: MediaQuery.of(context).size.width * 3 / 100,
                              //       height: MediaQuery.of(context).size.height * 3 / 100,
                              //     ),
                              //   ),
                              // ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 2 / 100,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: CustomTextField(
                              obscureText: true,
                              controller: passwordController,
                              hintText: appLocalization(context).password,
                              suffix: Image.asset(
                                IconConstants.icLockadd,
                                scale: 1.5,
                              ),
                              validator: (p0) {
                                if (p0?.isEmpty ?? false) {
                                  return "Please enter password address";
                                }
                                return null;
                              },
                              // decoration: InputDecoration(
                              //   hintText: appLocalization(context).password,
                              //   hintStyle: const TextStyle(
                              //       color: AppColor.lightfillColor,
                              //       fontWeight: FontWeight.w800,
                              //       fontFamily: AppFont.fontFamily),
                              //   enabledBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(2),
                              //     borderSide: const BorderSide(
                              //         width: 1.5, color: AppColor.fillColor),
                              //   ),
                              //   focusedBorder: const OutlineInputBorder(
                              //     borderSide:
                              //         BorderSide(color: AppColor.fillColor, width: 1.5),
                              //     borderRadius: BorderRadius.all(Radius.circular(2)),
                              //   ),
                              //   filled: true,
                              //   fillColor: AppColor.fillColor.withOpacity(0.2),
                              //   counterText: '',
                              //   suffixIcon: Image.asset(IconConstants.icLockadd),
                              // ),
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 2 / 100,
                          ),
                          // if (_errorMessage != null)
                          //   Text(_errorMessage!,
                          //       style: const TextStyle(color: Colors.red)),
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height * 2 / 100,
                          // ),
                          AppButton(
                            text: appLocalization(context).login,
                            onPress: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                authBloc.add(LoginWithEmailAndPasswordEvent(
                                    email: emailController.text,
                                    password: passwordController.text));
                              }
                            },
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 2 / 100,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(IconConstants.icGoogle,
                                  height: MediaQuery.of(context).size.height *
                                      10 /
                                      100),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      2 /
                                      100),
                              Image.asset(
                                IconConstants.icMac,
                                height: MediaQuery.of(context).size.height *
                                    10 /
                                    100,
                              ),
                            ],
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 1 / 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                appLocalization(context).dontHaveAnAccount,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppFont.fontFamily,
                                    color: AppColor.greylightColor,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      2 /
                                      100),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const Register()));
                                },
                                child: Text(appLocalization(context).register,
                                    style: const TextStyle(
                                        color: AppColor.yellowlightColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 5 / 100),
                        ] else ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: IntlPhoneField(
                              ///TODO:  need to implement api country picker dont use this package
                              controller: phoneController,
                              decoration: InputDecoration(
                                hintText: appLocalization(context).phoneNumber,
                                hintStyle: const TextStyle(
                                    color: AppColor.lightfillColor,
                                    fontFamily: AppFont.fontFamily,
                                    fontWeight: FontWeight.w600),
                                //labelText: 'Phone Number',
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
                              ),
                              initialCountryCode: 'IN',
                              validator: (p0) {
                                if (p0?.isValidNumber() ?? false) {
                                  return "Please enter phone number";
                                }
                                return null;
                              },
                              onChanged: (phone) {
                                countryCode = phone.countryCode;
                                // enteredPhone = phone.completeNumber;
                                print(phone.completeNumber);
                                print(phone.countryCode);
                              },
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 5 / 100),
                          AppButton(
                            text: appLocalization(context).getOtp,
                            onPress: _verifyPhoneNumber,
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 2 / 100,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(IconConstants.icGoogle,
                                  height: MediaQuery.of(context).size.height *
                                      10 /
                                      100),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      2 /
                                      100),
                              Image.asset(
                                IconConstants.icMac,
                                height: MediaQuery.of(context).size.height *
                                    10 /
                                    100,
                              ),
                            ],
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 1 / 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                appLocalization(context).dontHaveAnAccount,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppFont.fontFamily,
                                    color: AppColor.greylightColor,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      2 /
                                      100),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const Register()));
                                },
                                child: Text(appLocalization(context).register,
                                    style: const TextStyle(
                                        color: AppColor.yellowlightColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 5 / 100),
                        ],
                      ]),
                    ),
                  ),
                );
              }),
        ));
  }
}
