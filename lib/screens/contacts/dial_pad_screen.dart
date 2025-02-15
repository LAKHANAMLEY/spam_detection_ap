import 'package:direct_call_plus/direct_call_plus.dart';
import 'package:spam_delection_app/lib.dart';

class DialPad extends StatefulWidget {
  const DialPad({super.key});

  @override
  State<DialPad> createState() => _DialPadState();
}

class _DialPadState extends State<DialPad> {
  String enteredNumber = "";

  void _onDeletePressed() {
    setState(() {
      if (enteredNumber.isNotEmpty) {
        enteredNumber = enteredNumber.substring(0, enteredNumber.length - 1);
      }
    });
  }

  onDeleteLongPressed() {
    setState(() {
      enteredNumber = "";
    });
  }

  void _onDialPressed(String number) {
    setState(() {
      enteredNumber += number;
    });
  }

  void _onLongPressed(String subText) {
    if (subText == "+") {
      setState(() {
        enteredNumber += subText;
      });
    }
  }

  void onCallPressed() async {
    if (enteredNumber == null || enteredNumber.isEmpty) {
      print("Error: No number entered.");
      return;
    }

    String phoneNumber = enteredNumber;
    try {
      await DirectCallPlus.makeCall(phoneNumber);
      print("Calling $phoneNumber");
    } catch (e) {
      print("Failed to make the call: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          // height: 600,
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
          padding: const EdgeInsets.all(10),
          //constraints: BoxConstraints(minHeight: 20, minWidth: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        enteredNumber.isEmpty
                            ? "Enter a number"
                            : enteredNumber,
                        style: textTheme(context).headlineLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    GestureDetector(
                      onLongPress: onDeleteLongPressed,
                      child: IconButton(
                        onPressed: _onDeletePressed,
                        icon: const Icon(Icons.backspace),
                        iconSize: 32,
                        color: Colors.red,
                      ),
                    ),
                  ]),
              10.height(),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    // mainAxisExtent: 80,
                    childAspectRatio: 1.9),
                itemCount: 12,
                itemBuilder: (context, index) {
                  if (index == 9) {
                    return _buildDialerButton("*", subText: "");
                  } else if (index == 10) {
                    return _buildDialerButton("0", subText: "+");
                  } else if (index == 11) {
                    return _buildDialerButton("#", subText: "");
                  } else {
                    return _buildDialerButton((index + 1).toString(),
                        subText: getSubText(index + 1));
                  }
                },
              ),
              10.height(),
              FloatingActionButton.extended(
                backgroundColor: AppColor.greenColor,
                onPressed: () async {
                  // await DirectCallPlus.makeCall((contact
                  //             ?.countryCode?.isNotEmpty ??
                  //         false)
                  //     ? "+${contact?.countryCode ?? ""} ${contact?.mobileNo ?? ""}"
                  //     : contact?.mobileNo ?? "");
                },
                icon: const Icon(Icons.call, size: 32, color: Colors.white),
                label: Text(
                  appLocalization(context).call,
                  style: textTheme(context)
                      .titleMedium
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDialerButton(String text, {String subText = ""}) {
    return GestureDetector(
      onTap: () => _onDialPressed(text),
      onLongPress: () => _onLongPressed(subText),
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
              style: textTheme(context).titleLarge,
            ),
            if (subText.isNotEmpty)
              Text(
                subText,
                style: textTheme(context)
                    .bodySmall
                    ?.copyWith(color: Colors.black54),
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
