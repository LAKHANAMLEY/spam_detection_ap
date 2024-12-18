import 'package:spam_delection_app/lib.dart';

class ChangeSecurity extends StatefulWidget {
  const ChangeSecurity({super.key});

  @override
  State<ChangeSecurity> createState() => _ChangeSecurityState();
}

class _ChangeSecurityState extends State<ChangeSecurity> {
  final TextEditingController currentSecurityPinController =
      TextEditingController();
  final TextEditingController newSecurityPinController =
      TextEditingController();
  final TextEditingController confirmSecurityPinController =
      TextEditingController();
  double scale = 3.5;
  var changeSecurityBloc = ApiBloc(ApiBlocInitialState());
  final _formKey = GlobalKey<FormState>();
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
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset(
                    IconConstants.backIcon,
                  ),
                ),
              )),
          title: Image.asset(
            IconConstants.icBroadlogo,
            height: MediaQuery.of(context).size.height * 5 / 100,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: BlocConsumer(
                bloc: changeSecurityBloc,
                listener: (context, state) {
                  if (state is ChangeSecurityState) {
                    if (state.value.statusCode == 200) {
                      Navigator.pushNamed(context, AppRoutes.profile);
                    } else {
                      showCustomDialog(context,
                          dialogType: DialogType.success,
                          subTitle: state.value.message.toString());
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
                              padding: EdgeInsets.only(left: 80, right: 80),
                              child: Text(
                                appLocalization(context).changeSecurity,
                                textAlign: TextAlign.center,
                                style: TextStyle(
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
                              padding: EdgeInsets.all(18),
                              child: Text(
                                appLocalization(context).pleaseNewPinSecure,
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
                            10.height(),
                            CustomTextField(
                              controller: currentSecurityPinController,
                              hintText:
                                  appLocalization(context).currentSecurityPin,
                              keyboardType: TextInputType.number,
                              suffix: Image.asset(
                                IconConstants.icLockadd,
                                scale: 1.5,
                              ),
                              validator: (p0) {
                                if (p0?.isEmpty ?? true) {
                                  return appLocalization(context)
                                      .pleaseCurrentSecurityPin;
                                }
                                return null;
                              },
                            ),
                            10.height(),
                            CustomTextField(
                              controller: newSecurityPinController,
                              hintText: appLocalization(context).newSecurityPin,
                              keyboardType: TextInputType.number,
                              suffix: Image.asset(
                                IconConstants.icLockadd,
                                scale: 1.5,
                              ),
                              validator: (p0) {
                                if (p0?.isEmpty ?? true) {
                                  return appLocalization(context)
                                      .pleaseNewSecurityPin;
                                }
                                return null;
                              },
                            ),
                            10.height(),
                            CustomTextField(
                              controller: confirmSecurityPinController,
                              hintText:
                                  appLocalization(context).confirmSecurityPin,
                              keyboardType: TextInputType.number,
                              suffix: Image.asset(
                                IconConstants.icLockadd,
                                scale: 1.5,
                              ),
                              validator: (p0) {
                                if (p0?.isEmpty ?? true) {
                                  return appLocalization(context)
                                      .pleaseConfirmSecurityPin;
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 4 / 100,
                            ),
                            AppButton(
                                text: appLocalization(context).changeSecurity,
                                onPress: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    changeSecurityBloc.add(
                                      ChangeSecurityEvent(
                                        currentPin: currentSecurityPinController
                                            .text
                                            .trim(),
                                        newPin: newSecurityPinController.text
                                            .trim(),
                                        confirmNewPin:
                                            confirmSecurityPinController.text
                                                .trim(),
                                      ),
                                    );
                                  }
                                }),
                          ]),
                        ),
                      ),
                    ),
                  );
                })));
  }
}
