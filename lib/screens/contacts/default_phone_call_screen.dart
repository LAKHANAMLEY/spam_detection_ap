import 'package:spam_delection_app/lib.dart';

class DefaultCall extends StatelessWidget {
  final CallType? callType;
  final String? number;
  final int? duration;
  const DefaultCall({super.key, this.callType, this.number, this.duration});

  @override
  Widget build(BuildContext context) {
    var arg = args(context) as DefaultCall?;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 100 / 100,
              padding: EdgeInsets.only(top: 60),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[800]!, Colors.blue[400]!],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Text("BoardLink Protect",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  5.height(),
                  Text("Calling ① Jio True5G...",
                      style: TextStyle(color: Colors.white70)),
                  Text("${arg?.number}",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  20.height(),
                  CircleAvatar(
                      radius: 35,
                      child: Text("V", style: TextStyle(fontSize: 30))),
                  10.height(),
                  Text("Vodafone Help Menu",
                      style: TextStyle(color: Colors.white, fontSize: 24)),
                  10.height(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("IDENTIFIED BY BROADLINK",
                        style: TextStyle(color: Colors.white)),
                  ),
                  //5.height(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColor.yellowLightColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("⭐ Likely a business",
                        style: TextStyle(color: AppColor.themeYellowColor)),
                  ),
                  GestureDetector(
                    onTap: () {
                      //Navigator.pushNamed(context,)
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColor.whiteColor, width: 1.5),
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.blackColor,
                      ),
                      child: Text(
                        "View profile",
                        style: TextStyle(
                            color: AppColor.whiteColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                  // TextButton(
                  //     onPressed: () {},
                  //     child: Text("View profile",
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             decoration: TextDecoration.underline))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  10.height(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildIconButton(
                        Icons.mic_off,
                        "Mute",
                        onTap: () => CallController.mute(),
                      ),
                      _buildIconButton(Icons.dialpad, "Keypad"),
                      _buildIconButton(Icons.volume_up, "Speaker"),
                    ],
                  ),
                  20.height(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildIconButton(
                        Icons.add_ic_call,
                        "Add Call",
                        disabled: true,
                        onTap: () => CallController.addCall(),
                      ),
                      _buildIconButton(Icons.sim_card, "Change SIM"),
                      _buildIconButton(Icons.message, "Message"),
                    ],
                  ),
                  10.height(),
                  InkWell(
                    onTap: () => CallController.endCall(),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.red,
                      child:
                          Icon(Icons.call_end, color: Colors.white, size: 30),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String label,
      {bool disabled = false, void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Opacity(
        opacity: disabled ? 0.4 : 1,
        child: Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.grey[800],
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            8.height(),
            Text(label, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
