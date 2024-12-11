import 'package:spam_delection_app/lib.dart';

class PlanDetail extends StatefulWidget {
  final Planslist? plan;
  const PlanDetail({super.key, this.plan});

  @override
  State<PlanDetail> createState() => _PlanDetailState();
}

class _PlanDetailState extends State<PlanDetail> {
  int Selectedtab = 0;
  int _selection = 0;
  int SelectedPlan = 0;

  Planslist? plan;
  @override
  Widget build(BuildContext context) {
    var arg = args(context) as PlanDetail;
    plan = arg.plan;
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      appBar: AppBar(
        backgroundColor: AppColor.secondryColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                IconConstants.backIcon,
              ),
            ),
          ),
        ),
        title: Image.asset(
          IconConstants.icBroadlogo,
          height: MediaQuery.of(context).size.height * 35 / 100,
          width: MediaQuery.of(context).size.width * 35 / 100,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(height: MediaQuery.of(context).size.height * 3 / 100),
            Image.asset(
              IconConstants.icpremiumprotection,
              height: MediaQuery.of(context).size.height * 15 / 100,
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Text(
                appLocalization(context).personalProtection,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColor.callColor,
                    fontSize: 25,
                    fontFamily: AppFont.fontFamily,
                    fontWeight: FontWeight.w600),
              ),
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Text(
                appLocalization(context).spamScamDetection,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColor.verifyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFont.fontFamily),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selection = 0;
                        });
                      },
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 6 / 100,
                            width: MediaQuery.of(context).size.width * 28 / 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: _selection == 1
                                      ? AppColor.callColor
                                      : AppColor.callColor,
                                  width: 1),
                              color: Selectedtab == 1
                                  ? AppColor.callColor
                                  : AppColor.callColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Radio(
                                //focusColor: AppColor.decentgreyColor,
                                activeColor: _selection == 1
                                    ? AppColor.borderstekColor
                                    : AppColor.secondryColor,
                                groupValue: _selection,
                                onChanged: (selectTime) {
                                  selectTime(int timeSelected) {
                                    setState(() {
                                      _selection = timeSelected;
                                    });
                                  }
                                },
                                value: 0,
                              ),
                              Text(
                                appLocalization(context).calls,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppFont.fontFamily,
                                    color: _selection == 1
                                        ? AppColor.callColor
                                        : AppColor.secondryColor,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selection = 0;
                        });
                      },
                      child: Stack(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 5 / 100,
                          ),
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 6 / 100,
                            width: MediaQuery.of(context).size.width * 28 / 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColor.borderstekColor, width: 1),
                              color: _selection == 1
                                  ? AppColor.callColor
                                  : AppColor.secondryColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 2 / 100,
                          ),
                          Row(
                            children: <Widget>[
                              Radio(
                                // focusColor: AppColor.decentgreyColor,
                                activeColor: AppColor.decentgreyColor,
                                groupValue: _selection,
                                onChanged: (selectTime) {
                                  selectTime(int timeSelected) {
                                    setState(() {
                                      _selection = timeSelected;
                                    });
                                  }
                                },
                                value: 0,
                              ),
                              Text(
                                appLocalization(context).sms,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppFont.fontFamily,
                                    color: AppColor.callColor,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selection = 0;
                        });
                      },
                      child: Stack(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 5 / 100,
                          ),
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 6 / 100,
                            width: MediaQuery.of(context).size.width * 28 / 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColor.borderstekColor, width: 1),
                              color: AppColor.secondryColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 2 / 100,
                          ),
                          Row(
                            children: <Widget>[
                              Radio(
                                // focusColor: AppColor.decentgreyColor,
                                activeColor: AppColor.decentgreyColor,
                                groupValue: _selection,
                                onChanged: (selectTime) {
                                  selectTime(int timeSelected) {
                                    setState(() {
                                      _selection = timeSelected;
                                    });
                                  }
                                },
                                value: 0,
                              ),
                              Text(
                                appLocalization(context).email,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppFont.fontFamily,
                                    color: AppColor.callColor,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            10.height(),
            SizedBox(
              height: 200,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  var months = ["3\nmonth", "6\nmonth", "1\nyear"];
                  var prices = [
                    plan?.threeMonthPrice ?? "0",
                    plan?.sixMonthPrice ?? "0",
                    plan?.yearlyPrice ?? "0"
                  ];
                  return PlanDurationTypeCardView(
                    planId: index,
                    selectedPlanId: SelectedPlan,
                    month: months[index],
                    price: prices[index],
                    onTap: () {
                      SelectedPlan = index;
                      setState(() {});
                    },
                  );
                },
              ),
            ),
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: [
            //       GestureDetector(
            //         onTap: () {
            //           setState(() {
            //             SelectedPlan = 0;
            //             //  Navigator.push(context, MaterialPageRoute(builder: (context)=>PlanDetail()));
            //           });
            //         },
            //         child: Card(
            //           elevation: 2.0, // Optional: adds shadow to the card
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(
            //                 8), // Applies general rounding to the card if needed
            //           ),
            //           color: Colors.white,
            //           child: Column(
            //             // mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               // Top Section
            //               Container(
            //                 // height:
            //                 //     MediaQuery.of(context).size.height * 10 / 100,
            //                 width: MediaQuery.of(context).size.width * 40 / 100,
            //                 padding: const EdgeInsets.all(10),
            //                 decoration: BoxDecoration(
            //                   color: SelectedPlan == 0
            //                       ? AppColor.yellowdeep
            //                       : AppColor.decentgreyColor,
            //                   borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(8),
            //                     topRight: Radius.circular(8),
            //                   ),
            //                   border: Border.all(
            //                     color: AppColor.whitedecentColor,
            //                     width: 0.5,
            //                   ),
            //                 ),
            //                 child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   crossAxisAlignment: CrossAxisAlignment.center,
            //                   children: [
            //                     const Text(
            //                       "1",
            //                       style: TextStyle(
            //                         color: AppColor.secondryColor,
            //                         fontSize: 20,
            //                         fontFamily: AppFont.fontFamily,
            //                         fontWeight: FontWeight.w600,
            //                       ),
            //                     ),
            //                     Text(
            //                       appLocalization(context).month,
            //                       style: const TextStyle(
            //                         color: AppColor.secondryColor,
            //                         fontSize: 20,
            //                         fontFamily: AppFont.fontFamily,
            //                         fontWeight: FontWeight.w600,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               const Expanded(
            //                 child: Center(
            //                   child: Text(
            //                     "\$7.99",
            //                     textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                       color: AppColor.primaryColor,
            //                       fontSize: 20,
            //                       fontFamily: AppFont.fontFamily,
            //                       fontWeight: FontWeight.w600,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         width: MediaQuery.of(context).size.width * 2 / 100,
            //       ),
            //       GestureDetector(
            //         onTap: () {
            //           setState(() {
            //             SelectedPlan = 1;
            //             //  Navigator.push(context, MaterialPageRoute(builder: (context)=>PlanDetail()));
            //           });
            //         },
            //         child: Card(
            //           elevation: 2.0, // Optional: adds shadow to the card
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(
            //                 8), // Applies general rounding to the card if needed
            //           ),
            //           child: Column(
            //             children: [
            //               // Top Section
            //               Container(
            //                 height:
            //                     MediaQuery.of(context).size.height * 10 / 100,
            //                 width: MediaQuery.of(context).size.width * 40 / 100,
            //                 decoration: BoxDecoration(
            //                   color: SelectedPlan == 1
            //                       ? AppColor.yellowdeep
            //                       : AppColor.decentgreyColor,
            //                   borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(8),
            //                     topRight: Radius.circular(8),
            //                   ),
            //                   border: Border.all(
            //                     color: AppColor.whitedecentColor,
            //                     width: 0.5,
            //                   ),
            //                 ),
            //                 child: Center(
            //                   child: Column(
            //                     mainAxisAlignment: MainAxisAlignment
            //                         .center, // Centers the text vertically
            //                     children: [
            //                       const Text(
            //                         "3",
            //                         style: TextStyle(
            //                           color: AppColor.secondryColor,
            //                           fontSize: 20,
            //                           fontFamily: AppFont.fontFamily,
            //                           fontWeight: FontWeight.w600,
            //                         ),
            //                       ),
            //                       Text(
            //                         appLocalization(context).month,
            //                         style: const TextStyle(
            //                           color: AppColor.secondryColor,
            //                           fontSize: 20,
            //                           fontFamily: AppFont.fontFamily,
            //                           fontWeight: FontWeight.w600,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //               Container(
            //                 height:
            //                     MediaQuery.of(context).size.height * 12 / 100,
            //                 width: MediaQuery.of(context).size.width * 40 / 100,
            //                 decoration: BoxDecoration(
            //                   color: AppColor.secondryColor,
            //                   borderRadius: const BorderRadius.only(
            //                     bottomLeft: Radius.circular(6),
            //                     bottomRight: Radius.circular(6),
            //                   ),
            //                   border: Border.all(
            //                     color: AppColor.vanishColor,
            //                     width: 0.5,
            //                   ),
            //                 ),
            //                 child: const Center(
            //                   child: Text(
            //                     "\$20",
            //                     textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                       color: AppColor.primaryColor,
            //                       fontSize: 20,
            //                       fontFamily: AppFont.fontFamily,
            //                       fontWeight: FontWeight.w600,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         width: MediaQuery.of(context).size.width * 2 / 100,
            //       ),
            //       GestureDetector(
            //         onTap: () {
            //           setState(() {
            //             SelectedPlan = 2;
            //             //  Navigator.push(context, MaterialPageRoute(builder: (context)=>PlanDetail()));
            //           });
            //         },
            //         child: Card(
            //           elevation: 2.0, // Optional: adds shadow to the card
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(
            //                 8), // Applies general rounding to the card if needed
            //           ),
            //           child: Column(
            //             children: [
            //               // Top Section
            //               Container(
            //                 height:
            //                     MediaQuery.of(context).size.height * 10 / 100,
            //                 width: MediaQuery.of(context).size.width * 40 / 100,
            //                 decoration: BoxDecoration(
            //                   color: SelectedPlan == 2
            //                       ? AppColor.yellowdeep
            //                       : AppColor.decentgreyColor,
            //                   borderRadius: const BorderRadius.only(
            //                     topLeft: Radius.circular(8),
            //                     topRight: Radius.circular(8),
            //                   ),
            //                   border: Border.all(
            //                     color: AppColor.whitedecentColor,
            //                     width: 0.5,
            //                   ),
            //                 ),
            //                 child: Center(
            //                   child: Column(
            //                     mainAxisAlignment: MainAxisAlignment
            //                         .center, // Centers the text vertically
            //                     children: [
            //                       const Text(
            //                         "9",
            //                         style: TextStyle(
            //                           color: AppColor.secondryColor,
            //                           fontSize: 20,
            //                           fontFamily: AppFont.fontFamily,
            //                           fontWeight: FontWeight.w600,
            //                         ),
            //                       ),
            //                       Text(
            //                         appLocalization(context).month,
            //                         style: const TextStyle(
            //                           color: AppColor.secondryColor,
            //                           fontSize: 20,
            //                           fontFamily: AppFont.fontFamily,
            //                           fontWeight: FontWeight.w600,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //               Container(
            //                 height:
            //                     MediaQuery.of(context).size.height * 12 / 100,
            //                 width: MediaQuery.of(context).size.width * 40 / 100,
            //                 decoration: BoxDecoration(
            //                   color: AppColor.secondryColor,
            //                   borderRadius: const BorderRadius.only(
            //                     bottomLeft: Radius.circular(6),
            //                     bottomRight: Radius.circular(6),
            //                   ),
            //                   border: Border.all(
            //                     color: AppColor.vanishColor,
            //                     width: 0.5,
            //                   ),
            //                 ),
            //                 child: const Center(
            //                   child: Text(
            //                     "\$50",
            //                     textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                       color: AppColor.primaryColor,
            //                       fontSize: 20,
            //                       fontFamily: AppFont.fontFamily,
            //                       fontWeight: FontWeight.w600,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //       // Add more Card widgets here as needed
            //     ],
            //   ),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 5 / 100,
            ),
            AppButton(
              text: appLocalization(context).continuePurchase,
              onPress: () {},
            )
          ]),
        ),
      ),
    );
  }
}

class PlanDurationTypeCardView extends StatelessWidget {
  final int selectedPlanId;
  final int planId;
  final String month;
  final String price;
  final void Function()? onTap;
  const PlanDurationTypeCardView(
      {super.key,
      required this.selectedPlanId,
      required this.planId,
      required this.month,
      required this.price,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // onTap: () {
      //   setState(() {
      //     selectedPlanId = 0;
      //     //  Navigator.push(context, MaterialPageRoute(builder: (context)=>PlanDetail()));
      //   });
      // },
      child: Card(
        elevation: 2.0, // Optional: adds shadow to the card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              8), // Applies general rounding to the card if needed
        ),
        color: Colors.white,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Top Section
            Container(
              // height:
              //     MediaQuery.of(context).size.height * 10 / 100,
              width: MediaQuery.of(context).size.width * 40 / 100,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: selectedPlanId == planId
                    ? AppColor.yellowdeep
                    : AppColor.decentgreyColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                border: Border.all(
                  color: AppColor.whitedecentColor,
                  width: 0.5,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    month,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColor.secondryColor,
                      fontSize: 20,
                      fontFamily: AppFont.fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // Text(
                  //   appLocalization(context).month,
                  //   style: const TextStyle(
                  //     color: AppColor.secondryColor,
                  //     fontSize: 20,
                  //     fontFamily: AppFont.fontFamily,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  price,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 20,
                    fontFamily: AppFont.fontFamily,
                    fontWeight: FontWeight.w600,
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
