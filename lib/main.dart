import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:spam_delection_app/lib.dart';
import 'package:system_alert_window/system_alert_window.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemAlertWindow.checkPermissions().then((isHavingPermission) async {
    if (isHavingPermission ?? false) {
    } else {
      await SystemAlertWindow.requestPermissions();
    }
  });

  runApp(const MyApp());
}

// overlay entry point
@pragma("vm:entry-point")
void overlayMain() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
          child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          // color: AppColor.callColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(IconConstants.icBroadlogo),
            ),
            const Text(
              "Incoming call",
              // style: textTheme(context).bodyLarge,
            ),
          ],
        ),
      ))));
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
