import 'package:spam_delection_app/lib.dart';

class CustomListTile extends StatelessWidget {
  final void Function()? onTap;
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  const CustomListTile({
    super.key,
    this.onTap,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(10),
          decoration: ThemeConstants.decoration,
          child: Row(
            children: [
              if (leading != null) leading!,
              5.width(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null) title!,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (subtitle != null) ? subtitle! : const Spacer(),
                        // 5.width(),
                        if (trailing != null) trailing!
                      ],
                    ),
                  ],
                ),
              ),
              // 5.width(),
              // if (trailing != null) trailing!
            ],
          )),
    );
  }
}
