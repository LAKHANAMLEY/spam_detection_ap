import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spam_delection_app/constants/image_constants.dart';
import 'package:spam_delection_app/data/repository/user_repo/edit_profile_api.dart';
import 'package:spam_delection_app/globals/appbutton.dart';
import 'package:spam_delection_app/screens/profile_screen.dart';

import '../constants/icons_constants.dart';
import '../constants/string_constants.dart';
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

  bool _isLoading = false;
  String? _errorMessage;
  String? enteredPhone;

  List<dynamic> countries = [];
  bool isLoading = true;
  String? selectedCountryCode;
  String? selectedCountryName;
  final List<String> _genders = ['Male', 'Female']; // Dropdown options
  String? _selectedGender;
  DateTime? selectedDate;
  get pickeddate => null;

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController dateofbirthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController addressfirstController = TextEditingController();
  final TextEditingController addressecondController = TextEditingController();
  final TextEditingController photoController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        debugPrint("Photo taken: ${photo.path}");
        // Handle the selected photo (e.g., upload it, save it, or display it)
      }
    } catch (e) {
      debugPrint("Error taking photo: $e");
    }
  }
  Future<void> _chooseFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        debugPrint("Image selected: ${image.path}");
        setState(() {
          _selectedImage = File(image.path);
        });
      } else {
        debugPrint("No image selected.");
      }
      // Handle the selected image

    } catch (e) {
      debugPrint("Error selecting image: $e");
    }
  }
  Future<void> _saveImage(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/profile_image.png';
    final savedImage = await image.copy(path);
    print('Image saved to: $path');
  }

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
  void _showEditOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Choose an option',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16.0),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  // Call your camera function here
                  _takePhoto();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.green),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  // Call your gallery function here
                  _chooseFromGallery();
                },
              ),
              const SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
    );
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
          Center(
            child: SizedBox(
            child: CircleAvatar(

              backgroundColor: AppColor.vanishColor.withOpacity(0.2),
              radius: 43.0,
          backgroundImage: _selectedImage != null
              ? FileImage(_selectedImage!)
              : AssetImage(IconConstants.iccircleAvater),
          child: Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                    backgroundColor: AppColor.callColor,
                    radius: 12.0,
                    child: GestureDetector(
                      onTap: (){
                        _showEditOptions(context);
                      },
                                  child: Image.asset(
                                    IconConstants.icCamera,
                                    height: MediaQuery.of(context).size.height *
                                        2 /
                                        100,
                                  ))),
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
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: DropdownButtonFormField<String>(
                  value: _selectedGender,
                  items: _genders.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue!;
                    });
                  },
                  decoration:  InputDecoration(
                    hintText: 'Gender',
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
                    /*suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      IconConstants.icEmailadd, // Adjust the path as necessary
                      width: MediaQuery.of(context).size.width * 3 / 100,
                      height: MediaQuery.of(context).size.height * 3 / 100,
                    ),
                  ),
                    */
                  ),
                ),
              ),
    SizedBox(
    height: MediaQuery.of(context).size.height * 3 / 100,
    ),
                   /*Container(
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

                    */
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 90 / 100,
                child: TextFormField(
                  controller: stateController,
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
                  controller: cityController,
                  decoration: InputDecoration(
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
                  controller: zipController,
                  decoration: InputDecoration(
                    //  labelText: StringConstants.usertext,
                    //  labelStyle: const TextStyle(
                    //     color: AppColor.lightfillColor, fontWeight: FontWeight.w500),
                    hintText: 'Zip',
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
                  controller: addressfirstController,
                  decoration: InputDecoration(
                    //  labelText: StringConstants.usertext,
                    //  labelStyle: const TextStyle(
                    //     color: AppColor.lightfillColor, fontWeight: FontWeight.w500),
                    hintText: 'Address First',
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
                  controller: addressecondController,
                  decoration: InputDecoration(
                    hintText: 'Address Second',
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
              if (_errorMessage != null)
                Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : AppButton(
                text: StringConstants.editprofiletext,
                onPress: () {
                  final firstname = firstnameController.text;
                  final lastname = lastnameController.text;
                  final dob = dateofbirthController.text;
                  final gender = genderController.text;
                  final state = stateController.text;
                  final city = cityController.text;
                  final zip = zipController.text;
                  final addressfirst = addressfirstController.text;
                  final addressecond = addressecondController.text;
                  final photo=photoController.text;

                            if (firstname.isNotEmpty &&
                                lastname.isNotEmpty  ) {
                              setState(() {
                                _isLoading = true;
                              });
                    editProfile(
                      firstname: firstname,
                      lastname: lastname,
                      dateofbirth: dob,
                      gender:gender,
                      state:state,
                      city:city,
                      zip:zip,
                      addressFirst: addressfirst,
                      addressSecond: addressecond,
                      photo: photo,
                    ).then((response) {
                      setState(() {
                        _isLoading = false;
                      });
                      // class SignUpResponse
                      //var response
                      if (response.statusCode == 200) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                            const Profile()));
                      } else {
                        setState(() {
                          _errorMessage = response.message.toString();
                        });
                      }
                    });
                  } else {
                    setState(() {
                      _errorMessage = 'Please enter the all fields.';
                    });
                  }
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
          ]
          ),
        ),
      )
    );

  }
}
/*void _showEditOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choose an option',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blue),
              title: const Text('Take a Photo'),
              onTap: () {
                Navigator.pop(context);
                // Call your camera function here
                _takePhoto();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.green),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                // Call your gallery function here
                _chooseFromGallery();
              },
            ),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );
    },
  );
}


 */
/*final ImagePicker _picker = ImagePicker(); // Instance of ImagePicker

Future<void> _takePhoto() async {
  try {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      debugPrint("Photo taken: ${photo.path}");
      // Handle the selected photo (e.g., upload it, save it, or display it)
    }
  } catch (e) {
    debugPrint("Error taking photo: $e");
  }
}
final ImagePicker _picker = ImagePicker();
File? _selectedImage;
Future<void> _chooseFromGallery() async {
  try {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      debugPrint("Image selected: ${image.path}");
      setState(() {
        _selectedImage = File(image.path);
      });
    } else {
      debugPrint("No image selected.");
    }
      // Handle the selected image

  } catch (e) {
    debugPrint("Error selecting image: $e");
  }
}
Future<void> _saveImage(File image) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/profile_image.png';
  final savedImage = await image.copy(path);
  print('Image saved to: $path');
}


 */



