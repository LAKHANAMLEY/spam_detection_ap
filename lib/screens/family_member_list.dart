import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/screens/edit_family_number_screen.dart';

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

  var familyListBloc = ApiBloc(ApiBlocInitialState());

  @override
  void initState() {
    super.initState();
    filteredContacts = [];
    familyListBloc.add(GetFamilyMemberListEvent());
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
      appBar: AppBar(
        backgroundColor: AppColor.secondryColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Image.asset(
              IconConstants.icbackCircle,
            ),
          ),
        ),
        title: Text(
          appLocalization(context).familyList,
          style: const TextStyle(
              color: AppColor.callColor,
              fontFamily: AppFont.fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),

        //centerTitle: true,
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
                bloc: familyListBloc,
                listener: (context, state) {
                  if (state is GetFamilyMemberListState) {
                    contacts = state.value.familymemberslist ?? [];
                    filteredContacts = contacts;
                  }
                },
                builder: (context, state) {
                  if (state is GetFamilyMemberListState) {
                    contacts = state.value.familymemberslist ?? [];
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
                                child: const Text("Edit Member"),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.familyEditMember,
                                      arguments: EditFamilyMember(
                                          familyMember:
                                              filteredContacts[index]));
                                },
                              ),
                              PopupMenuItem(
                                child: const Text("Delete Member "),
                                onTap: () {},
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
              MaterialPageRoute(builder: (context) => const AddFamilyMember()));
        },
      ),
    );
  }
}
