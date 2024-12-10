import 'package:spam_delection_app/lib.dart';

class AddStaffMember extends StatefulWidget {
  const AddStaffMember({super.key});

  @override
  State<AddStaffMember> createState() => _AddStaffMemberState();
}

class _AddStaffMemberState extends State<AddStaffMember> {
  String? enteredPhone;

  PhoneNumber? phoneNumber;

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

  double scale = 3.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondryColor,
        appBar: const CustomAppBar(title: "Add Staff Member"),
        body: SafeArea(
            child: BlocConsumer(
                bloc: staffBloc,
                listener: (context, state) {
                  if (state is StaffAddMemberState) {
                    if (state.value.statusCode == 200) {
                      //back screen pr pop krna h qki new screen ka stack create ho jayega
                      Navigator.pop(context); //yes clear sir
                      //but back screen pr list v update hona chahiye abhi nhi hogi check krte h
                      //abhi update nhi ho rhi list
                      //isliye common bloc use krege ya us bloc ko yha se list event hit krege
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const StaffMemberList()));
                    } else if (state.value.statusCode ==
                        HTTPStatusCodes.sessionExpired) {
                      sessionExpired(context, state.value.message);
                    } else {
                      showCustomDialog(context,
                          dialogType: DialogType.success,
                          subTitle: state.value.message.toString());
                    }
                    //yaha list again get krege
                    staffBloc.add(GetStaffMemberListEvent());
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
                          10.height(),
                          CustomTextField(
                            controller: firstnameController,
                            hintText: 'first name',
                            suffix: Image.asset(IconConstants.icUsername),
                            validator: (p0) {
                              if (p0?.isEmpty ?? true) {
                                return "Please enter fist name";
                              }
                              return null;
                            },
                          ),
                          10.height(),
                          CustomTextField(
                            controller: lastnameController,
                            hintText: 'Last name',
                            suffix: Image.asset(
                              IconConstants.icUsername,
                              scale: 1.5,
                              //2x min hona chahiye
                            ),
                            validator: (p0) {
                              if (p0?.isEmpty ?? true) {
                                return "Please enter last name";
                              }
                              return null;
                            },
                          ),
                          10.height(),
                          CustomTextField(
                            controller: emailController,
                            hintText: 'Email',
                            suffix: Image.asset(
                              IconConstants.icfluentMail,
                              scale: scale,
                            ),
                            validator: (p0) {
                              if (p0?.isEmpty ?? true) {
                                return "Please enter Email";
                              }
                              return null;
                            },
                          ),
                          10.height(),
                          CustomTextField(
                            controller: passwordController,
                            hintText: 'Password',
                            obscureText: true,
                            //suffix: Image.asset(IconConstants.icUsername),
                            validator: (p0) {
                              if (p0?.isEmpty ?? true) {
                                return "Please enter password";
                              }
                              return null;
                            },
                          ),
                          10.height(),
                          CustomTextField(
                            controller: positionController,
                            hintText: 'Position',
                            suffix: Image.asset(IconConstants.icUsername),
                            validator: (p0) {
                              if (p0?.isEmpty ?? true) {
                                return "Please enter position";
                              }
                              return null;
                            },
                          ),
                          10.height(),
                          CustomTextField(
                            controller: supportPinController,
                            hintText: 'Support pin',
                            //suffix: Image.asset(IconConstants.icUsername),
                            validator: (p0) {
                              if (p0?.isEmpty ?? true) {
                                return "Please enter support pin";
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
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    IconConstants.icCalladd,
                                    // Adjust the path as necessary
                                    width: MediaQuery.of(context).size.width *
                                        3 /
                                        100,
                                    height: MediaQuery.of(context).size.height *
                                        3 /
                                        100,
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
                              text: "Add Staff Member",
                              onPress: () {
                                staffBloc.add(
                                  StaffAddMemberEvent(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    firstName: firstnameController.text.trim(),
                                    lastName: lastnameController.text.trim(),
                                    relation: positionController.text.trim(),
                                    supportpin:
                                        supportPinController.text.trim(),
                                    phone: phoneNumberController.text.trim(),
                                    countrycode: phoneNumber?.countryCode ?? '',
                                  ),
                                );
                              }),
                        ]),
                      ),
                    ),
                  );
                })));
  }
}
