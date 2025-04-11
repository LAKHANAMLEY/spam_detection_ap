import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/screens/plan/transaction_listitem.dart';

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
      backgroundColor: AppColor.whiteColor,
      appBar: (widget.showAppBar ?? argument?.showAppBar ?? false)
          ? const CustomAppBar(
              //centerTitle: true,
              )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              BlocBuilder(
                  bloc: transactionListBloc,
                  builder: (context, state) {
                    if (state is GetTransactionListState) {
                      var transactions = state.value.transactionHistory ?? [];
                      //print()
                      if (transactions.isEmpty) {
                        return Center(
                          child: Text(appLocalization(context).noData),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: transactions.length,
                        itemBuilder: (context, index) => TransactionListItem(
                          transactionData: transactions[index],
                        ),
                      );
                    }
                    return const Loader();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
