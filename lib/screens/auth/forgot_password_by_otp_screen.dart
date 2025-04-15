import 'package:spam_delection_app/lib.dart';

class ForgotPasswordMobile extends StatefulWidget {
  const ForgotPasswordMobile({super.key});

  @override
  State<ForgotPasswordMobile> createState() => _ForgotPasswordMobileState();
}

class _ForgotPasswordMobileState extends State<ForgotPasswordMobile> {
  TextEditingController phoneController = TextEditingController();
  var selectPhoneBloc =
      SelectionBloc(SelectCountryState(AppConstants.selectedCountry));
  CountryData? selectedPhoneCodeCountry;
  double scale = 3.5;

  var forgotBloc = ApiBloc(ApiBlocInitialState());
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
                bloc: forgotBloc,
                listener: (context, state) {
                  if (state is ForgetPasswordState) {
                    if (state.value.statusCode == 200) {
                      Navigator.pushNamed(
                          context, AppRoutes.forgotOTPVerification,
                          arguments: const ForgotOtpVerify(
                              //phone: phoneController.text,
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
                                  MediaQuery.of(context).size.height * 8 / 100,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 70, left: 70),
                              child: Text(
                                appLocalization(context).forgotPassword,
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
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                appLocalization(context).forgotPassDetails,
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
                                  MediaQuery.of(context).size.height * 4 / 100,
                            ),
                            10.height(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 18, right: 18),
                              child: BlocConsumer(
                                  bloc: selectPhoneBloc,
                                  listener: (context, state) {
                                    if (state is SelectCountryState) {
                                      selectedPhoneCodeCountry = state.value;
                                    }
                                  },
                                  builder: (context, state) {
                                    return CustomTextField(
                                      keyboardType: TextInputType.phone,
                                      //readOnly: true,
                                      controller: phoneController,
                                      hintText:
                                          appLocalization(context).phoneNumber,
                                      labelText:
                                          appLocalization(context).phoneNumber,
                                      suffixIcon: Image.asset(
                                        IconConstants.icCallAdd,
                                        scale: 1.5,
                                      ),
                                      prefix: CountryPhoneCodePrefix(
                                        bloc: selectPhoneBloc,
                                      ),
                                      validator: (p0) {
                                        if (p0?.isEmpty ?? true) {
                                          return appLocalization(context)
                                              .pleaseEnterPhone;
                                        }
                                        return null;
                                      },
                                    );
                                  }),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 3 / 100,
                            ),
                            Text(
                              appLocalization(context).pleaseCheckMail,
                              style: const TextStyle(
                                  color: AppColor.constantGreyColor,
                                  fontFamily: AppFont.fontFamily,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 3 / 100,
                            ),
                            AppButton(
                              text: appLocalization(context).continueTxt,
                              onPress: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  forgotBloc.add(ForgetPasswordPhoneEvent(
                                    phone: phoneController.text,
                                    countryCode:
                                        selectedPhoneCodeCountry?.phonecode ??
                                            '',
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
