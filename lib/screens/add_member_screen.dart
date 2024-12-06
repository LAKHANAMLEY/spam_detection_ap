import 'package:spam_delection_app/lib.dart';

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  DateTime? selectedDate;
  get pickeddate => null;

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  String? enteredPhone;
  PhoneNumber? phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      appBar: AppBar(
        backgroundColor: AppColor.secondryColor,
        leading: GestureDetector(
          onTap: () {},
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                IconConstants.icbackCircle,
              ),
            ),
          ),
        ),
        title: const Text(
          StringConstants.addMember,
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
          child: Column(
            children: [
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
                      borderSide: const BorderSide(
                          width: 1.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.fillColor, width: 1.5),
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
                      borderSide: const BorderSide(
                          width: 1.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.fillColor, width: 1.5),
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
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: const BorderSide(
                          width: 1.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.fillColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        IconConstants
                            .icEmailadd, // Adjust the path as necessary
                        width: MediaQuery.of(context).size.width * 3 / 100,
                        height: MediaQuery.of(context).size.height * 3 / 100,
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
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: const BorderSide(
                          width: 1.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffE1E6EB), width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    counterText: '',
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
                height: MediaQuery.of(context).size.height * 3 / 100,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 90 / 100,
                child: TextFormField(
                  controller: lastnameController,
                  decoration: InputDecoration(
                    hintText: 'Relation',
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: const BorderSide(
                          width: 1.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.fillColor, width: 1.5),
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
                    hintText: 'Support pin',
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: const BorderSide(
                          width: 1.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.fillColor, width: 1.5),
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
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: IntlPhoneField(
                  controller: phonenumberController,
                  decoration: InputDecoration(
                    hintText: "Enter Phone Number",
                    hintStyle: const TextStyle(color: AppColor.lightfillColor),
                    //labelText: 'Phone Number',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: const BorderSide(
                          width: 1.5, color: AppColor.fillColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.fillColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    filled: true,
                    fillColor: AppColor.fillColor.withOpacity(0.2),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        IconConstants.icCalladd, // Adjust the path as necessary
                        width: MediaQuery.of(context).size.width * 3 / 100,
                        height: MediaQuery.of(context).size.height * 3 / 100,
                      ),
                    ),
                  ),
                  initialCountryCode: 'IN',
                  onChanged: (phone) {
                    phoneNumber = phone;
                    enteredPhone = phone.completeNumber;
                    // print(phone.completeNumber);
                    // print(phone.countryCode);
                  },
                ),
              ),
              AppButton(text: "Submit", onPress: (){}),

            ],
          ),
        ),
      ),
    );
  }
}
//work kr rhe h ye ki nhi?
// wait sir check krte hai