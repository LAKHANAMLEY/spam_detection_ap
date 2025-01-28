import 'package:spam_delection_app/lib.dart';

class BlockList extends StatefulWidget {
  const BlockList({super.key});

  @override
  State<BlockList> createState() => _BlockListState();
}

class _BlockListState extends State<BlockList> {
  var markSmsSpamBloc = ApiBloc(ApiBlocInitialState());
  final TextEditingController editingController = TextEditingController();
  List<SmsSpamList> sms = [];
  List<SmsSpamList> filteredContacts = [];

  @override
  void initState() {
    super.initState();
    markSmsSpamBloc.add(SmsSpamListEvent());
  }

  void filterSearchResults(String query) {
    setState(() {
      filteredContacts = sms
          .where((item) => "${item.name} ${item.address}"
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: appLocalization(context).myBlockList,
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          CustomTextField(
            fillColor: AppColor.secondaryColor,
            onChanged: (value) => filterSearchResults(value),
            controller: editingController,
            prefix: const Icon(Icons.search),
            hintText: appLocalization(context).searchMore,
          ),
          Expanded(
              child: BlocConsumer(
                  bloc: markSmsSpamBloc,
                  listener: (context, state) {
                    if (state is SmsSpamListState) {
                      sms = state.value.smsSpamList ?? [];
                      filterSearchResults("");
                    }
                    if (state is RemoveSmsSpamState) {
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
                      markSmsSpamBloc.add(SmsSpamListEvent());
                    }
                  },
                  builder: (context, state) {
                    if (state is SmsSpamListState) {
                      // SmsDetail = state.value.smsLog ?? ;
                      if (filteredContacts.isEmpty) {
                        return Center(
                          child: Text(appLocalization(context).noContacts),
                        );
                      }
                      return ListView.builder(
                        itemCount: filteredContacts.length,
                        itemBuilder: (context, index) {
                          return SmsSpamListItem(
                              spamSms: filteredContacts[index]);
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
