// import 'package:spam_delection_app/lib.dart';
//
// class PlanListItem extends StatelessWidget {
//   final Planslist plan;
//   final int selectedTab;
//   final void Function()? onTap;
//
//   const PlanListItem(
//       {super.key, required this.plan, required this.selectedTab, this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Stack(
//         children: [
//           Container(
//             margin: const EdgeInsets.all(8),
//             height: MediaQuery
//                 .of(context)
//                 .size
//                 .height * 40 / 100,
//             width: MediaQuery
//                 .of(context)
//                 .size
//                 .width * 60 / 100,
//             decoration: BoxDecoration(
//
//               // gradient: const LinearGradient(colors: [
//               //   AppColor.constantGraniteColor,
//               //   AppColor.darkPurpleColor
//               // ]),
//                 color: plan.isActive == 1
//                     ? AppColor.yellowLightColor.withOpacity(0.8)
//                     : AppColor.whiteColor,
//                 border: Border.all(
//                   color: plan.isActive == 1
//                       ? AppColor.yellowColor
//                       : AppColor.constantGraniteColor,
//                 ),
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.zero,
//                     bottomLeft: Radius.circular(8),
//                     topRight: Radius.circular(30),
//                     bottomRight: Radius.circular(12))),
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         plan.title ?? "",
//                         style: const TextStyle(
//                             color: AppColor.blackColor,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                             fontFamily: AppFont.fontFamily),
//                       ),
//                       5.width(),
//                       Container(
//                         padding: EdgeInsets.all(2),
//                         decoration: BoxDecoration(
//                             color: AppColor.greenColor,
//                             borderRadius: BorderRadius.circular(12)),
//                         //color: AppColor.greenColor,
//                         child: Text(
//                           plan.isActive == 1
//                               ? " ${appLocalization(context).active}"
//                               : "",
//                           style: const TextStyle(
//                               color: AppColor.whiteColor,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                               fontFamily: AppFont.fontFamily),
//                         ),
//                       ),
//                     ],
//                   ),
//                   10.height(),
//                   Text(
//                     "${plan.price} (${plan.validity})",
//                     style: const TextStyle(
//                         color: AppColor.darkPurpleColor,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: AppFont.fontFamily),
//                   ),
//                   20.height(),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ChoiceChip(
//                         avatar: plan.callProtection == "1"
//                             ? null
//                             : CircleAvatar(
//                           child: const Icon(Icons.clear),
//                           backgroundColor: AppColor.yellowLightColor,
//                         ),
//                         padding: EdgeInsets.zero,
//                         visualDensity: VisualDensity.compact,
//                         selected: plan.callProtection == "1",
//                         label: Text(appLocalization(context).callProtection),
//                       ),
//                       5.height(),
//                       ChoiceChip(
//                         avatar: plan.smsProtection == "1"
//                             ? null
//                             : const Icon(Icons.clear),
//                         padding: EdgeInsets.zero,
//                         visualDensity: VisualDensity.compact,
//                         selected: plan.smsProtection == "1",
//                         label: Text(appLocalization(context).smsProtection),
//                       ),
//                       5.height(),
//                       ChoiceChip(
//                         avatar: plan.emailProtection == "1"
//                             ? null
//                             : const Icon(Icons.clear),
//                         padding: EdgeInsets.zero,
//                         visualDensity: VisualDensity.compact,
//                         selected: plan.emailProtection == "1",
//                         label: Text(appLocalization(context).emailProtection),
//                       ),
//                       5.height(),
//                       ChoiceChip(
//                         avatar: plan.familySharing != "0"
//                             ? null
//                             : const Icon(Icons.clear),
//                         padding: EdgeInsets.zero,
//                         visualDensity: VisualDensity.compact,
//                         selected: plan.familySharing != "0",
//                         label: Text(appLocalization(context).familySharing),
//                       ),
//                     ],
//                   ),
//
//                   // Wrap(
//                   //   children: [
//                   //     ChoiceChip(
//                   //       avatar: plan.callProtection == "1"
//                   //           ? null
//                   //           : const Icon(Icons.clear),
//                   //       padding: EdgeInsets.zero,
//                   //       visualDensity: VisualDensity.compact,
//                   //       selected: plan.callProtection == "1",
//                   //       label: Text(appLocalization(context).callProtection),
//                   //     ),
//                   //     5.height(),
//                   //     ChoiceChip(
//                   //       avatar: plan.smsProtection == "1"
//                   //           ? null
//                   //           : const Icon(Icons.clear),
//                   //       padding: EdgeInsets.zero,
//                   //       visualDensity: VisualDensity.compact,
//                   //       selected: plan.smsProtection == "1",
//                   //       label: Text(appLocalization(context).smsProtection),
//                   //     ),
//                   //     5.height(),
//                   //     ChoiceChip(
//                   //       avatar: plan.emailProtection == "1"
//                   //           ? null
//                   //           : const Icon(Icons.clear),
//                   //       padding: EdgeInsets.zero,
//                   //       visualDensity: VisualDensity.compact,
//                   //       selected: plan.emailProtection == "1",
//                   //       label: Text(appLocalization(context).emailProtection),
//                   //     ),
//                   //     5.height(),
//                   //     ChoiceChip(
//                   //       avatar: plan.familySharing != "0"
//                   //           ? null
//                   //           : const Icon(Icons.clear),
//                   //       padding: EdgeInsets.zero,
//                   //       visualDensity: VisualDensity.compact,
//                   //       selected: plan.familySharing != "0",
//                   //       label: Text(appLocalization(context).familySharing),
//                   //     ),
//                   //   ],
//                   // ),
//                   // 10.height(),
//                   // Text(
//                   //   plan.description ?? "",
//                   //   style: const TextStyle(
//                   //       color: AppColor.whiteColor,
//                   //       fontSize: 14,
//                   //       fontWeight: FontWeight.w600,
//                   //       fontFamily: AppFont.fontFamily),
//                   // ),
//                   // 10.height(),
//                   // Text(
//                   //   "${plan.price} (${plan.validity})",
//                   //   style: const TextStyle(
//                   //       color: AppColor.darkPurpleColor,
//                   //       fontSize: 20,
//                   //       fontWeight: FontWeight.w600,
//                   //       fontFamily: AppFont.fontFamily),
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//           // if (plan.isPopular == "1")
//           //   Positioned(
//           //     right: 10,
//           //     top: 10,
//           //     child: Container(
//           //       padding: const EdgeInsets.all(5),
//           //       decoration: const BoxDecoration(
//           //           borderRadius:
//           //               BorderRadius.only(topRight: Radius.circular(10)),
//           //           gradient: LinearGradient(colors: [
//           //             AppColor.yellowColor,
//           //             AppColor.yellowDecentColor,
//           //           ])),
//           //       child: Text(
//           //         appLocalization(context).popular,
//           //         style: const TextStyle(
//           //             color: Colors.white, fontWeight: FontWeight.bold),
//           //       ),
//           //     ),
//           //   )
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// import '../../models/plan_list_model.dart';
//
// class PlanListItem extends StatelessWidget {
//   final Planslist plan;
//   final int selectedTab;
//   final void Function()? onTap;
//
//   const PlanListItem({
//     super.key,
//     required this.plan,
//     required this.selectedTab,
//     this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.all(8),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//             color: plan.isActive == 1 ? Colors.yellow[100] : Colors.white,
//             border: Border.all(
//               color: plan.isActive == 1 ? Colors.yellow : Colors.grey,
//             ),
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.zero,
//                 bottomLeft: Radius.circular(8),
//                 topRight: Radius.circular(36),
//                 bottomRight: Radius.circular(17))),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               //crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   plan.title ?? "",
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(width: 5),
//                 if (plan.isActive == 1)
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.green,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       "Active",
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Text(
//               "${plan.price} (${plan.validity})",
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.purple,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildFeatureChip(
//                     "Call Protection", plan.callProtection == "1"),
//                 _buildFeatureChip("SMS Protection", plan.smsProtection == "1"),
//                 _buildFeatureChip(
//                     "Email Protection", plan.emailProtection == "1"),
//                 _buildFeatureChip("Family Sharing", plan.familySharing != "0"),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFeatureChip(String label, bool isSelected) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: ChoiceChip(
//         avatar: isSelected ? null : const Icon(Icons.clear),
//         selected: isSelected,
//         label: Text(label),
//       ),
//     );
//   }
// }

import 'package:spam_delection_app/lib.dart';

import '../../models/api_body_model/transaction_history_details_model.dart';

class TransactionListItem extends StatelessWidget {
  final TransactionData transactionData;

  const TransactionListItem({
    super.key,
    required this.transactionData,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      leading: Image.asset(IconConstants.icPremiumPurchase),
      // title: Row(children: [
      //   Text(
      //     transactionData.title ?? "",
      //     style: TextStyle(
      //         color: AppColor.greyDecent,
      //         fontWeight: FontWeight.w500,
      //         fontSize: 15),
      //   ),
      //   Text(transactionData.price ?? '',
      //       style: TextStyle(
      //           color: AppColor.greyDecent,
      //           fontWeight: FontWeight.w500,
      //           fontSize: 15)),
      // ]),
      // subtitle: Row(
      //   children: [
      //     Text(
      //       'Txn : ${transactionData.transactionId ?? ""}',
      //       style: TextStyle(
      //           color: AppColor.greyDecent,
      //           fontWeight: FontWeight.w500,
      //           fontSize: 15),
      //     ),
      //     Text(
      //       transactionData.status ?? "",
      //       style: TextStyle(
      //           color: AppColor.greyDecent,
      //           fontWeight: FontWeight.w500,
      //           fontSize: 15),
      //     )
      //   ],
      // ),
    );
  }
}
