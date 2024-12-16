import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/screens/widgets/show_image_picker_dialog.dart';

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

  SelectionBloc selectImageBloc = SelectionBloc(SelectionBlocInitialState());

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
                                          : _selectedImage?.mimeType == "http"
                                              ? CircleAvatar(
                                                  backgroundColor: AppColor
                                                      .vanishColor
                                                      .withOpacity(0.2),
                                                  radius: 43.0,
                                                  backgroundImage: NetworkImage(
                                                      _selectedImage?.path ??
                                                          ""),
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
                                                  backgroundImage: FileImage(
                                                      File(_selectedImage
                                                              ?.path ??
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
