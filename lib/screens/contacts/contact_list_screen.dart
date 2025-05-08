import 'package:permission_handler/permission_handler.dart';
import 'package:spam_delection_app/lib.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final searchBloc = SelectionBloc(SelectStringState(""));
  List<ContactData> contacts = [];
  List<ContactData> filteredContacts = [];
  final searchController = TextEditingController();
  // contactListBloc.add(GetContactEvent());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ContactDBBloc>().add(LoadDBContacts());
    });
    super.initState();
  }

  List<ContactData> filter() {
    filteredContacts = contacts
        .where((e) => ((e.name
                    ?.toLowerCase()
                    .contains(searchController.text.toLowerCase()) ??
                false) ||
            (e.mobileNo
                    ?.toLowerCase()
                    .contains(searchController.text.toLowerCase()) ??
                false)))
        .toList();
    searchBloc.add(SelectStringEvent(searchController.text));
    return filteredContacts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColor.whiteLightColor,
      appBar: CustomAppBar(title: appLocalization(context).contactList),
      body: SafeArea(
        child: Column(
          children: [
            PermissionWidget(
              permission: Permission.contacts,
            ),
            Expanded(
              child: BlocConsumer<ContactDBBloc, ContactDBState>(
                  listener: (context, contactDBState) {
                if (contactDBState is ContactDBLoaded) {
                  contacts = contactDBState.contacts;
                  filter();
                }
              }, builder: (context, contactDBState) {
                // if (contactDBState is ContactDBError) {
                //   // if (contactDBState.exception is PermissionException) {
                //   //   return Center(
                //   //       child: Text(
                //   //           appLocalization(context).permissionNotAllowed));
                //   // }
                //   return Center(
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Text(
                //           contactDBState.message,
                //           textAlign: TextAlign.center,
                //         ),
                //         ElevatedButton(
                //           onPressed: () {
                //             context.read<ContactDBBloc>().add(SyncDBContacts());
                //           },
                //           child: Text(appLocalization(context).sync),
                //         ),
                //         // ElevatedButton(
                //         //     onPressed: () {
                //         //       context.read<ContactDBBloc>().add(DeleteDBContacts());
                //         //     },
                //         //     child: Text("Delete DB"))
                //       ],
                //     ),
                //   );
                // }
                // if (contactDBState is ContactDBInitial) {
                //   return Center(
                //     child: ElevatedButton(
                //       onPressed: () {
                //         context.read<ContactDBBloc>().add(SyncDBContacts());
                //       },
                //       child: Text("Load contacts"),
                //     ),
                //   );
                // }
                // if (contactDBState is ContactDBLoaded) {
                //   contacts = contactDBState.contacts;
                //   filter();
                // filteredContacts = filter();
                return BlocConsumer(
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
                              controller: searchController,
                              onTap: null,
                              fillColor: AppColor.whiteColor,
                              onChanged: (value) {
                                filter();
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
                                        // contactListBloc
                                        //     .add(GetDeviceContactEvent());
                                        context
                                            .read<ContactDBBloc>()
                                            .add(SyncDBContacts());
                                      },
                                      child: Text(appLocalization(context)
                                          .syncContacts)),
                                  PopupMenuItem(
                                      onTap: () {
                                        // contactListBloc
                                        //     .add(GetDeviceContactEvent());
                                        context
                                            .read<ContactDBBloc>()
                                            .add(DeleteDBContacts());
                                      },
                                      child: Text(
                                          appLocalization(context).deleteAll))
                                ],
                              ),
                            ),
                            // 5.height(),
                            Expanded(
                              child: Builder(
                                  // bloc: contactListBloc,
                                  // listener: (context, state) {
                                  //   if (state is ApiBlocInitialState) {
                                  //     contactListBloc.add(GetContactEvent());
                                  //   }
                                  //   if (state is GetDeviceContactState) {
                                  //     var deviceContacts = state.value;
                                  //     if (deviceContacts != null) {
                                  //       contacts = deviceContacts
                                  //           .map((e) => ContactData(
                                  //                 mobileNo: e.phones.isNotEmpty
                                  //                     ? e.phones.first.number
                                  //                     : "",
                                  //                 // callDuration: e.duration.toString(),
                                  //                 name: e.displayName,
                                  //                 // callType: e.callType?.name,
                                  //                 // callTime: e.timestamp?.toDateTime(),
                                  //               ))
                                  //           .toList();
                                  //       filteredContacts = filter("", contacts);
                                  //       contactListBloc.add(SyncContactEvent(
                                  //           contacts: deviceContacts));
                                  //     }
                                  //   }
                                  //   if (state is GetContactState) {
                                  //     // filterSearchResults("");
                                  //     if (state.value.statusCode == 200) {
                                  //       contacts = state.value.contactslist ?? [];
                                  //       filteredContacts = filter("", contacts);
                                  //     } else if (state.value.statusCode ==
                                  //         HTTPStatusCodes.sessionExpired) {
                                  //       sessionExpired(
                                  //           context, state.value.message ?? "");
                                  //     } else {
                                  //       showToast(state.value.message);
                                  //     }
                                  //   }
                                  //   if (state is SyncContactState) {
                                  //     if (state.value.statusCode == 200) {
                                  //       showToast(state.value.message);
                                  //     } else if (state.value.statusCode ==
                                  //         HTTPStatusCodes.sessionExpired) {
                                  //       sessionExpired(
                                  //           context, state.value.message ?? "");
                                  //     } else {
                                  //       showToast(state.value.message);
                                  //     }
                                  //     contactListBloc.add(GetContactEvent());
                                  //   }
                                  //   if (state is DeleteContactState) {
                                  //     if (state.value.statusCode == 200) {
                                  //       showCustomDialog(
                                  //         context,
                                  //         dialogType: DialogType.success,
                                  //         subTitle: state.value.message ??
                                  //             appLocalization(context)
                                  //                 .deletedSuccessfully,
                                  //       );
                                  //     } else if (state.value.statusCode ==
                                  //         HTTPStatusCodes.sessionExpired) {
                                  //       sessionExpired(
                                  //           context, state.value.message ?? "");
                                  //     } else {
                                  //       showToast(state.value.message);
                                  //     }
                                  //     contactListBloc.add(GetContactEvent());
                                  //   }
                                  // },
                                  builder: (context) {
                                // if (state is GetContactState) {
                                return BlocBuilder(
                                    bloc: searchBloc,
                                    builder: (context, searchState) {
                                      if (searchState is SelectStringState) {
                                        if (contactDBState
                                                is ContactDBLoading &&
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
                                          itemBuilder: (context, i) {
                                            return ContactListItem(
                                              contact: filteredContacts[i],
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
                    });
                // }
                // return Loader();
              }),
            ),
          ],
        ),
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
}
