import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';
import 'package:spam_delection_app/lib.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<SmsLog> messages = [];
  List<SmsLog> filteredMessages = [];
  final searchController = TextEditingController();
  final searchBloc = SelectionBloc(SelectStringState(""));
  // final messagesBloc = ApiBloc(ApiBlocInitialState());

  @override
  void initState() {
    // messagesBloc.add(SmsListEvent());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MessageDBBloc>().add(GetAllSmsFromDB());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SmsBloc, SmsState>(
        listener: (context, state) {
          if (state is SmsInitial) {
            log("Initial state");
            context.read<SmsBloc>().add(StartListeningSms());
          }
          if (state is NewSmsReceived) {
            log("SMS received");
            // messagesBloc.add(GetDeviceMessagesEvent());
            context
                .read<MessageDBBloc>()
                .add(SyncChangedMessageWithServer(smsMessage: state.message));
          }
          if (state is NewSmsSent) {
            log("SMS delivered");
            // messagesBloc.add(GetDeviceMessagesEvent());
            context
                .read<MessageDBBloc>()
                .add(SyncChangedMessageWithServer(smsMessage: state.message));
          }
        },
        child: Column(
          children: [
            PermissionWidget(
              permission: Permission.sms,
            ),
            CustomTextField(
              onChanged: (value) {
                // searchBloc.add(SelectStringEvent(value));
                filterSearchResults();
              },
              prefix: const Icon(
                Icons.search,
                color: AppColor.redColor,
              ),
              suffix: PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text(appLocalization(context).sync),
                    onTap: () {
                      // messagesBloc.add(GetDeviceMessagesEvent());
                      context
                          .read<MessageDBBloc>()
                          .add(SyncMessagesWithServer());
                    },
                  ),
                  PopupMenuItem(
                    child: Text(appLocalization(context).delete),
                    onTap: () {
                      // messagesBloc.add(GetDeviceMessagesEvent());
                      context.read<MessageDBBloc>().add(DeleteMessageDB());
                    },
                  ),
                  PopupMenuItem(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.blockList);
                    },
                    child: Row(
                      children: [
                        // Image.asset(
                        //   IconConstants.icBlockedCall,
                        //   scale: 2,
                        // ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width * 5 / 100,
                        // ),
                        Text(appLocalization(context).myBlockList,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  )
                ],
              ),
              controller: searchController,
              hintText: appLocalization(context).searchMore,
              fillColor: Colors.white,
            ),
            Expanded(
              child: BlocConsumer<MessageDBBloc, MessageDBState>(
                listener: (context, state) {
                  if (state is MessageDBLoaded) {
                    messages = state.smsLogs;
                    filterSearchResults();
                  }
                },
                // bloc: messagesBloc,
                // listener: (context, state) {
                //   if (state is ApiBlocInitialState) {
                //     messagesBloc.add(GetDeviceMessagesEvent());
                //   }
                //   if (state is GetDeviceMessagesState) {
                //     // messages = state.value;
                //     messagesBloc.add(SyncSmsEvent(smsLogs: state.value));
                //   }
                //   if (state is SyncSmsState) {
                //     if (state.value.statusCode == 200) {
                //       showToast(state.value.message);
                //     } else if (state.value.statusCode ==
                //         HTTPStatusCodes.sessionExpired) {
                //       sessionExpired(context, state.value.message);
                //     } else {
                //       showToast(state.value.message);
                //     }
                //     messagesBloc.add(SmsListEvent());
                //   }
                //   if (state is SmsListState) {
                //     if (state.value.statusCode == 200) {
                //     } else if (state.value.statusCode ==
                //         HTTPStatusCodes.sessionExpired) {
                //       sessionExpired(context, state.value.message);
                //     } else {
                //       showToast(state.value.message);
                //     }
                //   }
                //   //if (state is smsDelete) {}
                // },
                builder: (context, state) {
                  if (state is MessageDBError) {
                    // if (state.exception is PermissionException) {
                    //   return Center(
                    //       child: Text(
                    //           appLocalization(context).permissionNotAllowed));
                    // }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            state.message,
                            textAlign: TextAlign.center,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<MessageDBBloc>()
                                  .add(SyncMessagesWithServer());
                            },
                            child: Text(appLocalization(context).sync),
                          ),
                          // ElevatedButton(
                          //     onPressed: () {
                          //       context
                          //           .read<MessageDBBloc>()
                          //           .add(DeleteMessageDB());
                          //     },
                          //     child: Text("Delete DB"))
                        ],
                      ),
                    );
                  }
                  if (state is MessageDBInitial) {
                    return Center(
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<MessageDBBloc>()
                              .add(SyncMessagesWithServer());
                        },
                        child: Text(appLocalization(context).sync),
                      ),
                    );
                  }
                  // if (state is MessageDBLoaded) {
                  //   var messages = state.smsLogs;
                  return BlocBuilder(
                    bloc: searchBloc,
                    builder: (context, searchState) {
                      // if (state is SelectStringState) {
                      if (filteredMessages.isEmpty &&
                          state is MessageDBLoading) {
                        return Loader();
                      } else if (filteredMessages.isEmpty) {
                        return Center(
                          child: Text(appLocalization(context).noMessages),
                        );
                      }
                      return ListView.builder(
                        itemCount: filteredMessages.length,
                        itemBuilder: (context, index) =>
                            MessageListItem(sms: filteredMessages[index]),
                      );
                      // }
                      // return const Loader();
                    },
                  );
                  // }
                  // return const Loader();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<SmsLog> filterSearchResults() {
    filteredMessages = messages
        .where((e) =>
                (e.address
                        ?.toLowerCase()
                        .contains(searchController.text.toLowerCase()) ??
                    false) ||
                (e.name
                        ?.toLowerCase()
                        .contains(searchController.text.toLowerCase()) ??
                    false)
            //&&
            // (e.?.toLowerCase().contains(searchString.toLowerCase()) ??
            //     false)
            )
        .toList();
    searchBloc.add(SelectStringEvent(searchController.text));
    return filteredMessages;
  }
}
