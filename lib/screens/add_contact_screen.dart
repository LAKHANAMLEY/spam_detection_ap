import 'package:spam_delection_app/lib.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  bool _isLoading = false;
  String? _errorMessage;
  String? enteredPhone;
  double scale = 3.5;

  List<dynamic> countries = [];

  final TextEditingController phoneController = TextEditingController();

  PhoneNumber? phoneNumber;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  //String _selectedType = appLocalization(context).mobile;

  /*final List<String> _options = [
    appLocalization(context).contactList,
    "Home",
    "Work",
    "Home Fax",
    "Work Fax",
    "Other"
  ];
    
   */

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _options = [
      appLocalization(context).mobile,
      appLocalization(context).home,
      appLocalization(context).work,
      appLocalization(context).homeFax,
      appLocalization(context).workFax,
      appLocalization(context).other,
    ];
    String _selectedType = appLocalization(context).mobile;
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      appBar: CustomAppBar(title: appLocalization(context).addContact),
      //centerTitle: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 90 / 100,
                child: TextFormField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    hintText: appLocalization(context).userName,
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                          width: 1.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.fillColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
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
                          child: Image.asset(
                            IconConstants.icUsername,
                            scale: 1.5,
                          ),
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
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: appLocalization(context).emailAddress,
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                          width: 1.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.fillColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        IconConstants.icfluentMail,
                        scale: 3,
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
                    hintText: appLocalization(context).numberType,
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                          width: 1.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.fillColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    /*suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      IconConstants.icEmailAdd,
                    ),
                  ),
                    */
                  ),
                ),
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: IntlPhoneField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    hintText: appLocalization(context).phoneNumber,
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    //labelText: 'Phone Number',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                          width: 1.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.fillColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        IconConstants.icCallTone,
                        scale: 3,
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
              if (_errorMessage != null)
                Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : AppButton(
                      text: appLocalization(context).addContact,
                      onPress: () {
                        final email = emailController.text;
                        final phone = phoneNumberController.text;
                        final fullName = fullNameController.text;
                        final numberType = _numberController.text;

                        if (email.isNotEmpty &&
                            fullName.isNotEmpty &&
                            phone.isNotEmpty) {
                          setState(() {
                            _isLoading = true;
                          });
                          addContact(
                            email: email,
                            fullname: fullName,
                            phonenumber: phone,
                            countrycode: phoneNumber?.countryCode,
                            numbertype: numberType,
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
                            _errorMessage =
                                appLocalization(context).pleaseEnterFields;
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
