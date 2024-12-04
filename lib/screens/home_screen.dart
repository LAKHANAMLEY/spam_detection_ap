import 'package:spam_delection_app/lib.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isCallProtectionEnabled = true;

  bool isMessageProtectionEnabled = false;

  bool isEmailProtectionEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 3 / 100),
                  Image.asset(
                    IconConstants.securitykeyIcon,
                    height: MediaQuery.of(context).size.height * 15 / 100,
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 1 / 100),
                  Text(
                    appLocalization(context).pleaseActiveYourSubscription,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.yellowdeep,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFont.fontFamily),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 100,
                  ),
                  Text(
                    appLocalization(context)
                        .youAreProtectedAgainstAllTheDangerousPhoneNumbersFromOurSecurityDatabase,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.verifyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFont.fontFamily),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 4 / 100,
                  ),
                  SecurityOption(
                    image: IconConstants.icplusCall,
                    title: appLocalization(context).callProtection,
                    description: appLocalization(context)
                        .allSpamCallsAreCurrentlyBeingBlockedFromCallingYourTelephoneNumberYouMayMissImportantCallIfTheCallerNumberIsFlaggedByTheNetworkAsSpam,
                    isEnabled: isCallProtectionEnabled,
                    onToggle: (value) {
                      setState(() {
                        isCallProtectionEnabled = value;
                      });
                    },
                  ),
                  SecurityOption(
                    image: IconConstants.iclockMessages,
                    title: appLocalization(context).protectAIMessages,
                    description: appLocalization(context).yourMessagesAreCurrentlyBeingScreenedByDetectAIToIdentityPotentialScams,
                    isEnabled: isMessageProtectionEnabled,
                    onToggle: (value) {
                      setState(() {
                        isMessageProtectionEnabled = value;
                      });
                    },
                  ),
                  SecurityOption(
                    image: IconConstants.iclockMail,
                    title: appLocalization(context).protectAIEmail,
                    description:  appLocalization(context).yourEmailsAreCurrentlyBeingScreenedByProtectAIToDetectPotentialScamAndSafeGuardYourDataAndFinancials,
                    isEnabled: isEmailProtectionEnabled,
                    onToggle: (value) {
                      setState(() {
                        isEmailProtectionEnabled = value;
                      });
                    },
                  ),
                ]),
          ),
        ),
      ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   key: _bottomNavigationKey,
      //   index: _page,
      //   height: 75,
      //   items: <Widget>[
      //     Image.asset(
      //       IconConstants.icHome,
      //       height: MediaQuery.of(context).size.height * 6 / 100,
      //       width: MediaQuery.of(context).size.width * 6 / 100,
      //     ),
      //     Image.asset(
      //       IconConstants.icChat,
      //       height: MediaQuery.of(context).size.height * 6 / 100,
      //       width: MediaQuery.of(context).size.width * 6 / 100,
      //     ),
      //     Image.asset(
      //       IconConstants.icPhone,
      //       height: MediaQuery.of(context).size.height * 6 / 100,
      //       width: MediaQuery.of(context).size.width * 6 / 100,
      //     ),
      //     Image.asset(
      //       IconConstants.icPremium,
      //       height: MediaQuery.of(context).size.height * 6 / 100,
      //       width: MediaQuery.of(context).size.width * 6 / 100,
      //     ),
      //     Image.asset(
      //       IconConstants.icSetting,
      //       height: MediaQuery.of(context).size.height * 6 / 100,
      //       width: MediaQuery.of(context).size.width * 6 / 100,
      //     ),
      //   ],
      //   color: AppColor.callColor,
      //   buttonBackgroundColor: AppColor.yellowdeep,
      //   backgroundColor: AppColor.secondryColor,
      //   animationCurve: Curves.easeInOut,
      //   animationDuration: const Duration(milliseconds: 600),
      //   onTap: (index) {
      //     setState(() {
      //       _page = index;
      //       // _pages = _page;
      //       //_pages[_page];
      //     });
      //   },
      //   letIndexChange: (index) => true,
      // )
    );
  }
}

class SecurityOption extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final bool isEnabled;
  final ValueChanged<bool> onToggle;

  const SecurityOption({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.isEnabled,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 28,
                backgroundColor: AppColor.callColor,
                child: Image.asset(image,
                    height: MediaQuery.of(context).size.height * 4 / 100),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 4 / 100),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColor.callColor),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(
                        color: AppColor.thumbColor, fontSize: 14),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 12 / 100,
                height: MediaQuery.of(context).size.height * 4 / 100,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Switch(
                    //splashRadius: 10,
                    value: isEnabled,
                    onChanged: onToggle,

                    //inactiveThumbColor: AppColor.inactiveThumbColor,

                    activeTrackColor: AppColor.secondryColor,
                    inactiveTrackColor: AppColor.secondryColor,
                    activeColor: AppColor.toggleColor,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    //activeThumbImage:AssetImage(IconConstants.icactiveThumb),
                    // inactiveThumbImage: AssetImage(IconConstants.icinactiveThumb),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
