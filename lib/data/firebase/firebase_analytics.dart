import 'package:firebase_analytics/firebase_analytics.dart';

firebaseAnalyticsConfig() {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logAppOpen();
}
