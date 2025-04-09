import 'package:spam_delection_app/lib.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Container(
            color: AppColor.greyDecent.withOpacity(0.5),
            height: MediaQuery.of(context).size.height * 20 / 100,
            width: MediaQuery.of(context).size.width * 100 / 100,
            child: Column(children: [
              10.height(),
              Image.asset(
                IconConstants.icPremiumPurchase,
                height: MediaQuery.of(context).size.height * 6 / 100,
              ),
              Text(
                'Basic',
                style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFont.fontFamily),
              ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       plan.title ?? "",
              //       style: TextStyle(
              //         fontSize: 20,
              //         color: plan.isActive == 1
              //             ? AppColor.decentYellow
              //             : plan.callProtection == "1"
              //             ? AppColor.darkBlue
              //             : AppColor.redLight,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //       60.width(),
              //       if (plan.isActive == 1)
              //         Container(
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 8, vertical: 4),
              //           decoration: BoxDecoration(
              //             color: Colors.green,
              //             borderRadius: BorderRadius.circular(12),
              //           ),
              //           child: Text(
              //             appLocalization(context).active,
              //             style: const TextStyle(
              //               color: Colors.white,
              //               fontSize: 12,
              //             ),
              //           ),
              //         ),
              //     ],
              //   ),
              // ),
              // 5.height(),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: StyledText(
              //     text:
              //     '<price>${plan.price}</price>/<validity>${plan.validity}</validity>',
              //     tags: {
              //       'price': StyledTextTag(
              //         style: const TextStyle(
              //           fontSize: 22,
              //           fontFamily: AppFont.fontFamily,
              //           fontWeight: FontWeight.w600,
              //           color: AppColor.grey,
              //         ),
              //       ),
              //       'validity': StyledTextTag(
              //         style: const TextStyle(
              //           fontSize: 16,
              //           color: Colors.black87,
              //         ),
              //       ),
              //     },
              //   ),
              // ),
            ]),
          )
        ],
      ),
    );
  }
}
