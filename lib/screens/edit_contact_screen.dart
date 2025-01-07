import '../lib.dart';

class EditContact extends StatefulWidget {
  const EditContact({super.key});

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<String> options = [
      appLocalization(context).mobile,
      appLocalization(context).home,
      appLocalization(context).work,
      appLocalization(context).homeFax,
      appLocalization(context).workFax,
      appLocalization(context).other,
    ];
    String selectedType = appLocalization(context).mobile;
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      appBar: CustomAppBar(title: appLocalization(context).editContact),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            10.height(),
            CustomTextField(
              controller: fullNameController,
              hintText: appLocalization(context).fullName,
              labelText: appLocalization(context).fullName,
              suffix: Image.asset(
                IconConstants.icUsername,
                scale: 1.5,
              ),
              validator: (p0) {
                if (p0?.isEmpty ?? true) {
                  return appLocalization(context).pleaseEnterYourFullName;
                }
                return null;
              },
            ),
            10.height(),
            CustomTextField(
              controller: EmailController,
              hintText: appLocalization(context).fullName,
              labelText: appLocalization(context).fullName,
              suffix: Image.asset(
                IconConstants.icFluentMail,
                scale: 1.5,
              ),
              validator: (p0) {
                if (p0?.isEmpty ?? true) {
                  return appLocalization(context).pleaseEnterYourEmailAddress;
                }
                return null;
              },
            ),
            10.height(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: DropdownButtonFormField<String>(
                value: selectedType,
                items: options.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedType = newValue!;
                  });
                },
                decoration: InputDecoration(
                  hintText: appLocalization(context).numberType,
                  hintStyle: const TextStyle(color: AppColor.lightFillColor),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:
                        const BorderSide(width: 1.5, color: AppColor.fillColor),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColor.fillColor, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  filled: true,
                  fillColor: AppColor.fillColor.withOpacity(0.2),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
