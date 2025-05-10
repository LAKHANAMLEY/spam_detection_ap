import 'package:spam_delection_app/lib.dart';

class CommentListItem extends StatelessWidget {
  final SpamComment? comment;
  const CommentListItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: Text(comment?.comments ?? ""),
    );
  }
}
