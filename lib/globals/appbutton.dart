import 'package:flutter/material.dart';

import 'colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function onPress;

  const AppButton({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 90 / 100,
          height: MediaQuery.of(context).size.height * 7 / 100,
          decoration: const BoxDecoration(
            color: AppColor.yellowlightColor,
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 18),
          )),
    );
  }
}
