import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/screens/add_staff_member.dart';

import 'edit_staff_member.dart';

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

  String? numberType;
  List<StaffMemberList> categories = [];

  var staffListBloc = ApiBloc(ApiBlocInitialState());

  @override
  void initState() {
    super.initState();
    filteredContacts = [];
    staffListBloc.add(GetStaffMemberListEvent());
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
              hintText: appLocalization(context).searchHere,
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
        SizedBox(
          height: MediaQuery.of(context).size.height * 2 / 100,
        ),
        Expanded(
            child: BlocConsumer(
                bloc: staffListBloc,
                listener: (context, state) {
                  if (state is GetStaffMemberListState) {
                    contacts = state.value.staffmemberslist ?? [];
                    filteredContacts = contacts;
                  }
                },
                builder: (context, state) {
                  if (state is GetStaffMemberListState) {
                    contacts = state.value.staffmemberslist ?? [];
                    if (filteredContacts.isEmpty) {
                      return const Center(
                        child: Text('No contacts'),
                      );
                    }

                    return ListView.builder(
                      itemCount: filteredContacts.length,
                      // shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.network(
                            filteredContacts[index].userRole!,
                            //TODO: image path
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.person),
                            width: MediaQuery.of(context).size.width * 12 / 100,
                            height:
                                MediaQuery.of(context).size.height * 12 / 100,
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
                                  Navigator.pushNamed(
                                      context, AppRoutes.editStaffMember,
                                      arguments: EditStaffMember(
                                          staffMember:
                                              filteredContacts[index]));
                                },
                              ),
                              PopupMenuItem(
                                child: const Text("Delete Member "),
                                onTap: () {
                                  /*Navigator.pushNamed(
                                          context, AppRoutes.familyEditMember,
                                          arguments: EditFamilyMember(
                                              familyMember:
                                              filteredContacts[index]));

                                       */
                                },
                              ),
                            ],
                          ),
                        );
                      },
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
