import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spam_delection_app/globals/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final Widget? suffix;
  final Widget? prefix;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool readOnly;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final TextStyle? style;
  final InputBorder? border;
  final TextAlign textAlign;
  final String? initialValue;
  final int? maxLines;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final double? height;
  const CustomTextField(
      {super.key,
      this.labelText,
      this.hintText,
      this.suffix,
      this.prefix,
      this.keyboardType,
      this.controller,
      this.obscureText = false,
      this.validator,
      this.readOnly = false,
      this.onTap,
      this.onChanged,
      this.style,
      this.border,
      this.textAlign = TextAlign.start,
      this.initialValue,
      this.maxLines = 1,
      this.autofocus = false,
      this.inputFormatters,
      this.height = 70});

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    var isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // var border = OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(10),
    //   borderSide: const BorderSide(width: 1.5, color: AppColor.fillColor),
    // );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // height: height,
          // padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: isDarkMode ? Colors.white : Colors.white24,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          // // constraints: const BoxConstraints(maxHeight: 60, minHeight: 0),
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              if (prefix != null) prefix!,
              Expanded(
                child: TextFormField(
                  inputFormatters: inputFormatters,
                  // initialValue: initialValue,
                  controller: controller,
                  keyboardType: keyboardType,
                  obscureText: obscureText,
                  initialValue: initialValue,
                  maxLines: maxLines,
                  style: style ??
                      const TextStyle().copyWith(
                        color: isDarkMode ? Colors.black : Colors.black,
                        height: 1,
                      ),
                  textAlign: textAlign,
                  decoration: InputDecoration(
                      labelText: labelText,
                      floatingLabelStyle: const TextStyle(
                        color: AppColor.appbgColor,
                        height: 1,
                      ),
                      // floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: hintText,
                      labelStyle: const TextStyle(color: Colors.black),
                      // alignLabelWithHint: true,
                      // floatingLabelAlignment: FloatingLabelAlignment.start,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: const TextStyle(color: Colors.grey),
                      errorStyle: const TextStyle(
                        color: Colors.red,
                        height: 1,
                        inherit: false,
                      ),
                      // fillColor: Colors.white,
                      // filled: isNewDesign ? true : false,
                      suffix: suffix,
                      // prefix: prefix,
                      // prefix: Padding(
                      //   padding: const EdgeInsets.only(top: 0, right: 5),
                      //   child: prefix,
                      // ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 6),
                      // contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      border: InputBorder.none
                      // border: border,
                      // focusedBorder: border,
                      // enabledBorder: border,
                      // disabledBorder: border,
                      // errorBorder: border,
                      // filled: true,
                      // fillColor: AppColor.fillColor.withOpacity(0.2),
                      // border: border ??
                      //     OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                  validator: validator,
                  readOnly: readOnly,
                  onTap: onTap,
                  onChanged: onChanged,
                  autofocus: autofocus,
                ),
              ),
            ],
          ),
        ),
        // if (validator != null)
        //   Text(
        //     validator!.call("") ?? "",
        //     style: const TextStyle(color: Colors.red),
        //   ),
      ],
    );
  }

  String? validator1(String? value) => null;
}
