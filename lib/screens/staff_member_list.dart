import 'package:spam_delection_app/lib.dart';

class StaffMemberList extends StatefulWidget {
  const StaffMemberList({super.key});

  @override
  State<StaffMemberList> createState() => _StaffMemberListState();
}

class _StaffMemberListState extends State<StaffMemberList> {
  final TextEditingController editingController = TextEditingController();
  List<StaffMember> contacts = [];
  late List<StaffMember> filteredContacts;
  StaffMember? selectedCategory;

  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  String? numberType;
  List<StaffMemberList> categories = [];

  // var staffBloc = ApiBloc(ApiBlocInitialState());

  @override
  void initState() {
    super.initState();
    filteredContacts = [];
    staffBloc.add(GetStaffMemberListEvent());
  }

  void filterSearchResults(String query) {
    setState(() {
      filteredContacts = contacts
          .where((item) =>
              item.firstName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Staff List',
      ),
      backgroundColor: AppColor.secondryColor,
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
                bloc: staffBloc,
                listener: (context, state) {
                  if (state is GetStaffMemberListState) {
                    contacts = state.value.staffmemberslist ?? [];
                    filteredContacts = contacts;
                  }
                  if (state is StaffDeleteMemberState) {
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
                    staffBloc.add(GetStaffMemberListEvent());
                  }
                },
                builder: (context, state) {
                  if (state is GetStaffMemberListState) {
                    contacts = state.value.staffmemberslist ?? [];

                    return ModalProgressHUD(
                      progressIndicator: const Loader(),
                      inAsyncCall: state is ApiLoadingState,
                      child: (filteredContacts.isEmpty)
                          ? const Center(
                              child: Text('No staff'),
                            )
                          : ListView.builder(
                              itemCount: filteredContacts.length,
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
                                        child: const Text("Edit Staff Member"),
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              AppRoutes.editStaffMember,
                                              arguments: EditStaffMember(
                                                  staffMember:
                                                      filteredContacts[index]));
                                        },
                                      ),
                                      PopupMenuItem(
                                          child: const Text("Delete Member"),
                                          onTap: () {
                                            staffBloc.add(
                                                StaffDeleteMemberEvent(
                                                    id: filteredContacts[index]
                                                            .userId ??
                                                        ""));
                                            // Navigator.pop(context);
                                          })
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
              MaterialPageRoute(builder: (context) => const AddStaffMember()));
        },
      ),
    );
  }
}
