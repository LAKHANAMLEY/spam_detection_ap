import 'package:flutter/material.dart';

enum DialogType {
  success,
  failed,
  alert,
  warning,
  info,
  custom,
}

showCustomDialog(
  context, {
  DialogType dialogType = DialogType.info,
  String? title,
  String? subTitle,
  Widget? titleWidget,
  Widget? content,
  List<Widget>? actions,
  void Function()? onOkPressed,
  void Function()? onCancelPressed,
  bool showCancelBtn = false,
  String? okBtnTxt,
  String? cancelBtnTxt,
  Color? okBtnColor,
  Color? cancelBtnColor,
}) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: titleWidget ?? Text(getTitle(dialogType) ?? title ?? ""),
        content: subTitle != null ? Text(subTitle) : content,
        actions: actions ??
            [
              OutlinedButton(
                  style: OutlinedButton.styleFrom(backgroundColor: okBtnColor),
                  onPressed: onOkPressed ??
                      () {
                        Navigator.pop(context);
                      },
                  child: Text(okBtnTxt ?? "Ok")),
              if (showCancelBtn)
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: cancelBtnColor),
                    onPressed: onCancelPressed ??
                        () {
                          Navigator.pop(context);
                        },
                    child: Text(cancelBtnTxt ?? "No")),
            ],
      ),
    );

String? getTitle(DialogType dialogType) {
  switch (dialogType) {
    case DialogType.success:
      return "Success";
    case DialogType.failed:
      return "Failed";
    case DialogType.alert:
      return "Alert";
    case DialogType.warning:
      return "Warning";
    case DialogType.info:
      return "Info";
    case DialogType.custom:
      return null;
  }
}
