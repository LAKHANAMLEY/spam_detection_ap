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
    final expandedHeight = 280.0;
    final collapsedHeight = 60.0;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: expandedHeight,
          collapsedHeight: collapsedHeight,
          floating: true,
          pinned: true,
          snap: true,
          backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            title: Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Vyapar App',textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, color: Colors.black,)),
            ),
            background: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: expandedHeight - collapsedHeight - 80,
                    decoration: const BoxDecoration(
                     color: AppColor.redColor
                    ),
                  ),
                ),
                Positioned(
                  bottom: collapsedHeight + 30,
                  left: MediaQuery.of(context).size.width / 2 - 50,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: CircleBorder(),
                    ),
                    child: CircleAvatar(
                      backgroundImage:
                      AssetImage(IconConstants.icspamCircle),
                      radius: 45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6, // Adjust container height
            width: MediaQuery.of(context).size.width*90/100,
            //padding: const EdgeInsets.symmetric(vertical: 20),
            color: AppColor.vanishColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Ensures even spacing
              children: [
                ActionButton(label: 'Message', icon: Icons.message),
                ActionButton(label: 'Not Spam', icon: Icons.check_circle),
                ActionButton(label: 'Block', icon: Icons.block),
              ],
            ),
          ),
        ),

  ]
          );


  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const ActionButton({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Ensures buttons fit the row properly
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey.shade300,
          child: Icon(icon, color: Colors.black, size: 28), // Icon size adjusted
        ),
        const SizedBox(height: 8), // Spacing between icon and text
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.black), // Text styling
        ),
      ],
    );
  }
}


