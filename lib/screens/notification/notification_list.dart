import 'package:spam_delection_app/lib.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  var scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    notificationListBloc.add(NotificationListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: appLocalization(context).notificationList,
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
                  if (state is NotificationListState) {
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
                    notificationListBloc.add(NotificationListEvent());
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
                  if (state is NotificationListState) {
                    var notifications = state.value.notificationsList ?? [];

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
                                  NotificationListItem(
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
