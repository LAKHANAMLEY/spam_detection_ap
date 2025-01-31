import 'package:spam_delection_app/lib.dart';

class BlockSmsView extends StatefulWidget {
  final SmsDetail sms;

  const BlockSmsView({super.key, required this.sms});

  @override
  State<BlockSmsView> createState() => _BlockSmsViewState();
}

class _BlockSmsViewState extends State<BlockSmsView> {
  SmsDetail? sms;

  String? numberType;

  var commentController = TextEditingController();
  var selectedTabBloc = SelectionBloc(SelectIntState(0));

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
    return Scaffold(
        // backgroundColor: AppColor.redColor,
        backgroundColor: Colors.transparent,
        //extendBody: false,
        body: Container(
          decoration: const BoxDecoration(
            //color: Colors.green,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        appLocalization(context).blockSmsSpam,
                        style: const TextStyle(
                            color: AppColor.blackColor,
                            fontSize: 18,
                            fontFamily: AppFont.fontFamily,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100),
                      Text(
                        appLocalization(context).wasThisBusinessMessage,
                        style: const TextStyle(
                            color: AppColor.blackColor,
                            fontSize: 14,
                            fontFamily: AppFont.fontFamily,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 1 / 100,
                      ),
                      BlocBuilder(
                          bloc: selectedTabBloc,
                          builder: (context, selectTabState) {
                            if (selectTabState is SelectIntState) {
                              // int SelectedTab = selectTabState.value;
                              return Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Add event to update selected tab and numberType
                                        selectedTabBloc.add(SelectIntEvent(1));
                                      },
                                      child: Row(
                                        children: [
                                          Radio(
                                            focusColor:
                                                AppColor.deepYellowColor,
                                            groupValue: numberType,
                                            // Current selected value
                                            onChanged: (value) {
                                              // Trigger Bloc event and update numberType
                                              selectedTabBloc
                                                  .add(SelectIntEvent(0));
                                              numberType = value;
                                            },
                                            value: appLocalization(context)
                                                .business, // Value for this radio button
                                          ),
                                          Text(appLocalization(context)
                                              .business),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Add event to update selected tab and numberType
                                        selectedTabBloc.add(SelectIntEvent(1));
                                      },
                                      child: Row(
                                        children: [
                                          Radio(
                                            focusColor:
                                                AppColor.deepYellowColor,
                                            groupValue: numberType,
                                            // Current selected value
                                            onChanged: (value) {
                                              // Trigger Bloc event and update numberType
                                              selectedTabBloc
                                                  .add(SelectIntEvent(1));
                                              numberType = value;
                                            },
                                            value: appLocalization(context)
                                                .personal, // Value for this radio button
                                          ),
                                          Text(appLocalization(context)
                                              .personal),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ]);
                            }
                            return Loader();
                          }),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     GestureDetector(
                      //       onTap: () {
                      //         selectedTabBloc.add(SelectIntEvent(0));
                      //         //numberType = appLocalization(context).business;
                      //         // setState(() {
                      //         //   numberType = appLocalization(context).business;
                      //         // });
                      //       },
                      //       child: Row(
                      //         children: [
                      //           Radio(
                      //             focusColor: AppColor.yellowDeep,
                      //             groupValue: numberType,
                      //             onChanged: (value) {
                      //               selectedTabBloc.add(SelectIntEvent(1));
                      //               // numberType = value;
                      //               // // setState(() {
                      //               // //   numberType = value;
                      //               // // }
                      //               // );
                      //             },
                      //             value: appLocalization(context).business,
                      //           ),
                      //           Text(appLocalization(context).business),
                      //         ],
                      //       ),
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {
                      //         selectedTabBloc.add(SelectIntEvent(1));
                      //         // setState(() {
                      //         //   numberType = appLocalization(context).personal;
                      //         // });
                      //       },
                      //       child: Row(
                      //         children: [
                      //           Radio(
                      //             focusColor: AppColor.yellowDeep,
                      //             groupValue: numberType,
                      //             onChanged: (value) {
                      //               selectedTabBloc.add(SelectIntEvent(1));
                      //               numberType = value;
                      //             },
                      //             value: appLocalization(context).personal,
                      //           ),
                      //           Text(appLocalization(context).personal)
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 2 / 100,
                      ),
                      Text(
                        appLocalization(context).writeComment,
                        style: const TextStyle(
                            color: AppColor.blackColor,
                            fontSize: 14,
                            fontFamily: AppFont.fontFamily,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 2 / 100,
                      ),
                      CustomTextField(
                        readOnly: false,
                        controller: commentController,
                        hintText: appLocalization(context).whatCallAbout,
                        labelText: appLocalization(context).whatCallAbout,
                        validator: (p0) {
                          if (p0?.isEmpty ?? true) {
                            return appLocalization(context).pleaseEnterComments;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 2 / 100,
                      ),
                      Text(appLocalization(context).whatSpamIt),
                      BlocBuilder(
                        bloc: categoryListBloc,
                        builder: (context, state) {
                          if (state is GetCategoryListState) {
                            List<CategoryData> categories =
                                state.value.categorylist ?? [];
                            if (selectedCategory != null &&
                                !categories.contains(selectedCategory)) {
                              selectedCategory = null;
                            }
                            if (categories.isEmpty) {
                              return Center(
                                child: Text(
                                  appLocalization(context)
                                      .noCategoriesAvailable,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              );
                            }
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: DropdownButton<CategoryData>(
                                hint: Text(
                                    appLocalization(context).selectCategory),
                                value: selectedCategory,
                                isExpanded: true,
                                items: categories.map((category) {
                                  return DropdownMenuItem<CategoryData>(
                                    value: category,
                                    child: Text(category.cateName ?? ""),
                                  );
                                }).toList(),
                                onChanged: (CategoryData? value) {
                                  selectedCategory = value;
                                  selectCategoryBloc
                                      .add(SelectCategoriesEvent(value));
                                },
                              ),
                            );
                          }

                          return const Loader(); // Show loader while loading
                        },
                      ),

                      // BlocBuilder(
                      //     bloc: categoryListBloc,
                      //     builder: (context, state) {
                      //       if (state is GetCategoryListState) {
                      //         List<CategoryData> categories =
                      //             state.value.categorylist ?? [];
                      //         return Center(
                      //           child: categories.isEmpty
                      //               ? Text(appLocalization(context)
                      //                   .noCategoriesAvailable)
                      //               : Padding(
                      //                   padding: const EdgeInsets.symmetric(
                      //                       horizontal: 16.0),
                      //                   child: DropdownButton<CategoryData>(
                      //                     hint: Text(appLocalization(context)
                      //                         .selectCategory),
                      //                     value: selectedCategory,
                      //                     isExpanded: true,
                      //                     items: categories.map((category) {
                      //                       return DropdownMenuItem<
                      //                           CategoryData>(
                      //                         value: category,
                      //                         child:
                      //                             Text(category.cateName ?? ""),
                      //                       );
                      //                     }).toList(),
                      //                     onChanged: (CategoryData? value) {
                      //                       selectedCategory = value;
                      //                       categoryListBloc
                      //                           .add(GetCategoryListEvent());
                      //                       // setState(() {
                      //                       //   selectedCategory = value;
                      //                       // });
                      //                       //print(selectedCategory?.cateName ?? "");
                      //                     },
                      //                   ),
                      //                 ),
                      //         );
                      //       }
                      //       return const Loader();
                      //     }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 2 / 100,
                      ),
                      AppButton(
                        text: appLocalization(context).block,
                        onPress: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            if (numberType == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(appLocalization(context)
                                      .pleaseEnterNumberType),
                                  backgroundColor: Colors.black,
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.1,
                                    // Position above the Bottom Sheet
                                    left: 16,
                                    right: 16,
                                  ),
                                ),
                              );
                              return;
                            }
                            if (selectedCategory == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(appLocalization(context)
                                      .pleaseEnterCategory),
                                  backgroundColor: AppColor.blackColor,
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.1,
                                    left: 16,
                                    right: 16,
                                  ),
                                ),
                              );
                              return;
                            }
                            markSpamSmsBloc.add(MarkSpamSmsEvent(
                              address: sms?.address ?? "",
                              comment: commentController.text,
                              numberType: numberType ?? "",
                              category: selectedCategory?.cateId ?? "",
                            ));
                            Navigator.pushNamed(
                                context, AppRoutes.bottomNavigation);
                          }
                        },
                      ),

                      // AppButton(
                      //     text: appLocalization(context).block,
                      //     onPress: () {
                      //       if (_formKey.currentState?.validate() ?? false) {
                      //         if (selectedCategory == null) {
                      //           ScaffoldMessenger.of(context).showSnackBar(
                      //             SnackBar(
                      //               content: Text(appLocalization(context)
                      //                   .pleaseEnterCategory),
                      //               backgroundColor: AppColor.primaryColor,
                      //             ),
                      //           );
                      //           return;
                      //         }
                      //
                      //         if (numberType == null) {
                      //           ScaffoldMessenger.of(context).showSnackBar(
                      //             SnackBar(
                      //               content: Text(appLocalization(context)
                      //                   .pleaseEnterNumberType),
                      //               backgroundColor: Colors.black,
                      //             ),
                      //           );
                      //           return;
                      //         }
                      //         //print(getSms());
                      //         markSpamSmsBloc.add(MarkSpamSmsEvent(
                      //           address: sms?.address ?? "",
                      //           comment: commentController.text,
                      //           numberType: numberType ?? "",
                      //           category: selectedCategory?.cateId ?? "",
                      //         ));
                      //         Navigator.pushNamed(
                      //             context, AppRoutes.bottomNavigation);
                      //       }
                      //     }),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 4 / 100),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
