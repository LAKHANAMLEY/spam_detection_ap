// import 'package:spam_delection_app/lib.dart';
//
// class UnMarkSmsView extends StatefulWidget {
//   final SmsDetail sms;
//
//   const UnMarkSmsView({super.key, required this.sms});
//
//   @override
//   State<UnMarkSmsView> createState() => _UnMarkSmsViewState();
// }
//
// class _UnMarkSmsViewState extends State<UnMarkSmsView> {
//   SmsDetail? sms;
//
//   String? numberType;
//   bool _isRememberMeChecked = false;
//
//   var commentController = TextEditingController();
//   var selectedTabBloc = SelectionBloc(SelectStringState("business"));
//
//   var categoryListBloc = ApiBloc(ApiBlocInitialState());
//   var selectCategoryBloc = SelectionBloc(SelectionBlocInitialState());
//
//   CategoryData? selectedCategory;
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     sms = widget.sms;
//     categoryListBloc.add(GetCategoryListEvent());
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//         backgroundColor: Colors.transparent,
//         bottomNavigationBar: Container(
//           padding: const EdgeInsets.only(left: 18, right: 18),
//           height: MediaQuery
//               .of(context)
//               .size
//               .height * 20 / 100,
//           width: MediaQuery
//               .of(context)
//               .size
//               .width,
//           decoration: BoxDecoration(
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(16),
//               topRight: Radius.circular(16),
//             ),
//             color: Color(0xffF5F5F5),
//           ),
//           child: Column(
//             children: [
//               20.height(),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                     flex: 2,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Checkbox(
//                           value: _isRememberMeChecked,
//                           onChanged: (bool? value) {
//                             setState(() {
//                               _isRememberMeChecked = value ?? false;
//                               // _saveRememberMeState(
//                               //     _isRememberMeChecked);
//                             });
//                           },
//                         ),
//                         Flexible(
//                           flex: 2,
//                           child: Text(
//                             appLocalization(context).reportMessageExperience,
//                             style: const TextStyle(
//                               color: AppColor.decentBrownColor,
//                               fontFamily: AppFont.fontFamily,
//                               fontWeight: FontWeight.normal,
//                               fontSize: 14,
//                             ),
//                             maxLines: 2,
//                             overflow: TextOverflow.visible,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Flexible(
//                   //   flex: 2,
//                   //   child: TextButton(
//                   //     child: Text(
//                   //       appLocalization(context)
//                   //           .forgotPasswordText,
//                   //       softWrap: true,
//                   //       //overflow: TextOverflow.ellipsis,
//                   //       maxLines: 2,
//                   //       style: const TextStyle(
//                   //         fontSize: 14,
//                   //         color: AppColor
//                   //             .themeYellowColor,
//                   //         fontFamily:
//                   //         AppFont.fontFamily,
//                   //         fontWeight: FontWeight.w600,
//                   //       ),
//                   //     ),
//                   //     onPressed: () {
//                   //       Navigator.pushNamed(context,
//                   //           AppRoutes.forgotPassword);
//                   //     },
//                   //   ),
//                   // ),
//                 ],
//               ),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //   children: [
//               //     const Text(
//               //       "Total Amount",
//               //       style: TextStyle(
//               //         color: AppColor.blackColor,
//               //         fontSize: 18,
//               //         fontFamily: AppFont.fontFamily,
//               //         fontWeight: FontWeight.w500,
//               //       ),
//               //     ),
//               //     Text(
//               //       "Report messages",
//               //       style: TextStyle(
//               //         color: Colors.green[500],
//               //         fontWeight: FontWeight.w600,
//               //         fontSize: 20,
//               //         fontFamily: AppFont.fontFamily,
//               //       ),
//               //     ),
//               //   ],
//               // ),
//               20.height(),
//               GestureDetector(
//                 onTap: () {
//                   // Navigator.pushNamed(
//                   //   context,
//                   //   AppRoutes.createInvoice,
//                   //   arguments: CreateInvoice(items: cartState.cartItems),
//                   // );
//                 },
//                 child: Container(
//                   height: MediaQuery
//                       .of(context)
//                       .size
//                       .height * 0.07,
//                   width: MediaQuery
//                       .of(context)
//                       .size
//                       .width * 0.9,
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(2),
//                     color: AppColor.themeYellowColor,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 6,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: const Center(
//                     child: Text(
//                       'NOT SPAM',
//                       style: TextStyle(
//                         color: AppColor.whiteColor,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: Container(
//           decoration: const BoxDecoration(
//             //color: Colors.green,
//               borderRadius: BorderRadius.zero
//             // topLeft: Radius.circular,
//             // topRight: Radius.circular(00),
//             //),
//           ),
//           child: SafeArea(
//             child: Form(
//               key: _formKey,
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Align(
//                         alignment: Alignment.topLeft,
//                         child: Text(
//                           appLocalization(context).notSpam,
//                           style: const TextStyle(
//                               color: AppColor.blackColor,
//                               fontSize: 18,
//                               fontFamily: AppFont.fontFamily,
//                               fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                       10.height(),
//                       Text(
//                         appLocalization(context).reportSpamLabel,
//                         style: const TextStyle(
//                             color: AppColor.blackColor,
//                             fontSize: 14,
//                             fontFamily: AppFont.fontFamily,
//                             fontWeight: FontWeight.w400),
//                       ),
//                       // SizedBox(
//                       //   height: MediaQuery.of(context).size.height * 1 / 100,
//                       // ),
//                       // BlocBuilder(
//                       //     bloc: selectedTabBloc,
//                       //     builder: (context, selectTabState) {
//                       //       if (selectTabState is SelectStringState) {
//                       //         numberType = selectTabState.value;
//                       //         // int SelectedTab = selectTabState.value;
//                       //         return Row(
//                       //           mainAxisAlignment:
//                       //               MainAxisAlignment.spaceEvenly,
//                       //           children: [
//                       //             GestureDetector(
//                       //               onTap: () {
//                       //                 // Add event to update selected tab and numberType
//                       //                 selectedTabBloc
//                       //                     .add(SelectStringEvent("business"));
//                       //               },
//                       //               child: Row(
//                       //                 children: [
//                       //                   Radio(
//                       //                     focusColor: AppColor.deepYellowColor,
//                       //                     groupValue: numberType,
//                       //                     // Current selected value
//                       //                     onChanged: (value) {
//                       //                       // Trigger Bloc event and update numberType
//                       //                       selectedTabBloc
//                       //                           .add(SelectStringEvent(value));
//                       //                     },
//                       //                     value:
//                       //                         "business", // Value for this radio button
//                       //                   ),
//                       //                   Text(appLocalization(context).business),
//                       //                 ],
//                       //               ),
//                       //             ),
//                       //             GestureDetector(
//                       //               onTap: () {
//                       //                 // Add event to update selected tab and numberType
//                       //                 selectedTabBloc
//                       //                     .add(SelectStringEvent("personal"));
//                       //               },
//                       //               child: Row(
//                       //                 children: [
//                       //                   Radio(
//                       //                     focusColor: AppColor.deepYellowColor,
//                       //                     groupValue: numberType,
//                       //                     // Current selected value
//                       //                     onChanged: (value) {
//                       //                       // Trigger Bloc event and update numberType
//                       //                       selectedTabBloc
//                       //                           .add(SelectStringEvent(value));
//                       //                     },
//                       //                     value:
//                       //                         "personal", // Value for this radio button
//                       //                   ),
//                       //                   Text(appLocalization(context).personal),
//                       //                 ],
//                       //               ),
//                       //             ),
//                       //           ],
//                       //         );
//                       //       }
//                       //       return const Loader();
//                       //     }),
//
//                       // Row(
//                       //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       //   children: [
//                       //     GestureDetector(
//                       //       onTap: () {
//                       //         selectedTabBloc.add(SelectIntEvent(0));
//                       //         //numberType = appLocalization(context).business;
//                       //         // setState(() {
//                       //         //   numberType = appLocalization(context).business;
//                       //         // });
//                       //       },
//                       //       child: Row(
//                       //         children: [
//                       //           Radio(
//                       //             focusColor: AppColor.yellowDeep,
//                       //             groupValue: numberType,
//                       //             onChanged: (value) {
//                       //               selectedTabBloc.add(SelectIntEvent(1));
//                       //               // numberType = value;
//                       //               // // setState(() {
//                       //               // //   numberType = value;
//                       //               // // }
//                       //               // );
//                       //             },
//                       //             value: appLocalization(context).business,
//                       //           ),
//                       //           Text(appLocalization(context).business),
//                       //         ],
//                       //       ),
//                       //     ),
//                       //     GestureDetector(
//                       //       onTap: () {
//                       //         selectedTabBloc.add(SelectIntEvent(1));
//                       //         // setState(() {
//                       //         //   numberType = appLocalization(context).personal;
//                       //         // });
//                       //       },
//                       //       child: Row(
//                       //         children: [
//                       //           Radio(
//                       //             focusColor: AppColor.yellowDeep,
//                       //             groupValue: numberType,
//                       //             onChanged: (value) {
//                       //               selectedTabBloc.add(SelectIntEvent(1));
//                       //               numberType = value;
//                       //             },
//                       //             value: appLocalization(context).personal,
//                       //           ),
//                       //           Text(appLocalization(context).personal)
//                       //         ],
//                       //       ),
//                       //     ),
//                       //   ],
//                       // ),
//                       // SizedBox(
//                       //   height: MediaQuery.of(context).size.height * 2 / 100,
//                       // ),
//                       // Text(
//                       //   appLocalization(context).writeComment,
//                       //   style: const TextStyle(
//                       //       color: AppColor.blackColor,
//                       //       fontSize: 14,
//                       //       fontFamily: AppFont.fontFamily,
//                       //       fontWeight: FontWeight.w600),
//                       // ),
//                       // SizedBox(
//                       //   height: MediaQuery.of(context).size.height * 2 / 100,
//                       // ),
//                       // CustomTextField(
//                       //   readOnly: false,
//                       //   controller: commentController,
//                       //   hintText: appLocalization(context).whatCallAbout,
//                       //   labelText: appLocalization(context).whatCallAbout,
//                       //   validator: (p0) {
//                       //     if (p0?.isEmpty ?? true) {
//                       //       return appLocalization(context).pleaseEnterComments;
//                       //     }
//                       //     return null;
//                       //   },
//                       // ),
//                       //30.height(),
//                       // Text(appLocalization(context).whatTypeOfMessage),
//                       // BlocBuilder(
//                       //   bloc: categoryListBloc,
//                       //   builder: (context, state) {
//                       //     if (state is GetCategoryListState) {
//                       //       List<CategoryData> categories =
//                       //           state.value.categorylist ?? [];
//                       //       if (selectedCategory != null &&
//                       //           !categories.contains(selectedCategory)) {
//                       //         selectedCategory = null;
//                       //       }
//                       //       if (categories.isEmpty) {
//                       //         return Center(
//                       //           child: Text(
//                       //             appLocalization(context)
//                       //                 .noCategoriesAvailable,
//                       //             style: const TextStyle(
//                       //                 fontSize: 16, color: Colors.grey),
//                       //           ),
//                       //         );
//                       //       }
//                       //       return Padding(
//                       //         padding:
//                       //         const EdgeInsets.symmetric(horizontal: 16.0),
//                       //         child: BlocBuilder(
//                       //             bloc: selectCategoryBloc,
//                       //             builder: (context, state) {
//                       //               return DropdownButton<CategoryData>(
//                       //                 hint: Text(appLocalization(context)
//                       //                     .selectCategory),
//                       //                 value: selectedCategory,
//                       //                 isExpanded: true,
//                       //                 items: categories.map((category) {
//                       //                   return DropdownMenuItem<CategoryData>(
//                       //                     value: category,
//                       //                     child: Text(category.cateName ?? ""),
//                       //                   );
//                       //                 }).toList(),
//                       //                 onChanged: (CategoryData? value) {
//                       //                   selectedCategory = value;
//                       //                   selectCategoryBloc
//                       //                       .add(SelectCategoriesEvent(value));
//                       //                 },
//                       //               );
//                       //             }),
//                       //       );
//                       //     }
//                       //
//                       //     return const Loader(); // Show loader while loading
//                       //   },
//                       // ),
//
//                       // BlocBuilder(
//                       //     bloc: categoryListBloc,
//                       //     builder: (context, state) {
//                       //       if (state is GetCategoryListState) {
//                       //         List<CategoryData> categories =
//                       //             state.value.categorylist ?? [];
//                       //         return Center(
//                       //           child: categories.isEmpty
//                       //               ? Text(appLocalization(context)
//                       //                   .noCategoriesAvailable)
//                       //               : Padding(
//                       //                   padding: const EdgeInsets.symmetric(
//                       //                       horizontal: 16.0),
//                       //                   child: DropdownButton<CategoryData>(
//                       //                     hint: Text(appLocalization(context)
//                       //                         .selectCategory),
//                       //                     value: selectedCategory,
//                       //                     isExpanded: true,
//                       //                     items: categories.map((category) {
//                       //                       return DropdownMenuItem<
//                       //                           CategoryData>(
//                       //                         value: category,
//                       //                         child:
//                       //                             Text(category.cateName ?? ""),
//                       //                       );
//                       //                     }).toList(),
//                       //                     onChanged: (CategoryData? value) {
//                       //                       selectedCategory = value;
//                       //                       categoryListBloc
//                       //                           .add(GetCategoryListEvent());
//                       //                       // setState(() {
//                       //                       //   selectedCategory = value;
//                       //                       // });
//                       //                       //print(selectedCategory?.cateName ?? "");
//                       //                     },
//                       //                   ),
//                       //                 ),
//                       //         );
//                       //       }
//                       //       return const Loader();
//                       //     }),
//                       // 5.height(),
//                       // Text(
//                       //   appLocalization(context).writeComment,
//                       //   style: const TextStyle(
//                       //       color: AppColor.blackColor,
//                       //       fontSize: 14,
//                       //       fontFamily: AppFont.fontFamily,
//                       //       fontWeight: FontWeight.w600),
//                       // ),
//                       5.height(),
//                       CustomTextField(
//                         readOnly: false,
//                         controller: commentController,
//                         hintText: appLocalization(context).tellUsMore,
//                         labelText: appLocalization(context).tellUsMore,
//                         validator: (p0) {
//                           if (p0?.isEmpty ?? true) {
//                             return appLocalization(context).pleaseEnterComments;
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(
//                         height: MediaQuery
//                             .of(context)
//                             .size
//                             .height * 2 / 100,
//                       ),
//                       // AppButton(
//                       //   text: appLocalization(context).block,
//                       //   onPress: () {
//                       //     if (_formKey.currentState?.validate() ?? false) {
//                       //       if (numberType == null) {
//                       //         ScaffoldMessenger.of(context).showSnackBar(
//                       //           SnackBar(
//                       //             content: Text(appLocalization(context)
//                       //                 .pleaseEnterNumberType),
//                       //             backgroundColor: Colors.black,
//                       //             behavior: SnackBarBehavior.floating,
//                       //             margin: EdgeInsets.only(
//                       //               bottom: MediaQuery.of(context).size.height *
//                       //                   0.1,
//                       //               // Position above the Bottom Sheet
//                       //               left: 16,
//                       //               right: 16,
//                       //             ),
//                       //           ),
//                       //         );
//                       //         return;
//                       //       }
//                       //       if (selectedCategory == null) {
//                       //         ScaffoldMessenger.of(context).showSnackBar(
//                       //           SnackBar(
//                       //             content: Text(appLocalization(context)
//                       //                 .pleaseEnterCategory),
//                       //             backgroundColor: AppColor.blackColor,
//                       //             behavior: SnackBarBehavior.floating,
//                       //             margin: EdgeInsets.only(
//                       //               bottom: MediaQuery.of(context).size.height *
//                       //                   0.1,
//                       //               left: 16,
//                       //               right: 16,
//                       //             ),
//                       //           ),
//                       //         );
//                       //         return;
//                       //       }
//                       //       markSpamSmsBloc.add(MarkSpamSmsEvent(
//                       //         address: sms?.address ?? "",
//                       //         comment: commentController.text,
//                       //         numberType: numberType ?? "",
//                       //         category: selectedCategory?.cateId ?? "",
//                       //       ));
//                       //       Navigator.pop(context);
//                       //       // Navigator.pushNamed(
//                       //       //     context, AppRoutes.bottomNavigation);
//                       //     }
//                       //   },
//                       // ),
//
//                       // AppButton(
//                       //     text: appLocalization(context).block,
//                       //     onPress: () {
//                       //       if (_formKey.currentState?.validate() ?? false) {
//                       //         if (selectedCategory == null) {
//                       //           ScaffoldMessenger.of(context).showSnackBar(
//                       //             SnackBar(
//                       //               content: Text(appLocalization(context)
//                       //                   .pleaseEnterCategory),
//                       //               backgroundColor: AppColor.primaryColor,
//                       //             ),
//                       //           );
//                       //           return;
//                       //         }
//                       //
//                       //         if (numberType == null) {
//                       //           ScaffoldMessenger.of(context).showSnackBar(
//                       //             SnackBar(
//                       //               content: Text(appLocalization(context)
//                       //                   .pleaseEnterNumberType),
//                       //               backgroundColor: Colors.black,
//                       //             ),
//                       //           );
//                       //           return;
//                       //         }
//                       //         //print(getSms());
//                       //         markSpamSmsBloc.add(MarkSpamSmsEvent(
//                       //           address: sms?.address ?? "",
//                       //           comment: commentController.text,
//                       //           numberType: numberType ?? "",
//                       //           category: selectedCategory?.cateId ?? "",
//                       //         ));
//                       //         Navigator.pushNamed(
//                       //             context, AppRoutes.bottomNavigation);
//                       //       }
//                       //     }),
//                       // SizedBox(
//                       //     height: MediaQuery.of(context).size.height * 4 / 100),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }
// }

import 'package:spam_delection_app/lib.dart';

class UnMarkSmsView extends StatefulWidget {
  final SmsDetail sms;

  const UnMarkSmsView({super.key, required this.sms});

  @override
  State<UnMarkSmsView> createState() => _UnMarkSmsViewState();
}

class _UnMarkSmsViewState extends State<UnMarkSmsView> {
  SmsDetail? sms;

  String? numberType;
  bool _isRememberMeChecked = false;

  var commentController = TextEditingController();
  var selectedTabBloc = SelectionBloc(SelectStringState("business"));

  var categoryListBloc = ApiBloc(ApiBlocInitialState());
  var selectCategoryBloc = SelectionBloc(SelectionBlocInitialState());

  CategoryData? selectedCategory;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    sms = widget.sms;
    categoryListBloc.add(GetCategoryListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
                //color: Colors.green,
                borderRadius: BorderRadius.zero
                // topLeft: Radius.circular,
                // topRight: Radius.circular(00),
                //),
                ),
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            appLocalization(context).notSpam,
                            style: const TextStyle(
                                color: AppColor.blackColor,
                                fontSize: 18,
                                fontFamily: AppFont.fontFamily,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      10.height(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          appLocalization(context).reportSpamLabel,
                          style: const TextStyle(
                              color: AppColor.blackColor,
                              fontSize: 14,
                              fontFamily: AppFont.fontFamily,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      10.height(),
                      CustomTextField(
                        readOnly: false,
                        controller: commentController,
                        hintText: appLocalization(context).tellUsMore,
                        labelText: appLocalization(context).tellUsMore,
                        validator: (p0) {
                          if (p0?.isEmpty ?? true) {
                            return appLocalization(context).pleaseEnterComments;
                          }
                          return null;
                        },
                      ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 2 / 100,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 18, right: 18),
            height: MediaQuery.of(context).size.height * 20 / 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              color: Color(0xffF5f5F5),
            ),
            child: Column(
              children: [
                20.height(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: _isRememberMeChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isRememberMeChecked = value ?? false;
                                // _saveRememberMeState(
                                //     _isRememberMeChecked);
                              });
                            },
                          ),
                          Flexible(
                            flex: 2,
                            child: Text(
                              "Report the message to improve the experience for millions users like you",
                              style: const TextStyle(
                                color: AppColor.decentBrownColor,
                                fontFamily: AppFont.fontFamily,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Flexible(
                    //   flex: 2,
                    //   child: TextButton(
                    //     child: Text(
                    //       appLocalization(context)
                    //           .forgotPasswordText,
                    //       softWrap: true,
                    //       //overflow: TextOverflow.ellipsis,
                    //       maxLines: 2,
                    //       style: const TextStyle(
                    //         fontSize: 14,
                    //         color: AppColor
                    //             .themeYellowColor,
                    //         fontFamily:
                    //         AppFont.fontFamily,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //     onPressed: () {
                    //       Navigator.pushNamed(context,
                    //           AppRoutes.forgotPassword);
                    //     },
                    //   ),
                    // ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const Text(
                //       "Total Amount",
                //       style: TextStyle(
                //         color: AppColor.blackColor,
                //         fontSize: 18,
                //         fontFamily: AppFont.fontFamily,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //     Text(
                //       "Report messages",
                //       style: TextStyle(
                //         color: Colors.green[500],
                //         fontWeight: FontWeight.w600,
                //         fontSize: 20,
                //         fontFamily: AppFont.fontFamily,
                //       ),
                //     ),
                //   ],
                // ),
                20.height(),
                GestureDetector(
                  onTap: () {
                    markSpamSmsBloc
                        .add(RemoveSpamSmsEvent(address: sms?.address ?? ""));
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColor.themeYellowColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Not Spam',
                        style: TextStyle(
                          color: AppColor.whiteColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
