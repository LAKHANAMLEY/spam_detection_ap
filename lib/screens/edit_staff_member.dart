import 'package:spam_delection_app/lib.dart';

class EditStaffMember extends StatefulWidget {
  final StaffMember? staffMember;

  const EditStaffMember({super.key, this.staffMember});

  @override
  State<EditStaffMember> createState() => _EditStaffMemberState();
}

class _EditStaffMemberState extends State<EditStaffMember> {
  String? _errorMessage;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController relationController = TextEditingController();
  final TextEditingController familyidController = TextEditingController();
  final TextEditingController supportpinController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  var staffMemberBloc = ApiBloc(ApiBlocInitialState());

  StaffMember? staffMember;

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
                'Choose an option',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16.0),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  // Call your camera function here
                  _takePhoto();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.green),
                title: const Text('Choose from Gallery'),
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
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
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
    WidgetsBinding.instance.addPostFrameCallback((s) {
      var arg = args(context) as EditStaffMember;
      staffMemberBloc
          .add(GetStaffMemberDetailEvent(arg.staffMember?.userId ?? ""));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondryColor,
        appBar: const CustomAppBar(title: "Edit Staff Member"),
        body: SafeArea(
          child: BlocConsumer(
              bloc: staffMemberBloc,
              listener: (context, state) {
                if (state is GetStaffMemberDetailState) {
                  //yaha family member detail get krege
                  if (state.value.statusCode == 200) {
                    if (state.value.staffmemberdetails != null) {
                      staffMember = state.value.staffmemberdetails;
                      if (staffMember != null) {
                        updateData(staffMember!);
                      }
                      // sharedPrefBloc.add(GetUserDataFromLocalEvent());//ye shared pref se get kia h isko v comment krege
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
                if (state is StaffEditMemberState) {
                  //yha jb response milega jb aap edit family member api hit kroge
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
                  //yaha jese hi member edit hota h uski detail again get krege
                  staffMemberBloc.add(
                      GetStaffMemberDetailEvent(staffMember?.userId ?? ''));
                }
              },
              builder: (context, state) {
                return ModalProgressHUD(
                  progressIndicator: const Loader(),
                  inAsyncCall: state is ApiLoadingState,
                  child: Form(
                    key: _formKey, //isKey k through check krege
                    child: SingleChildScrollView(
                      //ye parent widget h yha padding ka use kroge to sabhi me padding aa jayegi

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //or ye center all place pr q use krte ho
                              SizedBox(
                                child: _selectedImage == null
                                    ? CircleAvatar(
                                        backgroundColor: AppColor.vanishColor
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
                                    : _selectedImage?.mimeType == "http"
                                        ? CircleAvatar(
                                            backgroundColor: AppColor
                                                .vanishColor
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
                                                        _showEditOptions(
                                                            context);
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
                                        : CircleAvatar(
                                            backgroundColor: AppColor
                                                .vanishColor
                                                .withOpacity(0.2),
                                            radius: 43.0,
                                            backgroundImage: FileImage(File(
                                                _selectedImage?.path ?? "")),
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: CircleAvatar(
                                                  backgroundColor:
                                                      AppColor.callColor,
                                                  radius: 12.0,
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        _showEditOptions(
                                                            context);
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
                                          ),
                              ),
                              10.height(),
                              CustomTextField(
                                controller: firstnameController,
                                hintText: 'First name',
                                suffix: Image.asset(IconConstants.icUsername),
                                validator: (p0) {
                                  if (p0?.isEmpty ?? true) {
                                    return "Please enter first name";
                                  }
                                  return null;
                                },
                              ),
                              10.height(),
                              CustomTextField(
                                controller: lastnameController,
                                hintText: 'Last name',
                                suffix: Image.asset(IconConstants.icUsername),
                                validator: (p0) {
                                  if (p0?.isEmpty ?? true) {
                                    return "Please enter last name";
                                  }
                                  return null;
                                },
                              ),
                              10.height(),
                              CustomTextField(
                                controller: relationController,
                                hintText: 'Position',
                                suffix: Image.asset(IconConstants.icUsername),
                                validator: (p0) {
                                  if (p0?.isEmpty ?? true) {
                                    return "Please enter relation";
                                  }
                                  return null;
                                },
                              ),

                              10.height(),
                              CustomTextField(
                                controller: familyidController,
                                hintText: 'Staff Id',
                                //suffix: Image.asset(IconConstants.icUsername),
                                validator: (p0) {
                                  if (p0?.isEmpty ?? true) {
                                    return "Please enter family ID";
                                  }
                                  return null;
                                },
                              ),
                              10.height(),
                              CustomTextField(
                                controller: supportpinController,
                                hintText: 'Support pin',
                                // suffix: Image.asset(IconConstants.icUsername),
                                validator: (p0) {
                                  if (p0?.isEmpty ?? true) {
                                    return "Please enter support pin";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    3 /
                                    100,
                              ),
                              //ye error message yha use nhi kroge ab me batata hu kese krna h
                              //sabhi place pr vese hi krege
                              //phle check kr lo ye work kr rha h ya nhi
                              //ab error message show krte h
                              //validations ka use krege
                              if (_errorMessage != null)
                                Text(_errorMessage!,
                                    style: const TextStyle(color: Colors.red)),
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    2 /
                                    100,
                              ),
                              AppButton(
                                  text: appLocalization(context).submit,
                                  onPress: () {
                                    //mene only first name me add kia h aap baki kr lena
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      staffMemberBloc.add(StaffEditMemberEvent(
                                          user: StaffMember(
                                        firstName: firstnameController.text,
                                        lastName: lastnameController.text,
                                        relation: relationController.text,
                                        userId: staffMember?.userId ?? "",
                                        supportPin: supportpinController.text,
                                        photo: _selectedImage?.path,
                                      )));
                                    }
                                  }),
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    2 /
                                    100,
                              ),
                            ]),
                      ),
                    ),
                  ),
                );
              }),
        ));
  }

  void updateData(StaffMember user) {
    staffMember = user;
    // SharedPrefer.saveUserData(user);// ye shared pref me save kia h data to isko remove krege
    _selectedImage = XFile(user.photo ?? "", mimeType: "http");
    firstnameController.text = user.firstName ?? "";
    lastnameController.text = user.lastName ?? "";
    relationController.text = user.relation ?? "";
    supportpinController.text = user.supportPin ?? "";
  }
}
