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
                    appLocalization(context).reportNumberSpam,
                    style: const TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 18,
                        fontFamily: AppFont.fontFamily,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100),
                  Text(
                    appLocalization(context).wasPersonalNumber,
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
                          setState(() {
                            numberType = appLocalization(context).business;
                          });
                        },
                        child: Row(
                          children: [
                            Radio(
                              focusColor: AppColor.yellowdeep,
                              groupValue: numberType,
                              onChanged: (value) {
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
                          setState(() {
                            numberType = appLocalization(context).personal;
                          });
                        },
                        child: Row(
                          children: [
                            Radio(
                              focusColor: AppColor.yellowdeep,
                              groupValue: numberType,
                              onChanged: (value) {
                                setState(() {
                                  numberType = value;
                                });
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
                    validator: (p0) {
                      if (p0?.isEmpty ?? true) {
                        return appLocalization(context).pleaseEnterComments;
                      }
                      return null;
                    },
                  ),

                  // decoration: InputDecoration(
                  //   hintText: 'What was the call about ?',
                  //   hintStyle:
                  //       const TextStyle(color: AppColor.lightfillColor),
                  //   enabledBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(2),
                  //     borderSide: const BorderSide(
                  //         width: 1.5, color: AppColor.fillColor),
                  //   ),
                  //   focusedBorder: const OutlineInputBorder(
                  //     borderSide:
                  //         BorderSide(color: Color(0xffE1E6EB), width: 1.5),
                  //     borderRadius: BorderRadius.all(Radius.circular(2)),
                  //   ),
                  //   filled: true,
                  //   fillColor: AppColor.fillColor.withOpacity(0.2),
                  //   counterText: '',
                  // ),
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
                  CustomTextField(
                    controller: phoneController,
                    hintText: appLocalization(context).phoneNumberOps,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 4 / 100),
                  AppButton(
                      text: appLocalization(context).reportText,
                      onPress: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          if (selectedCategory == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(appLocalization(context)
                                    .pleaseEnterCategory),
                                backgroundColor: Colors.black,
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
                          markSpamBloc.add(MarkSpamEvent(
                              contactId: contact?.id ?? "",
                              comment: commentController.text,
                              numberType: numberType ?? "",
                              categoryId: selectedCategory?.cateId ?? "",
                              phone: contact?.mobileNo ?? ""));
                          Navigator.pop(context);
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
