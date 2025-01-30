import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state_background/phone_state_background.dart';
import 'package:spam_delection_app/lib.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Bloc.observer = AppBlocObserver();
  firebaseAnalyticsConfig();
  firebaseCrashlyticsConfig();
  FlutterNativeSplash.remove();
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
  // if (event != null)
  await permissionRequest(Permission.systemAlertWindow);
  showOverlay(
      callType: getCallTypeStringFromBGPhoneState(event),
      number: number,
      duration: duration);
}

class MyApp extends StatelessWidget {
  final bool isOverlay;

  const MyApp({
    super.key,
    this.isOverlay = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: localizationBloc,
        listener: (context, state) {
          if (state is ChangeLocaleState) {
            AppConstants.selectedLanguage = state.locale.languageCode;
          }
        },
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
