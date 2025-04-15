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

  var currentPinVisibilityBloc = SelectionBloc(SelectBoolState(true));
  var newPinVisibilityBloc = SelectionBloc(SelectBoolState(true));
  var confirmPinVisibilityBloc = SelectionBloc(SelectBoolState(true));

  double scale = 3.5;
  var changeSecurityBloc = ApiBloc(ApiBlocInitialState());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: const CustomAppBar(
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
                              padding:
                                  const EdgeInsets.only(left: 70, right: 70),
                              child: Text(
                                appLocalization(context).changeSecurity,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: AppColor.lightPurpleColor,
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
                              padding: const EdgeInsets.all(18),
                              child: Text(
                                appLocalization(context).pleaseNewPinSecure,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: AppColor.materialGreyColor,
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
                            BlocBuilder(
                                bloc: currentPinVisibilityBloc,
                                builder: (context, state) {
                                  if (state is SelectBoolState) {
                                    return CustomTextField(
                                      keyboardType: TextInputType.number,
                                      controller: currentSecurityPinController,
                                      obscureText: state.value,
                                      labelText: appLocalization(context)
                                          .currentSecurityPin,
                                      hintText: appLocalization(context)
                                          .currentSecurityPin,
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            currentPinVisibilityBloc.add(
                                                SelectBoolEvent(!state.value));
                                          },
                                          child: state.value
                                              ? Image.asset(
                                                  IconConstants.icPassRemove,
                                                  scale: 3,
                                                )
                                              : Image.asset(
                                                  IconConstants.icPassLock,
                                                  scale: 3,
                                                )),
                                      validator: (p0) {
                                        if (p0?.isEmpty ?? true) {
                                          return appLocalization(context)
                                              .pleaseCurrentSecurityPin;
                                        }
                                        return null;
                                      },
                                    );
                                  }
                                  return const Loader();
                                }),
                            10.height(),
                            BlocBuilder(
                                bloc: newPinVisibilityBloc,
                                builder: (context, state) {
                                  if (state is SelectBoolState) {
                                    return CustomTextField(
                                      keyboardType: TextInputType.number,
                                      controller: newSecurityPinController,
                                      obscureText: state.value,
                                      labelText: appLocalization(context)
                                          .newSecurityPin,
                                      hintText: appLocalization(context)
                                          .newSecurityPin,
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            newPinVisibilityBloc.add(
                                                SelectBoolEvent(!state.value));
                                          },
                                          child: state.value
                                              ? Image.asset(
                                                  IconConstants.icPassRemove,
                                                  scale: 3,
                                                )
                                              : Image.asset(
                                                  IconConstants.icPassLock,
                                                  scale: 3,
                                                )),
                                      validator: (p0) {
                                        if (p0?.isEmpty ?? true) {
                                          return appLocalization(context)
                                              .pleaseNewSecurityPin;
                                        }
                                        return null;
                                      },
                                    );
                                  }
                                  return const Loader();
                                }),
                            10.height(),
                            BlocBuilder(
                                bloc: confirmPinVisibilityBloc,
                                builder: (context, state) {
                                  if (state is SelectBoolState) {
                                    return CustomTextField(
                                      keyboardType: TextInputType.number,
                                      controller: confirmSecurityPinController,
                                      obscureText: state.value,
                                      labelText: appLocalization(context)
                                          .confirmSecurityPin,
                                      hintText: appLocalization(context)
                                          .confirmSecurityPin,
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            confirmPinVisibilityBloc.add(
                                                SelectBoolEvent(!state.value));
                                          },
                                          child: state.value
                                              ? Image.asset(
                                                  IconConstants.icPassRemove,
                                                  scale: 3,
                                                )
                                              : Image.asset(
                                                  IconConstants.icPassLock,
                                                  scale: 3,
                                                )),
                                      validator: (p0) {
                                        if (p0?.isEmpty ?? true) {
                                          return appLocalization(context)
                                              .pleaseConfirmSecurityPin;
                                        }
                                        return null;
                                      },
                                    );
                                  }
                                  return const Loader();
                                }),
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
