import 'package:spam_delection_app/lib.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final bool? centerTitle;
  final PreferredSizeWidget? bottom;

  const CustomAppBar(
      {super.key,
      this.leading,
      required this.title,
      this.actions,
      this.centerTitle = true,
      this.titleWidget,
      this.bottom});

  @override
  Widget build(BuildContext context) {
    // var textTheme = Theme.of(context).textTheme;
    // var themeMode = MediaQuery.of(context).platformBrightness;
    // bool isDarkMode = themeMode == Brightness.dark;
    // print(themeMode);
    return AppBar(
      leading: leading ??
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.asset(
                  IconConstants.backIcon,
                ),
              ),
            ),
          ),
      elevation: 0,
      // backgroundColor: Colors.transparent,
      backgroundColor: AppColor.secondryColor,
      // backgroundColor: headerColor,
      // leading: const BackButton(
      //   color: Colors.white,
      // ),
      iconTheme: const IconThemeData(color: Colors.black),
      centerTitle: centerTitle,
      bottom: bottom,
      title: titleWidget ??
          Text(
            title,
            // style: const TextStyle(color: Colors.white),
            // style: textTheme.titleMedium,
            style: const TextStyle(color: Colors.black, fontSize: 18),
          ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size(200, 50);
}
