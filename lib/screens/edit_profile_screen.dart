import 'package:flutter/material.dart';

import '../constants/icons_constants.dart';
import '../globals/app_fonts.dart';
import '../globals/colors.dart';



class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  int _selection = 0;
  int Toogletab = 0;
  // final bool _obscureText = true;
  bool isCheckBoxValue = false;
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;
  bool isApiCalling = false;
  bool agreeToTerms = false;

  DateTime? selectedDate;
  get pickeddate => null;

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController dateofbirthController = TextEditingController();
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateofbirthController.text = picked.toString().split(".").first;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      appBar: AppBar(
        backgroundColor: AppColor.secondryColor,
        leading:GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(IconConstants.backIcon,
              ),

            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*5/100,),
          Center(
            child: SizedBox(
            child: CircleAvatar(
            backgroundColor: AppColor.greylightColor,
              radius: 45.0,
              child: CircleAvatar(
                radius: 48.0,
                backgroundImage: const AssetImage(
                    IconConstants.icAvater),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                      backgroundColor: AppColor.callColor,
                      radius: 12.0,
                      child: Image.asset(IconConstants.icCamera,height: MediaQuery.of(context).size.height*2/100,)
                  ),
                ),
              ),
            ),
                ),
          ),
              SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 90 / 100,
                child: TextFormField(
                  controller: firstnameController,
                  decoration: InputDecoration(
                    hintText: 'First name',
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide:
                      const BorderSide(width: 1.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.fillColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    suffixIcon: GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                        height: 10,
                        width: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Image.asset(IconConstants.icUsername),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 3 / 100,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 90 / 100,
                child: TextFormField(
                  controller: lastnameController,
                  decoration: InputDecoration(
                    //  labelText: StringConstants.usertext,
                    //  labelStyle: const TextStyle(
                    //     color: AppColor.lightfillColor, fontWeight: FontWeight.w500),
                    hintText: 'Last name',
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide:
                      const BorderSide(width: 1.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.fillColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    suffixIcon: GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                        height: 10,
                        width: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Image.asset(IconConstants.icUsername),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 3 / 100,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 90 / 100,
                child: TextFormField(
                  readOnly: true,
                  controller:
                  dateofbirthController, //ese controller every field me assign karo
                  decoration: InputDecoration(
                    // labelText: 'Date of Birth',
                    //  labelStyle: const TextStyle(
                    //   color: AppColor.lightfillColor, fontWeight: FontWeight.w800),
                      hintText: 'Date of Birth',
                      hintStyle: const TextStyle(color: AppColor.lightfillColor),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide:
                        const BorderSide(width: 1.5, color: AppColor.fillColor),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(color: AppColor.fillColor, width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      filled: true,
                      fillColor: AppColor.fillColor.withOpacity(0.2),
                      /* IconButton(
                      icon: Icon(Icons.calendar_today),
                      color: Colors.red,
                      onPressed: () async{

                        DateTime?  pickeddate=  await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1990),
                            lastDate: DateTime(2024));
                        if(pickeddate!=null){
                          print('Date selected:${pickeddate.day}-${pickeddate.month}-${pickeddate.year}');
                          setState(() {
                            _date.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                          });
                        }
                      },
                    )
                    */
                      suffixIcon: GestureDetector(
                          onTap: () async {
                            _pickDate(context);
                          },
                          child: Image.asset(IconConstants.icDate))),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 3 / 100,
              ),
                   Container(
                  width:
                  MediaQuery.of(context).size.width * 90 / 100,
                  height:
                  MediaQuery.of(context).size.height * 8 / 100,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                _selection = 1;
                              });
                            },
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      7 /
                                      100,
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      44 /
                                      100,
                                  decoration: BoxDecoration(

                                    border: Border.all(
                                        color: AppColor.fillColor,width: 1.5),
                                    color: AppColor.fillColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(6)),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Radio(
                                      focusColor:
                                      AppColor.yellowdeep,
                                      groupValue: _selection,
                                      onChanged: (_selectTime) {
                                        selectTime(
                                            int timeSelected) {
                                          setState(() {
                                            _selection =
                                                timeSelected;
                                          });
                                        }
                                      },
                                      value: 1,
                                    ),
                                    Image.asset(
                                      IconConstants.icmaleIcon,
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          4 /
                                          100,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          4 /
                                          100,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.5 /
                                          100,
                                    ),
                                    Text('Male',
                                      style: const TextStyle(
                                          fontWeight:
                                          FontWeight.w600,
                                          fontFamily:
                                          AppFont.fontFamily,
                                          color:
                                          AppColor.lightfillColor,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _selection = 2;
                              });
                            },
                            child: Stack(
                              children: <Widget>[
                                SizedBox(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      5 /
                                      100,
                                ),
                                Container(
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      7 /
                                      100,
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      44 /
                                      100,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColor.fillColor,width: 1.5),
                                    color: AppColor.fillColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(6)),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      2 /
                                      100,
                                ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      focusColor:
                                      AppColor.yellowdeep,
                                      groupValue: _selection,
                                      onChanged: (_selectTime) {
                                        selectTime(
                                            int timeSelected) {
                                          setState(() {
                                            _selection =
                                                timeSelected;
                                          });
                                        }
                                      },
                                      value: 2,
                                    ),
                                    Image.asset(
                                      IconConstants.icfemaleIcon,
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          4 /
                                          100,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          4 /
                                          100,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.5 /
                                          100,
                                    ),
                                    Text('Female',
                                      style: const TextStyle(
                                          fontWeight:
                                          FontWeight.w600,
                                          fontFamily:
                                          AppFont.fontFamily,
                                          color:
                                          AppColor.lightfillColor,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 3 / 100,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 90 / 100,
                child: TextFormField(
                  controller: lastnameController,
                  decoration: InputDecoration(
                    //  labelText: StringConstants.usertext,
                    //  labelStyle: const TextStyle(
                    //     color: AppColor.lightfillColor, fontWeight: FontWeight.w500),
                    hintText: 'Select State',
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide:
                      const BorderSide(width: 1.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.fillColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    /*suffixIcon: GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                        height: 10,
                        width: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Image.asset(IconConstants.icUsername),
                        ),
                      ),
                    ),
                    */
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 3 / 100,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 90 / 100,
                child: TextFormField(
                  controller: lastnameController,
                  decoration: InputDecoration(
                    //  labelText: StringConstants.usertext,
                    //  labelStyle: const TextStyle(
                    //     color: AppColor.lightfillColor, fontWeight: FontWeight.w500),
                    hintText: 'Select City',
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide:
                      const BorderSide(width: 1.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.fillColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    /*suffixIcon: GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                        height: 10,
                        width: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Image.asset(IconConstants.icUsername),
                        ),
                      ),
                    ),
                    */
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 3 / 100,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 90 / 100,
                child: TextFormField(
                  controller: lastnameController,
                  decoration: InputDecoration(
                    //  labelText: StringConstants.usertext,
                    //  labelStyle: const TextStyle(
                    //     color: AppColor.lightfillColor, fontWeight: FontWeight.w500),
                    hintText: 'Address ',
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide:
                      const BorderSide(width: 1.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.fillColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    /*suffixIcon: GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                        height: 10,
                        width: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Image.asset(IconConstants.icUsername),
                        ),
                      ),
                    ),
                    */
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 3 / 100,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 90 / 100,
                child: TextFormField(
                  controller: lastnameController,
                  decoration: InputDecoration(
                    //  labelText: StringConstants.usertext,
                    //  labelStyle: const TextStyle(
                    //     color: AppColor.lightfillColor, fontWeight: FontWeight.w500),
                    hintText: 'LandMark',
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide:
                      const BorderSide(width: 1.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.fillColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    /*suffixIcon: GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                        height: 10,
                        width: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Image.asset(IconConstants.icUsername),
                        ),
                      ),
                    ),
                    */
                  ),
                ),
              ),
          ]
          ),
        ),
      )
    );
  }
}
