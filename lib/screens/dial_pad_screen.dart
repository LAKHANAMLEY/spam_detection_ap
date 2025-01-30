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
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      //appBar: CustomAppBar(title: appLocalization(context).call),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              enteredNumber.isEmpty ? "Enter a number" : enteredNumber,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 60,
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                if (index == 9) {
                  return const SizedBox.shrink();
                } else if (index == 10) {
                  return _buildDialerButton("0");
                } else if (index == 11) {
                  return IconButton(
                    onPressed: _onDeletePressed,
                    icon: const Icon(Icons.backspace),
                    iconSize: 32,
                    color: Colors.red,
                  );
                } else {
                  return _buildDialerButton((index + 1).toString());
                }
              },
            ),
          ),

          // Call button
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.green,
              child: IconButton(
                onPressed: enteredNumber.isNotEmpty ? onCallPressed : null,
                icon: Image.asset(IconConstants.icCall,
                    color: AppColor.secondaryColor),
                iconSize: 32,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDialerButton(String number) {
    return GestureDetector(
      onTap: () => onNumberPressed(number),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
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
}
