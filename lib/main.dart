import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  // Workmanager().initialize(
  //   callbackDispatcher,
  //   isInDebugMode: true, // Optional: Enable logging for debugging
  // );

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
  // Workmanager().registerPeriodicTask(
  //   'periodic-task-identifier',
  //   'my_background_task',
  //   frequency: Duration(minutes: 15), // Minimum 15 minutes on Android
  //   inputData: {'periodic': true},
  //   constraints: Constraints(
  //     networkType: NetworkType.connected,
  //   ),
  // );
  // await Workmanager().cancelAll();//To cancel all bg task
  print('Periodic task scheduled');
  // if (event != null)
  // await permissionRequest(Permission.systemAlertWindow);
  showOverlay(
      callType: getCallTypeStringFromBGPhoneState(event),
      number: number,
      duration: duration);
}

// @pragma('vm:entry-point') // Required for isolates
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     switch (task) {
//       case 'my_background_task':
//         // Your background task logic here
//         print("Running my background task with input: $inputData");
//         // You can use plugins here, but ensure they are initialized within this isolate.
//         // For example, for shared_preferences:
//         // final prefs = await SharedPreferences.getInstance();
//         // final counter = (prefs.getInt('counter') ?? 0) + 1;
//         // await prefs.setInt('counter', counter);
//         return Future.value(true); // Indicate success
//       case 'another_task':
//         print("Running another background task");
//         return Future.value(true);
//     }
//     return Future.value(false); // Task not recognized
//   });
// }

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
