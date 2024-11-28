import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_bloc.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_event.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_state.dart';
import 'package:spam_delection_app/data/repository/contact/sync_contacts_api.dart';
import 'package:spam_delection_app/data/repository/setting_repo/category_list_api.dart';
import 'package:spam_delection_app/data/repository/spam_repo/mark_spam_contacts_api.dart';
import 'package:spam_delection_app/globals/app_fonts.dart';
import 'package:spam_delection_app/globals/appbutton.dart';
import 'package:spam_delection_app/globals/colors.dart';
import 'package:spam_delection_app/models/category_list_model.dart';
import 'package:spam_delection_app/models/contact_list_response.dart';
import 'package:spam_delection_app/screens/add_contact_screen.dart';
import 'package:spam_delection_app/screens/check_spam_screen.dart';
import 'package:spam_delection_app/screens/loader.dart';
import 'package:spam_delection_app/utils/permission_request.dart';

import '../constants/icons_constants.dart';
//import '../data/repository/contact_repo/sync_contacts_api.dart';

class CallLog extends StatefulWidget {
  const CallLog({super.key});

  @override
  State<CallLog> createState() => _CallLogState();
}

class _CallLogState extends State<CallLog> {
  // CategoryListResponse categories = [];
  CategoryData? selectedCategory;
  bool isLoading = false;
  String? errorMessage;

  String? numberType;
  List<Contactslist> contacts = [];
  late List<Contactslist> filteredContacts;
  final TextEditingController editingController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  var contactListBloc = ApiBloc(ApiBlocInitialState());

  List<CategoryData> categories = [];

  var markSpamBloc =
      ApiBloc(ApiBlocInitialState()); //ye variable define kr dia bloc ka

  getLocalContacts() async {
    permissionRequest(Permission.contacts).then((status) async {
      if (status == PermissionStatus.granted) {
        final contacts = await FastContacts.getAllContacts();
        syncContacts(contacts);
      } else {
        print("$status");
      }
    });
  }

  Future<void> fetchCategories() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final fetchedCategories = await ApiService.fetchCategories();
      print(fetchedCategories.toString());
      setState(() {
        categories = fetchedCategories.categorylist ?? [];
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Failed to load categories: $error';
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    contactListBloc.add(GetContactEvent());

    getLocalContacts();
    fetchCategories();
  }

  void filterSearchResults(String query) {
    setState(() {
      filteredContacts = contacts
          .where(
              (item) => item.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _showEditOptions(BuildContext context, {required Contactslist contact}) {
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
          return BlocConsumer(
              bloc: markSpamBloc,
              listener: (context, state) {
                if (state is MarkSpamState) {
                  //ab state se response ese get krege
                  if (state.value.statusCode == 200) {
                    //TODO:handle success
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(state.value.message ?? ""),
                      ),
                    );
                  } else {
                    //TODO: handle failure
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(state.value.message ?? ""),
                      ),
                    );
                  }
                  //ab loader show krte h
                  // showDialog(context: context, builder: builder);
                }
              },
              builder: (context, state) {
                //done
                return ModalProgressHUD(
                  progressIndicator: const Loader(),
                  inAsyncCall: state is ApiLoadingState,
                  child: Padding(
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
                            height:
                                MediaQuery.of(context).size.height * 2 / 100),
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
                        Container(
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
                                    width: MediaQuery.of(context).size.width *
                                        1 /
                                        100,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        7 /
                                        100,
                                    width: MediaQuery.of(context).size.width *
                                        40 /
                                        100,
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
                                    width: MediaQuery.of(context).size.width *
                                        1 /
                                        100,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        7 /
                                        100,
                                    width: MediaQuery.of(context).size.width *
                                        40 /
                                        100,
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
                        const Align(child: Text("Write a comment",style: TextStyle(color: AppColor.primaryColor,fontSize: 12,fontFamily: AppFont.fontFamily,fontWeight: FontWeight.w400),)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        Container(
                          height: MediaQuery.sizeOf(context).width * 20 / 100,
                          width: MediaQuery.sizeOf(context).width * 90 / 100,
                          child: TextFormField(
                            controller: commentController,
                            //obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'What was the call about ?',
                              hintStyle: const TextStyle(
                                  color: AppColor.lightfillColor),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2),
                                borderSide: const BorderSide(
                                    width: 1.5, color: AppColor.fillColor),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffE1E6EB), width: 1.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)),
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
                        Center(
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : errorMessage != null
                                  ? Text(errorMessage!)
                                  : categories.isEmpty
                                      ? const Text('No categories available.')
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: DropdownButton<CategoryData>(
                                            hint:
                                                const Text('Select a category'),
                                            value: selectedCategory,
                                            isExpanded: true,
                                            items: categories.map((category) {
                                              return DropdownMenuItem<
                                                  CategoryData>(
                                                value: category,
                                                child: Text(
                                                    category.cateName ?? ""),
                                              );
                                            }).toList(),
                                            onChanged: (CategoryData? value) {
                                              setState(() {
                                                selectedCategory = value;
                                              });
                                              print(
                                                  selectedCategory?.cateName ??
                                                      "");
                                            },
                                          ),
                                        ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        Container(
                          height: MediaQuery.sizeOf(context).width * 20 / 100,
                          width: MediaQuery.sizeOf(context).width * 90 / 100,
                          child: TextFormField(
                            controller: phoneController,
                            //obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                              hintStyle: const TextStyle(
                                  color: AppColor.lightfillColor),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2),
                                borderSide: const BorderSide(
                                    width: 1.5, color: AppColor.fillColor),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffE1E6EB), width: 1.5),
                                borderRadius:
                                BorderRadius.all(Radius.circular(2)),
                              ),
                              filled: true,
                              fillColor: AppColor.fillColor.withOpacity(0.2),
                              counterText: '',
                            ),
                          ),
                        ),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 4 / 100),
                        AppButton(
                          text: "Report",
                          onPress: () {
                            //TODO:call api to report a spam

                            //isko block se call krte h
                            //ab is function ki need nahi h hame
                            // markSpam(contactId: contact.id??"", comment: commentController.text, numberType: numberType??"", categoryId: selectedCategory?.cateId??"");
                            print(contact.id);

                            //TODO: calling api through bloc
                            // yha btn pr event hit krna h
                            markSpamBloc.add(MarkSpamEvent(
                                contactId: contact.id ?? "",
                                comment: commentController.text,
                                numberType: numberType ?? "",
                                categoryId: selectedCategory?.cateId ?? "",
                                phone: contact.mobileNo ?? ""));
                            //same parameter pass hoge jese function me kiye the
                          },
                        ),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 4 / 100),
                      ],
                    ),
                  ),
                );
              });
        });
      },
    );
  }

  // final String _searchText = '';
  // final int _selection = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      // appBar: AppBar(
      //     leading: Image.asset(
      //       IconConstants.icdrawer,
      //       height: MediaQuery.of(context).size.height * 4 / 100,
      //       width: MediaQuery.of(context).size.width * 4 / 100,
      //     ),
      //     title: Image.asset(
      //       IconConstants.iccallAvater,
      //       height: MediaQuery.of(context).size.height * 6 / 100,
      //     ),
      //     actions: [
      //       Image.asset(
      //         IconConstants.icMoreDetails,
      //         height: MediaQuery.of(context).size.height * 3 / 100,
      //       ),
      //       SizedBox(
      //         width: MediaQuery.of(context).size.width * 3 / 100,
      //       ),
      //     ]),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => filterSearchResults(value),
                controller: editingController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search number,names & more",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  hintStyle: const TextStyle(
                    color: Color(0xffB2B8BD),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xffE1E6EB), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(width: 0.5, color: Color(0xffE1E6EB)),
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
                      contacts = state.value.contactslist ?? [];
                      filteredContacts = contacts;
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
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckSpam()));
                        },
                        child: ListView.builder(
                          itemCount: filteredContacts.length,
                          // shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Image.network(
                                filteredContacts[index].name!, //TODO: image path
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.person),
                                width:
                                    MediaQuery.of(context).size.width * 12 / 100,
                                height:
                                    MediaQuery.of(context).size.height * 12 / 100,
                              ),
                              title: Text(
                                filteredContacts[index].name ?? "",
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
                                      //pass the contact parameter here in the function
                                      _showEditOptions(context,
                                          contact: filteredContacts[index]);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const Loader();
                  }),
            ),
          ],
        ),
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
