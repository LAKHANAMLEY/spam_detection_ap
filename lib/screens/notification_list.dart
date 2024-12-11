import 'package:spam_delection_app/lib.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  //var notifications = state.value.notifications ?? [];
  var notificationListBloc = ApiBloc(ApiBlocInitialState());

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
      ),
      backgroundColor: AppColor.greylightColor,
      body: SafeArea(
          child: Column(children: <Widget>[
        Expanded(
            child: BlocConsumer(
                bloc: staffBloc,
                listener: (context, state) {
                  if (state is NotificationListState) {
                    if (state.value.statusCode == 200) {
                      // showCustomDialog(
                      //   context,
                      //   dialogType: DialogType.success,
                      //   subTitle:
                      //       state.value.message ?? "Notification successfully!",
                      // );
                    } else if (state.value.statusCode ==
                        HTTPStatusCodes.sessionExpired) {
                      sessionExpired(
                          context,
                          state.value.message ??
                              "Session expired. Please log in again.");
                    } else {
                      showCustomDialog(
                        context,
                        dialogType: DialogType.success,
                        subTitle: state.value.message,
                      );
                    }
                    notificationListBloc.add(NotificationTypeEvent());
                  }
                },
                builder: (context, state) {
                  if (state is NotificationListState) {
                    var notifications = state.value.notificationsList ?? [];
                    return ModalProgressHUD(
                      progressIndicator: const Loader(),
                      inAsyncCall: state is ApiLoadingState,
                      child: (notifications.isEmpty)
                          ? const Center(
                              child: Text('No Notifications'),
                            )
                          : ListView.builder(
                              itemCount: notifications.length,
                              itemBuilder: (context, index) {
                                return CustomListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        notifications[index].toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.callColor),
                                      ),
                                      10.width(),
                                      Text("10 Dec 24")
                                    ],
                                  ),
                                  subtitle:
                                      Text(notifications[index].toString()),
                                  leading: const CircleAvatar(
                                      radius: 12,
                                      backgroundImage: AssetImage(
                                          IconConstants.icNotification)),
                                );
                              }),
                    );
                  }

                  return const Loader();
                }))
      ])),
    );
  }
}
