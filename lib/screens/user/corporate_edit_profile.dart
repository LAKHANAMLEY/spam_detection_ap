import 'package:spam_delection_app/lib.dart';

class CorporateProfile extends StatefulWidget {
  final CorporateData? corporateData;

  const CorporateProfile({super.key, this.corporateData});

  @override
  State<CorporateProfile> createState() => _CorporateProfileState();
}

class _CorporateProfileState extends State<CorporateProfile> {
  final _formKey = GlobalKey<FormState>();

  double scale = 3.5;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController crnIdController = TextEditingController();

  XFile? _selectedImage;

  var corporateBloc = ApiBloc(ApiBlocInitialState());
  SelectionBloc selectImageBloc = SelectionBloc(SelectionBlocInitialState());

  CorporateData? corporateData;

  @override
  void initState() {
    corporateBloc.add(GetUserProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar:
            CustomAppBar(title: appLocalization(context).editCorporateProfile),
        body: SafeArea(
          child: BlocConsumer(
              bloc: corporateBloc,
              listener: (context, state) {
                if (state is GetUserProfileState) {
                  if (state.value.statusCode == 200) {
                    if (state.value.data != null) {
                      updateData(CorporateData.fromJson(state.value.data));
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
                                                .whiteCreamColor
                                                .withOpacity(0.2),
                                            radius: 43.0,
                                            backgroundImage: const AssetImage(
                                                IconConstants.icUsername),
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: CircleAvatar(
                                                  backgroundColor:
                                                      AppColor.darkPurpleColor,
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
                                                    .whiteCreamColor
                                                    .withOpacity(0.2),
                                                radius: 43.0,
                                                backgroundImage: NetworkImage(
                                                    _selectedImage?.path ?? ""),
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: CircleAvatar(
                                                      backgroundColor: AppColor
                                                          .darkPurpleColor,
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
                                                    .whiteCreamColor
                                                    .withOpacity(0.2),
                                                radius: 43.0,
                                                backgroundImage: FileImage(File(
                                                    _selectedImage?.path ??
                                                        "")),
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: CircleAvatar(
                                                      backgroundColor: AppColor
                                                          .darkPurpleColor,
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
                              controller: userNameController,
                              hintText: appLocalization(context).corporateName,
                              labelText: appLocalization(context).corporateName,
                              suffix: Image.asset(
                                IconConstants.icUsername,
                                height: AppConstants.suffixIconHeight,
                                width: AppConstants.suffixIconWidth,
                                // height: MediaQuery.of(context).size.height *
                                //     5 /
                                //     100,
                                // width: MediaQuery.of(context).size.width *
                                //     5 /
                                //     100
                                //scale: 1.5,
                              ),
                              validator: (p0) {
                                if (p0?.isEmpty ?? true) {
                                  return appLocalization(context)
                                      .pleaseCorporateName;
                                }
                                return null;
                              },
                            ),
                            10.height(),
                            CustomTextField(
                              controller: companyNameController,
                              hintText: appLocalization(context).companyName,
                              labelText: appLocalization(context).companyName,
                              suffix: Image.asset(
                                IconConstants.icCorporateID,
                                scale: 3,
                              ),
                              validator: (p0) {
                                if (p0?.isEmpty ?? true) {
                                  return appLocalization(context)
                                      .pleaseCompanyName;
                                }
                                return null;
                              },
                            ),
                            10.height(),
                            CustomTextField(
                              controller: crnIdController,
                              hintText: appLocalization(context).crnId,
                              labelText: appLocalization(context).crnId,
                              suffix: Image.asset(
                                IconConstants.icCorporateID,
                                scale: 3,
                              ),
                              validator: (p0) {
                                if (p0?.isEmpty ?? true) {
                                  return appLocalization(context).pleaseCrnId;
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 3 / 100,
                            ),
                            AppButton(
                                text: appLocalization(context).submit,
                                onPress: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    corporateBloc.add(CorporateEditProfileEvent(
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

  void updateData(CorporateData user) {
    corporateData = user;
    _selectedImage = XFile(user.photo ?? "", mimeType: "http");
    userNameController.text = user.uName ?? "";
    companyNameController.text = user.company ?? "";
    crnIdController.text = user.crn ?? "";
  }
}
