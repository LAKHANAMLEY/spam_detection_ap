import 'package:firebase_auth/firebase_auth.dart';
import 'package:spam_delection_app/lib.dart';

class LoginGoogle extends StatefulWidget {
  const LoginGoogle({super.key});

  @override
  State<LoginGoogle> createState() => _LoginGoogleState();
}

class _LoginGoogleState extends State<LoginGoogle> {
  UserCredential? userCredential;

  var authBloc = ApiBloc(ApiBlocInitialState());

  get googleSignIn => null;

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
                  IconConstants.backIcon,
                ),
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
            child: BlocConsumer(
                bloc: authBloc,
                listener: (context, state) {
                  if (state is SocialSignUpState) {
                    if (state.value.statusCode == 200) {
                      SharedPref.saveUserData(state.value.data);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginSuccessful(
                                    user: state.value.data,
                                  )));
                    } else {
                      showCustomDialog(context,
                          dialogType: DialogType.success,
                          subTitle: state.value.message);
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
                        height: MediaQuery.of(context).size.height * 6 / 100,
                      ),
                       Center(
                          child: Text(
                            appLocalization(context).login,
                        style: TextStyle(
                            color: AppColor.bluelightColor,
                            fontSize: 35,
                            fontFamily: AppFont.fontFamily,
                            fontWeight: FontWeight.w600),
                      )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 8 / 100,
                      ),
                      GestureDetector(
                        onTap: () async {
                          try {
                            userCredential = await signInWithGoogle();
                            if (userCredential != null) {
                              //TODO:implement social signup
                              authBloc.add(SocialSignupEvent(
                                  email: userCredential?.user?.email ?? "",
                                  signupMethod: "gmail",
                                  firstName:
                                      userCredential?.user?.displayName ?? "",
                                  lastName: ""));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Google Sign-In failed. Please try again.')),
                              );
                            }
                          } catch (e) {
                            print('Error during Google Sign-In: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'An error occurred during Google Sign-In.')),
                            );
                          }
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 90 / 100,
                          height: MediaQuery.sizeOf(context).height * 8 / 100,
                          decoration: BoxDecoration(
                            color: AppColor.fillColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(color: AppColor.fillColor),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width:
                                    MediaQuery.sizeOf(context).width * 8 / 100,
                                height:
                                    MediaQuery.sizeOf(context).height * 4 / 100,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        IconConstants.icgoogleLogo,
                                      ),
                                      fit: BoxFit.cover),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 4 / 100,
                              ),
                               Text(
                                appLocalization(context).loginWithGoogle,
                                style: TextStyle(
                                    color: AppColor.gracyColor,
                                    fontFamily: AppFont.fontFamily,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 4 / 100,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 90 / 100,
                          height: MediaQuery.sizeOf(context).height * 8 / 100,
                          decoration: BoxDecoration(
                            color: AppColor.fillColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(color: AppColor.fillColor),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width:
                                    MediaQuery.sizeOf(context).width * 8 / 100,
                                height:
                                    MediaQuery.sizeOf(context).height * 4 / 100,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage(IconConstants.icappleLogo),
                                      fit: BoxFit.cover),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 4 / 100,
                              ),
                               Text(
                                appLocalization(context).loginWithApple,
                                style: TextStyle(
                                    color: AppColor.gracyColor,
                                    fontFamily: AppFont.fontFamily,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 8 / 100,
                      ),
                      Row(children: <Widget>[
                        Expanded(
                          child: Container(
                              width: MediaQuery.sizeOf(context).width * 6 / 100,
                              margin: const EdgeInsets.only(
                                  left: 50.0, right: 10.0),
                              child: Divider(
                                color: AppColor.gracyColor,
                                height:
                                    MediaQuery.sizeOf(context).height * 6 / 100,
                              )),
                        ),
                         Text(
                          appLocalization(context).orTxt,
                          style: TextStyle(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                        Expanded(
                          child: Container(
                              margin:
                                  const EdgeInsets.only(left: 10, right: 50),
                              child: Divider(
                                color: AppColor.gracyColor,
                                height:
                                    MediaQuery.sizeOf(context).height * 6 / 100,
                              )),
                        ),
                      ]),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 8 / 100,
                      ),
                      AppButton(
                          text:appLocalization(context).loginWithEmail,
                          onPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()));
                          }),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 4 / 100,
                      ),
                      // TextButton(
                      //   child: const Text(
                      //     'Logout',
                      //     style: TextStyle(fontSize: 18,color:AppColor.yellowlightColor),
                      //   ),
                      //   onPressed: () async {
                      //     bool signOutSuccess = await signOutFromGoogle();
                      //     if (signOutSuccess) {
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         const SnackBar(content: Text(
                      //             'Successfully signed out from Google.')),
                      //       );
                      //       // Navigate to login or home screen after sign out
                      //       Navigator.pushReplacement(context,
                      //           MaterialPageRoute(builder: (context) => const Welcome()));
                      //     } else {
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         const SnackBar(content: Text(
                      //             'Failed to sign out. Please try again.')),
                      //       );
                      //     }
                      //   },
                      // ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 2 / 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                          appLocalization(context).dontHaveAnAccount,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: AppFont.fontFamily,
                                color: AppColor.greylightColor,
                                fontSize: 15),
                          ),
                          SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 1 / 100),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const RegisterGoogle()));
                            },
                            child: Text(appLocalization(context).register,
                                style: TextStyle(
                                    color: AppColor.yellowlightColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 5 / 100),
                    ])),
                  );
                })));
  }
}
