import 'package:spam_delection_app/lib.dart';

class ProtectionType extends StatefulWidget {
  const ProtectionType({super.key});

  @override
  State<ProtectionType> createState() => _ProtectionTypeState();
}

class _ProtectionTypeState extends State<ProtectionType> {
  var selectedTabBloc = SelectionBloc(SelectIntState(0));

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
              height: MediaQuery.of(context).size.height * 8 / 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80),
              child: Text(
                appLocalization(context).protectionType,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColor.lightPurpleColor,
                    fontSize: 35,
                    fontFamily: AppFont.fontFamily,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Center(
                  child: Text(
                appLocalization(context).pleaseTxt,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColor.materialGreyColor,
                    fontFamily: AppFont.fontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 5 / 100,
            ),
            BlocBuilder(
                bloc: selectedTabBloc,
                builder: (context, selectTabState) {
                  if (selectTabState is SelectIntState) {
                    int selectedTab = selectTabState.value;
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            selectedTabBloc.add(SelectIntEvent(0));
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 90 / 100,
                            height: MediaQuery.sizeOf(context).height * 8 / 100,
                            decoration: BoxDecoration(
                              color: selectedTab == 1
                                  ? AppColor.lightBrownColor.withOpacity(0.2)
                                  : AppColor.darkPurpleColor,
                              borderRadius: BorderRadius.circular(2),
                              border:
                                  Border.all(color: AppColor.lightBrownColor),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.sizeOf(context).width *
                                      8 /
                                      100,
                                  height: MediaQuery.sizeOf(context).height *
                                      8 /
                                      100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          selectedTab == 1
                                              ? AppColor.darkPurpleColor
                                              : AppColor.whiteColor,
                                          BlendMode.srcIn),
                                      image: const AssetImage(
                                          IconConstants.icPersonalShield),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      4 /
                                      100,
                                ),
                                Text(
                                  appLocalization(context).personalProtection,
                                  style: TextStyle(
                                      color: selectedTab == 1
                                          ? AppColor.deepGreyColor
                                          : AppColor.whiteColor,
                                      fontFamily: AppFont.fontFamily,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 5 / 100,
                        ),
                        GestureDetector(
                          onTap: () {
                            selectedTabBloc.add(SelectIntEvent(1));
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 90 / 100,
                            height: MediaQuery.sizeOf(context).height * 8 / 100,
                            decoration: BoxDecoration(
                              color: selectedTab == 1
                                  ? AppColor.darkPurpleColor
                                  : AppColor.lightBrownColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(2),
                              border:
                                  Border.all(color: AppColor.lightBrownColor),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.sizeOf(context).width *
                                      8 /
                                      100,
                                  height: MediaQuery.sizeOf(context).height *
                                      8 /
                                      100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          selectedTab == 1
                                              ? AppColor.whiteColor
                                              : AppColor.darkPurpleColor,
                                          BlendMode.srcIn),
                                      image: const AssetImage(
                                          IconConstants.icCorporateShield),
                                    ),
                                  ),
                                ),
                                //30.height(),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      4 /
                                      100,
                                ),
                                Text(
                                  appLocalization(context).corporateProtection,
                                  style: TextStyle(
                                      color: selectedTab == 1
                                          ? AppColor.whiteColor
                                          : AppColor.deepGreyColor,
                                      fontFamily: AppFont.fontFamily,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        //30.height(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 5 / 100,
                        ),
                        AppButton(
                            text: appLocalization(context).continueTxt,
                            onPress: () {
                              if (selectedTab == 0) {
                                Navigator.pushNamed(
                                    context, AppRoutes.loginGoogle);
                              } else {
                                Navigator.pushNamed(
                                    context, AppRoutes.corporateLogin);
                              }
                            }),
                      ],
                    );
                  }
                  return const Loader();
                }),
          ]),
        )));
  }
}
