import 'package:firebase_auth/firebase_auth.dart';
import 'package:spam_delection_app/lib.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int tabIndex = 0;
  bool isValue = false;
  bool obscureText = true;
  bool isCheckBoxValue = false;
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;
  bool isApiCalling = false;
  bool agreeToTerms = false; //ab kro test // ok

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final TextEditingController _phoneController = TextEditingController();//itne controller ki need nahi hai
  // String? _verificationId;

  // String? enteredPhone;
  String? countryCode;

  Future<void> _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: (countryCode ?? "") + phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Phone number automatically verified and signed in!')),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Phone verification failed: ${e.message}')),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          // _verificationId = verificationId;
        });
        // Navigate to OTP Verification Screen
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OtpVerify(
            verificationId: verificationId,
            phoneNumber: phoneController.text,
            countryCode: countryCode ?? "",
          ),
        ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // _verificationId = verificationId;
      },
    );
  }

  /*final TextEditingController phoneController = TextEditingController();
  String initialCountry = 'FR'; // Set initial country to France (FR)
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'FR');
  bool isLoading = false;
   */

  /*TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  signInUserValidation(String email, String password) async {
    print("userName $email");
    print("password $password");
    if (email.isEmpty) {
      SnackBarToastMessage.showSnackBar(
          context, StringConstants.emailMessage);
      return false;
    } else if (!AppData.emailValidatorRegExp.hasMatch(email)) {
      SnackBarToastMessage.showSnackBar(
          context, StringConstants.emailValidMessage);
      return false;
    } else if (password.isEmpty) {
      SnackBarToastMessage.showSnackBar(
          context, StringConstants.passwordNameessage);
      return false;
    } else if (password.length < 6) {
      SnackBarToastMessage.showSnackBar(
          context, StringConstants.passwordMinMessage);
      return false;
    } else if (isValue == false) {
      SnackBarToastMessage.showSnackBar(
          context, StringConstants.checkBoxMessage);
      return false;
    } else {
      signInUserApiCall(email, password);
    }
  }

  signInUserApiCall(String username, String password) async {
    Uri url = Uri.parse("${ApiUrlConstants.endPointEmailPassword}");

    Map<String, String> headers = ({
      'Content-Type': 'application/json',
    });

    Map<String, String> body = ({'username': username, 'password': password});
    setState(() {
      isApiCalling = true;
    });
    try {
      final  http.Response response = await http.post(
        url,

        body: jsonEncode(body),
      );
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        setState(() {
          isApiCalling = false;
        });
        if (res['status'] == true) {
          dynamic userDetails = res['data'];
          print("userDetails $userDetails");
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("user_details", jsonEncode(userDetails));

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginSuccessful()),
          );
        }
      } else {
        setState(() {
          isApiCalling = false;
        });
        throw Exception('Album loading failed!');
      }
    } catch (e) {
      setState(() {
        isApiCalling = false;
      });
      print(e);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginSuccessful()),
      );
    }
  }

  /*@override
  Widget build(BuildContext context) {
    return ProgressHUD(
        inAsyncCall: isApiCalling,
        opacity: 0.5,
        child: _buildUIScreen(context));
  }

   */

  @override
  void dispose() {
    super.dispose();
  }
   */

  /*final TextEditingController  phoneController=TextEditingController();
  final TextEditingController  countryController=TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  final String loginUrl = ApiUrlConstants.endPointEmailPassword;


  Future<void> _login() async {

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final response = await http.post(
      Uri.parse(loginUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': emailController.text,
        'password': passwordController.text,
        'device_token': deviceToken ?? '',
        'device_type': deviceType,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.containsKey('token')) {

        print('Login successful! Token: ${data['token']}');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginSuccessful()));
      } else {
        setState(() {
          _errorMessage = 'Login failed: No token received';
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Login failed: ${jsonDecode(response.body)['message']}';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }


   */

  /*Future<void> signIn(String email, String password) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final url = Uri.parse(
        ApiUrlConstants.endPointEmailPassword); // API endpoint

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.containsKey('token')) {
          print('Login Success: ${data['token']}');
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginSuccessful())); // Navigate to HomeScreen
        } else {
          setState(() {
            _errorMessage = 'Login failed: Token not received';
          });
        }
      } else {
        final errorResponse = jsonDecode(response.body);
        setState(() {
          _errorMessage = errorResponse['message'] ?? 'An error occurred';
        });
        print('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


   */

  /*Future<void>sendPostRequest()async {
    var response = await http.post(Uri.parse(ApiUrlConstants.endPointEmailPassword),
        body: {
          "email": emailController.text,
          "password": passwordController.text,
        });
    print('response:::::::::::::::::$response');
    print('response:::::::::::::::::${jsonEncode({
      "email": emailController.text,
      "password": passwordController.text,
    })}');
    print('response:::::::::::::::::${response.body}');
    print('response:::::::::::::::::${response.statusCode}');
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Post created successfully!"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to create post!"),
      ));
    }
  }
   */
  final TextEditingController phoneController = TextEditingController(); //#2
  final TextEditingController countryController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                IconConstants.backIcon,
              ),
            ),
          ),
          title: Image.asset(
            IconConstants.icBroadlogo,
            height: MediaQuery.of(context).size.height * 35 / 100,
            width: MediaQuery.of(context).size.width * 35 / 100,
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
                StringConstants.logintext,
                style: TextStyle(
                    color: AppColor.bluelightColor,
                    fontSize: 35,
                    fontFamily: AppFont.fontFamily,
                    fontWeight: FontWeight.w600),
              )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                    child: Text(
                  StringConstants.plsvalidtext, // this one
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.verifyColor,
                      fontFamily: AppFont.fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                )),
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      tabIndex = 0;
                    });
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 12 / 100,
                          width: MediaQuery.of(context).size.width * 18 / 100,
                          child: Center(
                            child: tabIndex == 1
                                ? Image.asset(IconConstants
                                    .icphoneunSelect) // Show secondary image
                                : Image.asset(IconConstants
                                    .icphoneSelect), // Show primary image
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 5 / 100,
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                tabIndex = 1;
                              });
                            },
                            child: SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 12 / 100,
                              width:
                                  MediaQuery.of(context).size.width * 18 / 100,
                              child: Center(
                                child: tabIndex == 1
                                    ? Image.asset(IconConstants
                                        .icemailSelect) // Show secondary image
                                    : Image.asset(IconConstants
                                        .icemailunSelect), // Show primary image
                              ),
                            )),
                      ])),
              SizedBox(
                height: MediaQuery.of(context).size.height * 5 / 100,
              ),
              if (tabIndex == 1) ...[
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 90 / 100,
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: StringConstants.emailadresstext,
                      hintStyle: const TextStyle(
                          color: AppColor.lightfillColor,
                          fontFamily: AppFont.fontFamily,
                          fontWeight: FontWeight.w600),
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
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 3 / 100,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 90 / 100,
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                            color: AppColor.lightfillColor,
                            fontWeight: FontWeight.w800,
                            fontFamily: AppFont.fontFamily),
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
                        counterText: '',
                        suffixIcon: Image.asset(IconConstants.icLockadd)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 100,
                ),
                if (_errorMessage != null)
                  Text(_errorMessage!,
                      style: const TextStyle(color: Colors.red)),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 2 / 100,
                ),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : AppButton(
                        text: StringConstants.logintext,
                        onPress: () {
                          final email = emailController.text;
                          final password = passwordController.text;
                          if (email.isNotEmpty && password.isNotEmpty) {
                            setState(() {
                              _isLoading = true;
                            });
                            login(email: email, password: password)
                                .then((loginResponse) {
                              SharedPref.saveUserData(loginResponse.data);
                              setState(() {
                                _isLoading = false;
                              });
                              if (loginResponse.statusCode == 200) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      LoginSuccessful(user: loginResponse.data),
                                ));
                              } else {
                                setState(() {
                                  _errorMessage =
                                      loginResponse.message.toString();
                                });
                              }
                            });
                          } else {
                            setState(() {
                              _errorMessage =
                                  'Please enter both email and password';
                            });
                          }
                        },
                      ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 2 / 100,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(IconConstants.icGoogle,
                        height: MediaQuery.of(context).size.height * 10 / 100),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 2 / 100),
                    Image.asset(
                      IconConstants.icMac,
                      height: MediaQuery.of(context).size.height * 10 / 100,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      StringConstants.donttext,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFont.fontFamily,
                          color: AppColor.greylightColor,
                          fontSize: 15),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 2 / 100),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Register()));
                      },
                      child: const Text(StringConstants.registertext,
                          style: TextStyle(
                              color: AppColor.yellowlightColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 5 / 100),
              ] else ...[
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 18, right: 20),
                  child: IntlPhoneField(
                    ///TODO:  need to implement api country picker dont use this package
                    controller: phoneController,
                    decoration: InputDecoration(
                      hintText: "Enter Phone Number",
                      hintStyle: const TextStyle(
                          color: AppColor.lightfillColor,
                          fontFamily: AppFont.fontFamily,
                          fontWeight: FontWeight.w600),
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
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      countryCode = phone.countryCode;
                      // enteredPhone = phone.completeNumber;
                      print(phone.completeNumber);
                      print(phone.countryCode);
                    },
                  ),
                )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 3 / 100,
                ),
                /*Container(
                width: MediaQuery.sizeOf(context).width * 90/ 100,
                child:  TextFormField(
                  keyboardType: TextInputType.number,
                  controller:phoneController,
                  decoration:  InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: const TextStyle(color: AppColor.lightfillColor,fontFamily: AppFont.fontFamily,fontWeight: FontWeight.w600),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: const BorderSide(
                          width: 1.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColor.fillColor, width: 1.5),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(2)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        IconConstants.icCalladd, // Adjust the path as necessary
                        width:MediaQuery.of(context).size.width*3/100,
                        height: MediaQuery.of(context).size.height*3/100,
                      ),
                    ),
                  ),
                ),
              ),

               */
                SizedBox(height: MediaQuery.of(context).size.height * 5 / 100),
                AppButton(
                  text: StringConstants.otptext,
                  onPress: _verifyPhoneNumber,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 2 / 100,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(IconConstants.icGoogle,
                        height: MediaQuery.of(context).size.height * 10 / 100),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 2 / 100),
                    Image.asset(
                      IconConstants.icMac,
                      height: MediaQuery.of(context).size.height * 10 / 100,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      StringConstants.donttext,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFont.fontFamily,
                          color: AppColor.greylightColor,
                          fontSize: 15),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 2 / 100),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Register()));
                      },
                      child: const Text(StringConstants.registertext,
                          style: TextStyle(
                              color: AppColor.yellowlightColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 5 / 100),
              ],
            ]),
          ),
        ));
  }
}
