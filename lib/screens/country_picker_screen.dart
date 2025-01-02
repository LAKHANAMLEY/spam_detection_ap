import 'package:spam_delection_app/lib.dart';

class CountryPickerScreen extends StatefulWidget {
  final SelectionBloc? bloc;
  const CountryPickerScreen({super.key, this.bloc});

  @override
  State<CountryPickerScreen> createState() => _CountryPickerScreenState();
}

class _CountryPickerScreenState extends State<CountryPickerScreen> {
  var countryListBloc = ApiBloc(ApiBlocInitialState());

  var searchController = TextEditingController();

  var searchBloc = SelectionBloc(SelectStringState(""));

  @override
  void initState() {
    countryListBloc.add(CountryListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: appLocalization(context).selectCountry,
      ),
      body: BlocBuilder(
          bloc: countryListBloc,
          builder: (context, state) {
            if (state is CountryListState) {
              AppConstants.countryList = state.value.countrylist ?? [];
              return Column(
                children: [
                  CustomTextField(
                    fillColor: Colors.white,
                    controller: searchController,
                    hintText: appLocalization(context).searchHere,
                    onChanged: (value) {
                      searchBloc.add(SelectStringEvent(value));
                    },
                  ),
                  // CustomTextField(
                  //   controller: SearchController(),
                  //   fillColor: Colors.white,
                  //   hintText: appLocalization(context).searchCountry,
                  //   // labelText: appLocalization(context).country,
                  // ),
                  Expanded(
                    child: BlocBuilder(
                        bloc: searchBloc,
                        builder: (context, state) {
                          if (state is SelectStringState) {
                            var filteredCountry = AppConstants.countryList
                                .where((e) =>
                                    (e.name
                                            ?.toLowerCase()
                                            .contains(searchController.text) ??
                                        false) ||
                                    ("+${e.phonecode}"
                                        .toLowerCase()
                                        .contains(searchController.text)) ||
                                    (e.code
                                            ?.toLowerCase()
                                            .contains(searchController.text) ??
                                        false))
                                .toList();
                            return ListView.builder(
                              itemCount: filteredCountry.length,
                              itemBuilder: (context, index) => CountryListItem(
                                  filteredCountry[index],
                                  bloc: widget.bloc),
                            );
                          }
                          return const Loader();
                        }),
                  ),
                ],
              );
            }
            return const Loader();
          }),
    );
  }
}
