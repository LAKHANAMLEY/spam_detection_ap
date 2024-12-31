import 'package:spam_delection_app/lib.dart';

final userOnlineOfflineStatusBloc = ApiBloc(ApiBlocInitialState());
handleAppLifeCycle() {
  // how to get in flutter user is online and offline
  AppLifecycleListener(onResume: () {
    userOnlineOfflineStatusBloc.add(SetUserOnlineOfflineEvent(isOnline: "1"));
  }, onInactive: () {
    userOnlineOfflineStatusBloc.add(SetUserOnlineOfflineEvent(isOnline: "0"));
  });
}
