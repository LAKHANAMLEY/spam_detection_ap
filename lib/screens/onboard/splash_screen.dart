import 'package:permission_handler/permission_handler.dart';
import 'package:spam_delection_app/lib.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    context.read<PermissionBloc>().add(RequestMultiplePermissionsEvent([
          Permission.phone,
          Permission.contacts,
          Permission.sms,
          Permission.notification,
          Permission.systemAlertWindow,
        ]));
    getAndSetDefaultCountry();
    SharedPref.getIsLogin().then((isLogin) {
      Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.pushNamedAndRemoveUntil(
            context,
            isLogin ? AppRoutes.bottomNavigation : AppRoutes.welcome,
            (route) => false),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 40 / 100,
            ),
            Center(
              child: Image.asset(
                IconConstants.icBroadLogo,
                height: MediaQuery.of(context).size.height * 20 / 100,
                width: MediaQuery.of(context).size.width * 50 / 100,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 28 / 100,
            ),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(IconConstants.icCopyRight,
                      height: MediaQuery.of(context).size.height * 4 / 100,
                      width: MediaQuery.of(context).size.width * 4 / 100),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1 / 100,
                  ),
                  Text(
                    appLocalization(context).copyrightText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.slatWhiteColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
