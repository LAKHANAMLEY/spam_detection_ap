import 'package:spam_delection_app/lib.dart';

class ReportSmsView extends StatefulWidget {
  final SmsDetail sms;

  const ReportSmsView({super.key, required this.sms});

  @override
  State<ReportSmsView> createState() => _ReportSmsViewState();
}

class _ReportSmsViewState extends State<ReportSmsView> {
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
    return Scaffold(
        // backgroundColor: AppColor.redColor,
        backgroundColor: Colors.transparent,
        //extendBody: false,
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(left: 18, right: 18),
          height: MediaQuery.of(context).size.height * 20 / 100,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            // color: AppColor.greyColor,

            color: Colors.grey.withAlpha(40),
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
                ],
              ),
              20.height(),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    if (numberType == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              appLocalization(context).pleaseEnterNumberType),
                          backgroundColor: Colors.black,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.1,
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
                          content: Text(
                              appLocalization(context).pleaseEnterCategory),
                          backgroundColor: AppColor.blackColor,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.1,
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
                    Navigator.pop(context);
                    // Navigator.pushNamed(
                    //     context, AppRoutes.bottomNavigation);
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: AppColor.redColor,
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
                      'REPORT',
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
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      appLocalization(context).reportSpam,
                      style: const TextStyle(
                          color: AppColor.blackColor,
                          fontSize: 18,
                          fontFamily: AppFont.fontFamily,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  10.height(),
                  Text(
                    appLocalization(context).reportSpamLabel,
                    style: const TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 14,
                        fontFamily: AppFont.fontFamily,
                        fontWeight: FontWeight.w400),
                  ),
                  10.height(),
                  BlocBuilder(
                      bloc: selectedTabBloc,
                      builder: (context, selectTabState) {
                        if (selectTabState is SelectStringState) {
                          numberType = selectTabState.value;
                          // int SelectedTab = selectTabState.value;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Add event to update selected tab and numberType
                                  selectedTabBloc
                                      .add(SelectStringEvent("business"));
                                },
                                child: Row(
                                  children: [
                                    Radio(
                                      focusColor: AppColor.deepYellowColor,
                                      groupValue: numberType,
                                      // Current selected value
                                      onChanged: (value) {
                                        // Trigger Bloc event and update numberType
                                        selectedTabBloc
                                            .add(SelectStringEvent(value));
                                      },
                                      value:
                                          "business", // Value for this radio button
                                    ),
                                    Text(appLocalization(context).business),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Add event to update selected tab and numberType
                                  selectedTabBloc
                                      .add(SelectStringEvent("personal"));
                                },
                                child: Row(
                                  children: [
                                    Radio(
                                      focusColor: AppColor.deepYellowColor,
                                      groupValue: numberType,
                                      // Current selected value
                                      onChanged: (value) {
                                        // Trigger Bloc event and update numberType
                                        selectedTabBloc
                                            .add(SelectStringEvent(value));
                                      },
                                      value:
                                          "personal", // Value for this radio button
                                    ),
                                    Text(appLocalization(context).personal),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                        return const Loader();
                      }),
                  Text(appLocalization(context).whatTypeOfMessage),
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
                              appLocalization(context).noCategoriesAvailable,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: BlocBuilder(
                              bloc: selectCategoryBloc,
                              builder: (context, state) {
                                return DropdownButton<CategoryData>(
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
                                );
                              }),
                        );
                      }

                      return const Loader(); // Show loader while loading
                    },
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
                  20.height()
                ],
              ),
            ),
          ),
        ));
  }
}
