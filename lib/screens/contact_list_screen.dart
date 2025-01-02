import 'package:spam_delection_app/lib.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final searchController = TextEditingController();
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
        .where((e) => (e.name!
                .toLowerCase()
                .contains(searchController.text.toLowerCase()) ||
            e.mobileNo!
                .toLowerCase()
                .contains(searchController.text.toLowerCase())))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.secondryColor,
      appBar: CustomAppBar(title: appLocalization(context).contactList),
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
                      fillColor: Colors.white,
                      onChanged: (value) {
                        // filterSearchResults();
                        searchBloc.add(SelectStringEvent(value));
                      },
                      controller: searchController,
                      prefix: const Icon(
                        Icons.search,
                        color: AppColor.redColor,
                      ),
                      hintText: appLocalization(context).searchMore,
                      suffix: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              onTap: () {
                                contactListBloc.add(GetDeviceContactEvent());
                              },
                              child:
                                  Text(appLocalization(context).syncContacts))
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
                            if (state is DeleteContactState) {
                              if (state.value.statusCode == 200) {
                                showCustomDialog(
                                  context,
                                  dialogType: DialogType.success,
                                  subTitle: state.value.message ??
                                      appLocalization(context)
                                          .deletedSuccessfully,
                                );
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
                              return BlocConsumer(
                                  bloc: searchBloc,
                                  listener: (context, state) {
                                    if (state is SelectStringState) {
                                      // filterSearchResults();
                                      // filteredContacts = contacts
                                      //     .where((contact) => (contact.name!
                                      //         .toLowerCase()
                                      //         .contains(state.value ??
                                      //             "".toLowerCase())))
                                      //     .toList();
                                      // print(filteredContacts.map((e) {
                                      //   print(e.name);
                                      // }));
                                    }
                                  },
                                  builder: (context, searchState) {
                                    if (searchState is SelectStringState) {
                                      filterSearchResults();
                                      if (filteredContacts.isEmpty) {
                                        return Center(
                                          child: Text(appLocalization(context)
                                              .noContacts),
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
                                    }
                                    return const Loader();
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
