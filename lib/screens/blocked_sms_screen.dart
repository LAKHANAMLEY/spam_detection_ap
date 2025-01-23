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
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return SafeArea(
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
                        color: AppColor.primaryColor,
                        fontSize: 18,
                        fontFamily: AppFont.fontFamily,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100),
                  Text(
                    appLocalization(context).wasThisBusinessMessage,
                    style: const TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 14,
                        fontFamily: AppFont.fontFamily,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          //selectedTabBloc.add(SelectIntEvent(0));
                          //numberType = appLocalization(context).business;
                          setState(() {
                            numberType = appLocalization(context).business;
                          });
                        },
                        child: Row(
                          children: [
                            Radio(
                              focusColor: AppColor.yellowDeep,
                              groupValue: numberType,
                              onChanged: (value) {
                                //selectedTabBloc.add(SelectIntEvent(1));
                                numberType = value;
                                setState(() {
                                  numberType = value;
                                });
                              },
                              value: appLocalization(context).business,
                            ),
                            Text(appLocalization(context).business),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //selectedTabBloc.add(SelectIntEvent(1));
                          setState(() {
                            numberType = appLocalization(context).personal;
                          });
                        },
                        child: Row(
                          children: [
                            Radio(
                              focusColor: AppColor.yellowDeep,
                              groupValue: numberType,
                              onChanged: (value) {
                                selectedTabBloc.add(SelectIntEvent(1));
                                numberType = value;
                              },
                              value: appLocalization(context).personal,
                            ),
                            Text(appLocalization(context).personal)
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  Text(
                    appLocalization(context).writeComment,
                    style: const TextStyle(
                        color: AppColor.primaryColor,
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
                                        return DropdownMenuItem<CategoryData>(
                                          value: category,
                                          child: Text(category.cateName ?? ""),
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
                  AppButton(
                      text: appLocalization(context).block,
                      onPress: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          if (selectedCategory == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(appLocalization(context)
                                    .pleaseEnterCategory),
                                backgroundColor: AppColor.primaryColor,
                              ),
                            );
                            return;
                          }

                          if (numberType == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(appLocalization(context)
                                    .pleaseEnterNumberType),
                                backgroundColor: Colors.black,
                              ),
                            );
                            return;
                          }
                          //print(getSms());
                          markSpamSmsBloc.add(MarkSpamSmsEvent(
                            address: sms?.address ?? "",
                            comment: commentController.text,
                            numberType: numberType ?? "",
                            category: selectedCategory?.cateId ?? "",
                          ));
                          Navigator.pushNamed(
                              context, AppRoutes.bottomNavigation);
                        }
                      }),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 4 / 100),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
