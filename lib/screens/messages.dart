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
    return Scaffold(
      body: Column(
        children: [
          CustomTextField(
            onChanged: (value) {
              searchBloc.add(SelectStringEvent(value));
            },
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
                  // messagesBloc.add(GetDeviceMessagesEvent());
                }
              },
              builder: (context, state) {
                if (state is GetDeviceMessagesState) {
                  var messages = state.value;
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
          )
        ],
      ),
    );
  }

  List<SmsMessage> filterSearchResults(
      String searchString, List<SmsMessage> messages) {
    return messages
        .where((e) =>
            (e.sender?.toLowerCase().contains(searchString.toLowerCase()) ??
                false) ||
            (e.body?.toLowerCase().contains(searchString.toLowerCase()) ??
                false))
        .toList();
  }
}
