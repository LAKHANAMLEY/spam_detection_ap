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
      child: Container(
        margin: const EdgeInsets.all(10),
        // height: MediaQuery.of(context).size.height * 18 / 100,
        // width: MediaQuery.of(context).size.width * 90 / 100,
        decoration: BoxDecoration(
            color: plan.isActive ?? false
                ? AppColor.yellowdecentColor
                : AppColor.secondryColor,
            border: Border.all(
              color: plan.isActive ?? false
                  ? AppColor.yellowColor
                  : AppColor.thumbColor,
            ),
            borderRadius: BorderRadius.circular(6)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plan.title ?? "",
                style: const TextStyle(
                    color: AppColor.callColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFont.fontFamily),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5 / 100,
              ),
              Text(
                plan.description ?? "",
                style: const TextStyle(
                    color: AppColor.borderstekColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFont.fontFamily),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5 / 100,
              ),
              Text(
                plan.price ?? "",
                style: const TextStyle(
                    color: AppColor.callColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFont.fontFamily),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
