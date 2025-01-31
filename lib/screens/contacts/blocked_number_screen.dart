import 'package:spam_delection_app/lib.dart';

class BlockedCalls extends StatefulWidget {
  const BlockedCalls({super.key});

  @override
  State<BlockedCalls> createState() => _BlockedCallsState();
}

class _BlockedCallsState extends State<BlockedCalls> {
  var selectTabBloc = SelectionBloc(SelectIntState(0));

  @override
  void initState() {
    markSpamBloc.add(GetBlockContactEvent());
    super.initState();
  }

  double scale = 3.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar(title: appLocalization(context).blockedNumber),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: CustomTextField(
                readOnly: true,
                hintText: appLocalization(context).addPhoneNumber,
                suffix: Image.asset(
                  IconConstants.icAddPhone,
                  scale: 3,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
            ),
            BlocBuilder(
                bloc: selectTabBloc,
                builder: (context, selectTabState) {
                  if (selectTabState is SelectIntState) {
                    int selectedTab = selectTabState.value;
                    return Column(children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 7 / 100,
                        width: MediaQuery.of(context).size.width * 90 / 100,
                        decoration: const BoxDecoration(
                          color: AppColor.whiteColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTab(
                                selectedTab: selectedTab,
                                tabIndex: 0,
                                onTap: () {
                                  selectTabBloc.add(SelectIntEvent(0));
                                },
                                text: appLocalization(context).recentText),
                            CustomTab(
                                selectedTab: selectedTab,
                                tabIndex: 1,
                                onTap: () {
                                  selectTabBloc.add(SelectIntEvent(1));
                                },
                                text: appLocalization(context).contactText)
                          ],
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
                              return Center(
                                  child: Text('Error: ${state.value}'));
                            }
                            if (state is GetBlockContactState) {
                              final contacts =
                                  state.value.blockcontactslist ?? [];
                              if (contacts.isEmpty) {
                                return Center(
                                  child:
                                      Text(appLocalization(context).noContacts),
                                );
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: contacts.length,
                                itemBuilder: (context, index) {
                                  final contact = contacts[index];
                                  return BlockedContactListItem(
                                    contact: contact,
                                  );
                                },
                              );
                            }
                            return const Loader();
                          },
                        ),
                      ] else
                        ...[]
                    ]);
                  }
                  return const Loader();
                })
          ]),
        ),
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  final int tabIndex;
  final int selectedTab;
  final void Function() onTap;
  final String text;

  const CustomTab(
      {super.key,
      required this.selectedTab,
      required this.onTap,
      required this.text,
      required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: MediaQuery.of(context).size.height * 6 / 100,
          width: MediaQuery.of(context).size.width * 40 / 100,
          decoration: BoxDecoration(
              color: selectedTab == tabIndex
                  ? AppColor.darkPurpleColor
                  : AppColor.whiteColor,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: selectedTab == tabIndex
                    ? AppColor.darkPurpleColor
                    : AppColor.magentaColor,
              )),
          child: Center(
              child: Text(
            text,
            style: TextStyle(
                color: selectedTab == tabIndex
                    ? AppColor.whiteColor
                    : AppColor.darkPurpleColor,
                fontSize: 18,
                fontFamily: AppFont.fontFamily,
                fontWeight: FontWeight.w600),
          )),
        ));
  }
}
