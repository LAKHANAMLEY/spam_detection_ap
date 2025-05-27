import 'package:spam_delection_app/lib.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();
  double scale = 3.5;
  var changePasswordBloc = ApiBloc(ApiBlocInitialState());
  var passwordVisibilityBloc = SelectionBloc(SelectBoolState(true));
  var newPasswordVisibilityBloc = SelectionBloc(SelectBoolState(true));
  var confirmPasswordVisibilityBloc = SelectionBloc(SelectBoolState(true));

  //var validationBloc = ValidationBloc();
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
                bloc: changePasswordBloc,
                listener: (context, state) {
                  if (state is ChangePasswordState) {
                    if (state.value.statusCode == 200) {
                      showCustomDialog(
                        context,
                        dialogType: DialogType.success,
                        subTitle: state.value.message.toString(),
                        onOkPressed: () {
                          Navigator.popUntil(
                              context,
                              (route) =>
                                  route.settings.name ==
                                  AppRoutes.bottomNavigation);
                        },
                      );
                    } else {
                      showCustomDialog(context,
                          dialogType: DialogType.failed,
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
                                  const EdgeInsets.only(left: 60, right: 50),
                              child: Text(
                                appLocalization(context).changePassword,
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
                                appLocalization(context).pleasNewPasswordSecure,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: AppColor.materialGreyColor,
                                    fontFamily: AppFont.fontFamily,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            10.height(),
                            BlocBuilder(
                                bloc: passwordVisibilityBloc,
                                builder: (context, state) {
                                  if (state is SelectBoolState) {
                                    return CustomTextField(
                                      controller: currentPasswordController,
                                      obscureText: state.value,
                                      labelText:
                                          appLocalization(context).currentPass,
                                      hintText:
                                          appLocalization(context).currentPass,
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            passwordVisibilityBloc.add(
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
                                              .pleaseCurrentPass;
                                        }
                                        return null;
                                      },
                                    );
                                  }
                                  return const Loader();
                                }),
                            10.height(),
                            BlocBuilder(
                                bloc: newPasswordVisibilityBloc,
                                builder: (context, state) {
                                  if (state is SelectBoolState) {
                                    return CustomTextField(
                                      controller: newPasswordController,
                                      obscureText: state.value,
                                      labelText:
                                          appLocalization(context).newPassword,
                                      hintText:
                                          appLocalization(context).newPassword,
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            newPasswordVisibilityBloc.add(
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
                                              .pleaseNewPass;
                                        } else if (p0 ==
                                            currentPasswordController.text) {
                                          return "New password should not be same from previous one";
                                        }
                                        return null;
                                      },
                                    );
                                  }
                                  return const Loader();
                                }),
                            10.height(),
                            BlocBuilder(
                                bloc: confirmPasswordVisibilityBloc,
                                builder: (context, state) {
                                  if (state is SelectBoolState) {
                                    return CustomTextField(
                                      controller: confirmNewPasswordController,
                                      obscureText: state.value,
                                      labelText: appLocalization(context)
                                          .confirmNewPassword,
                                      hintText: appLocalization(context)
                                          .confirmNewPassword,
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            confirmPasswordVisibilityBloc.add(
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
                                              .pleaseConfirmPass;
                                        } else if (p0 !=
                                            newPasswordController.text) {
                                          return "Password is not matching";
                                        }
                                        return null;
                                      },
                                    );
                                  }
                                  return const Loader();
                                }),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 3 / 100,
                            ),
                            AppButton(
                                text: appLocalization(context).changePassword,
                                onPress: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    changePasswordBloc.add(
                                      ChangePasswordEvent(
                                        currentPassword:
                                            currentPasswordController.text
                                                .trim(),
                                        newPassword:
                                            newPasswordController.text.trim(),
                                        confirmNewPassword:
                                            confirmNewPasswordController.text
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
