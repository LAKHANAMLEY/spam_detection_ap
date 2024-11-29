import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:spam_delection_app/app_route/route.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_bloc.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_event.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_state.dart';
import 'package:spam_delection_app/data/repository/contact/get_device_contacts.dart';
import 'package:spam_delection_app/globals/app_constants.dart';
import 'package:spam_delection_app/globals/app_fonts.dart';
import 'package:spam_delection_app/globals/appbutton.dart';
import 'package:spam_delection_app/globals/colors.dart';
import 'package:spam_delection_app/models/category_list_model.dart';
import 'package:spam_delection_app/models/contact_list_response.dart';
import 'package:spam_delection_app/screens/add_contact_screen.dart';
import 'package:spam_delection_app/screens/contact_detail_screen.dart';
import 'package:spam_delection_app/screens/loader.dart';
import 'package:spam_delection_app/screens/widgets/custom_app_bar.dart';
import 'package:spam_delection_app/screens/widgets/custom_dialog.dart';
import 'package:spam_delection_app/utils/api_constants/http_status_codes.dart';
import 'package:spam_delection_app/utils/session_expired.dart';
import 'package:spam_delection_app/utils/toast.dart';

import '../constants/icons_constants.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final TextEditingController editingController = TextEditingController();

  List<ContactData> contacts = [];
  late List<ContactData> filteredContacts;

  var markSpamBloc =
      ApiBloc(ApiBlocInitialState()); //ye variable define kr dia bloc ka

  @override
  void initState() {
    super.initState();
    getLocalContacts().then((contacts) {
      if (contacts != null) {
        contactListBloc.add(SyncContactEvent(contacts: contacts));
      } else {
        contactListBloc.add(GetContactEvent());
      }
    });
  }

  void filterSearchResults(String query) {
    setState(() {
      filteredContacts = contacts
          .where(
              (item) => item.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      appBar: const CustomAppBar(title: "Contact list"),
      body: SafeArea(
        child: BlocConsumer(
            bloc: markSpamBloc,
            listener: (context, state) {
              if (state is MarkSpamState) {
                if (state.value.statusCode == 200) {
                  showCustomDialog(
                    context,
                    dialogType: DialogType.success,
                    subTitle: state.value.message,
                  );
                } else {
                  showCustomDialog(
                    context,
                    dialogType: DialogType.failed,
                    subTitle: state.value.message,
                  );
                }
              }
            },
            builder: (context, state) {
              //done
              return ModalProgressHUD(
                progressIndicator: const Loader(),
                inAsyncCall: state is ApiLoadingState,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) => filterSearchResults(value),
                        controller: editingController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: "Search number, names & more",
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          hintStyle: const TextStyle(
                            color: Color(0xffB2B8BD),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xffE1E6EB), width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                width: 0.5, color: Color(0xffE1E6EB)),
                          ),
                          fillColor: AppColor.whiteLight.withOpacity(0.2),
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100,
                    ),
                    Expanded(
                      child: BlocConsumer(
                          bloc: contactListBloc,
                          listener: (context, state) {
                            if (state is GetContactState) {
                              // filterSearchResults("");
                              if (state.value.statusCode == 200) {
                                contacts = state.value.contactslist ?? [];
                                filteredContacts = contacts;
                              } else if (state.value.statusCode ==
                                  HTTPStatusCodes.sessionExpired) {
                                sessionExpired(
                                    context, state.value.message ?? "");
                              } else {
                                showToast(state.value.message);
                              }
                            }
                            if (state is SyncContactState) {
                              if (state.value.statusCode == 200) {
                                showToast(state.value.message);
                              } else if (state.value.statusCode ==
                                  HTTPStatusCodes.sessionExpired) {
                                sessionExpired(
                                    context, state.value.message ?? "");
                              } else {
                                showToast(state.value.message);
                              }
                              contactListBloc.add(GetContactEvent());
                            }
                          },
                          builder: (context, state) {
                            if (state is GetContactState) {
                              contacts = state.value.contactslist ?? [];
                              if (filteredContacts.isEmpty) {
                                return const Center(
                                  child: Text('No contacts'),
                                );
                              }

                              return ListView.builder(
                                itemCount: filteredContacts.length,
                                // shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ContactListItem(
                                    contact: filteredContacts[index],
                                    markSpamBloc: markSpamBloc,
                                  );
                                },
                              );
                            }
                            return const Loader();
                          }),
                    ),
                  ],
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.callColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Image.asset(
          IconConstants.icaddCall,
          height: MediaQuery.of(context).size.height * 6 / 100,
          width: MediaQuery.of(context).size.width * 6 / 100,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddContact()));
        },
      ),
    );
  }
}

class ContactListItem extends StatefulWidget {
  final ContactData contact;
  final ApiBloc markSpamBloc;

  const ContactListItem({
    super.key,
    required this.contact,
    required this.markSpamBloc,
  });

  @override
  State<ContactListItem> createState() => _ContactListItemState();
}

class _ContactListItemState extends State<ContactListItem> {
  final TextEditingController commentController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  CategoryData? selectedCategory;
  // String? errorMessage;
  // bool isLoading = false;
  // List<CategoryData> categories = [];

  String? numberType;

  var categoryListBloc = ApiBloc(ApiBlocInitialState());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.contactDetail,
            arguments: ContactDetail(
              contact: widget.contact,
            ));
      },
      leading: Image.network(
        widget.contact.name!, //TODO: image path
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.person),
        width: MediaQuery.of(context).size.width * 12 / 100,
        height: MediaQuery.of(context).size.height * 12 / 100,
      ),
      title: Text(
        widget.contact.name ?? "",
        style: const TextStyle(
            color: AppColor.primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            fontFamily: AppFont.fontFamily),
      ),
      trailing: PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            child: const Text("Report Number"),
            onTap: () {
              categoryListBloc.add(GetCategoryListEvent());
              _showReportBottomSheet(context, contact: widget.contact);
            },
          ),
        ],
      ),
    );
  }

  void _showReportBottomSheet(BuildContext context,
      {required ContactData contact}) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColor.secondryColor,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          //ui k liye bloc builder or bloc consumer or bloc listner ka use krege
          return Builder(builder: (context) {
            //done
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
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100),
                  const Text(
                    'Was this a business or personal Number?',
                    style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 12,
                        fontFamily: AppFont.fontFamily,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 100,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 8 / 100,
                    width: MediaQuery.of(context).size.width * 90 / 100,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              numberType = "Personal";
                            });
                          },
                          child: Stack(children: [
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 1 / 100,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 7 / 100,
                              width:
                                  MediaQuery.of(context).size.width * 40 / 100,
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
                          ]),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              numberType = "Personal";
                            });
                          },
                          child: Stack(children: [
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 1 / 100,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 7 / 100,
                              width:
                                  MediaQuery.of(context).size.width * 40 / 100,
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
                          ]),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  const Align(
                      child: Text(
                    "Write a comment",
                    style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 12,
                        fontFamily: AppFont.fontFamily,
                        fontWeight: FontWeight.w400),
                  )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).width * 20 / 100,
                    width: MediaQuery.sizeOf(context).width * 90 / 100,
                    child: TextFormField(
                      controller: commentController,
                      //obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'What was the call about ?',
                        hintStyle:
                            const TextStyle(color: AppColor.lightfillColor),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: const BorderSide(
                              width: 1.5, color: AppColor.fillColor),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffE1E6EB), width: 1.5),
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                        filled: true,
                        fillColor: AppColor.fillColor.withOpacity(0.2),
                        counterText: '',
                      ),
                    ),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
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
                  SizedBox(
                    height: MediaQuery.sizeOf(context).width * 20 / 100,
                    width: MediaQuery.sizeOf(context).width * 90 / 100,
                    child: TextFormField(
                      controller: phoneController,
                      //obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        hintStyle:
                            const TextStyle(color: AppColor.lightfillColor),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: const BorderSide(
                              width: 1.5, color: AppColor.fillColor),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffE1E6EB), width: 1.5),
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                        filled: true,
                        fillColor: AppColor.fillColor.withOpacity(0.2),
                        counterText: '',
                      ),
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 4 / 100),
                  AppButton(
                    text: "Report",
                    onPress: () {
                      widget.markSpamBloc.add(MarkSpamEvent(
                          contactId: contact.id ?? "",
                          comment: commentController.text,
                          numberType: numberType ?? "",
                          categoryId: selectedCategory?.cateId ?? "",
                          phone: contact.mobileNo ?? ""));
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 4 / 100),
                ],
              ),
            );
          });
        });
      },
    );
  }
}
