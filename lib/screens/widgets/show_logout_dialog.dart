import 'package:spam_delection_app/lib.dart';

showLogoutDialog(context) {
  showCustomDialog(
    context,
    dialogType: DialogType.alert,
    subTitle: appLocalization(context).doYouReallyWantToLogout,
    okBtnTxt: appLocalization(context).yes,
    // okBtnColor: Colors.red,
    // cancelBtnColor: Colors.green,
    showCancelBtn: true,
    onOkPressed: () async {
      // bool isTourNavigationShowed = await SharedPref.getIsTourNavigationShowed();
      // bool isIntroShowed = await SharedPref.getIsIntroShowed();
      // bool isRemember = await SharedPref.getisRemember();
      // if (isRemember) {
      //   String mobile = await SharedPref.getPhoneNumber();
      //   String password = await SharedPref.getPassword();
      //   SharedPref.clearAll();
      //   SharedPref.saveLoginCredentials(
      //       mobile: mobile, password: password, isRemember: isRemember);
      // } else {
      SharedPref.clearAll();
      // }
      // SharedPref.setIsTourNavigationShowed(isTourNavigationShowed);
      // SharedPref.setIsIntroShowed(isIntroShowed);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRoutes.protectionType, (route) => false);
    },
  );
  // var textTheme = Theme.of(context).textTheme;
  // bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  // AwesomeDialog(
  //     context: context,
  //     // dialogBackgroundColor: isDarkMode ? themeColorHeader : null,
  //     // barrierColor: themeColorHeader,
  //     dialogBackgroundColor: isDarkMode ? themeLogoColorBlue : Colors.white,
  //     dialogType: DialogType.question,
  //     title: appLocalization(context).doYouReallyWantToLogout,
  //     titleTextStyle: textTheme.titleMedium,
  //     btnOkText: appLocalization(context).yes,
  //     btnCancelText: appLocalization(context).no,
  //     btnOkColor: Colors.red,
  //     btnCancelColor: Colors.green,
  //     btnCancelOnPress: () {},
  //     btnOkOnPress: () async {
  //       bool isTourNavigationShowed =
  //           await SharedPref.getIsTourNavigationShowed();
  //       bool isIntroShowed = await SharedPref.getIsIntroShowed();
  //       bool isRemember = await SharedPref.getisRemember();
  //       if (isRemember) {
  //         String mobile = await SharedPref.getPhoneNumber();
  //         String password = await SharedPref.getPassword();
  //         SharedPref.clearAll();
  //         SharedPref.saveLoginCredentials(
  //             mobile: mobile, password: password, isRemember: isRemember);
  //       } else {
  //         SharedPref.clearAll();
  //       }
  //       SharedPref.setIsTourNavigationShowed(isTourNavigationShowed);
  //       SharedPref.setIsIntroShowed(isIntroShowed);
  //       // SharedPreferance.clearAll();
  //       Navigator.of(context)
  //           .pushNamedAndRemoveUntil(AppRoutes.welcome, (route) => false);
  //     }).show();
}
