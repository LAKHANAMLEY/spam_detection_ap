// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAmjejPvZIPjPdHeFBYGf8BtfEPpTSRAaE',
    appId: '1:1036303425157:web:1f85a9eb7fab7b2c8713ec',
    messagingSenderId: '1036303425157',
    projectId: 'spam-detect-cfb50',
    authDomain: 'spam-detect-cfb50.firebaseapp.com',
    storageBucket: 'spam-detect-cfb50.appspot.com',
    measurementId: 'G-5EJQNTQZNN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyChS9sWQVNwB0_KnbwRfGvfKo11asiTyso',
    appId: '1:1036303425157:android:2ada947334054edd8713ec',
    messagingSenderId: '1036303425157',
    projectId: 'spam-detect-cfb50',
    storageBucket: 'spam-detect-cfb50.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAyn60nH-lcCOXetx_xfnAXjv9Lz1plv-k',
    appId: '1:1036303425157:ios:6819cd9176cd2c278713ec',
    messagingSenderId: '1036303425157',
    projectId: 'spam-detect-cfb50',
    storageBucket: 'spam-detect-cfb50.appspot.com',
    iosBundleId: 'com.example.spamDelectionApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAyn60nH-lcCOXetx_xfnAXjv9Lz1plv-k',
    appId: '1:1036303425157:ios:6819cd9176cd2c278713ec',
    messagingSenderId: '1036303425157',
    projectId: 'spam-detect-cfb50',
    storageBucket: 'spam-detect-cfb50.appspot.com',
    iosBundleId: 'com.example.spamDelectionApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAmjejPvZIPjPdHeFBYGf8BtfEPpTSRAaE',
    appId: '1:1036303425157:web:45712c99fddf80478713ec',
    messagingSenderId: '1036303425157',
    projectId: 'spam-detect-cfb50',
    authDomain: 'spam-detect-cfb50.firebaseapp.com',
    storageBucket: 'spam-detect-cfb50.appspot.com',
    measurementId: 'G-DGXY9E370M',
  );
}