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
        backgroundColor: AppColor.secondryColor,
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
                    color: AppColor.blueLightColor,
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
                    color: AppColor.verifyColor,
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
                                  ? AppColor.fillColor.withOpacity(0.2)
                                  : AppColor.callColor,
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(color: AppColor.fillColor),
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
                                              ? AppColor.callColor
                                              : AppColor.secondryColor,
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
                                          ? AppColor.gracyColor
                                          : AppColor.secondryColor,
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
                                  ? AppColor.callColor
                                  : AppColor.fillColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(color: AppColor.fillColor),
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
                                              ? AppColor.secondryColor
                                              : AppColor.callColor,
                                          BlendMode.srcIn),
                                      image: const AssetImage(
                                          IconConstants.icCorporateShield),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      4 /
                                      100,
                                ),
                                Text(
                                  appLocalization(context).corporateProtection,
                                  style: TextStyle(
                                      color: selectedTab == 1
                                          ? AppColor.secondryColor
                                          : AppColor.gracyColor,
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
