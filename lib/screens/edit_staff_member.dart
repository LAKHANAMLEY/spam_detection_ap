import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/screens/widgets/show_image_picker_dialog.dart';

class EditStaffMember extends StatefulWidget {
  final StaffMember? staffMember;

  const EditStaffMember({super.key, this.staffMember});

  @override
  State<EditStaffMember> createState() => _EditStaffMemberState();
}

class _EditStaffMemberState extends State<EditStaffMember> {
  String? _errorMessage;
  File? _savedImage;
  double scale = 3.5;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController relationController = TextEditingController();
  final TextEditingController supportPinController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  var staffMemberBloc = ApiBloc(ApiBlocInitialState());

  StaffMember? staffMember;
  SelectionBloc selectImageBloc = SelectionBloc(SelectionBlocInitialState());

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
        appBar: CustomAppBar(title: appLocalization(context).editStaffMember),
        body: SafeArea(
          child: BlocConsumer(
              bloc: staffMemberBloc,
              listener: (context, state) {
                if (state is GetStaffMemberDetailState) {
                  if (state.value.statusCode == 200) {
                    if (state.value.staffmemberdetails != null) {
                      staffMember = state.value.staffmemberdetails;
                      if (staffMember != null) {
                        updateData(staffMember!);
                      }
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
                  staffMemberBloc.add(
                      GetStaffMemberDetailEvent(staffMember?.userId ?? ''));
                  staffBloc.add(GetStaffMemberListEvent());
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
                                hintText: appLocalization(context).firstName,
                                suffix: Image.asset(
                                  IconConstants.icUsername,
                                  scale: 1.5,
                                ),
                                validator: (p0) {
                                  if (p0?.isEmpty ?? true) {
                                    return appLocalization(context)
                                        .pleaseFirstName;
                                  }
                                  return null;
                                },
                              ),
                              10.height(),
                              CustomTextField(
                                controller: lastnameController,
                                hintText: appLocalization(context).lastName,
                                suffix: Image.asset(
                                  IconConstants.icUsername,
                                  scale: 1.5,
                                ),
                                validator: (p0) {
                                  if (p0?.isEmpty ?? true) {
                                    return appLocalization(context)
                                        .pleaseLastName;
                                  }
                                  return null;
                                },
                              ),
                              10.height(),
                              CustomTextField(
                                controller: relationController,
                                hintText: appLocalization(context).position,
                                suffix: Image.asset(
                                  IconConstants.icUsername,
                                  scale: 1.5,
                                ),
                                validator: (p0) {
                                  if (p0?.isEmpty ?? true) {
                                    return appLocalization(context)
                                        .pleaseRelation;
                                  }
                                  return null;
                                },
                              ),
                              10.height(),
                              CustomTextField(
                                controller: supportPinController,
                                hintText: appLocalization(context).supportPin,
                                // suffix: Image.asset(IconConstants.icUsername),
                                validator: (p0) {
                                  if (p0?.isEmpty ?? true) {
                                    return appLocalization(context)
                                        .pleaseSupportPin;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    3 /
                                    100,
                              ),
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
                                      staffMemberBloc.add(StaffEditMemberEvent(
                                          user: StaffMember(
                                        firstName: firstnameController.text,
                                        lastName: lastnameController.text,
                                        relation: relationController.text,
                                        userId: staffMember?.userId ?? "",
                                        supportPin: supportPinController.text,
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

  void updateData(StaffMember user) {
    staffMember = user;
    _selectedImage = XFile(user.photo ?? "", mimeType: "http");
    firstnameController.text = user.firstName ?? "";
    lastnameController.text = user.lastName ?? "";
    relationController.text = user.relation ?? "";
    supportPinController.text = user.supportPin ?? "";
  }
}
