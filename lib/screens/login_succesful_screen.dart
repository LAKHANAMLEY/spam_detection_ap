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
        backgroundColor: AppColor.secondryColor,
        appBar: AppBar(
          backgroundColor: AppColor.secondryColor,
          leading: GestureDetector(
            onTap: () {},
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
            height: MediaQuery.of(context).size.height * 10 / 100,
          ),
           Center(
              child: Text(
                appLocalization(context).successful,
            style: const TextStyle(
                color: AppColor.bluelightColor,
                fontSize: 35,
                fontFamily: AppFont.fontFamily,
                fontWeight: FontWeight.w600),
          )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 100,
          ),
          Text(
            '${appLocalization(context).yey}, ${widget.user?.name ?? ''}',
            style: const TextStyle(
                color: AppColor.yellowlightColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 100,
          ),
           Text(
<<<<<<< HEAD
             appLocalization(context).fromUs,
            style: TextStyle(color: AppColor.gracyColor),
=======
            appLocalization(context).fromNowOnYouArePartOfUs,
            style: const TextStyle(color: AppColor.gracyColor),
>>>>>>> bb159d58d8d4b67a403a82a7315d58934ff202bc
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 5 / 100,
          ),
          Image.asset(
            IconConstants.icsuccesfulLogo,
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
