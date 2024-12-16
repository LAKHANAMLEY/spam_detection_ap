import 'package:spam_delection_app/lib.dart';

class AlternativeEmail extends StatefulWidget {
  const AlternativeEmail({super.key});

  @override
  State<AlternativeEmail> createState() => _AlternativeEmailState();
}

class _AlternativeEmailState extends State<AlternativeEmail> {
  final TextEditingController emailController = TextEditingController();

  double scale = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      appBar: const CustomAppBar(
        title: 'Add Alernative Email',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 4 / 100,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  child: Text(
                    'Alternative Email',
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
                  hintText: 'Email Address',
                  suffix: Image.asset(IconConstants.icfluentMail, scale: scale
                      //2x min hona chahiye
                      ),
                  validator: (p0) {
                    if (p0?.isEmpty ?? true) {
                      return "Please all alternative email";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 8 / 100,
                ),
                AppButton(text: appLocalization(context).submit, onPress: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
