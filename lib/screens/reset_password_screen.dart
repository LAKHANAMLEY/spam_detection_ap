import 'package:spam_delection_app/lib.dart';

class ResetPassword extends StatefulWidget {
  final String? email;
  final String? code;

  const ResetPassword({super.key, this.email, this.code});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late String password;
  late String confirmPassword;

  var passwordVisibilityBloc = SelectionBloc(SelectBoolState(true));
  var renterPasswordVisibilityBloc = SelectionBloc(SelectBoolState(true));

  double scale = 3.5;
  var resetPassBloc = ApiBloc(ApiBlocInitialState());

  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String _validationMessage = '';

  @override
  void initState() {
    super.initState();
    passwordController.addListener(() {
      _validatePassword(passwordController.text);
    });
  }

  void _validatePassword(String password) {
    String validationMessage = '';

    if (password.length < 8) {
      validationMessage = appLocalization(context).minimumCharactersRequired;
    } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
      validationMessage = appLocalization(context).mustUppercaseLetter;
    } else if (!RegExp(r'[a-z]').hasMatch(password)) {
      validationMessage = appLocalization(context).mustLowercaseLetter;
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      validationMessage = appLocalization(context).mustSpecialCharacter;
    } else {
      validationMessage = appLocalization(context).passwordValid;
    }

    setState(() {
      _validationMessage = validationMessage;
    });
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //var argument = args(context) as ResetPassword;
    return Scaffold(
        // backgroundColor: AppColor.secondryColor,
        appBar: const CustomAppBar(
          centerTitle: true,
        ),
        body: SafeArea(
            child: BlocConsumer(
                bloc: resetPassBloc,
                listener: (context, state) {
                  if (state is ResetPasswordState) {
                    if (state.value.statusCode == 200) {
                      Navigator.pushNamed(context, AppRoutes.register);
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
                            Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 70, right: 70),
                              child: Text(
                                appLocalization(context).resetPassword,
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
                              padding: const EdgeInsets.all(18),
                              child: Text(
                                appLocalization(context).pleaseSecureAccount,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: AppColor.verifyColor,
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
                                      controller: passwordController,
                                      obscureText: state.value,
                                      labelText:
                                          appLocalization(context).password,
                                      hintText:
                                          appLocalization(context).password,
                                      suffix: InkWell(
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
                                              .pleaseEnterYourPassword;
                                        }
                                        return null;
                                      },
                                    );
                                  }
                                  return const Loader();
                                }),
                            Text(
                              _validationMessage,
                              style: TextStyle(
                                color: _validationMessage ==
                                        appLocalization(context).passwordValid
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 14,
                              ),
                            ),
                            10.height(),
                            BlocBuilder(
                                bloc: renterPasswordVisibilityBloc,
                                builder: (context, state) {
                                  if (state is SelectBoolState) {
                                    return CustomTextField(
                                      controller: confirmPasswordController,
                                      obscureText: state.value,
                                      labelText: appLocalization(context)
                                          .renterPassword,
                                      hintText: appLocalization(context)
                                          .renterPassword,
                                      suffix: InkWell(
                                          onTap: () {
                                            renterPasswordVisibilityBloc.add(
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
                              text: appLocalization(context).resetPassword,
                              onPress: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  resetPassBloc.add(ResetPasswordEvent(
                                      email: widget.email ?? "",
                                      code: widget.code ?? "",
                                      password: passwordController.text,
                                      confirmPassword:
                                          confirmPasswordController.text));
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
