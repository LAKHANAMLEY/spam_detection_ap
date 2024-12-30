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

  PhoneNumber? phoneNumber;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

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
      backgroundColor: AppColor.secondryColor,
      appBar: CustomAppBar(title: appLocalization(context).addContact),
      //centerTitle: true,
      body: SafeArea(
        child: BlocConsumer(
            bloc: contactListBloc,
            listener: (context, state) {
              if (state is AddContactState) {
                if (state.value.statusCode == 200) {
                  showCustomDialog(
                    context,
                    dialogType: DialogType.success,
                    subTitle: state.value.message,
                  );
                } else if (state.value.statusCode ==
                    HTTPStatusCodes.sessionExpired) {
                  sessionExpired(context, state.value.message);
                } else {
                  showCustomDialog(context,
                      dialogType: DialogType.failed,
                      subTitle: state.value.message.toString());
                }
                contactListBloc.add(GetContactEvent());
              }
            },
            builder: (context, state) {
              return ModalProgressHUD(
                progressIndicator: const Loader(),
                inAsyncCall: state is ApiLoadingState,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        10.height(),
                        CustomTextField(
                          controller: fullNameController,
                          hintText: appLocalization(context).userName,
                          suffix: Image.asset(
                            IconConstants.icUsername,
                            scale: 1.5,
                          ),
                          validator: (p0) {
                            if (p0?.isEmpty ?? true) {
                              return appLocalization(context)
                                  .pleaseEnterYourFullName;
                            }
                            return null;
                          },
                          // decoration: InputDecoration(
                          //   hintText: appLocalization(context).userName,
                          //   hintStyle: const TextStyle(
                          //       color: AppColor.lightfillColor),
                          //   enabledBorder: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(5),
                          //     borderSide: const BorderSide(
                          //         width: 1.5, color: AppColor.fillColor),
                          //   ),
                          //   focusedBorder: const OutlineInputBorder(
                          //     borderSide: BorderSide(
                          //         color: AppColor.fillColor, width: 1.5),
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(5)),
                          //   ),
                          //   filled: true,
                          //   fillColor: AppColor.fillColor.withOpacity(0.2),
                          //   suffixIcon: GestureDetector(
                          //     onTap: () {},
                          //     child: SizedBox(
                          //       height: 10,
                          //       width: 10,
                          //       child: Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             vertical: 10),
                          //         child: Image.asset(
                          //           IconConstants.icUsername,
                          //           scale: 1.5,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ),
                        10.height(),
                        CustomTextField(
                          keyboardType: TextInputType.emailAddress,
                          hintText: appLocalization(context).emailAddress,
                          controller: emailController,
                          suffix: Image.asset(
                            IconConstants.icfluentMail,
                            scale: 3,
                          ),
                          validator: (p0) {
                            if (p0?.isEmpty ?? true) {
                              return appLocalization(context)
                                  .pleaseEnterYourEmailAddress;
                            }
                            return null;
                          },
                          // decoration: InputDecoration(
                          //   hintText: appLocalization(context).emailAddress,
                          //   hintStyle: const TextStyle(
                          //       color: AppColor.lightfillColor),
                          //   enabledBorder: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(5),
                          //     borderSide: const BorderSide(
                          //         width: 1.5, color: AppColor.fillColor),
                          //   ),
                          //   focusedBorder: const OutlineInputBorder(
                          //     borderSide: BorderSide(
                          //         color: AppColor.fillColor, width: 1.5),
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(5)),
                          //   ),
                          //   filled: true,
                          //   fillColor: AppColor.fillColor.withOpacity(0.2),
                          //   suffixIcon: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: Image.asset(
                          //       IconConstants.icfluentMail,
                          //       scale: 3,
                          //     ),
                          //   ),
                          // ),
                        ),
                        10.height(),
                        DropdownButtonFormField<String>(
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
                                const TextStyle(color: AppColor.lightfillColor),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                  width: 1.5, color: AppColor.fillColor),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColor.fillColor, width: 1.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            filled: true,
                            fillColor: AppColor.fillColor.withOpacity(0.2),
                            /*suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            IconConstants.icEmailAdd,
                          ),
                        ),
                          */
                          ),
                        ),
                        10.height(),
                        IntlPhoneField(
                          controller: phoneNumberController,
                          decoration: InputDecoration(
                            hintText: appLocalization(context).phoneNumber,
                            hintStyle:
                                const TextStyle(color: AppColor.lightfillColor),
                            //labelText: 'Phone Number',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                  width: 1.5, color: AppColor.fillColor),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColor.fillColor, width: 1.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            filled: true,
                            fillColor: AppColor.fillColor.withOpacity(0.2),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                IconConstants.icCallTone,
                                scale: 3,
                              ),
                            ),
                          ),
                          initialCountryCode: 'IN',
                          onChanged: (phone) {
                            phoneNumber = phone;
                            enteredPhone = phone.completeNumber;
                            // print(phone.completeNumber);
                            // print(phone.countryCode);
                          },
                        ),
                        10.height(),
                        AppButton(
                          text: appLocalization(context).addContact,
                          onPress: () {
                            final email = emailController.text;
                            final phone = phoneNumberController.text;
                            final fullName = fullNameController.text;
                            final numberType = _numberController.text;
                            if (_formKey.currentState?.validate() ?? false) {
                              addDeviceContact(
                                name: fullName,
                                phone: phone,
                                email: email,
                                numberType: numberType,
                              );
                              contactListBloc.add(AddContactEvent(
                                  contact: ContactData(
                                      mobileNo: phone,
                                      countryCode:
                                          phoneNumber?.countryCode ?? "",
                                      name: fullName,
                                      numberType: numberType,
                                      email: email)));
                            }

                            // if (email.isNotEmpty &&
                            //     fullName.isNotEmpty &&
                            //     phone.isNotEmpty) {
                            //   setState(() {
                            //     _isLoading = true;
                            //   });
                            //   addContact(
                            //     email: email,
                            //     fullname: fullName,
                            //     phonenumber: phone,
                            //     countrycode: phoneNumber?.countryCode,
                            //     numbertype: numberType,
                            //   ).then((response) {
                            //     setState(() {
                            //       _isLoading = false;
                            //     });
                            //     // class SignUpResponse
                            //     //var response
                            //     if (response.statusCode == 200) {
                            //       Navigator.of(context).push(
                            //           MaterialPageRoute(
                            //               builder: (context) =>
                            //                   const ContactList()));
                            //     } else {
                            //       setState(() {
                            //         _errorMessage =
                            //             response.message.toString();
                            //       });
                            //     }
                            //   });
                            // } else {
                            //   setState(() {
                            //     _errorMessage = appLocalization(context)
                            //         .pleaseEnterFields;
                            //   });
                            // }
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
