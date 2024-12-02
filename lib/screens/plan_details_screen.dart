import 'package:spam_delection_app/lib.dart';

class PlanDetail extends StatefulWidget {
  const PlanDetail({super.key});

  @override
  State<PlanDetail> createState() => _PlanDetailState();
}

class _PlanDetailState extends State<PlanDetail> {
  int Selectedtab = 0;
  int _selection = 0;
  int SelectedPlan = 0;
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(height: MediaQuery.of(context).size.height * 3 / 100),
            Image.asset(
              IconConstants.icpremiumprotection,
              height: MediaQuery.of(context).size.height * 15 / 100,
            ),
            const Center(
                child: Padding(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: Text(
                StringConstants.personalProtectiontext,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColor.callColor,
                    fontSize: 25,
                    fontFamily: AppFont.fontFamily,
                    fontWeight: FontWeight.w600),
              ),
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 100,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: Text(
                StringConstants.spamdetecttext,
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
            SizedBox(
                height: MediaQuery.of(context).size.height * 8 / 100,
                width: MediaQuery.of(context).size.width * 90 / 100,
                //color: AppColor.redColor,
                child: Column(
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
                                height: MediaQuery.of(context).size.height *
                                    6 /
                                    100,
                                width: MediaQuery.of(context).size.width *
                                    28 /
                                    100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: _selection == 1
                                          ? AppColor.callColor
                                          : AppColor.callColor,
                                      width: 1),
                                  color: Selectedtab == 1
                                      ? AppColor.callColor
                                      : AppColor.callColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                    'Calls',
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
                                width:
                                    MediaQuery.of(context).size.width * 5 / 100,
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height *
                                    6 /
                                    100,
                                width: MediaQuery.of(context).size.width *
                                    28 /
                                    100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColor.borderstekColor,
                                      width: 1),
                                  color: _selection == 1
                                      ? AppColor.callColor
                                      : AppColor.secondryColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 100,
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
                                  const Text(
                                    'Sms',
                                    style: TextStyle(
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
                                width:
                                    MediaQuery.of(context).size.width * 5 / 100,
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height *
                                    6 /
                                    100,
                                width: MediaQuery.of(context).size.width *
                                    28 /
                                    100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColor.borderstekColor,
                                      width: 1),
                                  color: AppColor.secondryColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 100,
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
                                  const Text(
                                    'Email',
                                    style: TextStyle(
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
                )),
            Padding(
              padding: const EdgeInsets.all(18),
              child: SizedBox(
                height: MediaQuery.of(context).size.width * 46 / 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          SelectedPlan = 0;
                          //  Navigator.push(context, MaterialPageRoute(builder: (context)=>PlanDetail()));
                        });
                      },
                      child: Card(
                        elevation: 2.0, // Optional: adds shadow to the card
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8), // Applies general rounding to the card if needed
                        ),
                        child: Column(
                          children: [
                            // Top Section
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 10 / 100,
                              width:
                                  MediaQuery.of(context).size.width * 40 / 100,
                              decoration: BoxDecoration(
                                color: SelectedPlan == 0
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
                              child: const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Centers the text vertically
                                  children: [
                                    Text(
                                      "1",
                                      style: TextStyle(
                                        color: AppColor.secondryColor,
                                        fontSize: 20,
                                        fontFamily: AppFont.fontFamily,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "Month",
                                      style: TextStyle(
                                        color: AppColor.secondryColor,
                                        fontSize: 20,
                                        fontFamily: AppFont.fontFamily,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 12 / 100,
                              width:
                                  MediaQuery.of(context).size.width * 40 / 100,
                              decoration: BoxDecoration(
                                color: AppColor.secondryColor,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(6),
                                  bottomRight: Radius.circular(6),
                                ),
                                border: Border.all(
                                  color: AppColor.vanishColor,
                                  width: 0.5,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "\$7.99",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
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
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 2 / 100,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          SelectedPlan = 1;
                          //  Navigator.push(context, MaterialPageRoute(builder: (context)=>PlanDetail()));
                        });
                      },
                      child: Card(
                        elevation: 2.0, // Optional: adds shadow to the card
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8), // Applies general rounding to the card if needed
                        ),
                        child: Column(
                          children: [
                            // Top Section
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 10 / 100,
                              width:
                                  MediaQuery.of(context).size.width * 40 / 100,
                              decoration: BoxDecoration(
                                color: SelectedPlan == 1
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
                              child: const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Centers the text vertically
                                  children: [
                                    Text(
                                      "3",
                                      style: TextStyle(
                                        color: AppColor.secondryColor,
                                        fontSize: 20,
                                        fontFamily: AppFont.fontFamily,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "Month",
                                      style: TextStyle(
                                        color: AppColor.secondryColor,
                                        fontSize: 20,
                                        fontFamily: AppFont.fontFamily,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 12 / 100,
                              width:
                                  MediaQuery.of(context).size.width * 40 / 100,
                              decoration: BoxDecoration(
                                color: AppColor.secondryColor,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(6),
                                  bottomRight: Radius.circular(6),
                                ),
                                border: Border.all(
                                  color: AppColor.vanishColor,
                                  width: 0.5,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "\$20",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
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
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 2 / 100,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          SelectedPlan = 2;
                          //  Navigator.push(context, MaterialPageRoute(builder: (context)=>PlanDetail()));
                        });
                      },
                      child: Card(
                        elevation: 2.0, // Optional: adds shadow to the card
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8), // Applies general rounding to the card if needed
                        ),
                        child: Column(
                          children: [
                            // Top Section
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 10 / 100,
                              width:
                                  MediaQuery.of(context).size.width * 40 / 100,
                              decoration: BoxDecoration(
                                color: SelectedPlan == 2
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
                              child: const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Centers the text vertically
                                  children: [
                                    Text(
                                      "9",
                                      style: TextStyle(
                                        color: AppColor.secondryColor,
                                        fontSize: 20,
                                        fontFamily: AppFont.fontFamily,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "Month",
                                      style: TextStyle(
                                        color: AppColor.secondryColor,
                                        fontSize: 20,
                                        fontFamily: AppFont.fontFamily,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 12 / 100,
                              width:
                                  MediaQuery.of(context).size.width * 40 / 100,
                              decoration: BoxDecoration(
                                color: AppColor.secondryColor,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(6),
                                  bottomRight: Radius.circular(6),
                                ),
                                border: Border.all(
                                  color: AppColor.vanishColor,
                                  width: 0.5,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "\$50",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
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
                    ),
                    // Add more Card widgets here as needed
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 5 / 100,
            ),
            AppButton(
              text: StringConstants.continuepurchasetext,
              onPress: () {},
            )
          ]),
        ),
      ),
    );
  }
}
