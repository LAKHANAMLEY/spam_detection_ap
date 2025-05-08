import 'package:spam_delection_app/lib.dart';

class EditContact extends StatefulWidget {
  final ContactData? contactData;

  const EditContact({super.key, this.contactData});

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  double scale = 3.5;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  var selectPhoneCodeBloc =
      SelectionBloc(SelectCountryState(AppConstants.selectedCountry));

  CountryData? selectedPhoneCodeCountry;

  // var editContactBloc = ApiBloc(ApiBlocInitialState());

  ContactData? contactData;
  SelectionBloc selectImageBloc = SelectionBloc(SelectionBlocInitialState());
  SelectionBloc selectNumberTypeBloc =
      SelectionBloc(SelectStringState("Mobile"));

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((s) {
      var arg = args(context) as EditContact;
      contactData = arg.contactData;
      updateData(contactData!);
      // editContactBloc.add(GetContactDetailEvent(arg.contactData?.id ?? ""));
    });
    super.initState();
  }

  final List<String> options = [
    "Mobile",
    "Home",
    "Work",
    "Home fax",
    "Work fax",
    "Other",
  ];
  String selectedType = "Mobile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: CustomAppBar(title: appLocalization(context).editContact),
        body: SafeArea(
          child: BlocConsumer<ContactDBBloc, ContactDBState>(
            // bloc: editContactBloc,
            listener: (context, state) {
              // if (state is GetContactDetailState) {
              //   if (state.value.statusCode == 200) {
              //     if (state.value.contactdetails != null) {
              //       contactData = state.value.contactdetails;
              //       if (contactData != null) {
              //         updateData(contactData!);
              //       }
              //     }
              //   } else if (state.value.statusCode ==
              //       HTTPStatusCodes.sessionExpired) {
              //     sessionExpired(context, state.value.message ?? "");
              //   } else {
              //     showCustomDialog(context,
              //         subTitle: state.value.message,
              //         dialogType: DialogType.failed);
              //   }
              // }
              if (state is ContactUpdated) {
                if (state.value.statusCode == 200) {
                  showCustomDialog(context,
                      subTitle: state.value.message,
                      dialogType: DialogType.success);
                } else if (state.value.statusCode ==
                    HTTPStatusCodes.sessionExpired) {
                  sessionExpired(context, state.value.message ?? "");
                } else {
                  showCustomDialog(context,
                      subTitle: state.value.message,
                      dialogType: DialogType.failed);
                }
                // editContactBloc
                //     .add(GetContactDetailEvent(contactData?.mobileNo ?? ''));
                // contactListBloc.add(GetDeviceContactEvent());
                context.read<ContactDBBloc>().add(LoadDBContacts());
                // context.read<CallLogDBBloc>().add(SyncDBCallLogs());
              }
              if (state is ContactDBError) {
                showCustomDialog(context,
                    subTitle: state.message, dialogType: DialogType.failed);
              }
            },
            builder: (context, state) {
              return ModalProgressHUD(
                progressIndicator: const Loader(),
                inAsyncCall:
                    state is ApiLoadingState || state is ContactDBLoading,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            10.height(),
                            CustomTextField(
                              controller: fullNameController,
                              labelText: appLocalization(context).userName,
                              hintText: appLocalization(context).userName,
                              suffixIcon: Image.asset(
                                IconConstants.icUsername,
                                height: AppConstants.suffixIconHeight,
                                width: AppConstants.suffixIconWidth,
                                // height: MediaQuery.of(context).size.height *
                                //     5 /
                                //     100,
                                // width: MediaQuery.of(context).size.width *
                                //     5 /
                                //     100
                                // scale: 1.5,
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
                              suffixIcon: Image.asset(
                                IconConstants.icFluentMail,
                                scale: 3,
                              ),
                              // validator: (p0) {
                              //   if (p0?.isEmpty ?? true) {
                              //     return appLocalization(context)
                              //         .pleaseEnterYourEmailAddress;
                              //   }
                              //   return null;
                              // },
                            ),
                            10.height(),
                            BlocBuilder(
                                bloc: selectNumberTypeBloc,
                                builder: (context, state) {
                                  if (state is SelectStringState) {
                                    selectedType = state.value ?? "";
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6, right: 6),
                                      child: DropdownButtonFormField<String>(
                                        value: selectedType,
                                        items: options.map((String option) {
                                          return DropdownMenuItem<String>(
                                            value: option,
                                            child: Text(option),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          selectedType = newValue!;
                                          selectNumberTypeBloc
                                              .add(SelectStringEvent(newValue));
                                        },
                                        decoration: InputDecoration(
                                          hintText: appLocalization(context)
                                              .numberType,
                                          hintStyle: const TextStyle(
                                              color: AppColor.decentBrownColor),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                                width: 1.5,
                                                color:
                                                    AppColor.lightBrownColor),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColor.lightBrownColor,
                                                width: 1.5),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                          ),
                                          filled: true,
                                          fillColor: AppColor.lightBrownColor
                                              .withOpacity(0.2),
                                        ),
                                      ),
                                    );
                                  }
                                  return Loader();
                                }),
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
                                    readOnly: true,
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
                                      bloc: selectPhoneCodeBloc,
                                    ),
                                    // validator: (p0) {
                                    //   if (p0?.isEmpty ?? true) {
                                    //     return appLocalization(context)
                                    //         .pleaseEnterPhone;
                                    //   }
                                    //   return null;
                                    // },
                                  );
                                }),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 3 / 100,
                            ),
                            AppButton(
                                text: appLocalization(context).save,
                                onPress: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    // await ContactsController.editDeviceContact(
                                    //   contactId:
                                    //       contactData?.deviceContactId ?? "",
                                    //   name: fullNameController.text,
                                    //   email: emailController.text,
                                    //   numberType: selectedType,
                                    //   phone: phoneController.text,
                                    //   // countryCode:
                                    //   //     selectedPhoneCodeCountry?.phonecode,
                                    // );
                                    context
                                        .read<ContactDBBloc>()
                                        .add(UpdateDBContact(ContactData(
                                          name: fullNameController.text,
                                          email: emailController.text,
                                          numberType: selectedType,
                                          id: contactData?.id ?? "",
                                          mobileNo: phoneController.text,
                                          countryCode: selectedPhoneCodeCountry
                                              ?.phonecode,
                                          // supportPin:
                                          //  supportPinController.text,
                                          //photo: _selectedImage?.path,
                                          //photoFile: _selectedImage
                                        )));
                                  }
                                }),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 2 / 100,
                            ),
                          ]),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }

  void updateData(ContactData user) {
    contactData = user;
    //_selectedImage = XFile(user.photo ?? "", mimeType: "http");
    fullNameController.text = user.name ?? "";
    emailController.text = user.email ?? "";
    phoneController.text = user.mobileNo ?? "";
    selectedType = user.numberType ?? "";
    selectedPhoneCodeCountry =
        getCountryByNameOrDialCode(dialCode: user.countryCode);
  }
}

// import 'package:spam_delection_app/lib.dart';
//
// class EditContact extends StatefulWidget {
//   const EditContact({super.key});
//
//   @override
//   State<EditContact> createState() => _EditContactState();
// }
//
// class _EditContactState extends State<EditContact> {
//   String? enteredPhone;
//   double scale = 3.5;
//
//   List<dynamic> countries = [];
//
//   final TextEditingController phoneController = TextEditingController();
//
//   PhoneNumber? phoneNumber;
//
//   final TextEditingController fullNameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneNumberController = TextEditingController();
//   final TextEditingController _numberController = TextEditingController();
//   var selectPhoneCodeBloc =
//       SelectionBloc(SelectCountryState(AppConstants.selectedCountry));
//   CountryData? selectedPhoneCodeCountry;
//
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   void dispose() {
//     _numberController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final List<String> options = [
//       appLocalization(context).mobile,
//       appLocalization(context).home,
//       appLocalization(context).work,
//       appLocalization(context).homeFax,
//       appLocalization(context).workFax,
//       appLocalization(context).other,
//     ];
//     String selectedType = appLocalization(context).mobile;
//     return Scaffold(
//       backgroundColor: AppColor.secondaryColor,
//       appBar: CustomAppBar(title: appLocalization(context).editContact),
//       //centerTitle: true,
//       body: SafeArea(
//         child: BlocConsumer(
//             bloc: contactListBloc,
//             listener: (context, state) {
//               if (state is AddContactState) {
//                 if (state.value.statusCode == 200) {
//                   showCustomDialog(
//                     context,
//                     dialogType: DialogType.success,
//                     subTitle: state.value.message,
//                   );
//                 } else if (state.value.statusCode ==
//                     HTTPStatusCodes.sessionExpired) {
//                   sessionExpired(context, state.value.message);
//                 } else {
//                   showCustomDialog(context,
//                       dialogType: DialogType.failed,
//                       subTitle: state.value.message.toString());
//                 }
//                 contactListBloc.add(GetContactEvent());
//               }
//             },
//             builder: (context, state) {
//               return ModalProgressHUD(
//                 progressIndicator: const Loader(),
//                 inAsyncCall: state is ApiLoadingState,
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.all(10),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         10.height(),
//                         CustomTextField(
//                           controller: fullNameController,
//                           labelText: appLocalization(context).userName,
//                           hintText: appLocalization(context).userName,
//                           suffix: Image.asset(
//                             IconConstants.icUsername,
//                             scale: 1.5,
//                           ),
//                           validator: (p0) {
//                             if (p0?.isEmpty ?? true) {
//                               return appLocalization(context)
//                                   .pleaseEnterYourFullName;
//                             }
//                             return null;
//                           },
//                         ),
//                         10.height(),
//                         CustomTextField(
//                           keyboardType: TextInputType.emailAddress,
//                           labelText: appLocalization(context).emailAddress,
//                           hintText: appLocalization(context).emailAddress,
//                           controller: emailController,
//                           suffix: Image.asset(
//                             IconConstants.icFluentMail,
//                             scale: 3,
//                           ),
//                           validator: (p0) {
//                             if (p0?.isEmpty ?? true) {
//                               return appLocalization(context)
//                                   .pleaseEnterYourEmailAddress;
//                             }
//                             return null;
//                           },
//                         ),
//                         10.height(),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 1 / 100,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 6, right: 6),
//                           child: DropdownButtonFormField<String>(
//                             value: selectedType,
//                             items: options.map((String option) {
//                               return DropdownMenuItem<String>(
//                                 value: option,
//                                 child: Text(option),
//                               );
//                             }).toList(),
//                             onChanged: (String? newValue) {
//                               setState(() {
//                                 selectedType = newValue!;
//                               });
//                             },
//                             decoration: InputDecoration(
//                               hintText: appLocalization(context).numberType,
//                               hintStyle: const TextStyle(
//                                   color: AppColor.lightFillColor),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(5),
//                                 borderSide: const BorderSide(
//                                     width: 1.5, color: AppColor.fillColor),
//                               ),
//                               focusedBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                     color: AppColor.fillColor, width: 1.5),
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(5)),
//                               ),
//                               filled: true,
//                               fillColor: AppColor.fillColor.withOpacity(0.2),
//                             ),
//                           ),
//                         ),
//                         18.height(),
//                         BlocConsumer(
//                             bloc: selectPhoneCodeBloc,
//                             listener: (context, state) {
//                               if (state is SelectCountryState) {
//                                 selectedPhoneCodeCountry = state.value;
//                               }
//                             },
//                             builder: (context, state) {
//                               return CustomTextField(
//                                 keyboardType: TextInputType.phone,
//                                 readOnly: true,
//                                 controller: phoneNumberController,
//                                 hintText: appLocalization(context).phoneNumber,
//                                 labelText: appLocalization(context).phoneNumber,
//                                 suffix: Image.asset(
//                                   IconConstants.icCallAdd,
//                                   scale: 1.5,
//                                 ),
//                                 prefix: CountryPhoneCodePrefix(
//                                   bloc: selectPhoneCodeBloc,
//                                 ),
//                                 // validator: (p0) {
//                                 //   if (p0?.isEmpty ?? true) {
//                                 //     return appLocalization(context)
//                                 //         .pleaseEnterPhone;
//                                 //   }
//                                 //   return null;
//                                 // },
//                               );
//                             }),
//                         20.height(),
//                         AppButton(
//                           text: appLocalization(context).saveText,
//                           onPress: () {
//                             final email = emailController.text;
//                             final phone = phoneNumberController.text;
//                             final fullName = fullNameController.text;
//                             final numberType = _numberController.text;
//                             final contactId = UniqueKey().toString();
//
//                             if (_formKey.currentState?.validate() ?? false) {
//                               contactListBloc.add(EditContactEvent(
//                                   contact: ContactData(
//                                       id: contactId,
//                                       countryCode:
//                                           phoneNumber?.countryCode ?? "",
//                                       name: fullName,
//                                       numberType: numberType,
//                                       email: email)));
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }),
//       ),
//     );
//   }
// }
