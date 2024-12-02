import 'package:spam_delection_app/lib.dart';

class AllCall extends StatefulWidget {
  const AllCall({super.key});

  @override
  State<AllCall> createState() => _AllCallState();
}

class _AllCallState extends State<AllCall> {
  final List<Map<String, String>> duplicateItems = [
    {'name': 'Robert ', 'imagePath': ImageConstants.imageRobert},
    {'name': 'James ', 'imagePath': ImageConstants.imageJames},
    {'name': 'Marshal ', 'imagePath': ImageConstants.imageMarshal},
    {'name': 'Root ', 'imagePath': ImageConstants.imageRoot},
    {'name': 'Lasey ', 'imagePath': ImageConstants.imageLasey},
    {'name': 'Same ', 'imagePath': ImageConstants.imageSame},
    {'name': 'Joann ', 'imagePath': ImageConstants.imageJoann},
    {'name': 'Kevin ', 'imagePath': ImageConstants.imageKelvin},
  ];
  final List<Map<String, String>> listedItems = [
    {
      'fullName': 'Robert Adamas',
      'imageAvatar': ImageConstants.imageRobert,
      'iconCall': IconConstants.icfluentCall,
      'callText': StringConstants.incomingtext,
    },
    {
      'fullName': 'James Rich',
      'imageAvatar': ImageConstants.imageJames,
      'iconCall': IconConstants.icfluentCall,
      'callText': StringConstants.outgoingtext,
    },
    {
      'fullName': 'Spam',
      'imageAvatar': ImageConstants.imageSimmple,
      'iconCall': IconConstants.icfluentCall,
      'callText': StringConstants.jobspamtext,
    },
    {
      'fullName': 'Spam',
      'imageAvatar': ImageConstants.imageSimmple,
      'iconCall': IconConstants.icfluentCall,
      'callText': StringConstants.jobspamtext,
    }
  ];

  late List<Map<String, String>> items;
  final TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    items = duplicateItems;
  }

  void filterSearchResults(String query) {
    setState(() {
      items = duplicateItems
          .where((item) =>
              item['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondryColor,
        key: _key,
        drawer: Drawer(
          backgroundColor: AppColor.callColor,
          child: ListView(
            children: [
              DrawerHeader(child: Image.asset(IconConstants.icBroadlogo)),
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
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const ProtectionType(),
                        ),
                        (route) => false,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Failed to sign out. Please try again.')),
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
        ),
        appBar: AppBar(
          backgroundColor: AppColor.secondryColor,
          leading: InkWell(
            onTap: () {
              _key.currentState!.openDrawer();
            },
            child: Image.asset(
              IconConstants.icdrawer,
              height: MediaQuery.of(context).size.height * 4 / 100,
            ),
          ),
          /*title: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Profile()));
            },
            child: Image.asset(ImageConstants.imageProfile,
                height: MediaQuery.of(context).size.height * 6 / 100),
          ),

           */
          actions: [
            Image.asset(
              IconConstants.icMoreDetails,
              height: MediaQuery.of(context).size.height * 3 / 100,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 3 / 100,
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) => filterSearchResults(value),
                    controller: editingController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search number,names & more",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      hintStyle: const TextStyle(
                        color: Color(0xffB2B8BD),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffE1E6EB), width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 0.5, color: Color(0xffE1E6EB)),
                      ),
                      fillColor: AppColor.whiteLight.withOpacity(0.2),
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 2 / 100,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Color(0xff6C5E5E),
                        ),
                        label: const Text(
                          "Favourites",
                          style: TextStyle(color: Color(0xff6C5E5E)),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(150, 60),
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Image.asset(
                          IconConstants.icphonebold,
                          height: MediaQuery.of(context).size.height * 6 / 100,
                          width: MediaQuery.of(context).size.width * 6 / 100,
                        ),
                        label: const Text("Voice Call",
                            style: TextStyle(color: Color(0xff6C5E5E))),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(150, 60),
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 2 / 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 120, // Set a fixed height for the ListView
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                items[index]['imagePath']!,
                                width: 60,
                                height: 60,
                              ),
                              const SizedBox(height: 8),
                              Text(items[index]['name']!),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // SizedBox(height: MediaQuery.of(context).size.height*2/100,),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 22 / 100,
                  width: MediaQuery.of(context).size.width * 90 / 100,
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        IconConstants.icspamCircle,
                        height: MediaQuery.of(context).size.height * 6 / 100,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 5 / 100),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              StringConstants.smsdisabled,
                              style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontSize: 14,
                                  fontFamily: AppFont.fontFamily,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    2 /
                                    100),
                            const Text(StringConstants.smsautomaticallytext,
                                style: TextStyle(
                                    color: AppColor.primaryColor,
                                    fontSize: 12,
                                    fontFamily: AppFont.fontFamily,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 2 / 100,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.redColor,
                                    minimumSize: const Size(4, 40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    )),
                                onPressed: () {},
                                child: const Text(
                                  'Enable Now',
                                  style: TextStyle(
                                      color: AppColor.secondryColor,
                                      fontSize: 16,
                                      fontFamily: AppFont.fontFamily,
                                      fontWeight: FontWeight.w600),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 2 / 100,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listedItems.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final imageAvatar =
                        listedItems[index]['imageAvatar'] ?? 'Unknown';
                    final iconCall =
                        listedItems[index]['iconCall'] ?? 'Unknown';
                    final fullName =
                        listedItems[index]['fullName'] ?? 'Unknown';
                    final callText =
                        listedItems[index]['callText'] ?? 'Unknown';
                    return ListTile(
                      leading: Image.asset(
                        imageAvatar,
                        width: MediaQuery.of(context).size.width * 12 / 100,
                        height: MediaQuery.of(context).size.height * 12 / 100,
                      ),
                      title: Text(
                        fullName,
                        style: const TextStyle(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            fontFamily: AppFont.fontFamily),
                      ),
                      subtitle: Text(
                        callText,
                        style: const TextStyle(
                            color: AppColor.gracyColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            fontFamily: AppFont.fontFamily),
                      ),
                      trailing: Image.asset(
                        iconCall,
                        width: MediaQuery.of(context).size.width * 8 / 100,
                        height: MediaQuery.of(context).size.height * 8 / 100,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
