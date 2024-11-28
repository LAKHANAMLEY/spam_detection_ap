import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_event.dart';
import 'package:spam_delection_app/data/repository/spam_repo/spam_list_api.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_bloc.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_event.dart';
import 'package:spam_delection_app/bloc/api_bloc/api_state.dart';
import '../bloc/api_bloc/api_state.dart';
import '../constants/icons_constants.dart';
import '../data/repository/contact/sync_contacts_api.dart';
import '../data/repository/setting_repo/category_list_api.dart';
import '../globals/app_fonts.dart';
import '../globals/colors.dart';
import '../models/spam_list_model.dart';
import '../utils/permission_request.dart';
import 'loader.dart';

class SpamList extends StatefulWidget {
  const SpamList({super.key});

  @override
  State<SpamList> createState() => _SpamListState();
}

class _SpamListState extends State<SpamList> {
  final TextEditingController editingController = TextEditingController();
  List<SpamData> contacts = [];
  late List<SpamData> filteredContacts;
  SpamData? selectedCategory;
  bool isLoading = false;
  String? errorMessage;

  String? numberType;
  List<SpamData> categories = [];

  var spamListBloc= ApiBloc(ApiBlocInitialState());



  @override
  void initState() {
    super.initState();
    spamListBloc.add(GetSpamEvent());
  }

  void filterSearchResults(String query) {
    setState(() {
      filteredContacts = contacts
          .where((item) =>
              item.spamNo!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      appBar: AppBar(
        backgroundColor: AppColor.secondryColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Image.asset(
              IconConstants.icbackCircle,
            ),
          ),
        ),
        title: const Text(
          'Spam Calls',
          style: TextStyle(
              color: AppColor.callColor,
              fontFamily: AppFont.fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),

        //centerTitle: true,
      ),
      body: SafeArea(
          child: Column(children: <Widget>[
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
                borderSide: BorderSide(color: Color(0xffE1E6EB), width: 1.0),
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
    SizedBox(
    height: MediaQuery.of(context).size.height * 2 / 100,
    ),
    Expanded(
    child: BlocConsumer(
    bloc: spamListBloc,
    listener: (context, state) {
    if (state is GetSpamState) {

    contacts = state.value.spamcontactslist?? [];
    filteredContacts = contacts;
    }

      if(state is RemoveSpamState){
        if(state.value.statusCode==200){
          showDialog(context: context, builder: (context) => AlertDialog(title: Text(state.value.message??""),),);
        }else{
          showDialog(context: context, builder: (context) => AlertDialog(title: Text(state.value.message??""),),);
        }
        spamListBloc.add(GetSpamEvent());
      }
    },
    builder: (context, state) {
      if (state is GetSpamState) {
        contacts = state.value.spamcontactslist ?? [];
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
                MediaQuery
                    .of(context)
                    .size
                    .width * 12 / 100,
                height:
                MediaQuery
                    .of(context)
                    .size
                    .height * 12 / 100,
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
                itemBuilder: (context) =>
                [
                  PopupMenuItem(
                    child: const Text("Remove spam"),
                    onTap: () {
                      spamListBloc.add(RemoveSpamEvent(contactId: filteredContacts[index].id??""));
                    },

                  ),
                ],
              ),
            );
          },
        );
      }
      return const Loader();
    }
    )
    )
      ])),
    );
  }
}


