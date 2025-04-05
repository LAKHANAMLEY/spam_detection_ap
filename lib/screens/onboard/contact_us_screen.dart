import 'package:spam_delection_app/lib.dart';

class ContactUS extends StatefulWidget {
  const ContactUS({super.key});

  @override
  State<ContactUS> createState() => _ContactUSState();
}

class _ContactUSState extends State<ContactUS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: appLocalization(context).contactUs,
      ),
      body: Column(
        children: [
          // Text(
          //   "Contact Us",
          //   style: TextStyle(
          //       color: AppColor.blackColor,
          //       fontWeight: FontWeight.w400,
          //       fontSize: 18),
          // ),
          5.height(),
          ListTile(
            title: Text("123 Main Street",
                style: TextStyle(
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14)),
            leading: Icon(Icons.location_on),
            subtitle: Text(
              "Indore, India",
              style: TextStyle(
                  color: AppColor.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
          ),
          ListTile(
            title: Text("123458968",
                style: TextStyle(
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14)),
            leading: Icon(Icons.call),
          ),
          ListTile(
            title: Text("info@gmail.com",
                style: TextStyle(
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14)),
            leading: Icon(Icons.email),
          ),
        ],
      ),
    );
  }
}
