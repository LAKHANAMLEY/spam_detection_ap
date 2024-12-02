import 'package:spam_delection_app/lib.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<String> imageUrl = [
    IconConstants.icspamCheck,
    IconConstants.icClock,
    IconConstants.icsearchCheck,
    IconConstants.icmessageCheck
  ];
  final List<String> cardTexts = ['3', '68s', '25', '38'];
  final List<String> spamTexts = [
    StringConstants.spamcallstext,
    StringConstants.timesavestext,
    StringConstants.unknowntext,
    StringConstants.messagestext,
  ];

  @override
  void initState() {
    // userBloc.add(GetUserProfileEvent());
    sharedPrefBloc.add(GetUserDataFromLocalEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      appBar: AppBar(
        backgroundColor: AppColor.secondryColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Image.asset(
              IconConstants.backIcon,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Image.asset(
              IconConstants.icsettingPro,
              height: MediaQuery.of(context).size.height * 3 / 100,
            ),
          )
        ],
      ),
      body: BlocConsumer(
          bloc: sharedPrefBloc,
          listener: (context, state) {
            if (state is GetUserDataFromLocalState) {}
            // if (state is GetUserProfileState) {
            //   if (state.value.statusCode == 200) {
            //   } else if (state.value.statusCode ==
            //       HTTPStatusCodes.sessionExpired) {
            //     sessionExpired(context, state.value.message ?? "");
            //   } else {
            //     showCustomDialog(context,
            //         dialogType: DialogType.failed,
            //         subTitle: state.value.message);
            //   }
            // }
            // if (state is UpdateProfileState) {
            //   if (state.value.statusCode == 200) {
            //     showCustomDialog(context,
            //         subTitle: state.value.message,
            //         dialogType: DialogType.success);
            //   } else if (state.value.statusCode ==
            //       HTTPStatusCodes.sessionExpired) {
            //     sessionExpired(context, state.value.message ?? "");
            //   } else {
            //     showCustomDialog(context,
            //         subTitle: state.value.message,
            //         dialogType: DialogType.failed);
            //   }
            // }
          },
          builder: (context, state) {
            if (state is GetUserDataFromLocalState) {
              // var user = User.fromJson(state.value.data);
              var user = state.user;
              return Container(
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColor.secondryColor,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: SizedBox(
                            child: (user.photo?.isNotEmpty ?? false)
                                ? CircleAvatar(
                                    backgroundColor:
                                        AppColor.vanishColor.withOpacity(0.2),
                                    radius: 43.0,
                                    backgroundImage: NetworkImage(
                                      user.photo ?? "",
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: CircleAvatar(
                                          backgroundColor: AppColor.callColor,
                                          radius: 12.0,
                                          child: Image.asset(
                                            IconConstants.icCamera,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                2 /
                                                100,
                                          )),
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundColor:
                                        AppColor.vanishColor.withOpacity(0.2),
                                    radius: 43.0,
                                    backgroundImage: const AssetImage(
                                      IconConstants.iccircleAvater,
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: CircleAvatar(
                                          backgroundColor: AppColor.callColor,
                                          radius: 12.0,
                                          child: Image.asset(
                                            IconConstants.icCamera,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                2 /
                                                100,
                                          )),
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 1 / 100,
                        ),
                        Center(
                          child: Text(
                            user.name ?? "",
                            style: const TextStyle(
                              color: AppColor.primaryColor,
                              fontFamily: AppFont.fontFamily,
                              fontWeight: FontWeight.w700,
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            '${user.email}',
                            style: const TextStyle(
                              color: AppColor.borderstekColor,
                              fontFamily: AppFont.fontFamily,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.planType);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            height:
                                MediaQuery.of(context).size.height * 9 / 100,
                            width:
                                MediaQuery.of(context).size.height * 80 / 100,
                            decoration: const BoxDecoration(
                              color: AppColor.callColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  IconConstants.icpremiumStar,
                                  height: MediaQuery.of(context).size.height *
                                      10 /
                                      100,
                                  width: MediaQuery.of(context).size.width *
                                      10 /
                                      100,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      4 /
                                      100,
                                ),
                                const Text(
                                  StringConstants.upgradetext,
                                  style: TextStyle(
                                      color: AppColor.secondryColor,
                                      fontSize: 20,
                                      fontFamily: AppFont.fontFamily,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 5 / 100,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 55 / 100,
                          width: MediaQuery.of(context).size.width * 90 / 100,
                          decoration: BoxDecoration(
                            color: AppColor.whitedeep,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6.0)),
                            border: Border.all(color: AppColor.vanishColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      2 /
                                      100,
                                ),
                                const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Last 30 days",
                                      style: TextStyle(
                                          color: AppColor.lastColor,
                                          fontSize: 18,
                                          fontFamily: AppFont.fontFamily,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.start,
                                    )),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      2 /
                                      100,
                                ),
                                GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 1.2 / 1.2),
                                  itemCount: 4,
                                  primary: false,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        if (index == 0) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SpamList()));
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              color: AppColor.secondryColor),
                                          child: Container(
                                            margin: const EdgeInsets.all(8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(children: [
                                                  Image.asset(
                                                    imageUrl[index],
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            5 /
                                                            100,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            5 /
                                                            100,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            2 /
                                                            100,
                                                  ),
                                                  Text(
                                                    cardTexts[index],
                                                    style: const TextStyle(
                                                        color: AppColor
                                                            .borderstekColor,
                                                        fontSize: 20,
                                                        fontFamily:
                                                            AppFont.fontFamily),
                                                  )
                                                ]),
                                                Text(spamTexts[index],
                                                    style: const TextStyle(
                                                        color: AppColor
                                                            .spelledColor,
                                                        fontFamily:
                                                            AppFont.fontFamily,
                                                        fontSize: 16)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 4 / 100,
                        ),
                        SubMenu(
                          title: 'Edit Profile',
                          icon: IconConstants.icEdit,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const EditProfile()));
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        SubMenu(
                          title: 'Edit Security Pin',
                          icon: IconConstants.icEditSecurity,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditSecurityPin()));
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 7 / 100,
                          width: MediaQuery.of(context).size.height * 90 / 100,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(2.0)),
                              border: Border.all(
                                  color: AppColor.greyarrowColor, width: 1),
                              color: AppColor.secondryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  IconConstants.icchangePass,
                                  height: MediaQuery.of(context).size.height *
                                      5 /
                                      100,
                                  width: MediaQuery.of(context).size.width *
                                      5 /
                                      100,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      2 /
                                      100,
                                ),
                                const Text(
                                  'Change Password',
                                  style: TextStyle(
                                      color: AppColor.thumbColor, fontSize: 18),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      30 /
                                      100,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ChangePassword()));
                                  },
                                  child: Image.asset(
                                    IconConstants.icviewArrow,
                                    height: MediaQuery.of(context).size.height *
                                        6 /
                                        100,
                                    width: MediaQuery.of(context).size.width *
                                        6 /
                                        100,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 7 / 100,
                          width: MediaQuery.of(context).size.height * 90 / 100,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(2.0)),
                              border: Border.all(
                                  color: AppColor.greyarrowColor, width: 1),
                              color: AppColor.secondryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  IconConstants.icalternativeEmail,
                                  height: MediaQuery.of(context).size.height *
                                      6 /
                                      100,
                                  width: MediaQuery.of(context).size.width *
                                      6 /
                                      100,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      2 /
                                      100,
                                ),
                                const Text(
                                  ' Add Alertantive Email',
                                  style: TextStyle(
                                      color: AppColor.thumbColor, fontSize: 18),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      20 /
                                      100,
                                ),
                                Image.asset(
                                  IconConstants.icviewArrow,
                                  height: MediaQuery.of(context).size.height *
                                      6 /
                                      100,
                                  width: MediaQuery.of(context).size.width *
                                      6 /
                                      100,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 5 / 100,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const Loader();
          }),
    );
  }
}

class SubMenu extends StatelessWidget {
  final String title;
  final String icon;
  final void Function()? onTap;
  const SubMenu(
      {super.key, required this.title, this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // height: MediaQuery.of(context).size.height * 7 / 100,
        // width: MediaQuery.of(context).size.height * 90 / 100,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(2.0)),
            border: Border.all(color: AppColor.greyarrowColor, width: 1),
            color: AppColor.secondryColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    icon,
                    height: MediaQuery.of(context).size.height * 5 / 100,
                    width: MediaQuery.of(context).size.width * 5 / 100,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 2 / 100,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                        color: AppColor.thumbColor, fontSize: 18),
                  ),
                ],
              ),

              // SizedBox(
              //   width: MediaQuery.of(context).size.width * 46 / 100,
              // ),
              Image.asset(
                IconConstants.icviewArrow,
                height: MediaQuery.of(context).size.height * 6 / 100,
                width: MediaQuery.of(context).size.width * 6 / 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
