import 'package:spam_delection_app/lib.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  var notificationListBloc = ApiBloc(ApiBlocInitialState());
  var scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    notificationListBloc.add(NotificationListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Notifications List',
      ),
      backgroundColor: AppColor.secondryColor,
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
