import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_bloc.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_event.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_state.dart';
import 'package:spam_delection_app/data/repository/contact/sync_contacts_api.dart';
import 'package:spam_delection_app/globals/app_fonts.dart';
import 'package:spam_delection_app/globals/colors.dart';
import 'package:spam_delection_app/models/contact_list_response.dart';
import 'package:spam_delection_app/screens/add_contact_screen.dart';
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
  List<Contactslist> contacts = [];
  late List<Contactslist> filteredContacts;
  final TextEditingController editingController = TextEditingController();

  var contactListBloc = ApiBloc(ApiBlocInitialState());

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

  @override
  void initState() {
    super.initState();
    contactListBloc.add(GetContactEvent());
    getLocalContacts();
    // items = duplicateItems;
  }

  void filterSearchResults(String query) {
    setState(() {
      filteredContacts = contacts
          .where(
              (item) => item.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
                      return ListView.builder(
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
                          );
                        },
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
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddContact()));
        },
      ),
    );
  }
}
