import 'package:spam_delection_app/lib.dart';

class CountryPhoneCodePrefix extends StatelessWidget {
  final SelectionBloc? bloc;

  const CountryPhoneCodePrefix({super.key, this.bloc});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            useSafeArea: true,
            isScrollControlled: true,
            builder: (context) => CountryPickerScreen(bloc: bloc),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: BlocBuilder(
              bloc: bloc ?? selectCountryBloc,
              builder: (context, state) {
                if (state is SelectCountryState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        appLocalization(context).countryCode,
                        style: textTheme(context)
                            .bodySmall
                            ?.copyWith(color: AppColor.orangeColor),
                      ),
                      Text("(${state.value?.code}) +${state.value?.phonecode}"),
                      10.height(),
                    ],
                  );
                }
                return const Loader();
              }),
        ),
      );
    });
  }
}
