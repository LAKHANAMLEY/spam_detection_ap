import 'package:spam_delection_app/lib.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.callColor,
      child: ListView(
        children: [
          DrawerHeader(child: Image.asset(IconConstants.icBroadlogo)),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.contactList);
            },
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text(
              "Contact list",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            onTap: () async {
              // bool signOutSuccess = await signOutFromGoogle();
              // if (signOutSuccess) {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(
              //         content:
              //             Text('Successfully signed out from Google.')),
              //   );
              // Navigate to login or home screen after sign out
              SharedPref.clearAll().then((isCleared) {
                if (isCleared) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.protectionType, (route) => false);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Failed to sign out. Please try again.')),
                  );
                }
              });

              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const Welcome()));
              // } else {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(
              //       content:
              //           Text('Failed to sign out. Please try again.')),
              // );
              // }
            },
            leading: const Icon(Icons.logout, color: Colors.white),
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
