import 'package:spam_delection_app/lib.dart';

class CorpoateLogin extends StatefulWidget {
  const CorpoateLogin({super.key});

  @override
  State<CorpoateLogin> createState() => _CorpoateLoginState();
}

class _CorpoateLoginState extends State<CorpoateLogin> {
  final TextEditingController corporateIdController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  double scale = 3.5;

  final _formKey = GlobalKey<FormState>();

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
            height: MediaQuery.of(context).size.height * 38 / 100,
            width: MediaQuery.of(context).size.width * 38 / 100,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 8 / 100,
              ),
              Center(
                  child: Text(
                appLocalization(context).login,
                style: const TextStyle(
                    color: AppColor.bluelightColor,
                    fontSize: 35,
                    fontFamily: AppFont.fontFamily,
                    fontWeight: FontWeight.w600),
              )),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  appLocalization(context).pleaseCorporateID,
                  // this one
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: AppColor.verifyColor,
                      fontFamily: AppFont.fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              10.height(),
              CustomTextField(
                controller: corporateIdController,
                hintText: appLocalization(context).corporateID,
                suffix: Image.asset(
                  IconConstants.icCorporateID,
                  scale: 3,
                ),
                validator: (p0) {
                  if (p0?.isEmpty ?? true) {
                    return "Please enter corporate ID";
                  }
                  return null;
                },
              ),
              10.height(),
              CustomTextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                hintText: appLocalization(context).emailAddress,
                suffix: Image.asset(
                  IconConstants.icfluentMail,
                  scale: 3,
                ),
                validator: (p0) {
                  if (p0?.isEmpty ?? true) {
                    return "Please enter email adddress";
                  }
                  return null;
                },
              ),
              10.height(),
              CustomTextField(
                controller: passwordController,
                hintText: appLocalization(context).password,
                suffix: Image.asset(
                  IconConstants.icLockPass,
                  scale: 3,
                ),
                validator: (p0) {
                  if (p0?.isEmpty ?? true) {
                    return "Please enter password";
                  }
                  return null;
                },
              ),
              10.height(),
              if (_errorMessage != null)
                Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : AppButton(
                      text: appLocalization(context).login,
                      onPress: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          final corporateId = corporateIdController.text;
                          final email = emailController.text;
                          final password = passwordController.text;
                          if (email.isNotEmpty && password.isNotEmpty) {
                            setState(() {
                              _isLoading = true;
                            });
                            corporateLogin(
                                    email: email,
                                    password: password,
                                    corporateid: corporateId)
                                .then((response) {
                              SharedPref.saveUserData(response.data);
                              setState(() {
                                _isLoading = false;
                              });
                              if (response.statusCode == 200) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginSuccessful(
                                    user: response.data,
                                  ),
                                ));
                              } else {
                                setState(() {
                                  _errorMessage = response.message.toString();
                                });
                              }
                            });
                          }
                        }
                      },
                    ),
            ]),
          )),
        )));
  }
}
