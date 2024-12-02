import 'package:spam_delection_app/lib.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int SelectTab = 0;
  int Toogletab = 0;
  // final bool _obscureText = true;
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
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController dateofbirthController = TextEditingController();

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
        dateofbirthController.text = picked.toString().split(".").first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondryColor,
        appBar: AppBar(
          backgroundColor: AppColor.secondryColor,
          leading: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                IconConstants.backIcon,
              ),
            ),
          ),
          title: Image.asset(
            IconConstants.icBroadlogo,
            height: MediaQuery.of(context).size.height * 38 / 100,
            width: MediaQuery.of(context).size.width * 38 / 100,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 100,
          ),
          const Center(
              child: Text(
            StringConstants.registertext,
            style: TextStyle(
                color: AppColor.bluelightColor,
                fontSize: 35,
                fontFamily: AppFont.fontFamily,
                fontWeight: FontWeight.w600),
          )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 100,
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Center(
                child: Text(
              StringConstants.enjoytext,
              textAlign: TextAlign.center,
              style: TextStyle(
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
                hintText: 'First name',
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
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 90 / 100,
            child: TextFormField(
              controller: lastnameController,
              decoration: InputDecoration(
                hintText: 'Last name',
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
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 90 / 100,
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email Address',
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
                    IconConstants.icEmailadd, // Adjust the path as necessary
                    width: MediaQuery.of(context).size.width * 3 / 100,
                    height: MediaQuery.of(context).size.height * 3 / 100,
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
                hintText: "Phone Number",
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
            height: MediaQuery.of(context).size.height * 1 / 100,
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 90 / 100,
            child: TextFormField(
              readOnly: true,
              controller:
                  dateofbirthController, //ese controller every field me assign karo
              decoration: InputDecoration(
                  hintText: 'Date of Birth',
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
                      child: Image.asset(IconConstants.icDate))),
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
                hintText: 'Password',
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
                  child: Image.asset(
                    IconConstants.icLockadd, // Adjust the path as necessary
                    width: MediaQuery.of(context).size.width * 3 / 100,
                    height: MediaQuery.of(context).size.height * 3 / 100,
                  ),
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
                        child: const Text(
                          StringConstants.remembertext,
                          style: TextStyle(
                              color: AppColor.remainColor, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                    child: const Text(
                      StringConstants.resetext,
                      style: TextStyle(
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
                  text: StringConstants.registertext,
                  onPress: () {
                    final email = emailController.text;
                    final password = passwordController.text;
                    final phone = phonenumberController.text;
                    final firstname = firstnameController.text;
                    final lastname = lastnameController.text;
                    final dob = dateofbirthController.text;

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
                        _errorMessage = 'Please enter the all fields.';
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
              const Text(StringConstants.haveActext,
                  style: TextStyle(
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
                child: const Text(StringConstants.logintext,
                    style: TextStyle(
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
