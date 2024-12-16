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
                            const Padding(
                              padding: EdgeInsets.only(left: 60, right: 50),
                              child: Text(
                                StringConstants.changeSecurity,
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
                            const Padding(
                              padding: EdgeInsets.all(18),
                              child: Text(
                                StringConstants.securitypinMessage,
                                textAlign: TextAlign.center,
                                style: TextStyle(
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
                              hintText: 'Current Security Pin',
                              keyboardType: TextInputType.number,
                              suffix: Image.asset(
                                IconConstants.icLockadd,
                                scale: 1.5,
                              ),
                              validator: (p0) {
                                if (p0?.isEmpty ?? true) {
                                  return "Please enter current security pin";
                                }
                                return null;
                              },
                            ),
                            10.height(),
                            CustomTextField(
                              controller: newSecurityPinController,
                              hintText: 'New security pin',
                              keyboardType: TextInputType.number,
                              suffix: Image.asset(
                                IconConstants.icLockadd,
                                scale: 1.5,
                              ),
                              validator: (p0) {
                                if (p0?.isEmpty ?? true) {
                                  return "Please enter new security pin";
                                }
                                return null;
                              },
                            ),
                            10.height(),
                            CustomTextField(
                              controller: confirmSecurityPinController,
                              hintText: 'Confirm security pin',
                              keyboardType: TextInputType.number,
                              suffix: Image.asset(
                                IconConstants.icLockadd,
                                scale: 1.5,
                              ),
                              validator: (p0) {
                                if (p0?.isEmpty ?? true) {
                                  return "Please enter confirm security pin";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 4 / 100,
                            ),
                            AppButton(
                                text: "Change Security Pin",
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
