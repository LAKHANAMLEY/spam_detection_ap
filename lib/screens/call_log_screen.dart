import 'package:flutter/material.dart';
import 'package:spam_delection_app/globals/app_fonts.dart';
import 'package:spam_delection_app/globals/colors.dart';

import '../constants/icons_constants.dart';
import '../constants/image_constants.dart';


class CallLog extends StatefulWidget {
  const CallLog({super.key});

  @override
  State<CallLog> createState() => _CallLogState();
}

class _CallLogState extends State<CallLog> {
  final List<Map<String, String>> duplicateItems = [
    {'name': 'Robert Adams', 'imagePath': ImageConstants.imageRobert},
    {'name': 'James Rich', 'imagePath':  ImageConstants.imageJames},
    {'name': 'Marshal Jam', 'imagePath':  ImageConstants.imageMarshal,},
    {'name': 'Root Lee', 'imagePath': ImageConstants.imageRoot,},
    {'name': 'Lasey Ray', 'imagePath':  ImageConstants.imageLasey,},
    {'name': 'Same Tale', 'imagePath':   ImageConstants.imageSame,},
    {'name': 'Joann Short', 'imagePath': ImageConstants.imageJoann,},
    {'name': 'Kevin Price', 'imagePath': ImageConstants.imageKelvin,},
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
          .where((item) => item['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }


  String _searchText = '';
  int _selection = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      appBar: AppBar(
        leading: Image.asset(
          IconConstants.icdrawer, height: MediaQuery
            .of(context)
            .size
            .height * 4 / 100,width:MediaQuery
            .of(context)
            .size
            .width * 4 / 100 ,),
        title: Image.asset(
            IconConstants.iccallAvater, height: MediaQuery
            .of(context)
            .size
            .height * 6 / 100,),
        actions: [
       Image.asset(IconConstants.icMoreDetails, height: MediaQuery
          .of(context)
          .size
          .height * 3 / 100,
      ),
    SizedBox(width: MediaQuery
        .of(context)
        .size
        .width * 3 / 100,),
    ]
    ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) => filterSearchResults(value),
                  controller: editingController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search names & more",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    hintStyle: const TextStyle(
                      color: Color(0xffB2B8BD),),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xffE1E6EB), width: 1.0),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(12)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          width: 0.5, color: Color(0xffE1E6EB)),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*2/100,),
              ListView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.asset(
                      items[index]['imagePath']!,
                      width: MediaQuery.of(context).size.width*12/100,
                      height: MediaQuery.of(context).size.height*12/100,
                    ),
                    title: Text(items[index]['name']!,style: TextStyle(color: AppColor.primaryColor,fontWeight: FontWeight.w600,fontSize: 18,fontFamily: AppFont.fontFamily),),
                  );
                },
              ),

            ],
          ),
          /*
          Container(
          margin: EdgeInsets.all(20),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search numbers names & more',
              prefixIcon: Icon(Icons.search, color: Colors.red,),
              hintStyle: const TextStyle(
                color: Color(0xffB2B8BD),),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xffE1E6EB), width: 1.0),
                borderRadius:
                const BorderRadius.all(Radius.circular(12)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                    width: 0.5, color: Color(0xffE1E6EB)),
              ),
              fillColor: Colors.white,
              filled: true,
            ),
            onChanged: (value) {
              setState(() {
                _searchText = value;

              });
            },
          ),
              );
          */

        ),
      ),
      floatingActionButton:FloatingActionButton(
        backgroundColor: AppColor.callColor,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
    ),
    child: Image.asset(IconConstants.icaddCall,height: MediaQuery.of(context).size.height*6/100,width: MediaQuery.of(context).size.width*6/100,),
    onPressed: () {},
    ),
    );
  }
}
