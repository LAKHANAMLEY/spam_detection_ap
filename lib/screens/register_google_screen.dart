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
            child: SingleChildScrollView(
                child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 6 / 100,
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
            height: MediaQuery.of(context).size.height * 8 / 100,
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
                    width: MediaQuery.sizeOf(context).width * 8 / 100,
                    height: MediaQuery.sizeOf(context).height * 4 / 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(IconConstants.icgoogleLogo),
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
                    width: MediaQuery.sizeOf(context).width * 8 / 100,
                    height: MediaQuery.sizeOf(context).height * 4 / 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(IconConstants.icappleLogo),
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
                  margin: const EdgeInsets.only(left: 50.0, right: 10.0),
                  child: Divider(
                    color: AppColor.gracyColor,
                    height: MediaQuery.sizeOf(context).height * 6 / 100,
                  )),
            ),
            Text(
              appLocalization(context).orTxt,
              style: const TextStyle(
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 50),
                  child: Divider(
                    color: AppColor.gracyColor,
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
                    color: AppColor.greylightColor,
                    fontSize: 15),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 1 / 100),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const LoginGoogle()));
                },
                child: Text(appLocalization(context).login,
                    style: const TextStyle(
                        color: AppColor.yellowlightColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 5 / 100),
        ]))));
  }
}
