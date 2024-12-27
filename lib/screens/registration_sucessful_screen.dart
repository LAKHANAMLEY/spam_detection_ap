import 'package:spam_delection_app/lib.dart';

class RegistrationSuccessful extends StatefulWidget {
  const RegistrationSuccessful({super.key, this.user});

  final User? user;

  @override
  State<RegistrationSuccessful> createState() => _RegistrationSuccessfulState();
}

class _RegistrationSuccessfulState extends State<RegistrationSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondryColor,
        appBar: const CustomAppBar(
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 10 / 100,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Center(
                child: Text(
              appLocalization(context).registrationSuccessfulText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColor.bluelightColor,
                  fontSize: 35,
                  fontFamily: AppFont.fontFamily,
                  fontWeight: FontWeight.w600),
            )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 100,
          ),
          Text(
            '${appLocalization(context).yey} ${widget.user?.name}',
            style: const TextStyle(
                color: AppColor.yellowlightColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 100,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              appLocalization(context).congratulationsSuccessfullyCreated,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColor.gracyColor),
            ),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNavigation()));
              })
        ]))));
  }
}
