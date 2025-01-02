import 'package:spam_delection_app/lib.dart';

class CountryListItem extends StatelessWidget {
  final CountryData country;
  final SelectionBloc? bloc;
  const CountryListItem(this.country, {super.key, this.bloc});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onTap: () {
        (bloc ?? selectCountryBloc).add(SelectCountryEvent(country));
        Navigator.pop(context);
      },
      title: Text(
        country.name ?? "",
        style: textTheme(context)
            .bodyMedium
            ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        "+${country.phonecode}",
        style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
      ),
    );
  }
}
