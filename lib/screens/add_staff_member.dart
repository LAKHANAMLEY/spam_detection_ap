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

  var addStaffMemberBloc = ApiBloc(ApiBlocInitialState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondryColor,
        appBar: const CustomAppBar(title: "Add Staff Member"),
        body: SafeArea(
            child: BlocConsumer(
                bloc: addStaffMemberBloc,
                listener: (context, state) {
                  if (state is StaffAddMemberState) {
                    if (state.value.statusCode == 200) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StaffMemberList()));
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
                            controller: emailController,
                            hintText: 'Email',
                            suffix: Image.asset(IconConstants.icUsername),
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
                                return "Please enter postion";
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
                                addStaffMemberBloc.add(
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
                              } /*else {
                                // Show error message if any field is empty
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please fill all fields')),
                                );
                              }
                              */

                              ),
                        ]),
                      ),
                    ),
                  );
                })));
  }
}
