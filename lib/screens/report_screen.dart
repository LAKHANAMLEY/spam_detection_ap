import 'package:spam_delection_app/lib.dart';

class ReportView extends StatefulWidget {
  final ContactData contact;
  final ApiBloc markSpamBloc;
  const ReportView(
      {super.key, required this.contact, required this.markSpamBloc});

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
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Report Number As Spam',
              style: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 18,
                  fontFamily: AppFont.fontFamily,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
            const Text(
              'Was this a business or personal number?',
              style: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 12,
                  fontFamily: AppFont.fontFamily,
                  fontWeight: FontWeight.w500),
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
                      numberType = "Business";
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
                        value: "Business",
                      ),
                      const Text('Business'),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      numberType = "Personal";
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
                        value: "Personal",
                      ),
                      const Text("Personal")
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
            ),
            const Text(
              "Write a comment",
              style: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 12,
                  fontFamily: AppFont.fontFamily,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
            ),
            CustomTextField(
              controller: commentController,
              //obscureText: true,
              hintText: 'What was the call about ?',

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
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
            ),
            const Text("What type of spam was it?"),
            BlocBuilder(
                bloc: categoryListBloc,
                builder: (context, state) {
                  if (state is GetCategoryListState) {
                    List<CategoryData> categories =
                        state.value.categorylist ?? [];
                    return Center(
                      child: categories.isEmpty
                          ? const Text('No categories available.')
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: DropdownButton<CategoryData>(
                                hint: const Text('Select a category'),
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
                                  print(selectedCategory?.cateName ?? "");
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
              hintText: 'Phone Number',
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 4 / 100),
            AppButton(
              text: "Report",
              onPress: () {
                widget.markSpamBloc.add(MarkSpamEvent(
                    contactId: contact?.id ?? "",
                    comment: commentController.text,
                    numberType: numberType ?? "",
                    categoryId: selectedCategory?.cateId ?? "",
                    phone: contact?.mobileNo ?? ""));
                Navigator.pop(context);
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 4 / 100),
          ],
        ),
      );
    });
  }
}
