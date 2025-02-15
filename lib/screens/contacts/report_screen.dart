import 'package:spam_delection_app/lib.dart';

class ReportView extends StatefulWidget {
  final ContactData contact;

  const ReportView({super.key, required this.contact});

  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  ContactData? contact;

  String? numberType;

  var commentController = TextEditingController();
  var phoneController = TextEditingController();
  var selectedTabBloc = SelectionBloc(SelectIntState(0));

  var categoryListBloc = ApiBloc(ApiBlocInitialState());

  CategoryData? selectedCategory;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    contact = widget.contact;
    categoryListBloc.add(GetCategoryListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
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
                        appLocalization(context).reportNumberSpam,
                        style: const TextStyle(
                            color: AppColor.blackColor,
                            fontSize: 18,
                            fontFamily: AppFont.fontFamily,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100),
                      Text(
                        appLocalization(context).wasPersonalNumber,
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
                      //         setState(() {
                      //           numberType = appLocalization(context).business;
                      //         });
                      //       },
                      //       child: Row(
                      //         children: [
                      //           Radio(
                      //             focusColor: AppColor.yellowDeep,
                      //             groupValue: numberType,
                      //             onChanged: (value) {
                      //               setState(() {
                      //                 numberType = value;
                      //               });
                      //             },
                      //             value: appLocalization(context).business,
                      //           ),
                      //           Text(appLocalization(context).business),
                      //         ],
                      //       ),
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {
                      //         setState(() {
                      //           numberType = appLocalization(context).personal;
                      //         });
                      //       },
                      //       child: Row(
                      //         children: [
                      //           Radio(
                      //             focusColor: AppColor.yellowDeep,
                      //             groupValue: numberType,
                      //             onChanged: (value) {
                      //               setState(() {
                      //                 numberType = value;
                      //               });
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
                              return Center(
                                child: categories.isEmpty
                                    ? Text(appLocalization(context)
                                        .noCategoriesAvailable)
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: DropdownButton<CategoryData>(
                                          hint: Text(appLocalization(context)
                                              .selectCategory),
                                          value: selectedCategory,
                                          isExpanded: true,
                                          items: categories.map((category) {
                                            return DropdownMenuItem<
                                                CategoryData>(
                                              value: category,
                                              child:
                                                  Text(category.cateName ?? ""),
                                            );
                                          }).toList(),
                                          onChanged: (CategoryData? value) {
                                            setState(() {
                                              selectedCategory = value;
                                            });
                                            //print(selectedCategory?.cateName ?? "");
                                          },
                                        ),
                                      ),
                              );
                            }
                            return const Loader();
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 2 / 100,
                      ),
                      CustomTextField(
                        controller: phoneController,
                        hintText: appLocalization(context).phoneNumberOps,
                        keyboardType: TextInputType.phone,
                      ),
                      20.height(),
                      // SizedBox(
                      //     height: MediaQuery.of(context).size.height * 4 / 100),
                      AppButton(
                          text: appLocalization(context).reportText,
                          onPress: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (numberType == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(appLocalization(context)
                                        .pleaseEnterCategory),
                                    backgroundColor: AppColor.blackColor,
                                  ),
                                );
                                return const Loader();
                              }
                              if (selectedCategory == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(appLocalization(context)
                                        .pleaseEnterNumberType),
                                    backgroundColor: AppColor.blackColor,
                                  ),
                                );
                                return const Loader();
                              }
                              markSpamBloc.add(MarkSpamEvent(
                                  contactId: contact?.id ?? "0",
                                  comment: commentController.text,
                                  numberType: numberType ?? "",
                                  categoryId: selectedCategory?.cateId ?? "",
                                  phone: contact?.mobileNo ?? ""));
                              Navigator.pop(context);
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
