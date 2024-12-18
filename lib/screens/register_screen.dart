import 'package:spam_delection_app/lib.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isCheckBoxValue = false;
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;
  bool isApiCalling = false;
  bool agreeToTerms = false;

  bool _isLoading = false;
  String? _errorMessage;
  String? enteredPhone;
  double scale = 3.5;

  List<dynamic> countries = [];
  bool isLoading = true;
  String? selectedCountryCode;
  String? selectedCountryName;
  final TextEditingController phoneController = TextEditingController();

  PhoneNumber? phoneNumber;

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    try {
      final countryData = await CountriesResponse.fetchCountriesResponse();
      setState(() {
        countries = countryData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error loading country data: $e');
    }
  }

  DateTime? selectedDate;

  get pickeddate => null;

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateOfBirthController.text = picked.toString().split(".").first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondryColor,
        appBar: const CustomAppBar(
          // backgroundColor: AppColor.secondryColor,
          // leading: GestureDetector(
          //   onTap: () {},
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 10),
          //     child: Image.asset(
          //       IconConstants.backIcon,
          //     ),
          //   ),
          // ),
          // title: Image.asset(
          //   IconConstants.icBroadlogo,
          //   height: MediaQuery.of(context).size.height * 38 / 100,
          //   width: MediaQuery.of(context).size.width * 38 / 100,
          // ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 100,
          ),
          Center(
              child: Text(
            appLocalization(context).register,
            style: const TextStyle(
                color: AppColor.bluelightColor,
                fontSize: 35,
                fontFamily: AppFont.fontFamily,
                fontWeight: FontWeight.w600),
          )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 100,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
                child: Text(
              appLocalization(context).enjoyMember,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColor.bluelightColor,
                  fontFamily: AppFont.fontFamily,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            )),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 90 / 100,
            child: TextFormField(
              controller: firstnameController,
              decoration: InputDecoration(
                hintText: appLocalization(context).firstName,
                hintStyle: const TextStyle(color: AppColor.lightfillColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide:
                      const BorderSide(width: 1.5, color: AppColor.fillColor),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.fillColor, width: 1.5),
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
              controller: lastnameController,
              decoration: InputDecoration(
                hintText: appLocalization(context).lastName,
                hintStyle: const TextStyle(color: AppColor.lightfillColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide:
                      const BorderSide(width: 1.5, color: AppColor.fillColor),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.fillColor, width: 1.5),
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
              controller: emailController,
              decoration: InputDecoration(
                hintText: appLocalization(context).emailAddress,
                hintStyle: const TextStyle(color: AppColor.lightfillColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide:
                      const BorderSide(width: 1.5, color: AppColor.fillColor),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.fillColor, width: 1.5),
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
                filled: true,
                fillColor: AppColor.fillColor.withOpacity(0.2),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    IconConstants.icEmailadd,
                    scale: 1.5,
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
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: appLocalization(context).phoneNumber,
                hintStyle: const TextStyle(color: AppColor.lightfillColor),
                //labelText: 'Phone Number',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide:
                      const BorderSide(width: 1.5, color: AppColor.fillColor),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.fillColor, width: 1.5),
                  borderRadius: BorderRadius.all(Radius.circular(2)),
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
                // print(phone.completeNumber);
                // print(phone.countryCode);
              },
            ),
          )),
          SizedBox(height: MediaQuery.of(context).size.height * 1 / 100),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 90 / 100,
            child: TextFormField(
              readOnly: true,
              controller: dateOfBirthController,
              decoration: InputDecoration(
                  hintText: appLocalization(context).dateOfBirth,
                  hintStyle: const TextStyle(color: AppColor.lightfillColor),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide:
                        const BorderSide(width: 1.5, color: AppColor.fillColor),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColor.fillColor, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                  filled: true,
                  fillColor: AppColor.fillColor.withOpacity(0.2),
                  /* IconButton(
                      icon: Icon(Icons.calendar_today),
                      color: Colors.red,
                      onPressed: () async{

                        DateTime?  pickeddate=  await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1990),
                            lastDate: DateTime(2024));
                        if(pickeddate!=null){
                          print('Date selected:${pickeddate.day}-${pickeddate.month}-${pickeddate.year}');
                          setState(() {
                            _date.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                          });
                        }
                      },
                    )
                    */
                  suffixIcon: GestureDetector(
                      onTap: () async {
                        _pickDate(context);
                      },
                      child: Image.asset(
                        IconConstants.icCalenderData,
                        scale: 1.5,
                      ))),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 3 / 100,
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 90 / 100,
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: appLocalization(context).password,
                hintStyle: const TextStyle(color: AppColor.lightfillColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide:
                      const BorderSide(width: 1.5, color: AppColor.fillColor),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffE1E6EB), width: 1.5),
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
                filled: true,
                fillColor: AppColor.fillColor.withOpacity(0.2),
                counterText: '',
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(IconConstants.icLockPass, scale: 3),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isCheckBoxValue = !isCheckBoxValue;
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 5 / 100,
                        width: MediaQuery.of(context).size.width * 5 / 100,
                        child: isCheckBoxValue == false
                            ? Image.asset(IconConstants.icenablecheck,
                                fit: BoxFit.contain)
                            : Image.asset(IconConstants.checkboxIcon,
                                fit: BoxFit.contain),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 3 / 100),
                      Container(
                        width: MediaQuery.of(context).size.width * 30 / 100,
                        margin: const EdgeInsets.only(top: 6),
                        child: Text(
                          appLocalization(context).rememberMe,
                          style: const TextStyle(
                              color: AppColor.remainColor, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                    child: Text(
                      appLocalization(context).resetPassword,
                      style: const TextStyle(
                          fontSize: 14,
                          color: AppColor.yellowlightColor,
                          fontFamily: AppFont.fontFamily,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPassword()),
                      );
                    }),
              ],
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
                  text: appLocalization(context).register,
                  onPress: () {
                    final email = emailController.text;
                    final password = passwordController.text;
                    final phone = phoneNumberController.text;
                    final firstname = firstnameController.text;
                    final lastname = lastnameController.text;
                    final dob = dateOfBirthController.text;

                    if (email.isNotEmpty && password.isNotEmpty) {
                      setState(() {
                        _isLoading = true;
                      });
                      signup(
                        email: email,
                        password: password,
                        firstname: firstname,
                        lastname: lastname,
                        phonenumber: phone,
                        dateofbirth: dob,
                        countrycode: phoneNumber?.countryCode,
                      ).then((response) {
                        setState(() {
                          _isLoading = false;
                        });
                        // class SignUpResponse
                        //var response
                        if (response.statusCode == 200) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const RegistrationSucessful()));
                        } else {
                          setState(() {
                            _errorMessage = response.message.toString();
                          });
                        }
                      });
                    } else {
                      setState(() {
                        _errorMessage = 'Please enter all  the fields.';
                      });
                    }
                  },
                ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(appLocalization(context).haveAnAccount,
                  style: const TextStyle(
                      fontFamily: AppFont.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColor.haveColor)),
              SizedBox(width: MediaQuery.of(context).size.width * 1 / 100),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const Login()));
                },
                child: Text(appLocalization(context).login,
                    style: const TextStyle(
                        fontSize: 15,
                        color: AppColor.yellowlightColor,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 5 / 100,
          ),
        ]))));
  }
}
