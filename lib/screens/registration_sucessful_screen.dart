import 'package:spam_delection_app/lib.dart';

class RegistrationSucessful extends StatefulWidget {
  const RegistrationSucessful({super.key, this.firstname});
  final String? firstname;

  @override
  State<RegistrationSucessful> createState() => _RegistrationSucessfulState();
}

class _RegistrationSucessfulState extends State<RegistrationSucessful> {
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
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Center(
                child: Text(
              StringConstants.registersuccessfultext,
              textAlign: TextAlign.center,
              style: TextStyle(
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
            'Yey! ${widget.firstname ?? 'User'}',
            style: const TextStyle(
                color: AppColor.yellowlightColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 100,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              StringConstants.congratsregistertext,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColor.gracyColor),
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
              text: StringConstants.exploretext,
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNavigation()));
              })
        ]))));
  }
}
