import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:spam_delection_app/lib.dart';

class Register extends StatefulWidget {
  final UserCredential? userCredencial;

  const Register({
    super.key,
    this.userCredencial,
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isCheckBoxValue = false;
  bool isApiCalling = false;

  //String? _errorMessage;
  String? enteredPhone;
  double scale = 3.5;

  String? selectedCountryCode;
  String? selectedCountryName;
  final TextEditingController phoneController = TextEditingController();
  var passwordVisibilityBloc = SelectionBloc(SelectBoolState(true));
  final TextEditingController countryController = TextEditingController();
  var selectPhoneNumberBloc =
      SelectionBloc(SelectCountryState(AppConstants.selectedCountry));

  var datePickerBloc = SelectionBloc(DatePickerLoaded(DateTime.now()));

  CountryData? selectedPhoneCodeCountry;

  //selectPhoneCodeBloc.add(SelectCountryEvent(selectedPhoneCodeCountry));

  DateTime? selectedDate;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((d) {
      updateData();
    });
    super.initState();
  }

  //DateTime? selectedDate;

  final _formKey = GlobalKey<FormState>();
  var registerBloc = ApiBloc(ApiBlocInitialState());

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();

  Future<void> _pickDate(BuildContext context, datePickerBloc) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      datePickerBloc.add(DatePicked(picked));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: const CustomAppBar(
          centerTitle: true,
        ),
        body: SafeArea(
            child: BlocConsumer(
                bloc: registerBloc,
                listener: (context, state) {
                  if (state is RegisterState) {
                    if (state.value.statusCode == 200) {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.registerSuccess,
                        arguments: state.value.data,
                      );
                    } else if (state.value.statusCode ==
                        HTTPStatusCodes.sessionExpired) {
                      sessionExpired(context, state.value.message);
                    } else {
                      showCustomDialog(context,
                          dialogType: DialogType.failed,
                          subTitle: state.value.message.toString());
                      // okay working sir
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
                                height: MediaQuery.of(context).size.height *
                                    2 /
                                    100,
                              ),
                              Center(
                                  child: Text(
                                appLocalization(context).register,
                                style: const TextStyle(
                                    color: AppColor.lightPurpleColor,
                                    fontSize: 35,
                                    fontFamily: AppFont.fontFamily,
                                    fontWeight: FontWeight.w600),
                              )),
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    1 /
                                    100,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Center(
                                    child: Text(
                                  appLocalization(context).enjoyMember,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: AppColor.lightPurpleColor,
                                      fontFamily: AppFont.fontFamily,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                )),
                              ),
                              // SizedBox(
                              //     height: MediaQuery.of(context).size.height *
                              //         2 /
                              //         100),
                              10.height(),
                              CustomTextField(
                                controller: firstnameController,
                                labelText: appLocalization(context).firstName,
                                hintText: appLocalization(context).firstName,
                                suffix: Image.asset(
                                  IconConstants.icUsername,
                                  scale: 1.5,
                                ),
                                validator: (p0) {
                                  if (p0?.isEmpty ?? true) {
                                    return appLocalization(context)
                                        .pleaseEnterYourFirstName;
                                  }
                                  return null;
                                },
                              ),
                              10.height(),
                              CustomTextField(
                                controller: lastnameController,
                                labelText: appLocalization(context).lastName,
                                hintText: appLocalization(context).lastName,
                                suffix: Image.asset(
                                  IconConstants.icUsername,
                                  scale: 1.5,
                                ),
                                validator: (p0) {
                                  if (p0?.isEmpty ?? true) {
                                    return appLocalization(context)
                                        .pleaseEnterYourLastName;
                                  }
                                  return null;
                                },
                              ),
                              10.height(),
                              CustomTextField(
                                controller: emailController,
                                labelText:
                                    appLocalization(context).emailAddress,
                                hintText: appLocalization(context).emailAddress,
                                suffix: Image.asset(
                                  IconConstants.icFluentMail,
                                  scale: scale,
                                ),
                                validator: (p0) {
                                  if (p0?.isEmpty ?? true) {
                                    return appLocalization(context)
                                        .pleaseEnterYourEmailAddress;
                                  }
                                  return null;
                                },
                              ),
                              10.height(),
                              BlocConsumer(
                                  bloc: selectPhoneNumberBloc,
                                  listener: (context, state) {
                                    if (state is SelectCountryState) {
                                      selectedPhoneCodeCountry = state.value;
                                    }
                                  },
                                  builder: (context, state) {
                                    return CustomTextField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                            RegExp(r'[/\\]')),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      keyboardType: TextInputType.phone,
                                      //readOnly: true,
                                      controller: phoneController,
                                      hintText:
                                          appLocalization(context).phoneNumber,
                                      labelText:
                                          appLocalization(context).phoneNumber,
                                      suffix: Image.asset(
                                        IconConstants.icCallAdd,
                                        scale: 1.5,
                                      ),
                                      prefix: CountryPhoneCodePrefix(
                                        bloc: selectPhoneNumberBloc,
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
                              10.height(),
                              BlocConsumer(
                                  bloc: datePickerBloc,
                                  listener: (context, state) {
                                    String dateText = 'Select a date';
                                    if (state is DatePickerLoaded) {
                                      dateText = state.value.formatDate();
                                    }
                                    dateOfBirthController.text =
                                        dateText; // Set text in controller
                                  },
                                  builder: (context, state) {
                                    return CustomTextField(
                                      readOnly: true,
                                      controller: dateOfBirthController,
                                      onTap: () {
                                        _pickDate(context, datePickerBloc);
                                      },
                                      hintText:
                                          appLocalization(context).dateOfBirth,
                                      labelText:
                                          appLocalization(context).dateOfBirth,
                                      suffix: Image.asset(
                                        IconConstants.icCalenderData,
                                        scale: 1.5,
                                      ),
                                      validator: (p0) {
                                        if (p0?.isEmpty ?? true) {
                                          return appLocalization(context)
                                              .pleaseSelectDOB;
                                        }
                                        return null;
                                      },
                                    );
                                  }),

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
                                                  SelectBoolEvent(
                                                      !state.value));
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
                              20.height(),
                              AppButton(
                                text: appLocalization(context).register,
                                onPress: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    registerBloc.add(RegisterEvent(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        firstName: firstnameController.text,
                                        lastName: lastnameController.text,
                                        dateOfBirth:
                                            selectedDate?.toIso8601String() ??
                                                "",
                                        phone: phoneController.text,
                                        countryCode: selectedPhoneCodeCountry
                                                ?.phonecode ??
                                            ""));
                                  }
                                },
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    2 /
                                    100,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(appLocalization(context).haveAnAccount,
                                      style: const TextStyle(
                                          fontFamily: AppFont.fontFamily,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.constantWhiteColor)),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          1 /
                                          100),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AppRoutes.login);
                                    },
                                    child: Text(appLocalization(context).login,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: AppColor.themeYellowColor,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    5 /
                                    100,
                              ),
                            ]),
                          ))));
                })));
  }

  void updateData() {
    var arg = args(context) as Register;
    var userCredencial = arg.userCredencial;
    var user = userCredencial?.user;
    firstnameController.text = user?.displayName?.split(" ").first ?? "";
    lastnameController.text = user?.displayName?.split(" ").last ?? "";
    emailController.text = user?.email ?? "";
    phoneController.text = user?.phoneNumber ?? "";
    // phoneController.text = user?.photoURL ?? "";
  }
}
