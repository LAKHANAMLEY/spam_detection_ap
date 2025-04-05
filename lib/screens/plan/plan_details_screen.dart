import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/models/api_body_model/purchase_plan_model.dart';

class PlanDetail extends StatefulWidget {
  final Planslist? plan;
  final ApiBloc? planListBloc;

  const PlanDetail({super.key, this.plan, this.planListBloc});

  @override
  State<PlanDetail> createState() => _PlanDetailState();
}

class _PlanDetailState extends State<PlanDetail> {
  int selectedPrice = 0;

  Planslist? plan;

  var purchasePlanBloc = ApiBloc(ApiBlocInitialState());

  @override
  Widget build(BuildContext context) {
    var arg = args(context) as PlanDetail;
    plan = arg.plan;
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: const CustomAppBar(
        centerTitle: true,
      ),
      body: BlocConsumer(
          bloc: purchasePlanBloc,
          listener: (context, state) {
            if (state is PurchasePlanState) {
              var code = state.value.statusCode;
              var msg = state.value.message;
              if (code == HTTPStatusCodes.success) {
                showCustomDialog(
                  context,
                  dialogType: DialogType.success,
                  subTitle: msg,
                  barrierDismissible: false,
                  onOkPressed: () {
                    Navigator.popUntil(
                        context,
                        (route) =>
                            route.settings.name == AppRoutes.bottomNavigation);
                  },
                );
                arg.planListBloc?.add(GetPlanListEvent());
              } else if (code == HTTPStatusCodes.sessionExpired) {
                sessionExpired(context, msg);
              } else {
                showCustomDialog(
                  context,
                  dialogType: DialogType.failed,
                  subTitle: msg,
                );
              }
            }
            if (state is CancelPlanState) {
              var code = state.value.statusCode;
              var msg = state.value.message;
              if (code == HTTPStatusCodes.success) {
                showCustomDialog(
                  context,
                  dialogType: DialogType.success,
                  subTitle: msg,
                  barrierDismissible: false,
                  onOkPressed: () {
                    Navigator.popUntil(
                        context,
                        (route) =>
                            route.settings.name == AppRoutes.bottomNavigation);
                  },
                );
                arg.planListBloc?.add(GetPlanListEvent());
              } else if (code == HTTPStatusCodes.sessionExpired) {
                sessionExpired(context, msg);
              } else {
                showCustomDialog(
                  context,
                  dialogType: DialogType.failed,
                  subTitle: msg,
                );
              }
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              progressIndicator: const Loader(),
              inAsyncCall: state is ApiLoadingState,
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 3 / 100),
                        Image.asset(
                          IconConstants.icPremiumPurchase,
                          height: MediaQuery.of(context).size.height * 15 / 100,
                        ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: Text(
                            plan?.title ?? "",
                            // appLocalization(context).personalProtection,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: AppColor.darkPurpleColor,
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
                                color: AppColor.materialGreyColor,
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
                                ProtectionTypeView(
                                  title: appLocalization(context).call,
                                  isActive: plan?.callProtection == "1",
                                ),
                                ProtectionTypeView(
                                  title: appLocalization(context).sms,
                                  isActive: plan?.smsProtection == "1",
                                ),
                                ProtectionTypeView(
                                  title: appLocalization(context).email,
                                  isActive: plan?.emailProtection == "1",
                                ),
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
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              var months = ["1\nmonth", "6\nmonth", "1\nyear"];
                              var prices = [
                                plan?.price ?? "0",
                                plan?.price ?? "0",
                                plan?.price ?? "0"
                              ];
                              return PlanDurationTypeCardView(
                                planId: index,
                                selectedPlanId: selectedPrice,
                                month: months[index],
                                price: prices[index],
                                onTap: () {
                                  selectedPrice = index;
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
                        (plan?.isActive != 1)
                            ? AppButton(
                                text: appLocalization(context).continuePurchase,
                                onPress: () {
                                  purchasePlanBloc.add(PurchasePlanEvent(
                                      purchasePlanData: PurchasePlanModel(
                                          planId: plan?.id,
                                          transactionId:
                                              UniqueKey().toString())));
                                },
                              )
                            : AppButton(
                                btnColor: Colors.red,
                                text: appLocalization(context).cancel,
                                onPress: () {
                                  purchasePlanBloc.add(CancelPlanEvent());
                                },
                              )
                      ]),
                ),
              ),
            );
          }),
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
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              8), // Applies general rounding to the card if needed
        ),
        color: AppColor.whiteColor,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Top Section
            Container(
              // height:
              //     MediaQuery.of(context).size.height * 10 / 100,
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: selectedPlanId == planId
                    ? AppColor.deepYellowColor
                    : AppColor.decentGreyColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                border: Border.all(
                  color: AppColor.whiteDecentColor,
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
                      color: AppColor.whiteColor,
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
                    color: AppColor.blackColor,
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

class ProtectionTypeView extends StatelessWidget {
  final bool isActive;
  final String title;

  const ProtectionTypeView(
      {super.key, required this.isActive, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.darkPurpleColor, width: 1),
          color: isActive ? AppColor.darkPurpleColor : AppColor.greyColor,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              isActive ? Icons.check_circle : Icons.cancel,
              color: isActive ? Colors.green : Colors.white60,
            ),
            5.width(),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFont.fontFamily,
                  color: isActive ? AppColor.whiteColor : Colors.white60,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
