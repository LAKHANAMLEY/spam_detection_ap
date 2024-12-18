import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/models/corporate_edit_profile_model.dart';

class CorporateProfile extends StatefulWidget {
  final CorporateData? corporateData;

  const CorporateProfile({super.key, this.corporateData});

  @override
  State<CorporateProfile> createState() => _CorporateProfileState();
}

class _CorporateProfileState extends State<CorporateProfile> {
  String? _errorMessage;
  File? _savedImage;

  final _formKey = GlobalKey<FormState>();

  double scale = 3.5;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController crnIdController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  var corporateBloc = ApiBloc(ApiBlocInitialState());

  CorporateData? corporateData;

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
    corporateBloc.add(GetUserProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondryColor,
        appBar: const CustomAppBar(title: "Edit Corporate Profile"),
        body: SafeArea(
          child: BlocConsumer(
              bloc: corporateBloc,
              listener: (context, state) {
                if (state is GetUserProfileState) {
                  if (state.value.statusCode == 200) {
                    if (state.value.data != null) {
                      updateData(CorporateData.fromJson(state.value.data));
                      //sharedPrefBloc.add(GetUserDataFromLocalEvent());
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
                if (state is CorporateEditProfileState) {
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
                  child: Form(
                    key: _formKey,
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
                                controller: userNameController,
                                hintText: 'Corporate Name',
                                suffix: Image.asset(
                                  IconConstants.icUsername,
                                  scale: 1.5,
                                ),
                                validator: (p0) {
                                  if (p0?.isEmpty ?? true) {
                                    return "Please enter corporate name";
                                  }
                                  return null;
                                },
                              ),
                              10.height(),
                              CustomTextField(
                                controller: companyNameController,
                                hintText: 'Company name',
                                suffix: Image.asset(
                                  IconConstants.icCorporateID,
                                  scale: 3,
                                ),
                                validator: (p0) {
                                  if (p0?.isEmpty ?? true) {
                                    return "Please enter company name";
                                  }
                                  return null;
                                },
                              ),
                              10.height(),
                              CustomTextField(
                                controller: crnIdController,
                                hintText: 'Crn ID',
                                suffix: Image.asset(
                                  IconConstants.icCorporateID,
                                  scale: 3,
                                ),
                                validator: (p0) {
                                  if (p0?.isEmpty ?? true) {
                                    return "Please enter crn ID";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    3 /
                                    100,
                              ),
                              AppButton(
                                  text: appLocalization(context).submit,
                                  onPress: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      corporateBloc
                                          .add(CorporateEditProfileEvent(
                                              user: CorporateData(
                                        uName: userNameController.text,
                                        company: companyNameController.text,
                                        crn: crnIdController.text,
                                        photo: _selectedImage?.path,
                                        photoFile: _selectedImage,
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

  void updateData(CorporateData user) {
    corporateData = user;
    _selectedImage = XFile(user.photo ?? "", mimeType: "http");
    userNameController.text = user.uName ?? "";
    companyNameController.text = user.company ?? "";
    crnIdController.text = user.crn ?? "";
  }
}
