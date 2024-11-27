import 'package:flutter/material.dart';
import 'package:spam_delection_app/constants/string_constants.dart';

import '../constants/icons_constants.dart';
import '../globals/app_fonts.dart';
import '../globals/colors.dart';

class CheckSpam extends StatefulWidget {
  const CheckSpam({super.key});

  @override
  State<CheckSpam> createState() => _CheckSpamState();
}

class _CheckSpamState extends State<CheckSpam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondryColor,
        appBar: AppBar(
          backgroundColor: AppColor.redColor,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.asset(
                  IconConstants.icbackCircle, color: AppColor.secondryColor,
                ),
              ),
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 2 / 100,
            ),
          ),
          title: Text(

            StringConstants.identifiedtext,
            style: TextStyle(
                color: AppColor.secondryColor.withOpacity(0.2),
                fontFamily: AppFont.fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: Stack(
            children: [
              // Main content
              Column(
                children: [
                  // Space for AppBar
                  Container(
                    height: kToolbarHeight + MediaQuery
                        .of(context)
                        .padding
                        .top,
                    color: Colors.red, // AppBar background color
                  ),
                  Expanded(
                    child: Center(
                      child: Text("Main Content Here"),
                    ),
                  ),
                ],
              ),

              // Positioned Stack (with AppBar overlay)
              Positioned(
                top: MediaQuery
                    .of(context)
                    .padding
                    .top, // To account for status bar
                left: 16, // Padding from left
                child: Row(
                  children: [
                    // Back Button
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {},
                    ),
                    SizedBox(width: 16),
                    // Positioned Avatar
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150', // Replace with avatar image URL
                      ),
                    ),
                    SizedBox(width: 8),
                    // Title
                    Text(
                      "User Name",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ]
        )
    );
  }
}