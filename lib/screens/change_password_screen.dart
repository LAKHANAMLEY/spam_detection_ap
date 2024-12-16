import 'package:spam_delection_app/lib.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController currentpasswordController =
      TextEditingController();
  final TextEditingController newpasswordController = TextEditingController();
  final TextEditingController confirmnewpasswordController =
      TextEditingController();
  double scale = 3.5;
  var changePasswordBloc = ApiBloc(ApiBlocInitialState());
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
                bloc: changePasswordBloc,
                listener: (context, state) {
                  if (state is ChangePasswordState) {
                    if (state.value.statusCode == 200) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Profile()));
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
                                StringConstants.changePass,
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
                                StringConstants.resetMessage,
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
                              controller: currentpasswordController,
                              hintText: 'Current Password',
                              suffix: Image.asset(
                                IconConstants.icLockadd,
                                scale: 1.5,
                              ),
                              validator: (p0) {
                                if (p0?.isEmpty ?? true) {
                                  return "Please enter current password";
                                }
                                return null;
                              },
                            ),
                            10.height(),
                            CustomTextField(
                              controller: newpasswordController,
                              hintText: 'New Password',
                              suffix: Image.asset(
                                IconConstants.icLockadd,
                                scale: 1.5,
                              ),
                              validator: (p0) {
                                if (p0?.isEmpty ?? true) {
                                  return "Please enter New password";
                                }
                                return null;
                              },
                            ),
                            10.height(),
                            CustomTextField(
                              controller: confirmnewpasswordController,
                              hintText: 'Confirm new Password',
                              suffix: Image.asset(
                                IconConstants.icLockadd,
                                scale: 1.5,
                              ),
                              validator: (p0) {
                                if (p0?.isEmpty ?? true) {
                                  return "Please enter confirm new password";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 4 / 100,
                            ),
                            AppButton(
                                text: "Change Password",
                                onPress: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    changePasswordBloc.add(
                                      ChangePasswordEvent(
                                        currentPassword:
                                            currentpasswordController.text
                                                .trim(),
                                        newPassword:
                                            newpasswordController.text.trim(),
                                        confirmNewPassword:
                                            confirmnewpasswordController.text
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
