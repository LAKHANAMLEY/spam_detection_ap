import 'package:spam_delection_app/lib.dart';
//import 'add_member_screen.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  LanguageData? selectedLanguage;

  List<LanguageData> languages = [];
  var languageListBloc = ApiBloc(ApiBlocInitialState());

  @override
  void initState() {
    super.initState();
    languageListBloc.add(GetLanguageListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                10.height(),
                Align(
                  alignment: Alignment.centerRight,
                  child: BlocConsumer(
                      bloc: languageListBloc,
                      listener: (context, state) {
                        if (state is GetLanguageListState) {
                          if (state.value.statusCode == 200) {
                            languages = state.value.languagelist ?? [];
                            if (languages.isNotEmpty) {
                              selectedLanguage = languages.first;
                            }
                          } else if (state.value.statusCode ==
                              HTTPStatusCodes.sessionExpired) {
                            sessionExpired(context, state.value.message);
                          } else {
                            showCustomDialog(context,
                                dialogType: DialogType.failed,
                                subTitle: state.value.message);
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is GetLanguageListState) {
                          languages = state.value.languagelist ?? [];
                          if (languages.isEmpty) {
                            return Center(
                              child: Text(appLocalization(context).noData),
                            );
                          }
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: DropdownButton<LanguageData>(
                              hint: const Text('Select Language'),
                              value: selectedLanguage,
                              alignment: Alignment.centerRight,
                              // isExpanded: true,
                              items: languages.map((category) {
                                return DropdownMenuItem<LanguageData>(
                                  value: category,
                                  child: Text(category.name ?? ""),
                                );
                              }).toList(),
                              onChanged: (LanguageData? value) {
                                setState(() {
                                  selectedLanguage = value;
                                }); // wait sir // understand sir

                                //ab language change work krega protection type check kro
                                print(selectedLanguage?.name ?? "");
                                localizationBloc.add(ChangeLocaleEvent(
                                    Locale.fromSubtags(
                                        languageCode:
                                            selectedLanguage?.id ?? "")));
                              },
                            ),
                          );
                        }
                        return const Loader();
                      }),
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
                  style: const TextStyle(
                      color: AppColor.bluelightColor,
                      fontSize: 35,
                      fontFamily: AppFont.fontFamily,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 5 / 100),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Center(
                    child: Text(
                      appLocalization(context).welcomeTxt,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
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
                    text: appLocalization(context).getStarted,
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProtectionType()));
                    }),
              ],
            ),
          ),
        ));
  }
}
