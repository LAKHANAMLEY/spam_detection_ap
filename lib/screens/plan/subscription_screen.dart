import 'package:spam_delection_app/lib.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool isCallProtectionEnabled = true;

  bool isMessageProtectionEnabled = false;

  bool isEmailProtectionEnabled = false;

  // var subscriptionListBloc = ApiBloc(ApiBlocInitialState());

  @override
  void initState() {
    userBloc.add(GetUserProfileEvent());
    // subscriptionListBloc.add(GetPlanListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  10.height(),
                  Image.asset(
                    IconConstants.icHomeSecurity,
                    height: MediaQuery.of(context).size.height * 15 / 100,
                  ),
                  // 1.height(),
                  Text(
                    appLocalization(context).pleaseActiveYourSubscription,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: AppColor.deepYellowColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFont.fontFamily),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 100,
                  ),
                  Text(
                    appLocalization(context).youAreProtected,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: AppColor.materialGreyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFont.fontFamily),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 4 / 100,
                  ),
                  // BlocBuilder(
                  //     bloc: subscriptionListBloc,
                  //     builder: (context, state) {
                  //       if (state is GetPlanListState) {
                  //         var plans = state.value.planslist ?? [];
                  //         if (plans.isEmpty) {
                  //           return Center(
                  //             child: Text(appLocalization(context).noData),
                  //           );
                  //         }
                  //         return ListView.builder(
                  //             physics: const NeverScrollableScrollPhysics(),
                  //             shrinkWrap: true,
                  //             itemCount: plans.length,
                  //             itemBuilder: (context, index) {
                  //               return SecurityOption(
                  //                 image: IconConstants.icplusCall,
                  //                 title: plans[index].plansType ?? "",
                  //                 description: plans[index].description ?? "",
                  //                 isEnabled: plans[index].isActive ?? false,
                  //                 onToggle: (value) {
                  //                   setState(() {
                  //                     plans[index].isActive = value;
                  //                   });
                  //                 },
                  //               );
                  //             });
                  //       }
                  //       return const Loader();
                  //     }),
                  BlocBuilder(
                      bloc: userBloc,
                      builder: (context, state) {
                        if (state is GetUserProfileState) {
                          var user = User.fromJson(state.value.data);
                          var plan = user.planDetails;
                          return Column(
                            children: [
                              SecurityOption(
                                image: IconConstants.icCallSolar,
                                title: appLocalization(context).callProtection,
                                description:
                                    appLocalization(context).allSpamCalls,
                                isEnabled: plan?.callProtection == "1",
                                onToggle: (value) {
                                  if (plan?.callProtection != "1") {
                                    onActivatePressed();
                                  }
                                  // setState(() {
                                  //   isCallProtectionEnabled = true;
                                  // });
                                },
                              ),
                              SecurityOption(
                                image: IconConstants.icMessageLock,
                                title:
                                    appLocalization(context).protectAIMessages,
                                description: appLocalization(context)
                                    .yourMessagesAreCurrently,
                                isEnabled: plan?.smsProtection == "1",
                                onToggle: (value) {
                                  if (plan?.smsProtection != "1") {
                                    onActivatePressed();
                                  }

                                  // setState(() {
                                  //   isMessageProtectionEnabled = value;
                                  // });
                                },
                              ),
                              SecurityOption(
                                image: IconConstants.icEmailLock,
                                title: appLocalization(context).protectAIEmail,
                                description: appLocalization(context)
                                    .yourEmailsAreCurrently,
                                isEnabled: plan?.emailProtection == "1",
                                onToggle: (value) {
                                  if (plan?.emailProtection != "1") {
                                    onActivatePressed();
                                  }

                                  // setState(() {
                                  //   isEmailProtectionEnabled = value;
                                  // });
                                },
                              ),
                            ],
                          );
                        }
                        return const Loader();
                      }),
                ]),
          ),
        ),
      ),
    );
  }

  void onActivatePressed() {
    showCustomDialog(context, dialogType: DialogType.alert, onOkPressed: () {
      Navigator.pop(context);
      Navigator.pushNamed(context, AppRoutes.planList);
      // bottomNavigationBloc.add(SelectIntEvent(3));
    },
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text("Upgrade to premium to active this feature")],
        ));
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
                backgroundColor: AppColor.darkPurpleColor,
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
                        color: AppColor.darkPurpleColor),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(
                        color: AppColor.constantGraniteColor, fontSize: 14),
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
                    inactiveTrackColor: AppColor.whiteColor,
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
