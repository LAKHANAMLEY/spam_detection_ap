import 'package:spam_delection_app/lib.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final TextEditingController editingController = TextEditingController();

  List<ContactData> contacts = [];
  List<ContactData> filteredContacts = [];

  var markSpamBloc = ApiBloc(ApiBlocInitialState());
  @override
  void initState() {
    super.initState();
    contactListBloc.add(GetContactEvent());
    // getLocalContacts().then((contacts) {
    //   if (contacts != null) {
    //     contactListBloc.add(SyncContactEvent(contacts: contacts));
    //   } else {
    //     contactListBloc.add(GetContactEvent());
    //   }
    // });
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
                      onChanged: (value) => filterSearchResults(value),
                      controller: editingController,
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
                              var contacts = state.value;
                              if (contacts != null) {
                                contactListBloc
                                    .add(SyncContactEvent(contacts: contacts));
                              }
                            }
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
