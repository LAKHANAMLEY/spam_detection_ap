import 'package:spam_delection_app/lib.dart';

class RegisterGoogle extends StatefulWidget {
  const RegisterGoogle({super.key});

  @override
  State<RegisterGoogle> createState() => _RegisterFirstState();
}

class _RegisterFirstState extends State<RegisterGoogle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: const CustomAppBar(
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 6 / 100,
          ),
          Center(
              child: Text(
            appLocalization(context).register,
            style: const TextStyle(
                color: AppColor.lightPurpleColor,
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
                var userCredential = await signInWithGoogle();
                if (userCredential != null) {
                  Navigator.pushNamed(context, AppRoutes.register,
                      arguments: Register(
                        userCredencial: userCredential,
                      ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(appLocalization(context)
                            .googleSignFailedPleaseAgain)),
                  );
                }
              } catch (e) {
                print('Error during Google Sign-In: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(appLocalization(context)
                          .anErrorOccurredDuringGoogleSignIn)),
                );
              }
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width * 90 / 100,
              height: MediaQuery.sizeOf(context).height * 8 / 100,
              decoration: BoxDecoration(
                color: AppColor.lightBrownColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: AppColor.lightBrownColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 8 / 100,
                    height: MediaQuery.sizeOf(context).height * 4 / 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(IconConstants.icGoogleLogo),
                          fit: BoxFit.cover),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 4 / 100,
                  ),
                  Text(
                    appLocalization(context).registerWithGoogle,
                    style: const TextStyle(
                        color: AppColor.deepGreyColor,
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
                color: AppColor.lightBrownColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: AppColor.lightBrownColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 8 / 100,
                    height: MediaQuery.sizeOf(context).height * 4 / 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(IconConstants.icAppleLogo),
                          fit: BoxFit.cover),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 4 / 100,
                  ),
                  Text(
                    appLocalization(context).registerWithApple,
                    style: const TextStyle(
                        color: AppColor.deepGreyColor,
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
                  margin: const EdgeInsets.only(left: 50.0, right: 10.0),
                  child: Divider(
                    color: AppColor.deepGreyColor,
                    height: MediaQuery.sizeOf(context).height * 6 / 100,
                  )),
            ),
            Text(
              appLocalization(context).orTxt,
              style: const TextStyle(
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 50),
                  child: Divider(
                    color: AppColor.deepGreyColor,
                    height: MediaQuery.sizeOf(context).height * 6 / 100,
                  )),
            ),
          ]),
          SizedBox(
            height: MediaQuery.of(context).size.height * 8 / 100,
          ),
          AppButton(
              text: appLocalization(context).registerWithEmail,
              onPress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Register()));
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height * 10 / 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                appLocalization(context).alreadyHaveAnAccount,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFont.fontFamily,
                    color: AppColor.darkGreyColor,
                    fontSize: 15),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 1 / 100),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.loginGoogle);
                },
                child: Text(appLocalization(context).login,
                    style: const TextStyle(
                        color: AppColor.themeYellowColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 5 / 100),
        ]))));
  }
}
