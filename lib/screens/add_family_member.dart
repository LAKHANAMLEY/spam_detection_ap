import 'package:spam_delection_app/lib.dart';

class AddFamilyMember extends StatefulWidget {
  const AddFamilyMember({super.key});

  @override
  State<AddFamilyMember> createState() => _AddFamilyMemberState();
}

class _AddFamilyMemberState extends State<AddFamilyMember> {
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
  final TextEditingController relationController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController supportpinController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  var addMemberBloc = ApiBloc(ApiBlocInitialState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondryColor,
        appBar: const CustomAppBar(title: "Add Family Member"),
        body: SafeArea(
            child: BlocConsumer(
                bloc: addMemberBloc,
                listener: (context, state) {
                  if (state is FamilyAddMemberState) {
                    if (state.value.statusCode == 200) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FamilyMemberList()));
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
                    child: SingleChildScrollView(
                      child: Column(children: [
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 2 / 100),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 90 / 100,
                          child: TextFormField(
                            controller: firstnameController,
                            decoration: InputDecoration(
                              hintText: appLocalization(context).userName,
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
                              suffixIcon: GestureDetector(
                                onTap: () {},
                                child: SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child:
                                        Image.asset(IconConstants.icUsername),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 3 / 100,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 90 / 100,
                          child: TextFormField(
                            controller: lastnameController,
                            decoration: InputDecoration(
                              hintText: appLocalization(context).lastName,
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
                              suffixIcon: GestureDetector(
                                onTap: () {},
                                child: SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child:
                                        Image.asset(IconConstants.icUsername),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 3 / 100,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 90 / 100,
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: appLocalization(context).emailAddress,
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
                                  IconConstants.icEmailadd,
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
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 3 / 100,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 90 / 100,
                          child: TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: InputDecoration(
                                hintText: appLocalization(context).password,
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
                                counterText: '',
                                suffixIcon:
                                    Image.asset(IconConstants.icLockadd)),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 3 / 100,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 90 / 100,
                          child: TextFormField(
                            controller: relationController,
                            decoration: InputDecoration(
                              hintText: appLocalization(context).relation,
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
                              /*suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  IconConstants
                                      .icEmailadd, // Adjust the path as necessary
                                  width: MediaQuery.of(context).size.width *
                                      3 /
                                      100,
                                  height: MediaQuery.of(context).size.height *
                                      3 /
                                      100,
                                ),
                              ),

                               */
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 3 / 100,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 90 / 100,
                          child: TextFormField(
                            controller: supportpinController,
                            decoration: InputDecoration(
                              hintText: appLocalization(context).supportPin,
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
                              /*suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  IconConstants
                                      .icEmailadd, // Adjust the path as necessary
                                  width: MediaQuery.of(context).size.width *
                                      3 /
                                      100,
                                  height: MediaQuery.of(context).size.height *
                                      3 /
                                      100,
                                ),
                              ),

                               */
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 3 / 100,
                        ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: IntlPhoneField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              hintText: appLocalization(context).phoneNumber,
                              hintStyle: const TextStyle(
                                  color: AppColor.lightfillColor),
                              //labelText: 'Phone Number',
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
                              // print(phone.completeNumber);
                              // print(phone.countryCode);
                            },
                          ),
                        )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        //device connect kro
                        AppButton(
                            text: "Add Member",
                            onPress: () {
                              /*if (emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty &&
                                firstnameController.text.isNotEmpty &&
                                lastnameController.text.isNotEmpty &&
                                relationController.text.isNotEmpty &&
                                supportpinController.text.isNotEmpty){
                                //phoneController.text.isNotEmpty){
                              // Dispatch the event to add a member

                             */
                              addMemberBloc.add(
                                FamilyAddMemberEvent(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  firstName: firstnameController.text.trim(),
                                  lastName: lastnameController.text.trim(),
                                  relation: relationController.text.trim(),
                                  supportpin: supportpinController.text.trim(),
                                  phone: phoneController.text.trim(),
                                  countrycode: phoneNumber?.countryCode ?? '',
                                ),
                              );
                            } /*else {
                              // Show error message if any field is empty
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please fill in all fields')),
                              );
                            }
                            */

                            ),
                      ]),
                    ),
                  );
                })));
  }
}
