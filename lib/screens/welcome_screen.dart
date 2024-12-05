import 'package:spam_delection_app/lib.dart';
//import 'add_member_screen.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  LanguageData? selectedLanguage;
  bool isLoading = false;
  String? errorMessage;

  List<LanguageData> languages = [];
  Future<void> fetchLang() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final fetchedCategories = await fetchLanguages();
      print(fetchedCategories.toString());
      setState(() {
        languages = fetchedCategories.languagelist ?? [];
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
    fetchLang();
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
                          : languages.isEmpty
                              ? const Text('No categories available.')
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: DropdownButton<LanguageData>(
                                    hint: const Text('Select Language'),
                                    value: selectedLanguage,
                                    isExpanded: true,
                                    items: languages.map((category) {
                                      return DropdownMenuItem<LanguageData>(
                                        value: category,
                                        child: Text(category.name ?? ""),
                                      );
                                    }).toList(),
                                    onChanged: (LanguageData? value) {
                                      setState(() {
                                        selectedLanguage = value;
                                      });// wait sir // understand sir

                                      //ab language change work krega protection type check kro
                                      print(selectedLanguage?.name ?? "");
                                      localizationBloc.add(ChangeLocaleEvent(Locale.fromSubtags(languageCode:  selectedLanguage?.id??"")));
;                                    },
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
                 Text(
                 appLocalization(context).welcome,
                  style: TextStyle(
                      color: AppColor.bluelightColor,
                      fontSize: 35,
                      fontFamily: AppFont.fontFamily,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 5 / 100),
                 Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Center(
                    child: Text(
                      appLocalization(context).welcomeTxt,
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
                    text:  appLocalization(context).getStarted,
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
