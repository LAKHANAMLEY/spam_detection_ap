import 'package:spam_delection_app/lib.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  var messages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        if (messages.isEmpty) {
          return const Center(
            child: Text("No messages"),
          );
        }
        return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(messages[index].toString()),
          ),
        );
      }),
    );
  }
}
