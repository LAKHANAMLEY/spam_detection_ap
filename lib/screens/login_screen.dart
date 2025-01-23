import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spam_delection_app/lib.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isRememberMeChecked = false;

  // int tabIndex = 0;
  var selectPhoneBloc =
      SelectionBloc(SelectCountryState(AppConstants.selectedCountry));
  CountryData? selectedPhoneCodeCountry;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? countryCode;

  void _loadRememberMeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isRememberMeChecked = prefs.getBool('rememberMe') ?? false;
    });
  }

  // Save the state to SharedPreferences
  void _saveRememberMeState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', value);
  }

  Future<void> _verifyPhoneNumber() async {
    if (_formKey.currentState?.validate() ?? false) {
      await _auth.verifyPhoneNumber(
        phoneNumber: (countryCode ?? "") + phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(appLocalization(context).phoneAutomaticallySigned)),
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

    // print("Phone number: ${phoneController.text}, Country code: $countryCode");
  }

  final TextEditingController phoneController = TextEditingController(); //#2
  final TextEditingController countryController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var passwordVisibilityBloc = SelectionBloc(SelectBoolState(true));

  var selectTabBloc = SelectionBloc(SelectIntState(0));

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
                              color: AppColor.blueLightColor,
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
                        BlocBuilder(
                            bloc: selectTabBloc,
                            builder: (context, selectTabState) {
                              if (selectTabState is SelectIntState) {
                                int tabIndex = selectTabState.value;
                                return Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              selectTabBloc
                                                  .add(SelectIntEvent(0));
                                            },
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  12 /
                                                  100,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  18 /
                                                  100,
                                              child: Center(
                                                child: tabIndex == 1
                                                    ? Image.asset(IconConstants
                                                        .icPhoneUnSelect) // Show secondary image
                                                    : Image.asset(IconConstants
                                                        .icSMSSelected), // Show primary image
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                5 /
                                                100,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                selectTabBloc
                                                    .add(SelectIntEvent(1));
                                              },
                                              child: SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    12 /
                                                    100,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    18 /
                                                    100,
                                                child: Center(
                                                  child: tabIndex == 1
                                                      ? Image.asset(IconConstants
                                                          .icEmailSelected) // Show secondary image
                                                      : Image.asset(IconConstants
                                                          .icEmailUnselected), // Show primary image
                                                ),
                                              )),
                                        ]),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              5 /
                                              100,
                                    ),
                                    if (tabIndex == 1) ...[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18, right: 18),
                                        child: CustomTextField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          labelText: appLocalization(context)
                                              .emailAddress,
                                          controller: emailController,
                                          hintText: appLocalization(context)
                                              .emailAddress,
                                          suffix: Image.asset(
                                            IconConstants.icEmailAdd,
                                            scale: 1.5,
                                          ),
                                          validator: (p0) {
                                            if (p0?.isEmpty ?? false) {
                                              return appLocalization(context)
                                                  .pleaseEnterYourEmailAddress;
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                2 /
                                                100,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18, right: 18),
                                        child: BlocBuilder(
                                            bloc: passwordVisibilityBloc,
                                            builder: (context, state) {
                                              if (state is SelectBoolState) {
                                                return CustomTextField(
                                                  controller:
                                                      passwordController,
                                                  obscureText: state.value,
                                                  labelText:
                                                      appLocalization(context)
                                                          .password,
                                                  hintText:
                                                      appLocalization(context)
                                                          .password,
                                                  suffix: InkWell(
                                                      onTap: () {
                                                        passwordVisibilityBloc
                                                            .add(SelectBoolEvent(
                                                                !state.value));
                                                      },
                                                      child: state.value
                                                          ? Image.asset(
                                                              IconConstants
                                                                  .icPassRemove,
                                                              scale: 3,
                                                            )
                                                          : Image.asset(
                                                              IconConstants
                                                                  .icPassLock,
                                                              scale: 3,
                                                            )),
                                                  validator: (p0) {
                                                    if (p0?.isEmpty ?? true) {
                                                      return appLocalization(
                                                              context)
                                                          .pleaseEnterYourPassword;
                                                    }
                                                    return null;
                                                  },
                                                );
                                              }
                                              return const Loader();
                                            }),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18, right: 18),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Checkbox(
                                                  value: _isRememberMeChecked,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      _isRememberMeChecked =
                                                          value ?? false;
                                                      _saveRememberMeState(
                                                          _isRememberMeChecked);
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  appLocalization(context)
                                                      .rememberMe,
                                                  style: const TextStyle(
                                                    color:
                                                        AppColor.lightFillColor,
                                                    fontFamily:
                                                        AppFont.fontFamily,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TextButton(
                                                child: Text(
                                                  appLocalization(context)
                                                      .forgotPasswordText,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: AppColor
                                                          .yellowLightColor,
                                                      fontFamily:
                                                          AppFont.fontFamily,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                onPressed: () {
                                                  Navigator.pushNamed(context,
                                                      AppRoutes.forgotPassword);
                                                }),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                2 /
                                                100,
                                      ),
                                      AppButton(
                                        text: appLocalization(context).login,
                                        onPress: () {
                                          if (_formKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            authBloc.add(
                                                LoginWithEmailAndPasswordEvent(
                                                    email: emailController.text,
                                                    password: passwordController
                                                        .text));
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                2 /
                                                100,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(IconConstants.icGoogle,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  10 /
                                                  100),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  2 /
                                                  100),
                                          Image.asset(
                                            IconConstants.icMac,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                10 /
                                                100,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                1 /
                                                100,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            appLocalization(context)
                                                .dontHaveAnAccount,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontFamily: AppFont.fontFamily,
                                                color: AppColor.greylightColor,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  2 /
                                                  100),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, AppRoutes.register);
                                            },
                                            child: Text(
                                                appLocalization(context)
                                                    .register,
                                                style: const TextStyle(
                                                    color: AppColor
                                                        .yellowLightColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              5 /
                                              100),
                                    ] else ...[
                                      10.height(),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18, right: 18),
                                        child: BlocConsumer(
                                            bloc: selectPhoneBloc,
                                            listener: (context, state) {
                                              if (state is SelectCountryState) {
                                                selectedPhoneCodeCountry =
                                                    state.value;
                                              }
                                            },
                                            builder: (context, state) {
                                              return CustomTextField(
                                                keyboardType:
                                                    TextInputType.phone,
                                                //readOnly: true,
                                                controller: phoneController,
                                                hintText:
                                                    appLocalization(context)
                                                        .phoneNumber,
                                                labelText:
                                                    appLocalization(context)
                                                        .phoneNumber,
                                                suffix: Image.asset(
                                                  IconConstants.icCallAdd,
                                                  scale: 1.5,
                                                ),
                                                prefix: CountryPhoneCodePrefix(
                                                  bloc: selectPhoneBloc,
                                                ),
                                                validator: (p0) {
                                                  if (p0?.isEmpty ?? true) {
                                                    return appLocalization(
                                                            context)
                                                        .pleaseEnterPhone;
                                                  }
                                                  return null;
                                                },
                                              );
                                            }),
                                      ),
                                      20.height(),
                                      AppButton(
                                          text: appLocalization(context).getOtp,
                                          onPress: () {
                                            if (_formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              _verifyPhoneNumber;
                                            }
                                          }),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                2 /
                                                100,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(IconConstants.icGoogle,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  10 /
                                                  100),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  2 /
                                                  100),
                                          Image.asset(
                                            IconConstants.icMac,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                10 /
                                                100,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                1 /
                                                100,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            appLocalization(context)
                                                .dontHaveAnAccount,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontFamily: AppFont.fontFamily,
                                                color: AppColor.greylightColor,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  2 /
                                                  100),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          const Register()));
                                            },
                                            child: Text(
                                                appLocalization(context)
                                                    .register,
                                                style: const TextStyle(
                                                    color: AppColor
                                                        .yellowLightColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              5 /
                                              100),
                                    ],
                                  ],
                                );
                              }
                              return const Loader();
                            })
                      ]),
                    ),
                  ),
                );
              }),
        ));
  }
}
