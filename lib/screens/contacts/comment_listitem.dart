import 'package:spam_delection_app/lib.dart';

class CommentListItem extends StatelessWidget {
  final SpamComment? comment;
  const CommentListItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: Row(
        children: [
          Text(
            comment?.reportByUsername ?? "",
            style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
          ),
          Circle(),
          Text(
            comment?.markdate?.formatRelativeDateTime() ?? "",
            style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
          ),
        ],
      ),
      subtitle: Text(comment?.comments ?? ""),
      // trailing: Text(
      //   comment?.markdate?.formatRelativeDateTime() ?? "",
      //   style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
      // ),
    );
  }
}
