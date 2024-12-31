import 'package:spam_delection_app/lib.dart';

class AddStaffMember extends StatefulWidget {
  const AddStaffMember({super.key});

  @override
  State<AddStaffMember> createState() => _AddStaffMemberState();
}

class _AddStaffMemberState extends State<AddStaffMember> {
  String? enteredPhone;
  SelectionBloc selectImageBloc = SelectionBloc(SelectionBlocInitialState());
  PhoneNumber? phoneNumber;

  double scale = 3.5;

  List<dynamic> countries = [];
  bool isLoading = true;
  String? selectedCountryCode;
  String? selectedCountryName;
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController supportPinController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  XFile? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondryColor,
        appBar: CustomAppBar(title: appLocalization(context).addStaffMember),
        body: SafeArea(
            child: BlocConsumer(
                bloc: staffBloc,
                listener: (context, state) {
                  if (state is StaffAddMemberState) {
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
                                                      showImagePickerDialog(
                                                          context,
                                                          selectImageBloc);
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
                            controller: firstnameController,
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
                            controller: lastnameController,
                            hintText: appLocalization(context).lastName,
                            suffix: Image.asset(
                              IconConstants.icUsername,
                              scale: 1.5,
                              //2x min hona chahiye
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
                            labelText: appLocalization(context).email,
                            hintText: appLocalization(context).email,
                            suffix: Image.asset(
                              IconConstants.icfluentMail,
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
                          CustomTextField(
                            controller: passwordController,
                            labelText: appLocalization(context).password,

                            hintText: appLocalization(context).password,
                            obscureText: true,
                            //suffix: Image.asset(IconConstants.icUsername),
                            validator: (p0) {
                              if (p0?.isEmpty ?? true) {
                                return appLocalization(context)
                                    .pleaseEnterYourPassword;
                              }
                              return null;
                            },
                          ),
                          10.height(),
                          CustomTextField(
                            controller: positionController,
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
                            hintText: appLocalization(context).supportPin,
                            //suffix: Image.asset(IconConstants.icUsername),
                            validator: (p0) {
                              if (p0?.isEmpty ?? true) {
                                return appLocalization(context)
                                    .pleaseSupportPin;
                              }
                              return null;
                            },
                          ),
                          10.height(),
                          Padding(
                            padding: const EdgeInsets.only(left: 6, right: 6),
                            child: IntlPhoneField(
                              controller: phoneNumberController,
                              decoration: InputDecoration(
                                hintText: appLocalization(context).phoneNumber,
                                labelText: appLocalization(context).phoneNumber,
                                hintStyle: const TextStyle(
                                    color: AppColor.lightfillColor),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                      width: 1.5, color: AppColor.fillColor),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.fillColor, width: 1.5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                filled: true,
                                fillColor: AppColor.fillColor.withOpacity(0.2),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    IconConstants.icCalladd,
                                    scale: 1.5,
                                  ),
                                ),
                              ),
                              initialCountryCode: 'IN',
                              onChanged: (phone) {
                                phoneNumber = phone;
                                enteredPhone = phone.completeNumber;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          AppButton(
                              text: appLocalization(context).addStaffMember,
                              onPress: () {
                                staffBloc.add(
                                  StaffAddMemberEvent(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      firstName:
                                          firstnameController.text.trim(),
                                      lastName: lastnameController.text.trim(),
                                      relation: positionController.text.trim(),
                                      supportpin:
                                          supportPinController.text.trim(),
                                      phone: phoneNumberController.text.trim(),
                                      countrycode:
                                          phoneNumber?.countryCode ?? '',
                                      photoFile: selectedImage),
                                );
                              }),
                        ]),
                      ),
                    ),
                  );
                })));
  }
}
