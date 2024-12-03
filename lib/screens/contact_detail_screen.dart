import 'package:spam_delection_app/lib.dart';

class ContactDetail extends StatefulWidget {
  final ContactData? contact;

  const ContactDetail({super.key, this.contact});

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  final double expandedHeight = 280.0;
  final double collapsedHeight = 100.0;
  @override
  Widget build(BuildContext context) {
    var argument = args(context) as ContactDetail;
    var contact = argument.contact;
    const expandedHeight = 280.0;
    const collapsedHeight = 60.0;
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: expandedHeight,
          collapsedHeight: collapsedHeight,
          floating: true,
          pinned: true,
          snap: true,
          backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 150,
                    decoration: const BoxDecoration(color: AppColor.redColor),
                  ),
                ),
                Positioned(
                  left: 9,
                  right: 8,
                  top: 80,
                  bottom: 3,
                  //bottom: collapsedHeight + 30,
                  // left: MediaQuery.of(context).size.width / 2 - 50,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: CircleBorder(),
                        ),
                        child: const CircleAvatar(
                          backgroundImage:
                              AssetImage(IconConstants.icspamCircle),
                          radius: 45,
                        ),
                      ),
                      Text(
                        contact?.name ?? "",
                        style: const TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ActionButton(
                            label: 'Message',
                            icon: Icons.message,
                          ),
                          ActionButton(
                              label: 'Not Spam', icon: Icons.check_circle),
                          ActionButton(label: 'Block', icon: Icons.block),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16.0),
                height: MediaQuery.of(context).size.height * 10 / 100,
                width: MediaQuery.of(context).size.width * 90 / 100,
                decoration: BoxDecoration(
                    color: AppColor.secondryColor,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: AppColor.fillColor)),
                child: const ListTile(
                  leading: Icon(Icons.phone, color: AppColor.primaryColor),
                  title: Text(
                    '1800 208 2244',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Other'),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 20 / 100,
                width: MediaQuery.of(context).size.width * 90 / 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColor.fillColor,
                    )),
                child: IntrinsicHeight(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Column(children: [
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 10 / 100,
                              width:
                                  MediaQuery.of(context).size.width * 45 / 100,
                              decoration: const BoxDecoration(
                                  border: Border(
                                right: BorderSide(
                                  //
                                  color: AppColor.fillColor,
                                ),
                              )),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(StringConstants.spamreportext),
                                  Text(
                                    StringConstants.liketext,
                                    style: TextStyle(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: AppFont.fontFamily),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 9 / 100,
                              width:
                                  MediaQuery.of(context).size.width * 45 / 100,
                              decoration: const BoxDecoration(
                                  border: Border(
                                right: BorderSide(
                                  color: AppColor.fillColor,
                                ),
                                top: BorderSide(
                                  color: AppColor.fillColor,
                                ),
                              )),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(StringConstants.usallytext),
                                  Text(
                                    StringConstants.amtext,
                                    style: TextStyle(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: AppFont.fontFamily),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                        Expanded(
                          child: SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 10 / 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(StringConstants.callactivitytext),
                                Text(
                                  StringConstants.milliontext,
                                  style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppFont.fontFamily),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(
                    16.0), // Adds margin around the container
                height: MediaQuery.of(context).size.height * 10 / 100,
                width: MediaQuery.of(context).size.width * 90 / 100,
                decoration: BoxDecoration(
                    color: AppColor.secondryColor,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: AppColor.fillColor)),
                child: const ListTile(
                  leading:
                      Icon(Icons.location_on, color: AppColor.primaryColor),
                  title: Text(
                    'More info available',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Upgrade to Premium to view'),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const ActionButton({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Ensures buttons fit the row properly
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey.shade300,
          child: Icon(icon,
              color: AppColor.redColor, size: 28), // Icon size adjusted
        ),
        const SizedBox(height: 8),
        DefaultTextStyle(
          style: const TextStyle(
              color: AppColor.primaryColor,
              fontSize: 12,
              fontFamily: AppFont.fontFamily,
              fontWeight: FontWeight.w600),
          child: Text(label),
        )
      ],
    );
  }
}
