import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:phone_state_background/phone_state_background.dart';
import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/utils/show_overlay.dart';
import 'package:system_alert_window/system_alert_window.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Bloc.observer = AppBlocObserver();
  firebaseAnalyticsConfig();
  firebaseCrashlyticsConfig();
  SystemAlertWindow.checkPermissions().then((isHavingPermission) async {
    if (isHavingPermission ?? false) {
    } else {
      await SystemAlertWindow.requestPermissions();
    }
  });
  await PhoneStateBackground.checkPermission().then((isHavingPermission) async {
    if (isHavingPermission) {
      await PhoneStateBackground.initialize(
          phoneStateBackgroundCallbackHandler);
    } else {
      await PhoneStateBackground.requestPermissions();
    }
  });
  runApp(const MyApp());
}

// overlay entry point
@pragma("vm:entry-point")
void overlayMain() {
  runApp(const MyApp(
    isOverlay: true,
  ));
}

@pragma('vm:entry-point')
Future<void> phoneStateBackgroundCallbackHandler(
  PhoneStateBackgroundEvent event,
  String number,
  int duration,
) async {
  showOverlay(callType: event.name, number: number, duration: duration);
  // switch (event) {
  //   case PhoneStateBackgroundEvent.incomingstart:
  //     showOverlay(callType: event.name, number: number, duration: duration);
  //     break;
  //   case PhoneStateBackgroundEvent.incomingmissed:
  //     print('Incoming call missed, number: $number, duration: $duration s');
  //     await SystemAlertWindow.showSystemWindow(
  //       notificationTitle: AppConstants.projectName,
  //       notificationBody: "Missed call $number",
  //     );
  //     break;
  //   case PhoneStateBackgroundEvent.incomingreceived:
  //     print('Incoming call received, number: $number, duration: $duration s');
  //     await SystemAlertWindow.showSystemWindow(
  //       notificationTitle: AppConstants.projectName,
  //       notificationBody: "Incoming call $number",
  //     );
  //     break;
  //   case PhoneStateBackgroundEvent.incomingend:
  //     print('Incoming call ended, number: $number, duration $duration s');
  //     await SystemAlertWindow.showSystemWindow(
  //       notificationTitle: AppConstants.projectName,
  //       notificationBody: "Call end $number",
  //     );
  //     break;
  //   case PhoneStateBackgroundEvent.outgoingstart:
  //     print('Ougoing call start, number: $number, duration: $duration s');
  //     await SystemAlertWindow.showSystemWindow(
  //       notificationTitle: AppConstants.projectName,
  //       notificationBody: "Outgoing call $number",
  //     );
  //     break;
  //   case PhoneStateBackgroundEvent.outgoingend:
  //     print('Ougoing call ended, number: $number, duration: $duration s');
  //     await SystemAlertWindow.showSystemWindow(
  //       notificationTitle: AppConstants.projectName,
  //       notificationBody: "Call end $number",
  //     );
  //     break;
  // }
}

class MyApp extends StatelessWidget {
  final bool isOverlay;

  const MyApp({
    super.key,
    this.isOverlay = false,
  });

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
              home: isOverlay ? const OutSideAppOverlay() : const Splash(),
            );
          }
          return const Loader();
        });
  }
}
