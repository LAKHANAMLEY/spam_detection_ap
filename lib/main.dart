import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_state_background/phone_state_background.dart';
import 'package:spam_delection_app/data/repository/call_log_repo/call_log_sync_service.dart';
import 'package:spam_delection_app/data/repository/sms_repo/message_service.dart';
import 'package:spam_delection_app/lib.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  firebaseAnalyticsConfig();
  firebaseCrashlyticsConfig();
  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true, // Set to false in production
  );
  await Workmanager().registerPeriodicTask(
    "sync_call_log_task",
    "syncCallLogsWithServer",
    frequency: Duration(minutes: 15),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );

  await Workmanager().registerPeriodicTask(
    "sync_sms_task",
    "syncSmsWithServer",
    frequency: Duration(minutes: 15), // Minimum on Android
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );
  runApp(const MyApp());
  FlutterNativeSplash.remove(); // Hide splash after app loads
}

@pragma("vm:entry-point")
void overlayMain() {
  runApp(const MyApp(isOverlay: true));
}

@pragma('vm:entry-point')
Future<void> phoneStateBackgroundCallbackHandler(
  PhoneStateBackgroundEvent event,
  String number,
  int duration,
) async {
  print('📞 Call event captured for $number, duration $duration sec');

  showOverlay(
    callType: getCallTypeStringFromBGPhoneState(event),
    number: number,
    duration: duration,
  );
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      print("✅ WorkManager Task Started: $task");

      if (task == "syncSmsWithServer") {
        await MessageSyncService.syncMessages();
      } else if (task == "syncCallLogsWithServer") {
        await CallLogSyncService.syncCallLogs();
      }

      print("✅ WorkManager Task Completed: $task");
      return Future.value(true);
    } catch (e, stack) {
      print("❌ WorkManager Task Failed: $e\n$stack");
      return Future.value(false);
    }
  });
}

class MyApp extends StatelessWidget {
  final bool isOverlay;

  const MyApp({
    super.key,
    this.isOverlay = false,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PermissionBloc(),
        ),
        BlocProvider(
          create: (context) => ContactDBBloc(),
        ),
        BlocProvider(
          create: (context) => CallLogDBBloc(),
        ),
        BlocProvider(
          create: (context) => SmsBloc(),
        ),
        BlocProvider(
          create: (context) => MessageDBBloc(),
        ),
      ],
      child: BlocConsumer(
          bloc: localizationBloc,
          listener: (context, state) {
            if (state is ChangeLocaleState) {
              AppConstants.selectedLanguage = state.locale.languageCode;
            }
          },
          builder: (context, state) {
            if (state is ChangeLocaleState) {
              return ScreenUtilInit(
                minTextAdapt: true,
                splitScreenMode: true,
                child: MaterialApp(
                  title: AppConstants.projectName,
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    AppLocalizations.delegate,
                  ],
                  supportedLocales: AppLocalizations.supportedLocales,
                  debugShowCheckedModeBanner: false,
                  locale: state.locale,
                  themeMode: ThemeMode.light,
                  theme: ThemeConstants.lightTheme(),
                  darkTheme: ThemeConstants.darkTheme(),
                  routes: routes,
                  home: isOverlay ? const OutSideAppOverlay() : const Splash(),
                ),
              );
            }
            return const Loader();
          }),
    );
  }
}
