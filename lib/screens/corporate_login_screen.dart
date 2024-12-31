import 'package:spam_delection_app/lib.dart';

class CorporateLogin extends StatefulWidget {
  const CorporateLogin({super.key});

  @override
  State<CorporateLogin> createState() => _CorporateLoginState();
}

class _CorporateLoginState extends State<CorporateLogin> {
  final TextEditingController corporateIdController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  double scale = 3.5;

  final _formKey = GlobalKey<FormState>();
  var corporateBloc = ApiBloc(ApiBlocInitialState());
  var passwordVisibilityBloc = SelectionBloc(SelectBoolState(false));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondryColor,
        appBar: const CustomAppBar(
          centerTitle: true,
        ),
        body: SafeArea(
          child: BlocConsumer(
              bloc: corporateBloc,
              listener: (context, state) {
                if (state is CorporateLoginState) {
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
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 8 / 100,
                        ),
                        Center(
                            child: Text(
                          appLocalization(context).login,
                          style: const TextStyle(
                              color: AppColor.bluelightColor,
                              fontSize: 35,
                              fontFamily: AppFont.fontFamily,
                              fontWeight: FontWeight.w600),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Text(
                            appLocalization(context).pleaseCorporateID,
                            // this one
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: AppColor.verifyColor,
                                fontFamily: AppFont.fontFamily,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        10.height(),
                        CustomTextField(
                          controller: corporateIdController,
                          labelText: appLocalization(context).corporateID,
                          hintText: appLocalization(context).corporateID,
                          suffix: Image.asset(
                            IconConstants.icCorporateID,
                            scale: 3,
                          ),
                          validator: (p0) {
                            if (p0?.isEmpty ?? true) {
                              return appLocalization(context).pleaseCorporateID;
                            }
                            return null;
                          },
                        ),
                        10.height(),
                        CustomTextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          hintText: appLocalization(context).emailAddress,
                          labelText: appLocalization(context).emailAddress,
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
                        10.height(),
                        BlocBuilder(
                            bloc: passwordVisibilityBloc,
                            builder: (context, state) {
                              if (state is SelectBoolState) {
                                return CustomTextField(
                                  controller: passwordController,
                                  obscureText: state.value,
                                  labelText: appLocalization(context).password,
                                  hintText: appLocalization(context).password,
                                  suffix: InkWell(
                                      onTap: () {
                                        passwordVisibilityBloc
                                            .add(SelectBoolEvent(!state.value));
                                      },
                                      child: state.value
                                          ? Image.asset(
                                              IconConstants.icPassLock,
                                              scale: 3,
                                            )
                                          : Image.asset(
                                              IconConstants.icPassAdd,
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
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 3 / 100),
                        AppButton(
                          text: appLocalization(context).login,
                          onPress: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              corporateBloc.add(CorporateLoginEvent(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  corporateid: corporateIdController.text));
                            }
                          },
                        ),
                      ]),
                    )),
                  ),
                );
              }),
        ));
  }
}
