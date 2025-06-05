import 'package:spam_delection_app/lib.dart';

class CommentsList extends StatelessWidget {
  final ContactData? contact;
  const CommentsList({super.key, this.contact});

  @override
  Widget build(BuildContext context) {
    var arg = args(context) as CommentsList;
    final contact = arg.contact;
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
                "${appLocalization(context).comment} (${contact?.spamComments?.length ?? 0})"),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: (contact?.spamComments?.length ?? 0) < 3
                  ? contact?.spamComments?.length
                  : 3,
              itemBuilder: (context, index) =>
                  CommentListItem(comment: contact?.spamComments?[index]),
            ),
          ),
        ],
      ),
    );
  }
}
