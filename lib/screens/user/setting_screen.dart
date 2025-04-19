import 'package:spam_delection_app/lib.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  var scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    notificationListBloc.add(NotificationTypeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: appLocalization(context).setting,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                  onTap: () {
                    notificationListBloc.add(ClearAllNotificationEvent());
                  },
                  child: Text(appLocalization(context).clearAllNotifications))
            ],
          )
        ],
      ),
      backgroundColor: AppColor.whiteLightColor,
      body: SafeArea(
          child: Column(children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 2 / 100,
        ),
        Expanded(
            child: BlocConsumer(
                bloc: notificationListBloc,
                listener: (context, state) {
                  if (state is NotificationTypeState) {
                    if (state.value.statusCode == 200) {
                    } else if (state.value.statusCode ==
                        HTTPStatusCodes.sessionExpired) {
                      sessionExpired(
                          context,
                          state.value.message ??
                              appLocalization(context).sessionPleaseLogInAgain);
                    } else {
                      showCustomDialog(
                        context,
                        dialogType: DialogType.failed,
                        subTitle: state.value.message,
                      );
                    }
                    // notificationListBloc.add(NotificationListEvent());
                  }
                  if (state is ReadNotificationState) {
                    if (state.value.statusCode == 200) {
                    } else if (state.value.statusCode ==
                        HTTPStatusCodes.sessionExpired) {
                      sessionExpired(
                          context,
                          state.value.message ??
                              appLocalization(context).sessionPleaseLogInAgain);
                    } else {
                      showCustomDialog(
                        context,
                        dialogType: DialogType.failed,
                        subTitle: state.value.message,
                      );
                    }
                    notificationListBloc.add(NotificationTypeEvent());
                  }

                  if (state is ClearAllNotificationState) {
                    if (state.value.statusCode == 200) {
                    } else if (state.value.statusCode ==
                        HTTPStatusCodes.sessionExpired) {
                      sessionExpired(
                          context,
                          state.value.message ??
                              appLocalization(context).sessionPleaseLogInAgain);
                    } else {
                      showCustomDialog(
                        context,
                        dialogType: DialogType.failed,
                        subTitle: state.value.message,
                      );
                    }
                    notificationListBloc.add(NotificationListEvent());
                  }
                },
                builder: (context, state) {
                  if (state is NotificationTypeState) {
                    var notifications = state.value.notificationType ?? [];

                    return ModalProgressHUD(
                      progressIndicator: const Loader(),
                      inAsyncCall: state is ApiLoadingState,
                      child: (notifications.isEmpty)
                          ? Center(
                              child: Text(
                                  appLocalization(context).noNotifications),
                            )
                          : ListView.builder(
                              controller: scrollController,
                              itemCount: notifications.length,
                              itemBuilder: (context, index) =>
                                  NotificationTypeListItem(
                                    notification: notifications[index],
                                  )),
                    );
                  }
                  return const Loader();
                }))
      ])),
    );
  }
}
