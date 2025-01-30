import 'package:direct_call_plus/direct_call_plus.dart';
import 'package:spam_delection_app/lib.dart';

class DialPad extends StatefulWidget {
  const DialPad({super.key});

  @override
  State<DialPad> createState() => _DialPadState();
}

class _DialPadState extends State<DialPad> {
  String enteredNumber = "";

  void onNumberPressed(String number) {
    setState(() {
      enteredNumber += number;
    });
  }

  void _onDeletePressed() {
    setState(() {
      if (enteredNumber.isNotEmpty) {
        enteredNumber = enteredNumber.substring(0, enteredNumber.length - 1);
      }
    });
  }

  void _onDialPressed(String number) {
    setState(() {
      enteredNumber += number;
    });
  }

  void onCallPressed() async {
    if (enteredNumber == null || enteredNumber.isEmpty) {
      print("Error: No number entered.");
      return;
    }

    String phoneNumber = "+${enteredNumber}";
    try {
      await DirectCallPlus.makeCall(phoneNumber);
      print("Calling $phoneNumber");
    } catch (e) {
      print("Failed to make the call: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColor.secondaryColor,
      backgroundColor: Colors.transparent,
      //appBar: CustomAppBar(title: appLocalization(context).call),
      body: Container(
        // constraints: BoxConstraints(
        //   minHeight: 50,
        //   minWidth: double.infinity,
        // ),
        decoration: const BoxDecoration(
          //color: Colors.green,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        //constraints: BoxConstraints(minHeight: 20, minWidth: 20),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          enteredNumber.isEmpty
                              ? "Enter a number"
                              : enteredNumber,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        onPressed: _onDeletePressed,
                        icon: const Icon(Icons.backspace),
                        iconSize: 32,
                        color: Colors.red,
                      ),
                    ]),
              ),
              // Expanded(
              //   child: GridView.builder(
              //     padding: const EdgeInsets.all(16),
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       mainAxisExtent: 60,
              //       crossAxisCount: 3,
              //       crossAxisSpacing: 16,
              //       mainAxisSpacing: 16,
              //     ),
              //     itemCount: 12,
              //     itemBuilder: (context, index) {
              //       if (index == 9) {
              //         return const SizedBox.shrink();
              //       } else if (index == 10) {
              //         return _buildDialerButton("0");
              //       } else if (index == 11) {
              //         return IconButton(
              //           onPressed: _onDeletePressed,
              //           icon: const Icon(Icons.backspace),
              //           iconSize: 32,
              //           color: Colors.red,
              //         );
              //       } else {
              //         return _buildDialerButton((index + 1).toString());
              //       }
              //     },
              //   ),
              // ),
              // Expanded(
              //   child: GridView.builder(
              //     padding: const EdgeInsets.all(16),
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       mainAxisExtent: 60,
              //       crossAxisCount: 3,
              //       crossAxisSpacing: 16,
              //       mainAxisSpacing: 16,
              //     ),
              //     itemCount: 12,
              //     itemBuilder: (context, index) {
              //       if (index == 9) {
              //         return _buildDialerButton("*"); // Add "*"
              //       } else if (index == 10) {
              //         return _buildDialerButtonPress(
              //             "0 +"); // Supports long-press for "+"
              //       } else if (index == 11) {
              //         return _buildDialerButton("#"); // Add "#"
              //       } else {
              //         return _buildDialerButton((index + 1).toString());
              //       }
              //     },
              //   ),
              // ),
              //
              // Call button
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 80,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    if (index == 9) {
                      return _buildDialerButton("*", subText: "");
                    } else if (index == 10) {
                      return _buildDialerButton("0", subText: "+");
                    } else if (index == 11) {
                      return _buildDialerButton("#", subText: "");
                    } else {
                      return buildDialerButton((index + 1).toString(),
                          subText: getSubText(index + 1));
                    }
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: () {
                    // Action on call button press
                  },
                  child: const Icon(Icons.call, size: 32, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDialerButton(String number, {required String subText}) {
    return GestureDetector(
      onTap: () => onNumberPressed(number),
      child: Container(
        decoration: BoxDecoration(
          //shape: BoxShape.circle,
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue.shade50,
        ),
        alignment: Alignment.center,
        child: Text(
          number,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildDialerButton(String text, {String subText = ""}) {
    return GestureDetector(
      onTap: () => _onDialPressed(text),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            if (subText.isNotEmpty)
              Text(
                subText,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
          ],
        ),
      ),
    );
  }

  String getSubText(int number) {
    switch (number) {
      case 1:
        return "∞";
      case 2:
        return "ABC";
      case 3:
        return "DEF";
      case 4:
        return "GHI";
      case 5:
        return "JKL";
      case 6:
        return "MNO";
      case 7:
        return "PQRS";
      case 8:
        return "TUV";
      case 9:
        return "WXYZ";
      default:
        return "";
    }
  }
}
//   Widget _buildDialerButtonPress(String text) {
//     return GestureDetector(
//       onTap: () => _onDialPressed(text),
//       onLongPress: text == "0" ? () => _onDialPressed("+") : null,
//       // Long press for "+"
//       child: Container(
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.blue.shade50,
//         ),
//         alignment: Alignment.center,
//         child: Text(
//           text,
//           style: const TextStyle(
//               fontSize: 24,
//               color: AppColor.primaryColor,
//               fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }
