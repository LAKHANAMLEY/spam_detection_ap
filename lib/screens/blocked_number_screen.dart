import 'package:spam_delection_app/lib.dart';

class BlockedNumber extends StatefulWidget {
  const BlockedNumber({super.key});

  @override
  State<BlockedNumber> createState() => _BlockedNumberState();
}

class _BlockedNumberState extends State<BlockedNumber> {
  // var blockContactsBloc = ApiBloc(ApiBlocInitialState());

  @override
  void initState() {
    markSpamBloc.add(GetBlockContactEvent());
    super.initState();
  }

  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      appBar: const CustomAppBar(
        title: StringConstants.blockNumber,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 90 / 100,
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Add phone number ',
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
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Image.asset(
                        IconConstants.icggadd,
                        height: MediaQuery.of(context).size.height * 2 / 100,
                        width: MediaQuery.of(context).size.width * 2 / 100,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedTab = 0;
                });
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 8 / 100,
                width: MediaQuery.of(context).size.width * 90 / 100,
                decoration: const BoxDecoration(
                  color: AppColor.secondryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTab(
                        selectedTab: selectedTab,
                        index: 0,
                        onTap: () {
                          setState(() {
                            selectedTab = 0;
                          });
                        },
                        text: "Recents"),
                    CustomTab(
                        selectedTab: selectedTab,
                        index: 1,
                        onTap: () {
                          setState(() {
                            selectedTab = 1;
                          });
                        },
                        text: "Contacts")
                  ],
                ),
              ),
            ),
            if (selectedTab == 0) ...[
              10.height(),
              BlocConsumer(
                bloc: markSpamBloc,
                listener: (context, state) {
                  if (state is BlockUnBlockState) {
                    if (state.value.statusCode == 200) {
                      showCustomDialog(context,
                          dialogType: DialogType.success,
                          subTitle: state.value.message);
                    } else if (state.value.statusCode ==
                        HTTPStatusCodes.sessionExpired) {
                      sessionExpired(context, state.value.message);
                    } else {
                      showCustomDialog(context,
                          dialogType: DialogType.failed,
                          subTitle: state.value.message.toString());
                    }
                    markSpamBloc.add(GetBlockContactEvent());
                    // markSpamBloc.add(GetSpamEvent());
                  }
                },
                builder: (context, state) {
                  if (state is ApiErrorState) {
                    return Center(child: Text('Error: ${state.value}'));
                  }
                  if (state is GetBlockContactState) {
                    final contacts = state.value.blockcontactslist ?? [];
                    if (contacts.isEmpty) {
                      return Center(
                        child: Text(appLocalization(context).noContacts),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        final contact = contacts[index];
                        return CustomListTile(
                          leading: const CircleAvatar(
                            backgroundImage:
                                AssetImage(IconConstants.icspamCircle),
                          ),
                          title: Text(
                            contact.name ?? "",
                            style: textTheme(context).titleMedium,
                          ),
                          subtitle: Text(contact.mobileNo ?? ""),
                          trailing: InkWell(
                              onTap: () {
                                markSpamBloc.add(BlockUnBlockEvent(
                                    contactId: contact.mobileNo ?? "",
                                    comments: "unblock"));
                              },
                              child: const Icon(Icons.delete)),
                          // subtitle: Text(contact.phone),
                        );
                      },
                    );
                  }
                  return const Loader();
                },
              ),
            ] else
              ...[]
          ]),
        ),
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  final int index;
  final int selectedTab;
  final void Function() onTap;
  final String text;
  const CustomTab(
      {super.key,
      required this.selectedTab,
      required this.onTap,
      required this.text,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: MediaQuery.of(context).size.height * 6 / 100,
          width: MediaQuery.of(context).size.width * 40 / 100,
          decoration: BoxDecoration(
              color: selectedTab == index
                  ? AppColor.callColor
                  : AppColor.secondryColor,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: selectedTab == index
                    ? AppColor.callColor
                    : AppColor.borderstekColor,
              )),
          child: Center(
              child: Text(
            text,
            style: TextStyle(
                color: selectedTab == index
                    ? AppColor.secondryColor
                    : AppColor.callColor,
                fontSize: 18,
                fontFamily: AppFont.fontFamily,
                fontWeight: FontWeight.w600),
          )),
        ));
  }
}
