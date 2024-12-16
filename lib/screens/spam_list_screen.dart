import 'package:spam_delection_app/lib.dart';

class SpamList extends StatefulWidget {
  const SpamList({super.key});

  @override
  State<SpamList> createState() => _SpamListState();
}

class _SpamListState extends State<SpamList> {
  final TextEditingController editingController = TextEditingController();
  List<SpamData> contacts = [];
  List<SpamData> filteredContacts = [];

  @override
  void initState() {
    super.initState();
    markSpamBloc.add(GetSpamEvent());
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
      // backgroundColor: AppColor.secondryColor,
      appBar: CustomAppBar(
        title: appLocalization(context).spamCalls,
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
                  bloc: markSpamBloc,
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
                      } else if (state.value.statusCode ==
                          HTTPStatusCodes.sessionExpired) {
                        sessionExpired(context, state.value.message);
                      } else {
                        showCustomDialog(context,
                            dialogType: DialogType.failed,
                            subTitle: state.value.message);
                      }
                      markSpamBloc.add(GetSpamEvent());
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
                        itemBuilder: (context, index) {
                          return SpamListItem(
                              spamContact: filteredContacts[index]);
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
