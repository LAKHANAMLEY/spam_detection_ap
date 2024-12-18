import 'package:spam_delection_app/lib.dart';

class FamilyMemberList extends StatefulWidget {
  const FamilyMemberList({super.key});

  @override
  State<FamilyMemberList> createState() => _FamilyMemberListState();
}

class _FamilyMemberListState extends State<FamilyMemberList> {
  final TextEditingController editingController = TextEditingController();
  List<FamilyMember> contacts = [];
  late List<FamilyMember> filteredContacts;
  FamilyMember? selectedCategory;

  String? numberType;
  List<FamilyMember> categories = [];

  var familyBloc = ApiBloc(ApiBlocInitialState());

  @override
  void initState() {
    super.initState();
    filteredContacts = [];
    familyBloc.add(GetFamilyMemberListEvent());
  }

  void filterSearchResults(String query) {
    setState(() {
      filteredContacts = contacts
          .where((item) =>
              item.userRole!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondryColor,
      appBar: CustomAppBar(
        title: appLocalization(context).familyList,
      ),
      body: SafeArea(
          child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) => filterSearchResults(value),
            controller: editingController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: appLocalization(context).searchMore,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              hintStyle: const TextStyle(
                color: Color(0xffB2B8BD),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffE1E6EB), width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 0.5, color: Color(0xffE1E6EB)),
              ),
              fillColor: AppColor.whiteLight.withOpacity(0.2),
              filled: true,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 2 / 100,
        ),
        Expanded(
            child: BlocConsumer(
                bloc: familyBloc,
                listener: (context, state) {
                  if (state is GetFamilyMemberListState) {
                    contacts = state.value.familymemberslist ?? [];
                    filteredContacts = contacts;
                  }
                  if (state is FamilyDeleteMemberState) {
                    if (state.value.statusCode == 200) {
                      showCustomDialog(
                        context,
                        dialogType: DialogType.success,
                        subTitle:
                            state.value.message ?? "Deleted successfully!",
                      );
                    } else if (state.value.statusCode ==
                        HTTPStatusCodes.sessionExpired) {
                      sessionExpired(
                          context,
                          state.value.message ??
                              "Session expired. Please log in again.");
                    } else {
                      showCustomDialog(
                        context,
                        dialogType: DialogType.success,
                        subTitle: state.value.message,
                      );
                    }
                    staffBloc.add(GetFamilyMemberListEvent());
                  }
                },
                builder: (context, state) {
                  if (state is GetFamilyMemberListState) {
                    contacts = state.value.familymemberslist ?? [];

                    return ModalProgressHUD(
                      progressIndicator: const Loader(),
                      inAsyncCall: state is ApiLoadingState,
                      child: (filteredContacts.isEmpty)
                          ? Center(
                              child: Text(appLocalization(context).noContacts),
                            )
                          : ListView.builder(
                              itemCount: filteredContacts.length,
                              // shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        AppColor.vanishColor.withOpacity(0.2),
                                    radius: 43.0,
                                    backgroundImage:
                                        filteredContacts[index].photo != null
                                            ? NetworkImage(
                                                filteredContacts[index].photo!)
                                            : const AssetImage(
                                                ImageConstants.imageProfile),
                                  ),
                                  subtitle: Text(
                                    filteredContacts[index].relation ?? "",
                                    style: const TextStyle(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        fontFamily: AppFont.fontFamily),
                                  ),
                                  title: Text(
                                    filteredContacts[index].firstName ?? "",
                                    style: const TextStyle(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        fontFamily: AppFont.fontFamily),
                                  ),
                                  trailing: PopupMenuButton(
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Text(appLocalization(context)
                                            .editMember),
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              AppRoutes.familyEditMember,
                                              arguments: EditFamilyMember(
                                                  familyMember:
                                                      filteredContacts[index]));
                                        },
                                      ),
                                      PopupMenuItem(
                                        child: Text(appLocalization(context)
                                            .deleteMember),
                                        onTap: () {
                                          familyBloc.add(
                                              FamilyDeleteMemberEvent(
                                                  id: filteredContacts[index]
                                                          .userId ??
                                                      ""));
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    );
                  }
                  return const Loader();
                }))
      ])),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.callColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Image.asset(
          IconConstants.icaddCall,
          height: MediaQuery.of(context).size.height * 6 / 100,
          width: MediaQuery.of(context).size.width * 6 / 100,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddFamilyMember()));
        },
      ),
    );
  }
}
