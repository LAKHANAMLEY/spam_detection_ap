import 'package:spam_delection_app/lib.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? _errorMessage;
  String? enteredPhone;

  List<dynamic> countries = [];
  bool isLoading = true;
  String? selectedCountryCode;
  String? selectedCountryName;
  final List<String> _genders = ['Male', 'Female']; // Dropdown options
  String? _selectedGender = 'Male';
  DateTime? selectedDate;

  double scale = 3.5;

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();

  // final TextEditingController photoController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        debugPrint("Photo taken: ${photo.path}");
        // Handle the selected photo (e.g., upload it, save it, or display it)
      }
    } catch (e) {
      debugPrint("Error taking photo: $e");
    }
  }

  Future<void> _chooseFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        debugPrint("Image selected: ${image.path}");
        setState(() {
          _selectedImage = image;
        });
      } else {
        debugPrint("No image selected.");
      }
      // Handle the selected image
    } catch (e) {
      debugPrint("Error selecting image: $e");
    }
  }

  // Future<void> _saveImage(File image) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final path = '${directory.path}/profile_image.png';
  //   final savedImage = await image.copy(path);
  //   print('Image saved to: $path');
  // }

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

  void _showEditOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                appLocalization(context).chooseOption,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16.0),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: Text(appLocalization(context).takePhoto),
                onTap: () {
                  Navigator.pop(context);
                  // Call your camera function here
                  _takePhoto();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.green),
                title: Text(appLocalization(context).chooseGallery),
                onTap: () {
                  Navigator.pop(context);
                  // Call your gallery function here
                  _chooseFromGallery();
                },
              ),
              const SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  appLocalization(context).cancelText,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
    );
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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: SizedBox(
                              child: _selectedImage == null
                                  ? CircleAvatar(
                                      backgroundColor:
                                          AppColor.vanishColor.withOpacity(0.2),
                                      radius: 43.0,
                                      backgroundImage: const AssetImage(
                                          IconConstants.iccircleAvater),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: CircleAvatar(
                                            backgroundColor: AppColor.callColor,
                                            radius: 12.0,
                                            child: GestureDetector(
                                                onTap: () {
                                                  _showEditOptions(context);
                                                },
                                                child: Image.asset(
                                                  IconConstants.icCamera,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      2 /
                                                      100,
                                                ))),
                                      ),
                                    )
                                  : _selectedImage?.mimeType == "http"
                                      ? CircleAvatar(
                                          backgroundColor: AppColor.vanishColor
                                              .withOpacity(0.2),
                                          radius: 43.0,
                                          backgroundImage: NetworkImage(
                                              _selectedImage?.path ?? ""),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: CircleAvatar(
                                                backgroundColor:
                                                    AppColor.callColor,
                                                radius: 12.0,
                                                child: GestureDetector(
                                                    onTap: () {
                                                      _showEditOptions(context);
                                                    },
                                                    child: Image.asset(
                                                      IconConstants.icCamera,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              2 /
                                                              100,
                                                    ))),
                                          ),
                                        )
                                      : CircleAvatar(
                                          backgroundColor: AppColor.vanishColor
                                              .withOpacity(0.2),
                                          radius: 43.0,
                                          backgroundImage: FileImage(
                                              File(_selectedImage?.path ?? "")),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: CircleAvatar(
                                                backgroundColor:
                                                    AppColor.callColor,
                                                radius: 12.0,
                                                child: GestureDetector(
                                                    onTap: () {
                                                      _showEditOptions(context);
                                                    },
                                                    child: Image.asset(
                                                      IconConstants.icCamera,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              2 /
                                                              100,
                                                    ))),
                                          ),
                                        ),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 2 / 100),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 90 / 100,
                            child: TextFormField(
                              controller: firstnameController,
                              decoration: InputDecoration(
                                hintText: appLocalization(context).firstName,
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
                                fillColor: AppColor.fillColor.withOpacity(0.2),
                                suffixIcon: GestureDetector(
                                  onTap: () {},
                                  child: SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 10),
                                      child: Image.asset(
                                        IconConstants.icUsername,
                                        scale: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 3 / 100,
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 90 / 100,
                            child: TextFormField(
                              controller: lastnameController,
                              decoration: InputDecoration(
                                hintText: appLocalization(context).lastName,
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
                                fillColor: AppColor.fillColor.withOpacity(0.2),
                                suffixIcon: GestureDetector(
                                  onTap: () {},
                                  child: SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Image.asset(
                                        IconConstants.icUsername,
                                        scale: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 3 / 100,
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 90 / 100,
                            child: TextFormField(
                              readOnly: true,
                              controller: dateOfBirthController,
                              onTap: () {
                                _pickDate(context);
                              },
                              //ese controller every field me assign karo
                              decoration: InputDecoration(
                                  hintText:
                                      appLocalization(context).dateOfBirth,
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
                          */
                                  suffixIcon:
                                      Image.asset(IconConstants.icDate)),
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 3 / 100,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: DropdownButtonFormField<String>(
                              value: _selectedGender,
                              items: _genders.map((String option) {
                                return DropdownMenuItem<String>(
                                  value: option,
                                  child: Text(option),
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
                                fillColor: AppColor.fillColor.withOpacity(0.2),
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
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 3 / 100,
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 90 / 100,
                            child: TextFormField(
                              controller: stateController,
                              decoration: InputDecoration(
                                //  labelText: StringConstants.usertext,
                                //  labelStyle: const TextStyle(
                                //     color: AppColor.lightfillColor, fontWeight: FontWeight.w500),
                                hintText: appLocalization(context).selectState,
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
                                fillColor: AppColor.fillColor.withOpacity(0.2),
                              ),
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 3 / 100,
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 90 / 100,
                            child: TextFormField(
                              controller: cityController,
                              decoration: InputDecoration(
                                hintText: appLocalization(context).city,
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
                                fillColor: AppColor.fillColor.withOpacity(0.2),
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
                              ),
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 3 / 100,
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 90 / 100,
                            child: TextFormField(
                              controller: zipController,
                              decoration: InputDecoration(
                                hintText: appLocalization(context).zip,
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
                                fillColor: AppColor.fillColor.withOpacity(0.2),
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
                              ),
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 3 / 100,
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 90 / 100,
                            child: TextFormField(
                              controller: address1Controller,
                              decoration: InputDecoration(
                                hintText: appLocalization(context).address1,
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
                                fillColor: AppColor.fillColor.withOpacity(0.2),
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
                              ),
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 3 / 100,
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 90 / 100,
                            child: TextFormField(
                              controller: address2Controller,
                              decoration: InputDecoration(
                                hintText: appLocalization(context).address2,
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
                                fillColor: AppColor.fillColor.withOpacity(0.2),
                              ),
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 3 / 100,
                          ),
                          if (_errorMessage != null)
                            Text(_errorMessage!,
                                style: const TextStyle(color: Colors.red)),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 2 / 100,
                          ),
                          AppButton(
                            text: appLocalization(context).submit,
                            onPress: () {
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
                                      photoFile: _selectedImage)));

                              // if (firstname.isNotEmpty &&
                              //     lastname.isNotEmpty) {
                              //   setState(() {
                              //     _isLoading = true;
                              //   });
                              //   editProfile(
                              //           user: User(
                              //               firstName: firstname,
                              //               lastName: lastname,
                              //               dob: selectedDate,
                              //               gender: gender,
                              //               state: state,
                              //               city: city,
                              //               zip: zip,
                              //               address: addressfirst,
                              //               address2: addressecond,
                              //               photo: _selectedImage?.path,
                              //               photoFile: _selectedImage))
                              //       .then((response) {
                              //     setState(() {
                              //       _isLoading = false;
                              //     });
                              //     if (response.statusCode == 200) {
                              //       Navigator.of(context).push(
                              //           MaterialPageRoute(
                              //               builder: (context) =>
                              //                   const Profile()));
                              //     } else {
                              //       setState(() {
                              //         _errorMessage =
                              //             response.message.toString();
                              //       });
                              //     }
                              //   });
                              // } else {
                              //   setState(() {
                              //     _errorMessage =
                              //         'Please enter the all fields.';
                              //   });
                              // }
                            },
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 2 / 100,
                          ),
                        ]),
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
