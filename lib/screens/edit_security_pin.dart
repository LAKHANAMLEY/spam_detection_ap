import 'package:spam_delection_app/lib.dart';

class EditSecurityPin extends StatefulWidget {
  const EditSecurityPin({super.key});

  @override
  State<EditSecurityPin> createState() => _EditSecurityPinState();
}

class _EditSecurityPinState extends State<EditSecurityPin> {
  final TextEditingController currentPinController = TextEditingController();
  final TextEditingController newPinController = TextEditingController();
  final TextEditingController confirmnewPinController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  String? enteredPhone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      appBar: AppBar(
        backgroundColor: AppColor.secondryColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                IconConstants.backIcon,
              ),
            ),
          ),
        ),
        title: Image.asset(
          IconConstants.icBroadlogo,
          height: MediaQuery.of(context).size.height * 5 / 100,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 4 / 100,
              ),
              const Center(
                  child: Padding(
                padding: EdgeInsets.only(left: 60, right: 50),
                child: Text(
                  StringConstants.changeSecurity,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.bluelightColor,
                      fontSize: 35,
                      fontFamily: AppFont.fontFamily,
                      fontWeight: FontWeight.w600),
                ),
              )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              const Padding(
                padding: EdgeInsets.all(18),
                child: Text(
                  StringConstants.pinMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.verifyColor,
                      fontFamily: AppFont.fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 4 / 100,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 90 / 100,
                child: TextFormField(
                  controller: currentPinController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Current pin',
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: const BorderSide(
                          width: 0.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.fillColor, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        IconConstants.icLockadd, // Adjust the path as necessary
                        width: MediaQuery.of(context).size.width * 3 / 100,
                        height: MediaQuery.of(context).size.height * 3 / 100,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 4 / 100,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 90 / 100,
                child: TextFormField(
                  controller: newPinController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'New security pin',
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: const BorderSide(
                          width: 0.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.fillColor, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        IconConstants.icLockadd, // Adjust the path as necessary
                        width: MediaQuery.of(context).size.width * 3 / 100,
                        height: MediaQuery.of(context).size.height * 3 / 100,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 4 / 100,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 90 / 100,
                child: TextFormField(
                  controller: confirmnewPinController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Confirm security pin",
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: const BorderSide(
                          width: 0.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.fillColor, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        IconConstants.icLockadd, // Adjust the path as necessary
                        width: MediaQuery.of(context).size.width * 3 / 100,
                        height: MediaQuery.of(context).size.height * 3 / 100,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 4 / 100,
              ),
              if (_errorMessage != null)
                Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : AppButton(
                      text: appLocalization(context).changeSecurity,
                      onPress: () {
                        final currentPin = currentPinController.text;
                        final newPin = newPinController.text;
                        final confirmnewPin = confirmnewPinController.text;
                        if (currentPin.isNotEmpty &&
                            newPin.isNotEmpty &&
                            confirmnewPin.isNotEmpty) {
                          setState(() {
                            _isLoading = true;
                          });
                          changeSecurityPin(
                            currentPin: currentPin,
                            newPin: newPin,
                            confirmNewPin: confirmnewPin,
                          ).then((response) {
                            setState(() {
                              _isLoading = false;
                            });
                            // class SignUpResponse
                            //var response
                            if (response.statusCode == 200) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Profile()));
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
            ],
          ),
        ),
      ),
    );
  }
}
