import 'package:spam_delection_app/lib.dart';

class EditFamilyMember extends StatefulWidget {
  final FamilyMember? familyMember;

  const EditFamilyMember({super.key, this.familyMember});

  @override
  State<EditFamilyMember> createState() => _EditFamilyMemberState();
}

class _EditFamilyMemberState extends State<EditFamilyMember> {
  bool agreeToTerms = false;
  String? _errorMessage;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController relationController = TextEditingController();
  final TextEditingController familyidController = TextEditingController();
  final TextEditingController supportpinController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  var familyMemberBloc = ApiBloc(ApiBlocInitialState());

  FamilyMember? familyMember;

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
      var arg = args(context) as EditFamilyMember;
      familyMemberBloc
          .add(GetFamilyMemberDetailEvent(arg.familyMember?.userId ?? ""));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondryColor,
        appBar: const CustomAppBar(title: "Edit Member"),
        body: SafeArea(
          child: BlocConsumer(
              bloc: familyMemberBloc,
              listener: (context, state) {
                if (state is GetFamilyMemberDetailState) {
                  //yaha family member detail get krege
                  if (state.value.statusCode == 200) {
                    if (state.value.familymemberdetails != null) {
                      familyMember = state.value.familymemberdetails;
                      if (familyMember != null) {
                        updateData(familyMember!);
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
                if (state is FamilyEditMemberState) {
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
                  familyMemberBloc.add(
                      GetFamilyMemberDetailEvent(familyMember?.userId ?? ''));
                }
              },
              builder: (context, state) {
                return ModalProgressHUD(
                  progressIndicator: const Loader(),
                  inAsyncCall: state is ApiLoadingState,
                  child: Form(
                    key: _formKey, //isKey k through check krege
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
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
                                // okay sir but test align and suffic icon sab alag dekh rha hai
                                //ab jitne text field h is screen pr sbhi ko cstm me convert kro or valida

                                //error show krne k liye iska use krege
                                //itna sb kuch type krne ki need nhi h custom text field ka use kro
                                // decoration: InputDecoration(
                                //   hintText: 'First name',
                                //
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
                                //         child:
                                //             Image.asset(IconConstants.icUsername),
                                //       ),
                                //     ),
                                //   ),
                                // ),
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
                                hintText: 'Relation',
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
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      familyMemberBloc.add(
                                          FamilyEditMemberEvent(
                                              user: FamilyMember(
                                                  firstName:
                                                      firstnameController.text,
                                                  lastName:
                                                      lastnameController.text,
                                                  relation:
                                                      relationController.text,
                                                  userId:
                                                      familyMember?.userId ??
                                                          "",
                                                  supportPin:
                                                      supportpinController.text,
                                                  photo: _selectedImage?.path,
                                                  photoFile: _selectedImage)));
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

  void updateData(FamilyMember user) {
    familyMember = user;
    _selectedImage = XFile(user.photo ?? "", mimeType: "http");
    firstnameController.text = user.firstName ?? "";
    lastnameController.text = user.lastName ?? "";
    relationController.text = user.relation ?? "";
    supportpinController.text = user.supportPin ?? "";
  }
}
