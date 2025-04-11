import 'package:spam_delection_app/lib.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  String? enteredPhone;
  double scale = 3.5;

  List<dynamic> countries = [];

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  var selectPhoneCodeBloc =
  SelectionBloc(SelectCountryState(AppConstants.selectedCountry));
  CountryData? selectedPhoneCodeCountry;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> options = [
      appLocalization(context).mobile,
      appLocalization(context).home,
      appLocalization(context).work,
      appLocalization(context).homeFax,
      appLocalization(context).workFax,
      appLocalization(context).other,
    ];
    String selectedType = appLocalization(context).mobile;
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar(title: appLocalization(context).addContact),
      body: SafeArea(
        child: Builder(
          // bloc: contactListBloc,
          // listener: (context, state) {
          //   if (state is AddContactState) {
          //     if (state.value.statusCode == 200) {
          //       showCustomDialog(
          //         context,
          //         dialogType: DialogType.success,
          //         subTitle: state.value.message,
          //       );
          //     } else if (state.value.statusCode ==
          //         HTTPStatusCodes.sessionExpired) {
          //       sessionExpired(context, state.value.message);
          //     } else {
          //       showCustomDialog(context,
          //           dialogType: DialogType.failed,
          //           subTitle: state.value.message.toString());
          //     }
          //     contactListBloc.add(GetContactEvent());
          //   }
          // },
            builder: (context) {
              return ModalProgressHUD(
                progressIndicator: const Loader(),
                inAsyncCall: false, //state is ApiLoadingState,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        10.height(),
                        CustomTextField(
                          controller: fullNameController,
                          labelText: appLocalization(context).userName,
                          hintText: appLocalization(context).userName,
                          suffix: Image.asset(IconConstants.icUsername,
                            height: AppConstants.suffixIconHeight,
                            width: AppConstants.suffixIconWidth,
                            // height: MediaQuery.of(context).size.height * 5 / 100,
                            // width: MediaQuery.of(context).size.width * 5 / 100
                            //scale: 1.5,
                          ),
                          validator: (p0) {
                            if (p0?.isEmpty ?? true) {
                              return appLocalization(context)
                                  .pleaseEnterYourFullName;
                            }
                            return null;
                          },
                        ),
                        10.height(),
                        CustomTextField(
                          keyboardType: TextInputType.emailAddress,
                          labelText: appLocalization(context).emailAddress,
                          hintText: appLocalization(context).emailAddress,
                          controller: emailController,
                          suffix: Image.asset(
                            IconConstants.icFluentMail,
                            scale: 3,
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
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 1 / 100,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6, right: 6),
                          child: DropdownButtonFormField<String>(
                            value: selectedType,
                            items: options.map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedType = newValue!;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: appLocalization(context).numberType,
                              hintStyle:
                              const TextStyle(color: AppColor.decentBrownColor),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                    width: 1.5,
                                    color: AppColor.lightBrownColor),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.lightBrownColor,
                                    width: 1.5),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5)),
                              ),
                              filled: true,
                              fillColor: AppColor.lightBrownColor.withOpacity(
                                  0.2),
                            ),
                          ),
                        ),
                        18.height(),
                        BlocConsumer(
                            bloc: selectPhoneCodeBloc,
                            listener: (context, state) {
                              if (state is SelectCountryState) {
                                selectedPhoneCodeCountry = state.value;
                              }
                            },
                            builder: (context, state) {
                              return CustomTextField(
                                keyboardType: TextInputType.phone,
                                //readOnly: true,
                                controller: phoneNumberController,
                                hintText: appLocalization(context).phoneNumber,
                                labelText: appLocalization(context).phoneNumber,
                                suffix: Image.asset(
                                  IconConstants.icCallAdd,
                                  scale: 1.5,
                                ),
                                prefix: CountryPhoneCodePrefix(
                                  bloc: selectPhoneCodeBloc,
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
                        20.height(),
                        AppButton(
                          text: appLocalization(context).addContact,
                          onPress: () async {
                            final email = emailController.text;
                            final phone = phoneNumberController.text;
                            final fullName = fullNameController.text;
                            final numberType = _numberController.text;
                            if (_formKey.currentState?.validate() ?? false) {
                              await addDeviceContact(
                                name: fullName,
                                phone: phone,
                                email: email,
                                numberType: numberType,
                              );
                              context.read<ContactDBBloc>().add(
                                  SyncDBContacts());
                              // contactListBloc.add(AddContactEvent(
                              //     contact: ContactData(
                              //         mobileNo: phone,
                              //         countryCode:
                              //             selectedPhoneCodeCountry?.phonecode ?? "",
                              //         name: fullName,
                              //         numberType: numberType,
                              //         email: email)));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
