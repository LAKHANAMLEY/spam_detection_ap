import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:spam_delection_app/lib.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: localizationBloc,
        builder: (context, state) {
          if (state is ChangeLocaleState) {
            return MaterialApp(
              title: AppConstants.projectName,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                AppLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
              locale: state.locale,
              theme: ThemeConstants.lightTheme,
              darkTheme: ThemeConstants.darkTheme,
              routes: routes,
              home: const Splash(),
            );
          }
          return const Loader();
        });
  }
}
