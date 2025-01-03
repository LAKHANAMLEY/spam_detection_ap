import 'package:spam_delection_app/lib.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  var messages = [];
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onChanged: (value) => filterSearchResults(value),
          controller: searchController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: appLocalization(context).searchMore,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            hintStyle: const TextStyle(
              color: Color(0xffB2B8BD),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffE1E6EB), width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(width: 0.5, color: Color(0xffE1E6EB)),
            ),
            fillColor: AppColor.whiteLight.withOpacity(0.2),
            filled: true,
          ),
        ),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(ImageConstants.imageRobert),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Devin"),
            SizedBox(
              width: 15.0,
            ),
            Text(
              "8:30AM PM",
            ),
          ],
        ),
        subtitle: Text("Dear Customer, You have one missed call."),
        trailing: Icon(
          Icons.arrow_forward_ios,
        ),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(ImageConstants.imageJames),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Robert"),
            SizedBox(
              width: 15.0,
            ),
            Text(
              "5:00PM",
            ),
          ],
        ),
        subtitle: Text("Dear Customer, You have one missed call."),
        trailing: Icon(
          Icons.arrow_forward_ios,
        ),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(ImageConstants.imageKelvin),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("LPUNIV"),
            SizedBox(
              width: 15.0,
            ),
            Text(
              "12/06/24",
            ),
          ],
        ),
        subtitle: Text("Dear Applicant,the last date to apply today."),
        trailing: Icon(
          Icons.arrow_forward_ios,
        ),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(ImageConstants.imageSame),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("620046"),
            SizedBox(
              width: 15.0,
            ),
            Text(
              "11/19/24",
            ),
          ],
        ),
        subtitle: Text("Biggest scholarship test for Gate candidates."),
        trailing: Icon(
          Icons.arrow_forward_ios,
        ),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(ImageConstants.imageLasey),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Jyodan"),
            SizedBox(
              width: 15.0,
            ),
            Text(
              "4:00pm",
            ),
          ],
        ),
        subtitle: Text("Dear User your profile is shortlisted."),
        trailing: Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    ]));
  }

  filterSearchResults(String value) {}
}
