import 'package:spam_delection_app/lib.dart';

class SpamList extends StatefulWidget {
  const SpamList({super.key});

  @override
  State<SpamList> createState() => _SpamListState();
}

class _SpamListState extends State<SpamList> {
  final TextEditingController editingController = TextEditingController();
  List<SpamData> contacts = [];
  late List<SpamData> filteredContacts;
  SpamData? selectedCategory;
  bool isLoading = false;
  String? errorMessage;

  String? numberType;
  List<SpamData> categories = [];

  var spamListBloc = ApiBloc(ApiBlocInitialState());

  @override
  void initState() {
    super.initState();
    spamListBloc.add(GetSpamEvent());
  }

  void filterSearchResults(String query) {
    setState(() {
      filteredContacts = contacts
          .where((item) =>
              item.spamNo!.toLowerCase().contains(query.toLowerCase()))
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
        title: const Text(
          'Spam Calls',
          style: TextStyle(
              color: AppColor.callColor,
              fontFamily: AppFont.fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),

        //centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          CustomTextField(
            onChanged: (value) => filterSearchResults(value),
            controller: editingController,
            prefix: const Icon(Icons.search),
            hintText: "Search number, names & more",
          ),
          Expanded(
              child: BlocConsumer(
                  bloc: spamListBloc,
                  listener: (context, state) {
                    if (state is GetSpamState) {
                      contacts = state.value.spamcontactslist ?? [];
                      filteredContacts = contacts;
                    }
                    if (state is RemoveSpamState) {
                      if (state.value.statusCode == 200) {
                        showCustomDialog(context,
                            dialogType: DialogType.success,
                            subTitle: state.value.message);
                      } else {
                        showCustomDialog(context,
                            dialogType: DialogType.failed,
                            subTitle: state.value.message);
                      }
                      spamListBloc.add(GetSpamEvent());
                    }
                  },
                  builder: (context, state) {
                    if (state is GetSpamState) {
                      contacts = state.value.spamcontactslist ?? [];
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
                              filteredContacts[index].name!, //TODO: image path
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.person),
                              width:
                                  MediaQuery.of(context).size.width * 12 / 100,
                              height:
                                  MediaQuery.of(context).size.height * 12 / 100,
                            ),
                            title: Text(
                              filteredContacts[index].name ?? "",
                              style: const TextStyle(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: AppFont.fontFamily),
                            ),
                            trailing: PopupMenuButton(
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: const Text("Remove spam"),
                                  onTap: () {
                                    spamListBloc.add(RemoveSpamEvent(
                                        contactId:
                                            filteredContacts[index].id ?? ""));
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
        ],
      )),
    );
  }
}
