import 'package:flutter/material.dart';
import 'package:spam_delection_app/globals/colors.dart';

class Loader extends StatelessWidget {
  final double? value;
  final Color? backgroundColor;
  final Color? color;
  final Animation<Color?>? valueColor;
  final String? semanticsLabel;
  final String? semanticsValue;
  const Loader({
    super.key,
    this.value,
    this.backgroundColor,
    this.color = AppColor.themeOrangeColor,
    this.valueColor,
    this.semanticsLabel,
    this.semanticsValue,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: backgroundColor,
        value: value,
        color: color,
        key: key,
        semanticsLabel: semanticsLabel,
        semanticsValue: semanticsValue,
        valueColor: valueColor,
      ),
    );
  }
}
