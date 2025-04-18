import 'package:spam_delection_app/lib.dart';

class TransactionList extends StatefulWidget {
  final bool? showAppBar;

  const TransactionList({super.key, this.showAppBar = true});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  var transactionListBloc = ApiBloc(ApiBlocInitialState());

  int selectedTab = 0;

  @override
  void initState() {
    transactionListBloc.add(GetTransactionListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var argument = args(context) as TransactionList?;
    return Scaffold(
      //backgroundColor: AppColor.whiteColor,
      appBar: (widget.showAppBar ?? argument?.showAppBar ?? false)
          ? const CustomAppBar(
              //centerTitle: true,
              )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                5.height(),
                BlocBuilder(
                    bloc: transactionListBloc,
                    builder: (context, state) {
                      if (state is GetTransactionListState) {
                        var transactions = state.value.transactionHistory ?? [];
                        print(transactions.first.expiredAt ?? "");
                        if (transactions.isEmpty) {
                          return Center(
                            child: Text(appLocalization(context).noData),
                          );
                        }
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: transactions.length,
                          itemBuilder: (context, index) => TransactionListItem(
                            transactionData: transactions[index],
                          ),
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 5,
                            );
                          },
                        );
                      }
                      return const Loader();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
