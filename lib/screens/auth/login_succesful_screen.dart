import 'package:spam_delection_app/lib.dart';

class LoginSuccessful extends StatefulWidget {
  const LoginSuccessful({super.key, this.user});

  final User? user;

  @override
  State<LoginSuccessful> createState() => _LoginSuccessfulState();
}

class _LoginSuccessfulState extends State<LoginSuccessful> {
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
            height: MediaQuery.of(context).size.height * 10 / 100,
          ),
          Center(
              child: Text(
            appLocalization(context).successful,
            style: const TextStyle(
                color: AppColor.lightPurpleColor,
                fontSize: 35,
                fontFamily: AppFont.fontFamily,
                fontWeight: FontWeight.w600),
          )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 100,
          ),
          Text(
            '${appLocalization(context).yey} ${widget.user?.name ?? ''}',
            style: const TextStyle(
                color: AppColor.themeYellowColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 100,
          ),
          Text(
            appLocalization(context).fromUs,
            style: const TextStyle(color: AppColor.deepGreyColor),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 5 / 100,
          ),
          Image.asset(
            IconConstants.icSuccessCheck,
            height: MediaQuery.of(context).size.height * 20 / 100,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 5 / 100),
          AppButton(
              text: appLocalization(context).exploreHomePage,
              onPress: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.bottomNavigation,
                  (route) => false,
                );
              })
        ]))));
  }
}
