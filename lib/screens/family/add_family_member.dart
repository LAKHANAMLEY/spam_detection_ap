import 'package:spam_delection_app/lib.dart';

class AddFamilyMember extends StatefulWidget {
  const AddFamilyMember({super.key});

  @override
  State<AddFamilyMember> createState() => _AddFamilyMemberState();
}

class _AddFamilyMemberState extends State<AddFamilyMember> {
  String? enteredPhone;
  SelectionBloc selectImageBloc = SelectionBloc(SelectionBlocInitialState());
  var passwordVisibilityBloc = SelectionBloc(SelectBoolState(true));
  var selectPhoneCodeBloc =
      SelectionBloc(SelectCountryState(AppConstants.selectedCountry));
  CountryData? selectedPhoneCodeCountry;

  double scale = 3.5;

  List<dynamic> countries = [];
  bool isLoading = true;
  String? selectedCountryCode;
  String? selectedCountryName;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController relationController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController supportPinController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  var addMemberBloc = ApiBloc(ApiBlocInitialState());
  final _formKey = GlobalKey<FormState>();

  XFile? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondaryColor,
        appBar: CustomAppBar(title: appLocalization(context).addFamilyMember),
        body: SafeArea(
            child: BlocConsumer(
                bloc: addMemberBloc,
                listener: (context, state) {
                  if (state is FamilyAddMemberState) {
                    if (state.value.statusCode == 200) {
                      Navigator.pop(context);
                    } else {
                      showCustomDialog(context,
                          dialogType: DialogType.success,
                          subTitle: state.value.message.toString());
                    }
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
                        child: SingleChildScrollView(
                          child: Column(children: [
                            BlocConsumer(
                                bloc: selectImageBloc,
                                listener: (context, state) {
                                  if (state is SelectFileState) {
                                    selectedImage = state.value;
                                  }
                                },
                                builder: (context, state) {
                                  return SizedBox(
                                    child: selectedImage == null
                                        ? CircleAvatar(
                                            backgroundColor: AppColor
                                                .vanishColor
                                                .withOpacity(0.2),
                                            radius: 43.0,
                                            backgroundImage: const AssetImage(
                                                IconConstants.icCircleAvatar),
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
                                        : selectedImage?.mimeType == "http"
                                            ? CircleAvatar(
                                                backgroundColor: AppColor
                                                    .vanishColor
                                                    .withOpacity(0.2),
                                                radius: 43.0,
                                                backgroundImage: NetworkImage(
                                                    selectedImage?.path ?? ""),
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
                                                    selectedImage?.path ?? "")),
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
                              controller: firstNameController,
                              labelText: appLocalization(context).firstName,
                              hintText: appLocalization(context).firstName,
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
                            ),
                            10.height(),
                            CustomTextField(
                              controller: lastNameController,
                              labelText: appLocalization(context).lastName,
                              hintText: appLocalization(context).lastName,
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
                            ),
                            10.height(),
                            CustomTextField(
                              controller: emailController,
                              labelText: appLocalization(context).emailAddress,
                              hintText: appLocalization(context).emailAddress,
                              suffix: Image.asset(
                                IconConstants.icFluentMail,
                                scale: scale,
                              ),
                              validator: (p0) {
                                if (p0?.isEmpty ?? true) {
                                  return appLocalization(context)
                                      .pleaseEnterYourEmailAddress;
                                }
                                return null;
                              },
                            ),
                            10.height(),
                            BlocBuilder(
                                bloc: passwordVisibilityBloc,
                                builder: (context, state) {
                                  if (state is SelectBoolState) {
                                    return CustomTextField(
                                      controller: passwordController,
                                      obscureText: state.value,
                                      labelText:
                                          appLocalization(context).password,
                                      hintText:
                                          appLocalization(context).password,
                                      suffix: InkWell(
                                          onTap: () {
                                            passwordVisibilityBloc.add(
                                                SelectBoolEvent(!state.value));
                                          },
                                          child: state.value
                                              ? Image.asset(
                                                  IconConstants.icPassRemove,
                                                  scale: 3,
                                                )
                                              : Image.asset(
                                                  IconConstants.icPassLock,
                                                  scale: 3,
                                                )),
                                      validator: (p0) {
                                        if (p0?.isEmpty ?? true) {
                                          return appLocalization(context)
                                              .pleaseEnterYourPassword;
                                        }
                                        return null;
                                      },
                                    );
                                  }
                                  return const Loader();
                                }),
                            10.height(),
                            CustomTextField(
                              controller: relationController,
                              hintText: appLocalization(context).relation,
                              labelText: appLocalization(context).relation,
                              suffix: Image.asset(
                                IconConstants.icUsername,
                                scale: 1.5,
                              ),
                              validator: (p0) {
                                if (p0?.isEmpty ?? true) {
                                  return appLocalization(context)
                                      .pleaseEnterPosition;
                                }
                                return null;
                              },
                            ),
                            10.height(),
                            CustomTextField(
                              controller: supportPinController,
                              labelText: appLocalization(context).supportPin,
                              hintText: appLocalization(context).supportPin,
                              validator: (p0) {
                                if (p0?.isEmpty ?? true) {
                                  return appLocalization(context)
                                      .pleaseSupportPin;
                                }
                                return null;
                              },
                            ),
                            10.height(),
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
                                    // readOnly: true,
                                    controller: phoneController,
                                    hintText:
                                        appLocalization(context).phoneNumber,
                                    labelText:
                                        appLocalization(context).phoneNumber,
                                    suffix: Image.asset(
                                      IconConstants.icCallAdd,
                                      scale: 1.5,
                                    ),
                                    prefix: CountryPhoneCodePrefix(
                                      bloc: selectPhoneCodeBloc,
                                    ),
                                    validator: (p0) {
                                      if (p0?.isEmpty ?? true) {
                                        return appLocalization(context)
                                            .pleaseEnterPhone;
                                      }
                                      return null;
                                    },
                                  );
                                }),
                            10.height(),
                            AppButton(
                                text: appLocalization(context).addMember,
                                onPress: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    addMemberBloc.add(
                                      FamilyAddMemberEvent(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
                                          firstName:
                                              firstNameController.text.trim(),
                                          lastName:
                                              lastNameController.text.trim(),
                                          relation:
                                              relationController.text.trim(),
                                          supportPin:
                                              supportPinController.text.trim(),
                                          phone: phoneController.text.trim(),
                                          countryCode: selectedPhoneCodeCountry
                                                  ?.phonecode ??
                                              '',
                                          photoFile: selectedImage),
                                    );
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
                })));
  }
}
