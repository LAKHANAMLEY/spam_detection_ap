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
  final scrollController = ScrollController();
  final searchBloc = SelectionBloc(SelectStringState(""));
  final paginationBloc = SelectionBloc(SelectBoolState(false));

  int startFrom = 0;
  int limit = 50;

  // void _pagination() {
  //   if (scrollController.position.atEdge) {
  //     bool isTop = scrollController.position.pixels == 0;
  //     final isPaginating = paginationBloc.state is SelectBoolState &&
  //         (paginationBloc.state as SelectBoolState).value == true;

  //     if (!isTop && !isPaginating) {
  //       log("Reached bottom, start from : $startFrom, limit : $limit");
  //       paginationBloc.add(SelectBoolEvent(true)); // show loader

  //       context.read<MessageDBBloc>().add(
  //             GetAllSmsFromDB(start: startFrom, limit: limit),
  //           );
  //       startFrom += limit;
  //     }
  //   }
  // }

  void _pagination() {
    if (scrollController.position.atEdge) {
      bool isTop = scrollController.position.pixels == 0;
      final isPaginating = paginationBloc.state is SelectBoolState &&
          (paginationBloc.state as SelectBoolState).value == true;

      if (!isTop && !isPaginating) {
        startFrom += limit;
        log("Reached bottom, start from : $startFrom, limit : $limit");
        paginationBloc.add(SelectBoolEvent(true));
        // Trigger pagination
        context.read<MessageDBBloc>().add(
              GetAllSmsFromDB(start: startFrom, limit: limit),
            );
        // Start the background sync immediately after fetching from SQLite
        // context.read<MessageDBBloc>().add(
        //       PaginateAndSyncMessagesWithServer(start: startFrom, limit: limit),
        //     );
      }
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_pagination);
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<MessageDBBloc>()
          .add(GetAllSmsFromDB(start: startFrom, limit: limit));
      // context.read<MessageDBBloc>().add(
      //       PaginateAndSyncMessagesWithServer(start: startFrom, limit: limit),
      //     );
      scrollController.addListener(_pagination);
    });
  }

  void filterSearchResults() {
    setState(() {
      filteredMessages = messages
          .where((e) =>
              (e.address?.toLowerCase() ?? '')
                  .contains(searchController.text.toLowerCase()) ||
              (e.name?.toLowerCase() ?? '')
                  .contains(searchController.text.toLowerCase()))
          .toList();
    });
    searchBloc.add(SelectStringEvent(searchController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SmsBloc, SmsState>(
        listener: (context, state) {
          if (state is SmsInitial) {
            context.read<SmsBloc>().add(StartListeningSms());
          }
          if (state is NewSmsReceived) {
            startFrom = 0;
            context.read<MessageDBBloc>().add(AddSmsLog(
                SmsLog.fromSmsMessage(state.message, ContactData(), null)));
            // context.read<MessageDBBloc>().add(
            //       SyncChangedMessageWithServer(smsMessage: state.message),
            //     );
          } else if (state is NewSmsSent) {
            startFrom = 0;
            context.read<MessageDBBloc>().add(AddSmsLog(
                SmsLog.fromSmsMessage(state.message, ContactData(), null)));
            // context
            //     .read<MessageDBBloc>()
            //     .add(GetAllSmsFromDB(start: startFrom, limit: limit));
            // context.read<MessageDBBloc>().add(
            //       SyncChangedMessageWithServer(smsMessage: state.message),
            //     );
          }
        },
        child: Column(
          children: [
            PermissionWidget(permission: Permission.sms),
            CustomTextField(
              onChanged: (_) => filterSearchResults(),
              prefix: const Icon(Icons.search, color: AppColor.redColor),
              suffix: PopupMenuButton(
                onSelected: (value) {
                  switch (value) {
                    case 'sync':
                      // startFrom = 0;
                      // messages.clear();
                      context.read<MessageDBBloc>().add(
                            PaginateAndSyncMessagesWithServer(
                                start: 0, limit: limit),
                          );
                      break;
                    case 'delete':
                      context.read<MessageDBBloc>().add(DeleteMessageDB());
                      break;
                    case 'blockList':
                      Navigator.pushNamed(context, AppRoutes.blockList);
                      break;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                      value: 'sync',
                      child: Text(appLocalization(context).sync)),
                  PopupMenuItem(
                      value: 'delete',
                      child: Text(appLocalization(context).delete)),
                  PopupMenuItem(
                    value: 'blockList',
                    child: Text(appLocalization(context).myBlockList,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              controller: searchController,
              hintText: appLocalization(context).searchMore,
              fillColor: Colors.white,
            ),
            BlocBuilder(
              bloc: searchBloc,
              builder: (context, state) {
                if (searchController.text.isNotEmpty &&
                    searchController.text.isNumber) {
                  return CustomListTile(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.messagesDetail,
                        arguments: MessagesDetail(
                          sms: SmsLog(
                            // id: searchController.text,
                            address: searchController.text,
                          ),
                        ),
                      );
                    },
                    title: Text("Send to ${searchController.text}"),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            Expanded(
              child: BlocConsumer<MessageDBBloc, MessageDBState>(
                listener: (context, state) {
                  if (state is MessageDBLoaded) {
                    paginationBloc.add(SelectBoolEvent(false));
                    if (startFrom == 0) {
                      messages = List.from(state.smsLogs);
                    } else {
                      messages.addAll(state.smsLogs);
                    }
                    filterSearchResults();
                  }

                  if (state is NewMessageReceived) {
                    // messages.clear();
                    startFrom = 0;
                    context
                        .read<MessageDBBloc>()
                        .add(GetAllSmsFromDB(start: startFrom, limit: limit));
                  }

                  if (state is MessageDBDeletedAll) {
                    paginationBloc.add(SelectBoolEvent(false));
                    startFrom = 0;
                    context
                        .read<MessageDBBloc>()
                        .add(GetAllSmsFromDB(start: startFrom, limit: limit));
                    // messages.clear();
                    filterSearchResults();
                  }

                  if (state is MessageDBDeletedById) {
                    paginationBloc.add(SelectBoolEvent(false));
                    messages.removeWhere(
                        (m) => m.threadId == state.smsLog.threadId);
                    filterSearchResults();
                  }

                  if (state is MessageDBError) {
                    paginationBloc.add(SelectBoolEvent(false));
                    showToast(state.message);
                  }
                  if (state is MessageDBSynced) {
                    paginationBloc.add(SelectBoolEvent(false));
                    startFrom = 0;
                    context
                        .read<MessageDBBloc>()
                        .add(GetAllSmsFromDB(start: startFrom, limit: limit));
                  }
                },
                builder: (context, state) {
                  final isPaginating =
                      paginationBloc.state is SelectBoolState &&
                          (paginationBloc.state as SelectBoolState).value;

                  if (filteredMessages.isEmpty && state is MessageDBLoading) {
                    return const Loader();
                  } else if (filteredMessages.isEmpty) {
                    return Center(
                        child: Text(appLocalization(context).noMessages));
                  }

                  return ListView.builder(
                    controller: scrollController,
                    itemCount: filteredMessages.length + (isPaginating ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (isPaginating && index == filteredMessages.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Loader(),
                        );
                      }
                      return MessageListItem(sms: filteredMessages[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
