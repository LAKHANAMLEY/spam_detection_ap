import 'package:flutter/services.dart';
import 'package:spam_delection_app/lib.dart';

class ForgotOtpVerify extends StatefulWidget {
  final String? email;

  const ForgotOtpVerify({super.key, this.email});

  @override
  State<ForgotOtpVerify> createState() => _ForgotOtpVerifyState();
}

class _ForgotOtpVerifyState extends State<ForgotOtpVerify> {
  final GlobalKey<FormState> _forgotOtpFormKey = GlobalKey<FormState>();

  var forgotPassBloc = ApiBloc(ApiBlocInitialState());

  FocusNode? pin1FocusNode;
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;
  FocusNode? pin6FocusNode;

  TextEditingController firstInputController = TextEditingController();
  TextEditingController secondInputController = TextEditingController();
  TextEditingController thirdInputController = TextEditingController();
  TextEditingController forthInputController = TextEditingController();
  TextEditingController fifthInputController = TextEditingController();
  TextEditingController sixthInputController = TextEditingController();

  String firstInput = '';
  String secondInput = '';
  String thirdInput = '';
  String forthInput = '';
  String fifthInput = '';
  String sixInput = '';

  @override
  void initState() {
    super.initState();
    pin1FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  forgotOtpUserValidation(
      String firstInput,
      String secondInput,
      String thirdInput,
      String fourthInput,
      String fifthInput,
      String sixthInput) async {
    var otpInput = (firstInput +
        secondInput +
        thirdInput +
        fourthInput +
        fifthInput +
        sixthInput);
    if (otpInput.isEmpty) {
      SnackBarToastMessage.showSnackBar(context, StringConstants.otpMessage);
      return false;
    } else if (otpInput.length < 6) {
      SnackBarToastMessage.showSnackBar(
          context, StringConstants.otpMinLenthMessage);
      return false;
    } else {
      forgotOtpUserApiCall(firstInput, secondInput, thirdInput, fourthInput,
          fifthInput, sixthInput);
    }
  }

  forgotOtpUserApiCall(String firstInput, String secondInput, String thirdInput,
      String fourthInput, String fifthInput, String sixthInput) async {
    var argument = args(context) as ForgotOtpVerify;
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ResetPassword(
                email: argument.email,
                code: firstInput +
                    secondInput +
                    thirdInput +
                    fourthInput +
                    fifthInput +
                    sixthInput,
              )),
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
    pin5FocusNode!.dispose();
    pin6FocusNode!.dispose();
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
    var argument = args(context) as ForgotOtpVerify;
    return Scaffold(
        backgroundColor: AppColor.secondaryColor,
        appBar: const CustomAppBar(
          centerTitle: true,
        ),
        body: SafeArea(
            child: BlocConsumer(
                bloc: forgotPassBloc,
                listener: (context, state) {
                  if (state is ForgetPasswordState) {
                    if (state.value.statusCode == 200) {
                      showToast(state.value.message);
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
                      key: _forgotOtpFormKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 8 / 100,
                            ),
                            Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 70, right: 70),
                              child: Text(
                                appLocalization(context).forgotPassword,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: AppColor.blueLightColor,
                                    fontSize: 35,
                                    fontFamily: AppFont.fontFamily,
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 2 / 100,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 50, right: 50),
                              child: Center(
                                child: Text(
                                  appLocalization(context).enterCode,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: AppColor.verifyColor,
                                      fontFamily: AppFont.fontFamily,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                //  crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        5 /
                                        100,
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          90 /
                                          100,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 50,
                                              height: 60,
                                              child: Center(
                                                child: TextFormField(
                                                  controller:
                                                      firstInputController,
                                                  cursorColor:
                                                      AppColor.yellowLightColor,
                                                  autofocus: true,
                                                  readOnly: false,
                                                  focusNode: pin1FocusNode,
                                                  decoration: InputDecoration(
                                                    counterText: '',
                                                    border:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: AppColor
                                                              .fillColor,
                                                          width: 1.5),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  2)),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: firstInputController
                                                                  .text
                                                                  .isNotEmpty
                                                              ? AppColor
                                                                  .deepYellowColor
                                                              : AppColor
                                                                  .fillColor
                                                                  .withOpacity(
                                                                      0.2),
                                                          width: 1.5),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  2)),
                                                    ),
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: AppColor
                                                              .fillColor,
                                                          width: 1.5),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  2)),
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            (12)),
                                                    fillColor: AppColor
                                                        .fillColor
                                                        .withOpacity(0.2),
                                                    filled: true,
                                                  ),
                                                  style: const TextStyle(
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColor
                                                          .deepYellowColor),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: <TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                            RegExp(r'[0-9]')),
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                  ],
                                                  textAlign: TextAlign.center,
                                                  maxLength: 1,
                                                  onTap: () {
                                                    pin1FocusNode!
                                                        .requestFocus();
                                                  },
                                                  onChanged: (value) {
                                                    print(firstInputController
                                                        .text.length);
                                                    print(firstInputController
                                                        .text);
                                                    firstInputController.text =
                                                        value;
                                                    nextField(
                                                        value, pin2FocusNode!);
                                                  },
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 50,
                                              height: 60,
                                              child: TextFormField(
                                                controller:
                                                    secondInputController,
                                                cursorColor:
                                                    AppColor.yellowLightColor,
                                                maxLength: 1,
                                                autofocus: true,
                                                readOnly: false,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9]')),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                                textAlign: TextAlign.center,
                                                focusNode: pin2FocusNode,
                                                onTap: () {
                                                  pin2FocusNode!.requestFocus();
                                                },
                                                onChanged: (value) {
                                                  if (value.isEmpty) {
                                                    secondInputController.text =
                                                        '';
                                                    previousField(
                                                        value, pin1FocusNode!);
                                                  } else {
                                                    secondInputController.text =
                                                        value;
                                                    nextField(
                                                        value, pin3FocusNode!);
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  counterText: '',
                                                  border:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColor.fillColor,
                                                        width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                2.0)),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: secondInputController
                                                                .text.isNotEmpty
                                                            ? AppColor
                                                                .deepYellowColor
                                                            : AppColor.fillColor
                                                                .withOpacity(
                                                                    0.2),
                                                        width: 1.5),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                2.0)),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColor.fillColor,
                                                        width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                2.0)),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets.all(
                                                          (12)),
                                                  fillColor: AppColor.fillColor
                                                      .withOpacity(0.2),
                                                  filled: true,
                                                ),
                                                style: const TextStyle(
                                                    fontSize: 28,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor
                                                        .deepYellowColor),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 50,
                                              height: 60,
                                              child: TextFormField(
                                                controller:
                                                    thirdInputController,
                                                cursorColor:
                                                    AppColor.yellowLightColor,
                                                maxLength: 1,
                                                autofocus: true,
                                                // readOnly: true,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9]')),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                  counterText: '',
                                                  border:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColor.fillColor,
                                                        width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                2.0)),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: (thirdInputController
                                                                .text
                                                                .isNotEmpty)
                                                            ? AppColor
                                                                .deepYellowColor
                                                            : AppColor.fillColor
                                                                .withOpacity(
                                                                    0.2),
                                                        width: 1.5),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                2.0)),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColor.fillColor,
                                                        width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                2.0)),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets.all(
                                                          (12)),
                                                  fillColor: AppColor.fillColor
                                                      .withOpacity(0.2),
                                                  filled: true,
                                                ),
                                                style: TextStyle(
                                                    fontSize: 28,
                                                    fontWeight: FontWeight.w500,
                                                    color: (thirdInputController
                                                            .text.isNotEmpty)
                                                        ? AppColor
                                                            .deepYellowColor
                                                        : AppColor
                                                            .deepYellowColor),
                                                focusNode: pin3FocusNode,
                                                onTap: () {
                                                  pin3FocusNode!.requestFocus();
                                                },
                                                onChanged: (value) {
                                                  print('hello');
                                                  if (value.isEmpty) {
                                                    thirdInputController.text =
                                                        '';
                                                    previousField(
                                                        value, pin2FocusNode!);
                                                  } else {
                                                    nextField(
                                                        value, pin4FocusNode!);
                                                    thirdInputController.text =
                                                        value;
                                                  }
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 50,
                                              height: 60,
                                              child: TextFormField(
                                                controller:
                                                    forthInputController,
                                                cursorColor:
                                                    AppColor.yellowLightColor,
                                                maxLength: 1,
                                                autofocus: true,
                                                readOnly: false,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9]')),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                  counterText: '',
                                                  border:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColor.fillColor,
                                                        width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                2.0)),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: (forthInputController
                                                                .text
                                                                .isNotEmpty)
                                                            ? AppColor
                                                                .deepYellowColor
                                                            : AppColor.fillColor
                                                                .withOpacity(
                                                                    0.2),
                                                        width: 1.5),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                2.0)),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColor.fillColor,
                                                        width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                2.0)),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets.all(
                                                          (12)),
                                                  fillColor: AppColor.fillColor
                                                      .withOpacity(0.2),
                                                  filled: true,
                                                ),
                                                style: TextStyle(
                                                    fontSize: 28,
                                                    fontWeight: FontWeight.w500,
                                                    color: (forthInputController
                                                            .text.isNotEmpty)
                                                        ? AppColor
                                                            .deepYellowColor
                                                        : AppColor
                                                            .deepYellowColor),
                                                focusNode: pin4FocusNode,
                                                onTap: () {
                                                  pin4FocusNode!.requestFocus();
                                                },
                                                onChanged: (value) {
                                                  print('hello');
                                                  if (value.isEmpty) {
                                                    forthInputController.text =
                                                        '';
                                                    previousField(
                                                        value, pin3FocusNode!);
                                                  } else {
                                                    nextField(
                                                        value, pin5FocusNode!);
                                                    forthInputController.text =
                                                        value;
                                                  }
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 50,
                                              height: 60,
                                              child: TextFormField(
                                                controller:
                                                    fifthInputController,
                                                cursorColor:
                                                    AppColor.yellowLightColor,
                                                maxLength: 1,
                                                autofocus: true,
                                                readOnly: false,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9]')),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                  counterText: '',
                                                  border:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColor.fillColor,
                                                        width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                2.0)),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: (fifthInputController
                                                                .text
                                                                .isNotEmpty)
                                                            ? AppColor
                                                                .deepYellowColor
                                                            : AppColor.fillColor
                                                                .withOpacity(
                                                                    0.2),
                                                        width: 1.5),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                2.0)),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColor.fillColor,
                                                        width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                2.0)),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets.all(
                                                          (12)),
                                                  fillColor: AppColor.fillColor
                                                      .withOpacity(0.2),
                                                  filled: true,
                                                ),
                                                style: TextStyle(
                                                    fontSize: 28,
                                                    fontWeight: FontWeight.w500,
                                                    color: (fifthInputController
                                                            .text.isNotEmpty)
                                                        ? AppColor
                                                            .deepYellowColor
                                                        : AppColor
                                                            .deepYellowColor),
                                                focusNode: pin5FocusNode,
                                                onTap: () {
                                                  pin5FocusNode!.requestFocus();
                                                },
                                                onChanged: (value) {
                                                  print('hello');
                                                  if (value.isEmpty) {
                                                    fifthInputController.text =
                                                        '';
                                                    previousField(
                                                        value, pin4FocusNode!);
                                                  } else {
                                                    nextField(
                                                        value, pin6FocusNode!);
                                                    fifthInputController.text =
                                                        value;
                                                  }
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 50,
                                              height: 60,
                                              child: TextFormField(
                                                controller:
                                                    sixthInputController,
                                                cursorColor:
                                                    AppColor.yellowLightColor,
                                                focusNode: pin6FocusNode,
                                                autofocus: true,
                                                readOnly: false,
                                                maxLength: 1,
                                                // obscureText: true,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9]')),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                  counterText: '',
                                                  border:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColor.fillColor,
                                                        width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                2.0)),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: (forthInputController
                                                                .text
                                                                .isNotEmpty)
                                                            ? AppColor
                                                                .deepYellowColor
                                                            : AppColor.fillColor
                                                                .withOpacity(
                                                                    0.2),
                                                        width: 1.5),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                2.0)),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColor.fillColor,
                                                        width: 1.5),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                2.0)),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets.all(
                                                          (12)),
                                                  fillColor: AppColor.fillColor
                                                      .withOpacity(0.2),
                                                  filled: true,
                                                ),
                                                style: TextStyle(
                                                    fontSize: 28,
                                                    fontWeight: FontWeight.w500,
                                                    color: (forthInputController
                                                            .text.isNotEmpty)
                                                        ? AppColor
                                                            .deepYellowColor
                                                        : AppColor
                                                            .deepYellowColor),
                                                onTap: () {
                                                  pin6FocusNode?.requestFocus();
                                                },
                                                onChanged: (value) {
                                                  if (value.isEmpty) {
                                                    sixthInputController.text =
                                                        '';
                                                    previousField(
                                                        value, pin5FocusNode!);
                                                  } else {
                                                    sixthInputController.text =
                                                        value;
                                                  }
                                                },
                                              ),
                                            ),
                                          ])),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        4 /
                                        100,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        appLocalization(context).didReceiveCode,
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
                                          forgotPassBloc.add(
                                              ForgetPasswordEvent(
                                                  email: argument.email ?? ""));
                                        },
                                        child: Text(
                                          appLocalization(context).resend,
                                          style: const TextStyle(
                                            color: AppColor.yellowLightColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              5 /
                                              100),
                                  AppButton(
                                      text:
                                          appLocalization(context).continueTxt,
                                      onPress: () {
                                        forgotOtpUserValidation(
                                          firstInputController.text,
                                          secondInputController.text,
                                          thirdInputController.text,
                                          forthInputController.text,
                                          fifthInputController.text,
                                          sixthInputController.text,
                                        );
                                      }),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        4 /
                                        100,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ),
                    ),
                  );
                })));
  }
}
