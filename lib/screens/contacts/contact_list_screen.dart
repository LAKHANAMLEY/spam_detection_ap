import 'package:spam_delection_app/lib.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    final searchBloc = SelectionBloc(SelectStringState(""));
    List<ContactData> contacts = [];
    List<ContactData> filteredContacts = [];
    contactListBloc.add(GetContactEvent());
    return Scaffold(
      //backgroundColor: AppColor.whiteLightColor,
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
                      onTap: null,
                      fillColor: AppColor.whiteColor,
                      onChanged: (value) {
                        searchBloc.add(SelectStringEvent(value));
                      },
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
                            if (state is ApiBlocInitialState) {
                              contactListBloc.add(GetContactEvent());
                            }
                            if (state is GetDeviceContactState) {
                              var deviceContacts = state.value;
                              if (deviceContacts != null) {
                                contacts = deviceContacts
                                    .map((e) => ContactData(
                                          mobileNo: e.phones.isNotEmpty
                                              ? e.phones.first.number
                                              : "",
                                          // callDuration: e.duration.toString(),
                                          name: e.displayName,
                                          // callType: e.callType?.name,
                                          // callTime: e.timestamp?.toDateTime(),
                                        ))
                                    .toList();
                                filteredContacts =
                                    filterSearchResults("", contacts);
                                contactListBloc.add(
                                    SyncContactEvent(contacts: deviceContacts));
                              }
                            }
                            if (state is GetContactState) {
                              // filterSearchResults("");
                              if (state.value.statusCode == 200) {
                                contacts = state.value.contactslist ?? [];
                                filteredContacts =
                                    filterSearchResults("", contacts);
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
                            // if (state is GetContactState) {
                            return BlocConsumer(
                                bloc: searchBloc,
                                listener: (context, state) {
                                  if (state is SelectStringState) {
                                    filteredContacts = filterSearchResults(
                                        state.value ?? "", contacts);
                                  }
                                },
                                builder: (context, searchState) {
                                  if (searchState is SelectStringState) {
                                    if (state is ApiLoadingState &&
                                        filteredContacts.isEmpty) {
                                      return Loader();
                                    } else if (filteredContacts.isEmpty) {
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
                            // }
                            // return const Loader();
                          }),
                    ),
                  ],
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.darkPurpleColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Image.asset(
          IconConstants.icAddCall,
          height: MediaQuery.of(context).size.height * 6 / 100,
          width: MediaQuery.of(context).size.width * 6 / 100,
        ),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addContact);
        },
      ),
    );
  }

  List<ContactData> filterSearchResults(
    String searchText,
    List<ContactData> contacts,
  ) {
    return contacts
        .where((e) =>
            (e.name!.toLowerCase().contains(searchText.toLowerCase()) ||
                e.mobileNo!.toLowerCase().contains(searchText.toLowerCase())))
        .toList();
  }
}
