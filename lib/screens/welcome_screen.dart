import 'package:flutter/material.dart';
import 'package:spam_delection_app/constants/icons_constants.dart';
import 'package:spam_delection_app/constants/string_constants.dart';
import 'package:spam_delection_app/data/repository/auth_repo/countries_api.dart';
import 'package:spam_delection_app/globals/app_constants.dart';
import 'package:spam_delection_app/models/country_language_model.dart';
import 'package:spam_delection_app/models/country_list_model.dart';
import 'package:spam_delection_app/screens/all_calls_screen.dart';
import 'package:spam_delection_app/screens/edit_profile_screen.dart';
import 'package:spam_delection_app/screens/plans_type_screen.dart';
import 'package:spam_delection_app/screens/profile_screen.dart';
import 'package:spam_delection_app/screens/protection_type_screen.dart';

import '../data/repository/setting_repo/country_language_api.dart';
import '../globals/app_fonts.dart';
import '../globals/appbutton.dart';
import '../globals/colors.dart';
//import 'add_member_screen.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});
  static String routeName = './Welcome';

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  LanguageData? selectedCategory;
  bool isLoading = false;
  String? errorMessage;

  List<LanguageData> categories = [];
  Future<void> fetchLanguagies() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final fetchedCategories = await ApiService.fetchLanguagies();
      print(fetchedCategories.toString());
      setState(() {
        categories = fetchedCategories.languagelist ?? [];
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Failed to load categories: $error';
        isLoading = false;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    fetchLanguagies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.secondryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 5 / 100,
                ),
                Center(
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : errorMessage != null
                          ? Text(errorMessage!)
                          : categories.isEmpty
                              ? const Text('No categories available.')
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: DropdownButton<LanguageData>(
                                    hint: const Text('Select Language'),
                                    value: selectedCategory,
                                    isExpanded: true,
                                    items: categories.map((category) {
                                      return DropdownMenuItem<LanguageData>(
                                        value: category,
                                        child: Text(category.name ?? ""),
                                      );
                                    }).toList(),
                                    onChanged: (LanguageData? value) {
                                      setState(() {
                                        selectedCategory = value;
                                      });
                                      print(selectedCategory?.name?? "");
                                    },
                                  ),
                                ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 5 / 100,
                ),
                Image.asset(IconConstants.icBroadlogo,
                    height: MediaQuery.of(context).size.height * 8 / 100,
                    width: MediaQuery.of(context).size.width * 50 / 100),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 5 / 100,
                ),
                const Text(
                  StringConstants.weltext,
                  style: TextStyle(
                      color: AppColor.bluelightColor,
                      fontSize: 35,
                      fontFamily: AppFont.fontFamily,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 5 / 100),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Center(
                    child: Text(
                      StringConstants.welcometext,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColor.lightblurColor,
                          fontSize: 15,
                          fontFamily: AppFont.fontFamily),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 8 / 100,
                ),
                AppButton(
                    text: StringConstants.getstarted,
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProtectionType()));

                      // forgotPasswordUserValidation(
                      //    emailTextEditingController.text);
                    }),
                /*Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(IconConstants.icGoogle,height:MediaQuery.of(context).size.height*10/100 ),
                  SizedBox(width: MediaQuery.of(context).size.width*2/100 ),
                  Image.asset(IconConstants.icMac,height:MediaQuery.of(context).size.height*10/100 ,),
          
                ],
              ),
          
               */
              ],
            ),
          ),
        ));
  }
}
