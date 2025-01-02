import 'package:spam_delection_app/lib.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // String? _errorMessage;

  final List<String> _genders = ['Male', 'Female']; // Dropdown options
  String? _selectedGender = 'Male';
  DateTime? selectedDate;
  SelectionBloc selectImageBloc = SelectionBloc(SelectionBlocInitialState());
  double scale = 3.5;

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // final TextEditingController photoController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  final _formKey = GlobalKey<FormState>();

  var selectPhoneCodeBloc = SelectionBloc(SelectionBlocInitialState());

  CountryData? selectedPhoneCodeCountry;

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        debugPrint("Photo taken: ${photo.path}");
      }
    } catch (e) {
      debugPrint("Error taking photo: $e");
    }
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateOfBirthController.text = picked.formatDate();
      });
    }
  }

  @override
  void initState() {
    userBloc.add(GetUserProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondryColor,
        appBar: CustomAppBar(title: appLocalization(context).editProfile),
        body: SafeArea(
          child: BlocConsumer(
              bloc: userBloc,
              listener: (context, state) {
                if (state is GetUserProfileState) {
                  if (state.value.statusCode == 200) {
                    if (state.value.data != null) {
                      updateData(User.fromJson(state.value.data));
                      sharedPrefBloc.add(GetUserDataFromLocalEvent());
                    }
                  } else if (state.value.statusCode ==
                      HTTPStatusCodes.sessionExpired) {
                    sessionExpired(context, state.value.message ?? "");
                  } else {
                    showCustomDialog(context,
                        subTitle: state.value.message,
                        dialogType: DialogType.failed);
                  }
                }
                if (state is UpdateProfileState) {
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
                  userBloc.add(GetUserProfileEvent());
                }
              },
              builder: (context, state) {
                return ModalProgressHUD(
                  progressIndicator: const Loader(),
                  inAsyncCall: state is ApiLoadingState,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BlocConsumer(
                                bloc: selectImageBloc,
                                listener: (context, state) {
                                  if (state is SelectFileState) {
                                    _selectedImage = state.value;
                                  }
                                },
                                builder: (context, state) {
                                  return SizedBox(
                                    child: _selectedImage == null
                                        ? CircleAvatar(
                                            backgroundColor: AppColor
                                                .vanishColor
                                                .withOpacity(0.2),
                                            radius: 43.0,
                                            backgroundImage: const AssetImage(
                                                IconConstants.iccircleAvater),
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: CircleAvatar(
                                                  backgroundColor:
                                                      AppColor.callColor,
                                                  radius: 12.0,
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        showImagePickerDialog(
                                                            context,
                                                            selectImageBloc);
                                                      },
                                                      child: Image.asset(
                                                        IconConstants.icCamera,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            2 /
                                                            100,
                                                      ))),
                                            ),
                                          )
                                        : _selectedImage?.mimeType == "http"
                                            ? CircleAvatar(
                                                backgroundColor: AppColor
                                                    .vanishColor
                                                    .withOpacity(0.2),
                                                radius: 43.0,
                                                backgroundImage: NetworkImage(
                                                    _selectedImage?.path ?? ""),
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: CircleAvatar(
                                                      backgroundColor:
                                                          AppColor.callColor,
                                                      radius: 12.0,
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            showImagePickerDialog(
                                                                context,
                                                                selectImageBloc);
                                                          },
                                                          child: Image.asset(
                                                            IconConstants
                                                                .icCamera,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                2 /
                                                                100,
                                                          ))),
                                                ),
                                              )
                                            : CircleAvatar(
                                                backgroundColor: AppColor
                                                    .vanishColor
                                                    .withOpacity(0.2),
                                                radius: 43.0,
                                                backgroundImage: FileImage(File(
                                                    _selectedImage?.path ??
                                                        "")),
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: CircleAvatar(
                                                      backgroundColor:
                                                          AppColor.callColor,
                                                      radius: 12.0,
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            showImagePickerDialog(
                                                                context,
                                                                selectImageBloc);
                                                          },
                                                          child: Image.asset(
                                                            IconConstants
                                                                .icCamera,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                2 /
                                                                100,
                                                          ))),
                                                ),
                                              ),
                                  );
                                }),
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    2 /
                                    100),
                            CustomTextField(
                              controller: firstnameController,
                              hintText: appLocalization(context).firstName,
                              labelText: appLocalization(context).firstName,
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
                              // decoration: InputDecoration(
                              //   hintText: appLocalization(context).firstName,
                              //   labelText: appLocalization(context).firstName,
                              //   hintStyle: const TextStyle(
                              //       color: AppColor.lightfillColor),
                              //   enabledBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(2),
                              //     borderSide: const BorderSide(
                              //         width: 1.5, color: AppColor.fillColor),
                              //   ),
                              //   focusedBorder: const OutlineInputBorder(
                              //     borderSide: BorderSide(
                              //         color: AppColor.fillColor, width: 1.5),
                              //     borderRadius:
                              //         BorderRadius.all(Radius.circular(2)),
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
                            // SizedBox(
                            //   height:
                            //       MediaQuery.of(context).size.height * 3 / 100,
                            // ),
                            CustomTextField(
                              controller: lastnameController,
                              hintText: appLocalization(context).lastName,
                              labelText: appLocalization(context).lastName,
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
                              // decoration: InputDecoration(
                              //   hintText: appLocalization(context).lastName,
                              //   labelText: appLocalization(context).lastName,
                              //   hintStyle: const TextStyle(
                              //       color: AppColor.lightfillColor),
                              //   enabledBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(2),
                              //     borderSide: const BorderSide(
                              //         width: 1.5, color: AppColor.fillColor),
                              //   ),
                              //   focusedBorder: const OutlineInputBorder(
                              //     borderSide: BorderSide(
                              //         color: AppColor.fillColor, width: 1.5),
                              //     borderRadius:
                              //         BorderRadius.all(Radius.circular(2)),
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
                            CustomTextField(
                              keyboardType: TextInputType.emailAddress,
                              readOnly: true,
                              controller: emailController,
                              hintText: appLocalization(context).email,
                              labelText: appLocalization(context).email,
                              suffix: Image.asset(
                                IconConstants.icalternativeEmail,
                                scale: 1.5,
                              ),
                              validator: (p0) {
                                if (p0?.isEmpty ?? true) {
                                  return appLocalization(context)
                                      .pleaseEnterYourEmailAddress;
                                }
                                return null;
                              },
                            ),
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
                                    suffix: Image.asset(
                                      IconConstants.icPhone,
                                      scale: 1.5,
                                    ),
                                    prefix: CountryPhoneCodePrefix(
                                      bloc: selectPhoneCodeBloc,
                                    ),
                                    // validator: (p0) {
                                    //   if (p0?.isEmpty ?? true) {
                                    //     return appLocalization(context)
                                    //         .pleaseEnterYourMobileNumber;
                                    //   }
                                    //   return null;
                                    // },
                                  );
                                }),
                            // SizedBox(
                            //   height:
                            //       MediaQuery.of(context).size.height * 3 / 100,
                            // ),
                            CustomTextField(
                              readOnly: true,
                              controller: dateOfBirthController,
                              onTap: () {
                                _pickDate(context);
                              },
                              hintText: appLocalization(context).dateOfBirth,
                              labelText: appLocalization(context).dateOfBirth,
                              suffix: Image.asset(
                                IconConstants.icCalenderData,
                                scale: 1.5,
                              ),
                              // validator: (p0) {
                              //   if (p0?.isEmpty ?? true) {
                              //     return appLocalization(context)
                              //         .pleaseEnterYourAddress;
                              //   }
                              //   return null;
                              // },
                              // decoration: InputDecoration(
                              //     hintText:
                              //         appLocalization(context).dateOfBirth,
                              //     labelText:
                              //         appLocalization(context).dateOfBirth,
                              //     hintStyle: const TextStyle(
                              //         color: AppColor.lightfillColor),
                              //     enabledBorder: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(2),
                              //       borderSide: const BorderSide(
                              //           width: 1.5, color: AppColor.fillColor),
                              //     ),
                              //     focusedBorder: const OutlineInputBorder(
                              //       borderSide: BorderSide(
                              //           color: AppColor.fillColor, width: 1.5),
                              //       borderRadius:
                              //           BorderRadius.all(Radius.circular(2)),
                              //     ),
                              //     filled: true,
                              //     fillColor:
                              //         AppColor.fillColor.withOpacity(0.2),
                              /* IconButton(
                            icon: Icon(Icons.calendar_today),
                            color: Colors.red,
                            onPressed: () async{
                            
                              DateTime?  pickeddate=  await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1990),
                                  lastDate: DateTime(2024));
                              if(pickeddate!=null){
                                print('Date selected:${pickeddate.day}-${pickeddate.month}-${pickeddate.year}');
                                setState(() {
                                  _date.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                                });
                              }
                            },
                                                      )
                                                      // */
                              //         suffixIcon: Image.asset(
                              //           IconConstants.icCalenderData,
                              //           scale: 1.5,
                              //         )
                            ),
                            // SizedBox(
                            //   height:
                            //       MediaQuery.of(context).size.height * 3 / 100,
                            // ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: DropdownButtonFormField<String>(
                                value: _selectedGender,
                                items: _genders.map((String option) {
                                  return DropdownMenuItem<String>(
                                    value: option,
                                    child: Text(
                                      option,
                                      style: textTheme(context).bodyMedium,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedGender = newValue!;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: appLocalization(context).gender,
                                  hintStyle: const TextStyle(
                                      color: AppColor.lightfillColor),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                        width: 1.5, color: AppColor.fillColor),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.fillColor, width: 1.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                  ),
                                  filled: true,
                                  fillColor:
                                      AppColor.fillColor.withOpacity(0.2),
                                  /*suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              IconConstants.icEmailadd, // Adjust the path as necessary
                              width: MediaQuery.of(context).size.width * 3 / 100,
                              height: MediaQuery.of(context).size.height * 3 / 100,
                            ),
                          ),
                            */
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   height:
                            //       MediaQuery.of(context).size.height * 3 / 100,
                            // ),
                            BlocConsumer(
                                bloc: selectCountryBloc,
                                listener: (context, state) {
                                  if (state is SelectCountryState) {
                                    countryController.text =
                                        state.value?.name ?? "";
                                    AppConstants.selectedCountry = state.value;
                                  }
                                },
                                builder: (context, state) {
                                  return CustomTextField(
                                    readOnly: true,
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          useSafeArea: true,
                                          builder: (context) =>
                                              const CountryPickerScreen());
                                    },
                                    controller: countryController,
                                    hintText:
                                        appLocalization(context).enterCountry,
                                    labelText: appLocalization(context).country,
                                  );
                                }),
                            CustomTextField(
                              controller: stateController,
                              hintText: appLocalization(context).selectState,
                              labelText: appLocalization(context).selectState,
                              // validator: (p0) {
                              //   if (p0?.isEmpty ?? true) {
                              //     return appLocalization(context)
                              //         .pleaseEnterYourAddress;
                              //   }
                              //   return null;
                              // },
                              // decoration: InputDecoration(
                              //   hintText: appLocalization(context).selectState,
                              //   labelText: appLocalization(context).selectState,
                              //   hintStyle: const TextStyle(
                              //       color: AppColor.lightfillColor),
                              //   enabledBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(2),
                              //     borderSide: const BorderSide(
                              //         width: 1.5, color: AppColor.fillColor),
                              //   ),
                              //   focusedBorder: const OutlineInputBorder(
                              //     borderSide: BorderSide(
                              //         color: AppColor.fillColor, width: 1.5),
                              //     borderRadius:
                              //         BorderRadius.all(Radius.circular(2)),
                              //   ),
                              //   filled: true,
                              //   fillColor: AppColor.fillColor.withOpacity(0.2),
                              // ),
                            ),
                            // SizedBox(
                            //   height:
                            //       MediaQuery.of(context).size.height * 3 / 100,
                            // ),
                            CustomTextField(
                              controller: cityController,
                              hintText: appLocalization(context).city,
                              labelText: appLocalization(context).city,
                              validator: (p0) {
                                if (p0?.isEmpty ?? true) {
                                  return appLocalization(context)
                                      .pleaseEnterYourCity;
                                }
                                return null;
                              },
                              // decoration: InputDecoration(
                              //   hintText: appLocalization(context).city,
                              //   labelText: appLocalization(context).city,
                              //   hintStyle: const TextStyle(
                              //       color: AppColor.lightfillColor),
                              //   enabledBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(2),
                              //     borderSide: const BorderSide(
                              //         width: 1.5, color: AppColor.fillColor),
                              //   ),
                              //   focusedBorder: const OutlineInputBorder(
                              //     borderSide: BorderSide(
                              //         color: AppColor.fillColor, width: 1.5),
                              //     borderRadius:
                              //         BorderRadius.all(Radius.circular(2)),
                              //   ),
                              //   filled: true,
                              //   fillColor: AppColor.fillColor.withOpacity(0.2),
                              /*suffixIcon: GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              height: 10,
                              width: 10,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Image.asset(IconConstants.icUsername),
                              ),
                            ),
                                                      ),
                                                      */
                              // ),
                            ),
                            // SizedBox(
                            //   height:
                            //       MediaQuery.of(context).size.height * 3 / 100,
                            // ),
                            CustomTextField(
                              controller: zipController,
                              hintText: appLocalization(context).zip,
                              labelText: appLocalization(context).zip,
                              // validator: (p0) {
                              //   if (p0?.isEmpty ?? true) {
                              //     return appLocalization(context)
                              //         .pleaseEnterYourAddress;
                              //   }
                              //   return null;
                              // },
                              // decoration: InputDecoration(
                              //   hintText: appLocalization(context).zip,
                              //   labelText: appLocalization(context).zip,
                              //   hintStyle: const TextStyle(
                              //       color: AppColor.lightfillColor),
                              //   enabledBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(2),
                              //     borderSide: const BorderSide(
                              //         width: 1.5, color: AppColor.fillColor),
                              //   ),
                              //   focusedBorder: const OutlineInputBorder(
                              //     borderSide: BorderSide(
                              //         color: AppColor.fillColor, width: 1.5),
                              //     borderRadius:
                              //         BorderRadius.all(Radius.circular(2)),
                              //   ),
                              //   filled: true,
                              //   fillColor: AppColor.fillColor.withOpacity(0.2),
                              /*suffixIcon: GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              height: 10,
                              width: 10,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Image.asset(IconConstants.icUsername),
                              ),
                            ),
                                                      ),
                                                      */
                              // ),
                            ),
                            // SizedBox(
                            //   height:
                            //       MediaQuery.of(context).size.height * 3 / 100,
                            // ),
                            CustomTextField(
                              controller: address1Controller,
                              hintText: appLocalization(context).address1,
                              labelText: appLocalization(context).address1,
                              validator: (p0) {
                                if (p0?.isEmpty ?? true) {
                                  return appLocalization(context)
                                      .pleaseEnterYourAddress;
                                }
                                return null;
                              },
                              //     decoration: InputDecoration(
                              //       hintText: appLocalization(context).address1,
                              //       labelText: appLocalization(context).address1,
                              //       hintStyle: const TextStyle(
                              //           color: AppColor.lightfillColor),
                              //       enabledBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(2),
                              //         borderSide: const BorderSide(
                              //             width: 1.5, color: AppColor.fillColor),
                              //       ),
                              //       focusedBorder: const OutlineInputBorder(
                              //         borderSide: BorderSide(
                              //             color: AppColor.fillColor, width: 1.5),
                              //         borderRadius:
                              //             BorderRadius.all(Radius.circular(2)),
                              //       ),
                              //       filled: true,
                              //       fillColor: AppColor.fillColor.withOpacity(0.2),
                              //       /*suffixIcon: GestureDetector(
                              //   onTap: () {},
                              //   child: SizedBox(
                              //     height: 10,
                              //     width: 10,
                              //     child: Padding(
                              //       padding: const EdgeInsets.symmetric(vertical: 10),
                              //       child: Image.asset(IconConstants.icUsername),
                              //     ),
                              //   ),
                              // ),
                              // */
                              //     ),
                            ),
                            // SizedBox(
                            //   height:
                            //       MediaQuery.of(context).size.height * 3 / 100,
                            // ),
                            CustomTextField(
                              controller: address2Controller,
                              hintText: appLocalization(context).address2,
                              labelText: appLocalization(context).address2,
                              // validator: (p0) {
                              //   if (p0?.isEmpty ?? true) {
                              //     return appLocalization(context)
                              //         .pleaseEnterYourAddress;
                              //   }
                              //   return null;
                              // },
                              // decoration: InputDecoration(
                              //   hintText: appLocalization(context).address2,
                              //   labelText: appLocalization(context).address2,
                              //   hintStyle: const TextStyle(
                              //       color: AppColor.lightfillColor),
                              //   enabledBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(2),
                              //     borderSide: const BorderSide(
                              //         width: 1.5, color: AppColor.fillColor),
                              //   ),
                              //   focusedBorder: const OutlineInputBorder(
                              //     borderSide: BorderSide(
                              //         color: AppColor.fillColor, width: 1.5),
                              //     borderRadius:
                              //         BorderRadius.all(Radius.circular(2)),
                              //   ),
                              //   filled: true,
                              //   fillColor: AppColor.fillColor.withOpacity(0.2),
                              // ),
                            ),
                            // SizedBox(
                            //   height:
                            //       MediaQuery.of(context).size.height * 2 / 100,
                            // ),
                            // if (_errorMessage != null)
                            //   Text(_errorMessage!,
                            //       style: const TextStyle(color: Colors.red)),
                            // SizedBox(
                            //   height:
                            //       MediaQuery.of(context).size.height * 2 / 100,
                            // ),
                            10.height(),
                            AppButton(
                              text: appLocalization(context).submit,
                              onPress: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  userBloc.add(UpdateProfileEvent(
                                      user: User(
                                          firstName: firstnameController.text,
                                          lastName: lastnameController.text,
                                          dob: selectedDate,
                                          gender: _selectedGender,
                                          state: stateController.text,
                                          city: cityController.text,
                                          zip: zipController.text,
                                          address: address1Controller.text,
                                          address2: address2Controller.text,
                                          photo: _selectedImage?.path,
                                          photoFile: _selectedImage,
                                          phone: phoneController.text,
                                          email: emailController.text,
                                          countryId:
                                              AppConstants.selectedCountry?.id,
                                          country: countryController.text,
                                          countryCode: selectedPhoneCodeCountry
                                              ?.phonecode)));
                                }
                              },
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 2 / 100,
                            ),
                          ]),
                    ),
                  ),
                );
              }),
        ));
  }

  void updateData(User user) {
    SharedPref.saveUserData(user);
    _selectedImage = XFile(user.photo ?? "", mimeType: "http");
    firstnameController.text = user.firstName ?? "";
    lastnameController.text = user.lastName ?? "";
    emailController.text = user.email ?? "";
    phoneController.text = user.phone ?? "";
    countryController.text = user.country ?? "";
    AppConstants.selectedCountry = user.countryData;
    selectedPhoneCodeCountry =
        getCountryByNameOrDialCode(dialCode: user.countryCode);
    selectPhoneCodeBloc.add(SelectCountryEvent(selectedPhoneCodeCountry));
    dateOfBirthController.text = user.dob?.formatDate() ?? "";
    stateController.text = user.state ?? "";
    cityController.text = user.city ?? "";
    zipController.text = user.zip ?? "";
    address1Controller.text = user.address ?? "";
    address2Controller.text = user.address2 ?? "";
    _selectedGender =
        (user.gender?.isNotEmpty ?? false) ? user.gender : _selectedGender;
  }
}
