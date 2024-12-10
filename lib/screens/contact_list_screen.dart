import 'package:spam_delection_app/lib.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final TextEditingController searchController = TextEditingController();
  final searchBloc = SelectionBloc(SelectStringState(""));

  List<ContactData> contacts = [];
  List<ContactData> filteredContacts = [];

  @override
  void initState() {
    super.initState();
    contactListBloc.add(GetContactEvent());
  }

  void filterSearchResults() {
    filteredContacts = contacts
        .where((contact) =>
            contact.name!
                .toLowerCase()
                .contains(searchController.text.toLowerCase()) ||
            contact.mobileNo!
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.secondryColor,
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
                } else if (state.value.statusCode ==
                    HTTPStatusCodes.sessionExpired) {
                  sessionExpired(context, state.value.message ?? "");
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
              return ModalProgressHUD(
                progressIndicator: const Loader(),
                inAsyncCall: state is ApiLoadingState,
                child: Column(
                  children: <Widget>[
                    CustomTextField(
                      onChanged: (value) {
                        filterSearchResults();
                      },
                      controller: searchController,
                      prefix: const Icon(
                        Icons.search,
                        color: AppColor.redColor,
                      ),
                      hintText: "Search numbers, names & more",
                      suffix: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              onTap: () {
                                contactListBloc.add(GetDeviceContactEvent());
                              },
                              child: const Text("Sync contacts"))
                        ],
                      ),
                    ),
                    // 5.height(),
                    Expanded(
                      child: BlocConsumer(
                          bloc: contactListBloc,
                          listener: (context, state) {
                            if (state is GetDeviceContactState) {
                              var deviceContacts = state.value;
                              if (deviceContacts != null) {
                                contactListBloc.add(
                                    SyncContactEvent(contacts: deviceContacts));
                              }
                            }
                            if (state is GetContactState) {
                              // filterSearchResults("");
                              if (state.value.statusCode == 200) {
                                contacts = state.value.contactslist ?? [];
                                filterSearchResults();
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
                              return BlocBuilder(
                                  bloc: searchBloc,
                                  builder: (context, searchState) {
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
                                        );
                                      },
                                    );
                                  });
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
