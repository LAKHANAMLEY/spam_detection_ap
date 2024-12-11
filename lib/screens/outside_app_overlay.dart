import 'package:spam_delection_app/lib.dart';

class OutSideAppOverlay extends StatefulWidget {
  const OutSideAppOverlay({super.key});

  @override
  State<OutSideAppOverlay> createState() => _OutSideAppOverlayState();
}

class _OutSideAppOverlayState extends State<OutSideAppOverlay> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // themeMode: ThemeMode.dark,
      title: AppConstants.projectName,
      routes: routes,
      home: Material(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            // color: AppColor.callColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(IconConstants.icAvater),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Image.asset(IconConstants.icBroadlogo),
                  // ),
                  10.width(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Incoming call",
                        style: textTheme(context).bodySmall,
                      ),
                      Text(
                        "John doe",
                        style: textTheme(context).titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
              20.height(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                  // fixedSize: Size(double.infinity, 30),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.contactDetail,
                      arguments: ContactDetail(
                        contact: ContactData(
                          name: "Raj kumar patel",
                          mobileNo: "9977783414",
                        ),
                      ));
                },
                label: const Text("View profile"),
                icon: const Icon(Icons.account_circle),
              ),
              20.height(),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("+91 9977783414"),
                  Text("Indore, MP"),
                ],
              ),
              10.height(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [Icon(Icons.phone), Text("CALL")],
                  ),
                  Column(
                    children: [Icon(Icons.message), Text("MESSAGE")],
                  ),
                  Column(
                    children: [Icon(Icons.voice_chat), Text("VOICE")],
                  ),
                  Column(
                    children: [Icon(Icons.edit), Text("EDIT")],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
