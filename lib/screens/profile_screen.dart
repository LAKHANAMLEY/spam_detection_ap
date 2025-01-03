import 'package:spam_delection_app/lib.dart';

class Profile extends StatelessWidget {
  final bool? showAppBar;

  const Profile({super.key, this.showAppBar = true});

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrl = [
      IconConstants.icSecurityCall,
      IconConstants.icTimeClock,
      IconConstants.icEpSearch,
      IconConstants.icMessageCancel
    ];

    final List<Map> items = [
      {
        "key": appLocalization(context).lastThirtyDays,
        "value": "30",
      },
      {
        "key": appLocalization(context).lastThreeMonths,
        "value": "90",
      },
      {
        "key": appLocalization(context).lastSixMonths,
        "value": "180",
      },
      {
        "key": appLocalization(context).lastThisYear,
        "value": "365",
      },
      {
        "key": appLocalization(context).lastAllTime,
        "value": "0",
      },
    ];
    final List<String> spamTexts = [
      appLocalization(context).spamIdentified,
      appLocalization(context).timeSpammers,
      appLocalization(context).unknownIdentified,
      appLocalization(context).messagesSpam,
    ];
    // var argument = args(context) as Profile?;
    sharedPrefBloc.add(GetUserDataFromLocalEvent());
    var dashboardStatisticsBloc = ApiBloc(ApiBlocInitialState());
    var selectStatisticsDaysBloc = SelectionBloc(SelectStringState("30"));
    selectStatisticsDaysBloc.add(SelectStringEvent("30"));
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: (showAppBar ?? showAppBar ?? false)
          ? CustomAppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Image.asset(
                    IconConstants.icsettingPro,
                    height: MediaQuery.of(context).size.height * 3 / 100,
                  ),
                )
              ],
            )
          : null,
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
                                ? InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AppRoutes.imageView,
                                          arguments: ImageView(
                                            imageUrl: user.photo,
                                          ));
                                    },
                                    child: CircleAvatar(
                                      backgroundColor:
                                          AppColor.vanishColor.withOpacity(0.2),
                                      radius: 43.0,
                                      backgroundImage: NetworkImage(
                                        user.photo ?? "",
                                      ),
                                      // child: Align(
                                      //   alignment: Alignment.bottomRight,
                                      //   child: CircleAvatar(
                                      //       backgroundColor: AppColor.callColor,
                                      //       radius: 12.0,
                                      //       child: Image.asset(
                                      //         IconConstants.icCamera,
                                      //         height: MediaQuery.of(context)
                                      //                 .size
                                      //                 .height *
                                      //             2 /
                                      //             100,
                                      //       )),
                                      // ),
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundColor:
                                        AppColor.vanishColor.withOpacity(0.2),
                                    radius: 43.0,
                                    backgroundImage: const AssetImage(
                                      IconConstants.iccircleAvater,
                                    ),
                                    // child: Align(
                                    //   alignment: Alignment.bottomRight,
                                    //   child: CircleAvatar(
                                    //       backgroundColor: AppColor.callColor,
                                    //       radius: 12.0,
                                    //       child: Image.asset(
                                    //         IconConstants.icCamera,
                                    //         height: MediaQuery.of(context)
                                    //                 .size
                                    //                 .height *
                                    //             2 /
                                    //             100,
                                    //       )),
                                    // ),
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
                            // Navigator.pushNamed(context, AppRoutes.planType);
                            bottomNavigationBloc.add(SelectIntEvent(3));
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
                                Text(
                                  appLocalization(context).upgradePremium,
                                  style: const TextStyle(
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
                          // height: MediaQuery.of(context).size.height * 56 / 100,
                          // width: MediaQuery.of(context).size.width * 90 / 100,
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
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: BlocConsumer(
                                      bloc: selectStatisticsDaysBloc,
                                      listener: (context, state) {
                                        if (state is SelectStringState) {
                                          dashboardStatisticsBloc.add(
                                              DashboardStatisticsEvent(
                                                  days: state.value ?? "0"));
                                        }
                                      },
                                      builder: (context, state) {
                                        if (state is SelectStringState) {
                                          return DropdownButton(
                                            value: state.value,
                                            // underline: const SizedBox.shrink(),
                                            // icon: Image.asset(
                                            //   IconConstants.icDrop,
                                            //   // width: MediaQuery.of(context).size.width *
                                            //   //     3 /
                                            //   //     100,
                                            //   // height:
                                            //   //     MediaQuery.of(context).size.height *
                                            //   //         3 /
                                            //   //         100,
                                            //   color: AppColor.callColor,
                                            // ),
                                            hint: Text(
                                              appLocalization(context)
                                                  .lastThirtyDays,
                                              style: const TextStyle(
                                                  color: AppColor.callColor,
                                                  fontSize: 14,
                                                  fontFamily:
                                                      AppFont.fontFamily,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            items: items.map((value) {
                                              return DropdownMenuItem<String>(
                                                value: value['value'],
                                                child: Text(value['key']),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              selectStatisticsDaysBloc.add(
                                                  SelectStringEvent(newValue));
                                            },
                                          );
                                        }
                                        return const Loader();
                                      }),
                                ),
                                BlocBuilder(
                                    bloc: dashboardStatisticsBloc,
                                    builder: (context, state) {
                                      if (state is DashboardStatisticsState) {
                                        var data =
                                            state.value.statisticsDashboardData;
                                        List<String> cardTexts = [
                                          data?.totalSpamCalls.toString() ??
                                              "0",
                                          data?.timeSavedFromSpammers
                                                  .toString() ??
                                              "0",
                                          data?.unknownNumber.toString() ?? "0",
                                          data?.messageMovedToSpam.toString() ??
                                              "0"
                                        ];
                                        return GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 1.2 / 1.2,
                                          ),
                                          itemCount: 4,
                                          primary: false,
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
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
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4)),
                                                          color: AppColor
                                                              .secondryColor),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(8),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(children: [
                                                          Image.asset(
                                                            imageUrl[index],
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                5 /
                                                                100,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                5 /
                                                                100,
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
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
                                                                fontFamily: AppFont
                                                                    .fontFamily),
                                                          )
                                                        ]),
                                                        Text(spamTexts[index],
                                                            style: const TextStyle(
                                                                color: AppColor
                                                                    .spelledColor,
                                                                fontFamily: AppFont
                                                                    .fontFamily,
                                                                fontSize: 16)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                      return const Loader();
                                    }),
                              ],
                            ),
                          ),
                        ),
                        if (user.userRole?.toLowerCase() == "user") ...[
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 5 / 100,
                          ),
                          SubMenu(
                            title: appLocalization(context).editProfile,
                            icon: IconConstants.icEdit,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.editProfile);
                            },
                          ),
                        ],
                        if (user.userRole?.toLowerCase() == "corporate") ...[
                          10.height(),
                          SubMenu(
                            title:
                                appLocalization(context).corporateEditProfile,
                            icon: IconConstants.icEdit,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.corporateProfile);
                            },
                          )
                        ],
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        SubMenu(
                          title: appLocalization(context).editSecurityPin,
                          icon: IconConstants.icEdit,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ChangeSecurity()));
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        SubMenu(
                          title: appLocalization(context).changePassword,
                          icon: IconConstants.icchangePass,
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.changePassword);
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        SubMenu(
                          title: appLocalization(context).addAlternativeEmail,
                          icon: IconConstants.icalternativeEmail,
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.alternativeEmail);
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        SubMenu(
                          title: appLocalization(context).changeLanguage,
                          icon: IconConstants.icalternativeEmail,
                          onTap: () {
                            _showEditOptions(context);
                          },
                        ),
                        if (user.userRole?.toLowerCase() == "user") ...[
                          10.height(),
                          SubMenu(
                            title: appLocalization(context).familyList,
                            icon: IconConstants.icalternativeEmail,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.familyMemberList);
                            },
                          ),
                        ],
                        if (user.userRole?.toLowerCase() == "corporate") ...[
                          10.height(),
                          SubMenu(
                            title: appLocalization(context).staffList,
                            icon: IconConstants.icalternativeEmail,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.staffMember);
                            },
                          ),
                        ],
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
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

  void _showEditOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                appLocalization(context).changeALanguage,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16.0),
              FutureBuilder(
                future: fetchLanguages(),
                builder:
                    (context, AsyncSnapshot<CountryLanguageResponse> snapshot) {
                  if (snapshot.hasData) {
                    var languages = snapshot.data?.languagelist ?? [];

                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: languages.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading:
                                const Icon(Icons.language, color: Colors.green),
                            title: Text(languages[index].name ?? ""),
                            onTap: () {
                              localizationBloc.add(ChangeLocaleEvent(
                                  Locale.fromSubtags(
                                      languageCode:
                                          languages[index].id ?? "")));
                              Navigator.pop(context);

                              // Navigator.pop(context);
                              // Call your gallery function here
                              //_chooseFromGallery();
                            },
                          );
                        });
                  }
                  return const Loader();
                },
              ),
              const SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  appLocalization(context).cancelTxt,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
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
            //height: MediaQuery.of(context).size.height * 7 / 100,
            // width: MediaQuery.of(context).size.height * 90 / 100,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                border: Border.all(
                  color: AppColor.greyarrowColor,
                ),
                color: AppColor.secondryColor),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Image.asset(
                          icon,
                          height: MediaQuery.of(context).size.height * 5 / 100,
                          width: MediaQuery.of(context).size.width * 5 / 100,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 2 / 100,
                        ),
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                                color: AppColor.thumbColor, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    IconConstants.icEditDetails,
                    height: MediaQuery.of(context).size.height * 6 / 100,
                    width: MediaQuery.of(context).size.width * 6 / 100,
                  )
                ],
              ),
            )));
  }
}
