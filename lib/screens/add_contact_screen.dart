import 'package:spam_delection_app/lib.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  bool isCheckBoxValue = false;
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;
  bool isApiCalling = false;
  bool agreeToTerms = false;

  bool _isLoading = false;
  String? _errorMessage;
  String? enteredPhone;

  List<dynamic> countries = [];
  bool isLoading = true;
  String? selectedCountryCode;
  String? selectedCountryName;
  final TextEditingController phoneController = TextEditingController();

  PhoneNumber? phoneNumber;

  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  String _selectedType = "Home";

  final List<String> _options = [
    "Mobile",
    "Home",
    "Work",
    "Home Fax",
    "Work Fax",
    "Other"
  ];
  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      appBar: AppBar(
        backgroundColor: AppColor.secondryColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                IconConstants.icbackCircle,
              ),
            ),
          ),
        ),
        // ignore: prefer_const_constructors
        title: Text(
          'Add Contact',
          style: const TextStyle(
              color: AppColor.callColor,
              fontFamily: AppFont.fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),

        //centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 90 / 100,
                child: TextFormField(
                  controller: fullnameController,
                  decoration: InputDecoration(
                    hintText: 'Full name',
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: const BorderSide(
                          width: 1.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.fillColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    suffixIcon: GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                        height: 10,
                        width: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Image.asset(IconConstants.icUsername),
                        ),
                      ),
                    ),
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
                  controller: phonenumberController,
                  decoration: InputDecoration(
                    hintText: "Enter Phone Number",
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    //labelText: 'Phone Number',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: const BorderSide(
                          width: 1.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.fillColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        IconConstants.icCalladd, // Adjust the path as necessary
                        width: MediaQuery.of(context).size.width * 3 / 100,
                        height: MediaQuery.of(context).size.height * 3 / 100,
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
                height: MediaQuery.of(context).size.height * 3 / 100,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 90 / 100,
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    //labelText: StringConstants.emailadresstext,
                    //labelStyle: const TextStyle(
                    //   color: AppColor.lightfillColor, fontWeight: FontWeight.w800),
                    hintText: 'Enter your email',
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: const BorderSide(
                          width: 1.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.fillColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        IconConstants
                            .icEmailadd, // Adjust the path as necessary
                        width: MediaQuery.of(context).size.width * 3 / 100,
                        height: MediaQuery.of(context).size.height * 3 / 100,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: DropdownButtonFormField<String>(
                  value: _selectedType,
                  items: _options.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedType = newValue!;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Number Type',
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: const BorderSide(
                          width: 1.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.fillColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    /*suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      IconConstants.icEmailadd, // Adjust the path as necessary
                      width: MediaQuery.of(context).size.width * 3 / 100,
                      height: MediaQuery.of(context).size.height * 3 / 100,
                    ),
                  ),
                    */
                  ),
                ),
              ),
              if (_errorMessage != null)
                Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : AppButton(
                      text: StringConstants.addcontactext,
                      onPress: () {
                        final email = emailController.text;
                        final phone = phonenumberController.text;
                        final fullname = fullnameController.text;
                        final numbertype = _numberController.text;

                        if (email.isNotEmpty && fullname.isNotEmpty) {
                          setState(() {
                            _isLoading = true;
                          });
                          addContact(
                            email: email,
                            fullname: fullname,
                            phonenumber: phone,
                            countrycode: phoneNumber?.countryCode,
                            numbertype: numbertype,
                          ).then((response) {
                            setState(() {
                              _isLoading = false;
                            });
                            // class SignUpResponse
                            //var response
                            if (response.statusCode == 200) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ContactList()));
                            } else {
                              setState(() {
                                _errorMessage = response.message.toString();
                              });
                            }
                          });
                        } else {
                          setState(() {
                            _errorMessage = 'Please enter the all fields.';
                          });
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
