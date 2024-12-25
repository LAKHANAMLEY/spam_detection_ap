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
    //yha event add kia h list get krne ka
    //agar apko koi or state mile jese NotificationDeleteState
    //tab uspr firse event add krna hoga NotificationListEvent
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
        SizedBox(
          height: MediaQuery.of(context).size.height * 2 / 100,
        ),
        Expanded(
            child: BlocConsumer(
                bloc: notificationListBloc,
                listener: (context, state) {
                  if (state is NotificationListState) {
                    //ye state list get hone pr hi milti h
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
                    // notificationListBloc.add(NotificationListEvent());
                    //iski wajah se load ho rha tha
                    // okay sir but listbloc to add krna pdegana
                    //yes wo initstate me krege yaha to already list get ho rhi h fir se get krege to always get hoti rhegi loading
                    //understand sir
                  }
                  //yaha pr if condition laga kr
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
