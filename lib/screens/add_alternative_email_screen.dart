import 'package:spam_delection_app/lib.dart';

class AlternativeEmail extends StatefulWidget {
  const AlternativeEmail({super.key});

  @override
  State<AlternativeEmail> createState() => _AlternativeEmailState();
}

class _AlternativeEmailState extends State<AlternativeEmail> {
  final TextEditingController emailController = TextEditingController();

  double scale = 4;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      appBar: CustomAppBar(
        title: appLocalization(context).addAlternativeEmail,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 4 / 100,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 60, right: 60),
                    child: Text(
                      appLocalization(context).alternativeEmail,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: AppColor.bluelightColor,
                          fontSize: 35,
                          fontFamily: AppFont.fontFamily,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      appLocalization(context).secureEmail,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: AppColor.verifyColor,
                          fontFamily: AppFont.fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  10.height(),
                  CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    hintText: appLocalization(context).emailAddress,
                    suffix: Image.asset(IconConstants.icfluentMail, scale: scale
                        //2x min hona chahiye
                        ),
                    validator: (p0) {
                      if (p0?.isEmpty ?? true) {
                        return appLocalization(context).pleaseAlternativeEmail;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 8 / 100,
                  ),
                  AppButton(
                      text: appLocalization(context).submit,
                      onPress: () {
                        if (_formKey.currentState?.validate() ?? false) {}
                        ;
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
