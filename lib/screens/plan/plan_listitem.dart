import 'package:spam_delection_app/lib.dart';

class PlanListItem extends StatelessWidget {
  final Planslist plan;
  final int selectedTab;
  final void Function()? onTap;

  const PlanListItem(
      {super.key, required this.plan, required this.selectedTab, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            // height: MediaQuery.of(context).size.height * 18 / 100,
            // width: MediaQuery.of(context).size.width * 90 / 100,
            decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  AppColor.constantGraniteColor,
                  AppColor.darkPurpleColor
                ]),
                // color:
                //     plan.isActive == 1 ? AppColor.greenColor : AppColor.whiteColor,
                border: Border.all(
                  color: plan.isActive == 1
                      ? AppColor.yellowColor
                      : AppColor.constantGraniteColor,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        plan.title ?? "",
                        style: const TextStyle(
                            color: AppColor.whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFont.fontFamily),
                      ),
                      Text(
                        plan.isActive == 1
                            ? " (${appLocalization(context).active})"
                            : "",
                        style: const TextStyle(
                            color: AppColor.greenColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFont.fontFamily),
                      ),
                    ],
                  ),
                  20.height(),
                  Wrap(
                    children: [
                      ChoiceChip(
                        avatar: plan.callProtection == "1"
                            ? null
                            : const Icon(Icons.clear),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        selected: plan.callProtection == "1",
                        label: Text(appLocalization(context).callProtection),
                      ),
                      5.width(),
                      ChoiceChip(
                        avatar: plan.smsProtection == "1"
                            ? null
                            : const Icon(Icons.clear),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        selected: plan.smsProtection == "1",
                        label: Text(appLocalization(context).smsProtection),
                      ),
                      5.width(),
                      ChoiceChip(
                        avatar: plan.emailProtection == "1"
                            ? null
                            : const Icon(Icons.clear),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        selected: plan.emailProtection == "1",
                        label: Text(appLocalization(context).emailProtection),
                      ),
                      5.width(),
                      ChoiceChip(
                        avatar: plan.familySharing != "0"
                            ? null
                            : const Icon(Icons.clear),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        selected: plan.familySharing != "0",
                        label: Text(appLocalization(context).familySharing),
                      ),
                    ],
                  ),
                  10.height(),
                  Text(
                    plan.description ?? "",
                    style: const TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFont.fontFamily),
                  ),
                  10.height(),
                  Text(
                    "${plan.price} (${plan.validity})",
                    style: const TextStyle(
                        color: AppColor.darkPurpleColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFont.fontFamily),
                  ),
                ],
              ),
            ),
          ),
          if (plan.isPopular == "1")
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(10)),
                    gradient: LinearGradient(colors: [
                      AppColor.yellowColor,
                      AppColor.yellowDecentColor,
                    ])),
                child: Text(
                  appLocalization(context).popular,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
        ],
      ),
    );
  }
}
