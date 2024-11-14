import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spam_delection_app/screens/splash_screen.dart';


import 'app_route/route.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spam_Detection_App',
      /*localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('es'), // Spanish
      ],

       */
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

      ),
      routes: routes,
      home: const Splash(),
    );
  }
}
