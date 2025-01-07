import 'package:spam_delection_app/lib.dart';

class ViewedProfile extends StatefulWidget {
  const ViewedProfile({super.key});

  @override
  State<ViewedProfile> createState() => _ViewedProfileState();
}

class _ViewedProfileState extends State<ViewedProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: appLocalization(context).whoViewedMyProfile,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FacePile(
                faces: [
                  FaceHolder(
                    id: '1',
                    name: 'user 1',
                    avatar:
                        const NetworkImage('https://i.pravatar.cc/300?img=1'),
                  ),
                  FaceHolder(
                    id: '2',
                    name: 'user 2',
                    avatar:
                        const NetworkImage('https://i.pravatar.cc/300?img=2'),
                  ),
                  FaceHolder(
                    id: '3',
                    name: 'user 3',
                    avatar:
                        const NetworkImage('https://i.pravatar.cc/300?img=3'),
                  ),
                ],
                faceSize: 80,
                facePercentOverlap: .4,
                borderColor: AppColor.secondryColor,
              ),
              10.height(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  appLocalization(context).inIndiaViewedYourProfileRecently,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
              Text(
                appLocalization(context).upgradeToPremiumOutWho,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(appLocalization(context).learnMore)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 8 / 100,
                width: MediaQuery.of(context).size.width * 90 / 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  color: Colors.lightBlueAccent.withOpacity(0.2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        appLocalization(context)
                            .upgradeUsersSpamDetectionPremium,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              10.height(),
              Container(
                height: MediaQuery.of(context).size.height * 7 / 100,
                width: MediaQuery.of(context).size.height * 90 / 100,
                decoration: const BoxDecoration(color: Colors.blueAccent),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        appLocalization(context).yearlyPlan,
                        style: const TextStyle(color: AppColor.secondryColor),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "\$20/Year",
                            style: TextStyle(color: AppColor.secondryColor),
                          ),
                          5.width(),
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 3 / 100,
                            width: MediaQuery.of(context).size.width * 18 / 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: AppColor.yellowLightColor),
                            child: const Text(
                              "Save 25%",
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              10.height(),
              Container(
                height: MediaQuery.of(context).size.height * 7 / 100,
                width: MediaQuery.of(context).size.height * 90 / 100,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        appLocalization(context).quarterlyPlan,
                        style: const TextStyle(color: Colors.blueAccent),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "\$12.9/3 Months",
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                          5.width(),
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 3 / 100,
                            width: MediaQuery.of(context).size.width * 18 / 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.blueAccent),
                            child: const Text(
                              "Save 23%",
                              style: TextStyle(color: AppColor.secondryColor),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              10.height(),
              Container(
                height: MediaQuery.of(context).size.height * 7 / 100,
                width: MediaQuery.of(context).size.height * 90 / 100,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        appLocalization(context).monthlyPlan,
                        style: const TextStyle(color: Colors.blueAccent),
                      ),
                      const Text(
                        "\$7.99/month",
                        style: TextStyle(color: Colors.blueAccent),
                      )
                    ],
                  ),
                ),
              ),
              Text(appLocalization(context).freeTrialForNewSubscribers),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  appLocalization(context).youCanManageYourSubscription,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        )));
  }
}
