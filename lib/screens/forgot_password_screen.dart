import 'package:spam_delection_app/lib.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  CountryData? selectedPhoneCodeCountry;

  double scale = 3.5;
  var selectPhoneBloc =
      SelectionBloc(SelectCountryState(AppConstants.selectedCountry));

  var selectTabBloc = SelectionBloc(SelectIntState(0));

  var forgotBloc = ApiBloc(ApiBlocInitialState());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondaryColor,
        appBar: const CustomAppBar(
          centerTitle: true,
        ),
        body: SafeArea(
            child: BlocConsumer(
                bloc: forgotBloc,
                listener: (context, state) {
                  if (state is ForgetPasswordState) {
                    if (state.value.statusCode == 200) {
                      Navigator.pushNamed(
                          context, AppRoutes.forgotOTPVerification,
                          arguments: ForgotOtpVerify(
                            email: emailController.text,
                          ));
                    } else if (state.value.statusCode ==
                        HTTPStatusCodes.sessionExpired) {
                      sessionExpired(context, state.value.message);
                    } else {
                      showCustomDialog(context,
                          dialogType: DialogType.failed,
                          subTitle: state.value.message);
                    }
                  }
                  if (state is ForgetPasswordPhoneState) {
                    if (state.value.statusCode == 200) {
                      Navigator.pushNamed(
                          context, AppRoutes.forgotOTPVerification,
                          arguments: ForgotOtpVerify(
                            email: emailController.text,
                          ));
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
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 4 / 100,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 70, left: 70),
                              child: Text(
                                appLocalization(context).forgotPassword,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: AppColor.blueLightColor,
                                    fontSize: 35,
                                    fontFamily: AppFont.fontFamily,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 2 / 100,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                appLocalization(context).forgotPassDetails,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: AppColor.verifyColor,
                                    fontFamily: AppFont.fontFamily,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 2 / 100,
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
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            12 /
                                                            100,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            18 /
                                                            100,
                                                    child: Center(
                                                      child: tabIndex == 1
                                                          ? Image.asset(
                                                              IconConstants
                                                                  .icEmailSelected) // Show secondary image
                                                          : Image.asset(
                                                              IconConstants
                                                                  .icEmailUnselected), // Show primary image
                                                    ),
                                                  )),
                                            ]),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              3 /
                                              100,
                                        ),
                                        if (tabIndex == 1) ...[
                                          CustomTextField(
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            controller: emailController,
                                            labelText: appLocalization(context)
                                                .emailAddress,
                                            hintText: appLocalization(context)
                                                .emailAddress,
                                            suffix: Image.asset(
                                              IconConstants.icFluentMail,
                                              scale: 3,
                                            ),
                                            validator: (p0) {
                                              if (p0?.isEmpty ?? true) {
                                                return appLocalization(context)
                                                    .pleaseEnterYourEmailAddress;
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                3 /
                                                100,
                                          ),
                                          Text(
                                            appLocalization(context)
                                                .pleaseCheckMail,
                                            style: const TextStyle(
                                                color: AppColor.remainColor,
                                                fontFamily: AppFont.fontFamily,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                3 /
                                                100,
                                          ),
                                          AppButton(
                                            text: appLocalization(context)
                                                .continueTxt,
                                            onPress: () {
                                              if (_formKey.currentState
                                                      ?.validate() ??
                                                  false) {
                                                forgotBloc
                                                    .add(ForgetPasswordEvent(
                                                  email: emailController.text,
                                                ));
                                              }
                                            },
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
                                                  if (state
                                                      is SelectCountryState) {
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
                                                    prefix:
                                                        CountryPhoneCodePrefix(
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
                                              text: appLocalization(context)
                                                  .getOtp,
                                              onPress: () {
                                                if (_formKey.currentState
                                                        ?.validate() ??
                                                    false) {
                                                  forgotBloc.add(
                                                      ForgetPasswordPhoneEvent(
                                                    phone: phoneController.text,
                                                    countryCode:
                                                        selectedPhoneCodeCountry
                                                                ?.phonecode ??
                                                            "",
                                                  ));
                                                }
                                              }),
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
                            // CustomTextField(
                            //   keyboardType: TextInputType.emailAddress,
                            //   controller: emailController,
                            //   labelText: appLocalization(context).emailAddress,
                            //   hintText: appLocalization(context).emailAddress,
                            //   suffix: Image.asset(
                            //     IconConstants.icFluentMail,
                            //     scale: 3,
                            //   ),
                            //   validator: (p0) {
                            //     if (p0?.isEmpty ?? true) {
                            //       return appLocalization(context)
                            //           .pleaseEnterYourEmailAddress;
                            //     }
                            //     return null;
                            //   },
                            // ),
                            // SizedBox(
                            //   height:
                            //       MediaQuery.of(context).size.height * 3 / 100,
                            // ),
                            // Text(
                            //   appLocalization(context).pleaseCheckMail,
                            //   style: const TextStyle(
                            //       color: AppColor.remainColor,
                            //       fontFamily: AppFont.fontFamily,
                            //       fontWeight: FontWeight.w600),
                            // ),
                            // SizedBox(
                            //   height:
                            //       MediaQuery.of(context).size.height * 3 / 100,
                            // ),
                            // AppButton(
                            //   text: appLocalization(context).continueTxt,
                            //   onPress: () {
                            //     if (_formKey.currentState?.validate() ??
                            //         false) {
                            //       forgotBloc.add(ForgetPasswordEvent(
                            //         email: emailController.text,
                            //       ));
                            //     }
                            //   },
                            // ),
                          ]),
                        ),
                      ),
                    ),
                  );
                })));
  }
}

class Constants {
  static var emailValidatorRegExp;
}

class SnackBarToastMessage {
  static void showSnackBar(BuildContext context, emailMessage) {}
}
