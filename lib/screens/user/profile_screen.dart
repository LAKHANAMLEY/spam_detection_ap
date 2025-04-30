import 'package:spam_delection_app/lib.dart';

class Profile extends StatelessWidget {
  final bool? showAppBar;

  const Profile({super.key, this.showAppBar = true});

  @override
  Widget build(BuildContext context) {
    StatisticsDashboardData? data;
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
                    IconConstants.icSettingPro,
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
                  color: AppColor.whiteColor,
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
                                      backgroundColor: AppColor.whiteCreamColor
                                          .withOpacity(0.2),
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
                                    backgroundColor: AppColor.whiteCreamColor
                                        .withOpacity(0.2),
                                    radius: 43.0,
                                    backgroundImage: const AssetImage(
                                      IconConstants.icCircleAvatar,
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
                              color: AppColor.blackColor,
                              fontFamily: AppFont.fontFamily,
                              fontWeight: FontWeight.w700,
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            '${user.email}',
                            style: textTheme(context)
                                .bodySmall
                                ?.copyWith(color: AppColor.magentaColor),
                          ),
                        ),
                        20.height(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.planList);
                            //bottomNavigationBloc.add(SelectIntEvent(3));
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            // height:
                            //     MediaQuery.of(context).size.height * 9 / 100,
                            // width:
                            //     MediaQuery.of(context).size.height * 80 / 100,
                            decoration: const BoxDecoration(
                              color: AppColor.darkPurpleColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  IconConstants.icPremiumStar,
                                  height: 40,
                                  width: 40,
                                ),
                                10.width(),
                                Text(
                                  appLocalization(context).upgradePremium,
                                  style: const TextStyle(
                                      color: AppColor.whiteColor,
                                      fontSize: 20,
                                      fontFamily: AppFont.fontFamily,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                        ),
                        20.height(),
                        Container(
                          // height: MediaQuery.of(context).size.height * 56 / 100,
                          // width: MediaQuery.of(context).size.width * 90 / 100,
                          decoration: BoxDecoration(
                            color: AppColor.snowWhiteColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(color: AppColor.whiteBrownColor),
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
                                            dropdownColor: Color(0xffFFE8E3),
                                            underline: SizedBox.shrink(),
                                            value: state.value,
                                            hint: Text(
                                              appLocalization(context)
                                                  .lastThirtyDays,
                                              style:
                                                  textTheme(context).bodyLarge,
                                            ),
                                            items: items.map((value) {
                                              return DropdownMenuItem<String>(
                                                value: value['value'],
                                                child: Text(
                                                  value['key'],
                                                  style: textTheme(context)
                                                      .bodyLarge,
                                                ),
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
                                BlocConsumer(
                                    bloc: dashboardStatisticsBloc,
                                    listener: (context, state) {
                                      if (state is DashboardStatisticsState) {
                                        data =
                                            state.value.statisticsDashboardData;
                                      }
                                    },
                                    builder: (context, state) {
                                      // if (state is DashboardStatisticsState) {
                                      // var data =
                                      //     state.value.statisticsDashboardData;
                                      List<String> cardTexts = [
                                        data?.totalSpamCalls.toString() ?? "0",
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
                                          childAspectRatio: 1.2 / 1,
                                        ),
                                        itemCount: 4,
                                        primary: false,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: () {
                                              if (index == 0) {
                                                Navigator.pushNamed(context,
                                                    AppRoutes.spamList);
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.all(8),
                                              padding: const EdgeInsets.all(8),
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: AppColor.whiteColor),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Image.asset(
                                                        imageUrl[index],
                                                        height: 30,
                                                        width: 30,
                                                      ),
                                                      10.width(),
                                                      Text(
                                                        cardTexts[index],
                                                        style:
                                                            textTheme(context)
                                                                .titleLarge,
                                                      )
                                                    ],
                                                  ),
                                                  5.height(),
                                                  Text(
                                                    spamTexts[index],
                                                    style: textTheme(context)
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            color: AppColor
                                                                .slatWhiteColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                      // }
                                      // return const Loader();
                                    }),
                              ],
                            ),
                          ),
                        ),
                        if (user.userRole?.toLowerCase() == "user") ...[
                          // 10.height(),
                          SubMenu(
                            title: appLocalization(context).editProfile,
                            icon: IconConstants.icEdit,
                            iconColor: AppColor.greyDecent,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.editProfile);
                            },
                          ),
                        ],
                        if (user.userRole?.toLowerCase() == "corporate") ...[
                          // 10.height(),
                          SubMenu(
                            title:
                                appLocalization(context).corporateEditProfile,
                            icon: IconConstants.icEdit,
                            iconColor: AppColor.greyDecent,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.corporateProfile);
                            },
                          )
                        ],
                        // 10.height(),
                        SubMenu(
                          title: appLocalization(context).editSecurityPin,
                          icon: IconConstants.icEditPin,
                          iconColor: AppColor.greyDecent,
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.changeSecurity);
                          },
                        ),
                        // 10.height(),

                        SubMenu(
                          title: appLocalization(context).changePassword,
                          icon: IconConstants.icChangePass,
                          iconColor: AppColor.greyDecent,
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.changePassword);
                          },
                        ),
                        // 10.height(),

                        SubMenu(
                          title: appLocalization(context).addAlternativeEmail,
                          icon: IconConstants.icAlternativeEmail,
                          iconColor: AppColor.greyDecent,
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.alternativeEmail);
                          },
                        ),
                        // 10.height(),

                        SubMenu(
                          title: appLocalization(context).changeLanguage,
                          icon: IconConstants.icLanguage,
                          iconColor: AppColor.greyDecent,
                          onTap: () {
                            _showEditOptions(context);
                          },
                        ),
                        if (user.userRole?.toLowerCase() == "user") ...[
                          // 10.height(),
                          SubMenu(
                            title: appLocalization(context).familyList,
                            icon: IconConstants.icFamilyRest,
                            iconColor: AppColor.greyDecent.withOpacity(0.8),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.familyMemberList);
                            },
                          ),
                        ],
                        if (user.userRole?.toLowerCase() == "corporate") ...[
                          // 10.height(),
                          SubMenu(
                            title: appLocalization(context).staffList,
                            iconColor: AppColor.greyDecent,
                            icon: IconConstants.icAlternativeEmail,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.staffMember);
                            },
                          ),
                        ],
                        // 10.height(),

                        // SubMenu(
                        //   title: appLocalization(context).logout,
                        //   icon: Icons.logout,
                        //   onTap: () {
                        //     Navigator.pushNamed(context, AppRoutes.staffMember);
                        //   },
                        // ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * 2 / 100,
                        // ),
                        SubMenu(
                          title: appLocalization(context).logout,
                          icon: IconConstants.icLogoutDataIcon,
                          iconColor: AppColor.redColor,
                          onTap: () async {
                            showLogoutDialog(context);
                            //  Navigator.pushNamed(
                            //    context, AppRoutes.);
                          },
                        ),
                        // 10.height(),
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
  final Color iconColor;
  final void Function()? onTap;

  const SubMenu(
      {super.key,
      required this.title,
      this.onTap,
      required this.icon,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
            //height: MediaQuery.of(context).size.height * 7 / 100,
            // width: MediaQuery.of(context).size.height * 90 / 100,
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(
                color: AppColor.whiteBrownColor,
              ),
            ),
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
                          color: iconColor,

                          //color: AppColor.constantGraniteColor
                        ),
                        10.width(),
                        Expanded(
                          child: Text(
                            title,
                            style: textTheme(context).bodyMedium?.copyWith(
                                color: AppColor.constantGraniteColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    IconConstants.icEditDetails,
                    height: 20,
                    width: 20,
                  )
                ],
              ),
            )));
  }
}
