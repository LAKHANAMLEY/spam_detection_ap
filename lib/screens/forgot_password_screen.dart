import 'package:spam_delection_app/lib.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  double scale = 3.5;

  var forgotBloc = ApiBloc(ApiBlocInitialState());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondryColor,
        appBar: const CustomAppBar(
          centerTitle: true,
        ),
        body: SafeArea(
            child: BlocConsumer(
                bloc: forgotBloc,
                listener: (context, state) {
                  if (state is ForgetPasswordState) {
                    if (state.value.statusCode == 200) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ForgotOtpVerify()));
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
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 8 / 100,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 70, left: 70),
                              child: Text(
                                appLocalization(context).forgotPassword,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: AppColor.bluelightColor,
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
                                  MediaQuery.of(context).size.height * 4 / 100,
                            ),
                            CustomTextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              hintText: appLocalization(context).emailAddress,
                              suffix: Image.asset(
                                IconConstants.icfluentMail,
                                scale: 3,
                              ),
                              validator: (p0) {
                                if (p0?.isEmpty ?? true) {
                                  return appLocalization(context).emailAddress;
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 3 / 100,
                            ),
                            Text(
                              appLocalization(context).pleaseCheckMail,
                              style: const TextStyle(
                                  color: AppColor.remainColor,
                                  fontFamily: AppFont.fontFamily,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 3 / 100,
                            ),
                            AppButton(
                              text: appLocalization(context).login,
                              onPress: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  forgotBloc.add(ForgetPasswordEvent(
                                    email: emailController.text,
                                  ));
                                }
                              },
                            ),
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
