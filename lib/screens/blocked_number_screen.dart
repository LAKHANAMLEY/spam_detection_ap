import 'package:flutter/material.dart';
import 'package:spam_delection_app/constants/string_constants.dart';
import 'package:spam_delection_app/data/repository/block_repo/block_contact_list_api.dart';
import 'package:spam_delection_app/globals/app_fonts.dart';
import 'package:spam_delection_app/models/block_contacts_list_model.dart';

import '../constants/icons_constants.dart';
import '../globals/colors.dart';

class BlockedNumber extends StatefulWidget {
  const BlockedNumber({super.key});

  @override
  State<BlockedNumber> createState() => _BlockedNumberState();
}

class _BlockedNumberState extends State<BlockedNumber> {

  late Future<BlockedContactListResponse> _blockedContacts;

  @override
  void initState() {
    super.initState();
    _blockedContacts = blockContact();
  }
 /* final List<Map<String, String>> duplicateItems = [
    {
      'Number': '+233 840 945 232',
      'imagePath': IconConstants.icspamtriangle,
      'iconConst': IconConstants.icspambolcked
    },
    {
      'Number': '+233 264 619 356',
      'imagePath': IconConstants.icspamtriangle,
      'iconConst': IconConstants.icspambolcked
    },
    {
      'Number': '+233 365 574 603',
      'imagePath': IconConstants.icspamtriangle,
      'iconConst': IconConstants.icspambolcked
    },
    {
      'Number': '+233 480 649 772',
      'imagePath': IconConstants.icspamtriangle,
      'iconConst': IconConstants.icspambolcked
    },
  ];

  */
  /*late List<Map<String, String>> items;
  @override
  void initState() {
    super.initState();
    items = duplicateItems;
  }

   */

  int Toogletab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      appBar: AppBar(
        backgroundColor: AppColor.secondryColor,
        leading: GestureDetector(
          onTap: () {},
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                IconConstants.icbackCircle,
              ),
            ),
            height: MediaQuery.of(context).size.height * 2 / 100,
          ),
        ),
        title: Text(
          StringConstants.blockNumber,
          style: TextStyle(
              color: AppColor.callColor,
              fontFamily: AppFont.fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        //centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 90 / 100,
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Add phone number ',
                  hintStyle: const TextStyle(color: AppColor.lightfillColor),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide:
                        const BorderSide(width: 1.5, color: AppColor.fillColor),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColor.fillColor, width: 1.5),
                    borderRadius: const BorderRadius.all(Radius.circular(2)),
                  ),
                  filled: true,
                  fillColor: AppColor.fillColor.withOpacity(0.2),
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Image.asset(
                        IconConstants.icggadd,
                        height: MediaQuery.of(context).size.height * 2 / 100,
                        width: MediaQuery.of(context).size.width * 2 / 100,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  Toogletab = 1;
                });
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 8 / 100,
                width: MediaQuery.of(context).size.width * 90 / 100,
                decoration: BoxDecoration(
                  color: AppColor.secondryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      width: MediaQuery.of(context).size.width * 40 / 100,
                      decoration: BoxDecoration(
                          color: Toogletab == 1
                              ? AppColor.callColor
                              : AppColor.secondryColor,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Toogletab == 1
                                ? AppColor.callColor
                                : AppColor.borderstekColor,
                          )),
                      child: Center(
                          child: Text(
                        "Recents ",
                        style: TextStyle(
                            color: Toogletab == 1
                                ? AppColor.secondryColor
                                : AppColor.callColor,
                            fontSize: 18,
                            fontFamily: AppFont.fontFamily,
                            fontWeight: FontWeight.w600),
                      )),
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            Toogletab = 0;
                          });
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 6 / 100,
                          width: MediaQuery.of(context).size.width * 40 / 100,
                          decoration: BoxDecoration(
                              color: Toogletab == 1
                                  ? AppColor.secondryColor
                                  : AppColor.callColor,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Toogletab == 1
                                    ? AppColor.borderstekColor
                                    : AppColor.callColor,
                              )),
                          child: Center(
                              child: Text(
                            'Contacts',
                            style: TextStyle(
                                color: Toogletab == 1
                                    ? AppColor.callColor
                                    : AppColor.secondryColor,
                                fontSize: 18,
                                fontFamily: AppFont.fontFamily,
                                fontWeight: FontWeight.w600),
                          )),
                        )),
                  ],
                ),
              ),
            ),
            if (Toogletab == 1) ...[
              SizedBox(
                height: MediaQuery.of(context).size.height * 4 / 100,
              ),
              FutureBuilder<BlockedContactListResponse>(
                future: _blockedContacts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final contacts = snapshot.data!.contacts??[];
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        final contact = contacts[index];
                        return ListTile(
                          title: Text(contact.name),
                         // subtitle: Text(contact.phone),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('No blocked contacts found.'));
                  }
                },
              ),
              /*
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final imagePath = items[index]['imagePath'] ?? 'Unknown';
                  final iconConst = items[index]['iconConst'] ?? 'Unknown';
                  final number = items[index]['Number'] ?? 'Unknown';
                  return ListTile(
                    leading: Image.asset(
                      imagePath,
                      width: MediaQuery.of(context).size.width * 8 / 100,
                      height: MediaQuery.of(context).size.height * 8 / 100,
                    ),
                    title: Text(
                      number,
                      style: TextStyle(
                          color: AppColor.gracyColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: AppFont.fontFamily),
                    ),
                    trailing: Image.asset(
                      iconConst,
                      width: MediaQuery.of(context).size.width * 8 / 100,
                      height: MediaQuery.of(context).size.height * 8 / 100,
                    ),
                  );
                },
              ),
              */
            ] else
              ...[]
          ]),
        ),
      ),
    );
  }
}
