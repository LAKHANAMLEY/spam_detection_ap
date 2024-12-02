import 'package:spam_delection_app/lib.dart';

class ProtectionType extends StatefulWidget {
  const ProtectionType({super.key});
  static String routeName = './ProtectionType';

  @override
  State<ProtectionType> createState() => _ProtectionTypeState();
}

class _ProtectionTypeState extends State<ProtectionType> {
  int Selectedtab = 0;
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
              height: MediaQuery.of(context).size.height * 2 / 100,
              width: MediaQuery.of(context).size.width * 2 / 100,
            ),
          ),
        ),
        title: Image.asset(
          IconConstants.icBroadlogo,
          height: MediaQuery.of(context).size.height * 38 / 100,
          width: MediaQuery.of(context).size.width * 38 / 100,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 8 / 100,
              ),
              const Center(
                  child: Padding(
                padding: EdgeInsets.only(left: 70, right: 70),
                child: Text(
                  StringConstants.protectiontext,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.bluelightColor,
                      fontSize: 35,
                      fontFamily: AppFont.fontFamily,
                      fontWeight: FontWeight.w600),
                ),
              )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Center(
                    child: Text(
                  StringConstants.selectaccountext,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.verifyColor,
                      fontFamily: AppFont.fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 5 / 100,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    Selectedtab = 0;
                  });
                },
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 90 / 100,
                  height: MediaQuery.sizeOf(context).height * 8 / 100,
                  decoration: BoxDecoration(
                    color: Selectedtab == 1
                        ? AppColor.fillColor.withOpacity(0.2)
                        : AppColor.callColor,
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(color: AppColor.fillColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 8 / 100,
                        height: MediaQuery.sizeOf(context).height * 8 / 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Selectedtab == 1
                                    ? AppColor.callColor
                                    : AppColor.secondryColor,
                                BlendMode.srcIn),
                            image: const AssetImage(
                                IconConstants.covidprotectionshield),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 4 / 100,
                      ),
                      Text(
                        StringConstants.personalProtectiontext,
                        style: TextStyle(
                            color: Selectedtab == 1
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
                  setState(() {
                    Selectedtab = 1;
                  });
                },
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 90 / 100,
                  height: MediaQuery.sizeOf(context).height * 8 / 100,
                  decoration: BoxDecoration(
                    color: Selectedtab == 1
                        ? AppColor.callColor
                        : AppColor.fillColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(color: AppColor.fillColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 8 / 100,
                        height: MediaQuery.sizeOf(context).height * 8 / 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Selectedtab == 1
                                    ? AppColor.secondryColor
                                    : AppColor.callColor,
                                BlendMode.srcIn),
                            image: const AssetImage(IconConstants.icCorporate),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 4 / 100,
                      ),
                      Text(
                        StringConstants.corpotateprotectiontext,
                        style: TextStyle(
                            color: Selectedtab == 1
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
                  text: StringConstants.continutext,
                  onPress: () {
                    if (Selectedtab == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginGoogle()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CorpoateLogin()),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
