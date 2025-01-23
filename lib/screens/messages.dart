import 'package:spam_delection_app/lib.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List<SmsMessage> messages = [];
    final searchController = TextEditingController();
    final searchBloc = SelectionBloc(SelectStringState(""));
    final messagesBloc = ApiBloc(ApiBlocInitialState());
    messagesBloc.add(GetDeviceMessagesEvent());
    getDeviceToken();
    return Scaffold(
      body: Column(children: [
        CustomTextField(
          onChanged: (value) {
            searchBloc.add(SelectStringEvent(value));
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
                  messagesBloc.add(GetDeviceMessagesEvent());
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
          child: BlocConsumer(
            bloc: messagesBloc,
            listener: (context, state) {
              if (state is ApiBlocInitialState) {
                messagesBloc.add(GetDeviceMessagesEvent());
              }
              if (state is GetDeviceMessagesState) {
                // messages = state.value;
                messagesBloc.add(SyncSmsEvent(smsLogs: state.value));
              }
              if (state is SyncSmsState) {
                if (state.value.statusCode == 200) {
                  showToast(state.value.message);
                } else if (state.value.statusCode ==
                    HTTPStatusCodes.sessionExpired) {
                  sessionExpired(context, state.value.message);
                } else {
                  showToast(state.value.message);
                }
                messagesBloc.add(SmsListEvent());
              }
              if (state is SmsListState) {
                if (state.value.statusCode == 200) {
                } else if (state.value.statusCode ==
                    HTTPStatusCodes.sessionExpired) {
                  sessionExpired(context, state.value.message);
                } else {
                  showToast(state.value.message);
                }
              }
              //if (state is smsDelete) {}
            },
            builder: (context, state) {
              if (state is SmsListState) {
                var messages = state.value.smsLog ?? [];
                return BlocBuilder(
                  bloc: searchBloc,
                  builder: (context, state) {
                    if (state is SelectStringState) {
                      var filteredMessages =
                          filterSearchResults(state.value ?? "", messages);
                      if (filteredMessages.isEmpty) {
                        return Center(
                          child: Text(appLocalization(context).noMessages),
                        );
                      }
                      return ListView.builder(
                        itemCount: filteredMessages.length,
                        itemBuilder: (context, index) =>
                            MessageListItem(sms: filteredMessages[index]),
                      );
                    }
                    return const Loader();
                  },
                );
              }
              return const Loader();
            },
          ),
        ),
      ]),
    );
  }

  List<SmsLog> filterSearchResults(String searchString, List<SmsLog> messages) {
    return messages
        .where((e) =>
                (e.address
                        ?.toLowerCase()
                        .contains(searchString.toLowerCase()) ??
                    false) ||
                (e.name?.toLowerCase().contains(searchString.toLowerCase()) ??
                    false)
            //&&
            // (e.?.toLowerCase().contains(searchString.toLowerCase()) ??
            //     false)
            )
        .toList();
  }
}
