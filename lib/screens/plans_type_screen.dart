import 'package:spam_delection_app/lib.dart';

class PlanType extends StatefulWidget {
  final bool? showAppBar;
  const PlanType({super.key, this.showAppBar = true});

  @override
  State<PlanType> createState() => _PlanTypeState();
}

class _PlanTypeState extends State<PlanType> {
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    var argument = args(context) as PlanType?;
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      appBar: (widget.showAppBar ?? argument?.showAppBar ?? false)
          ? const CustomAppBar(
              centerTitle: true,
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 3 / 100),
              Image.asset(
                IconConstants.icsubsription,
                height: MediaQuery.of(context).size.height * 18 / 100,
              ),
               Center(
                  child: Padding(
                padding: EdgeInsets.only(left: 50, right: 50),
                child: Text(
                 appLocalization(context).chooseYourPlan,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.bluelightColor,
                      fontSize: 35,
                      fontFamily: AppFont.fontFamily,
                      fontWeight: FontWeight.w600),
                ),
              )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),
               Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  appLocalization(context).blockAccuracy,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.verifyColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFont.fontFamily),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTab = 0;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PlanDetail()));
                  });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 18 / 100,
                  width: MediaQuery.of(context).size.width * 90 / 100,
                  decoration: BoxDecoration(
                      color: selectedTab == 0
                          ? AppColor.yellowdecentColor
                          : AppColor.secondryColor,
                      border: Border.all(
                        color: selectedTab == 0
                            ? AppColor.yellowColor
                            : AppColor.thumbColor,
                      ),
                      borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          appLocalization(context).personalProtection,
                          style: TextStyle(
                              color: AppColor.callColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFont.fontFamily),
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 0.5 / 100,
                        ),
                         Text(
                           appLocalization(context).spamScamDetection,
                          style: TextStyle(
                              color: AppColor.borderstekColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFont.fontFamily),
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 0.5 / 100,
                        ),
                         Text(
                          appLocalization(context).personalMth,
                          style: TextStyle(
                              color: AppColor.callColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFont.fontFamily),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTab = 1;
                  });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 18 / 100,
                  width: MediaQuery.of(context).size.width * 90 / 100,
                  decoration: BoxDecoration(
                      color: selectedTab == 1
                          ? AppColor.yellowdecentColor
                          : AppColor.secondryColor,
                      border: Border.all(
                          color: selectedTab == 1
                              ? AppColor.yellowColor
                              : AppColor.thumbColor),
                      borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          appLocalization(context).callSMSBundle,
                          style: TextStyle(
                              color: AppColor.callColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFont.fontFamily),
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 0.5 / 100,
                        ),
                         Text(
                          appLocalization(context).spamSMSProtect,
                          style: TextStyle(
                              color: AppColor.borderstekColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFont.fontFamily),
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 0.5 / 100,
                        ),
                         Text(
                          appLocalization(context).smsMth,
                          style: TextStyle(
                              color: AppColor.callColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFont.fontFamily),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTab = 2;
                  });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 20 / 100,
                  width: MediaQuery.of(context).size.width * 90 / 100,
                  decoration: BoxDecoration(
                      color: selectedTab == 2
                          ? AppColor.yellowdecentColor
                          : AppColor.secondryColor,
                      border: Border.all(
                          color: selectedTab == 2
                              ? AppColor.yellowColor
                              : AppColor.thumbColor),
                      borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          appLocalization(context).completeProtectionBundle,
                          style: TextStyle(
                              color: AppColor.callColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFont.fontFamily),
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 0.5 / 100,
                        ),
                         Text(
                          appLocalization(context).spamSMSEmail,
                          style: TextStyle(
                              color: AppColor.borderstekColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFont.fontFamily),
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 0.5 / 100,
                        ),
                         Text(
                          appLocalization(context).completeMth,
                          style: TextStyle(
                              color: AppColor.callColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFont.fontFamily),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
