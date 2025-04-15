import 'package:permission_handler/permission_handler.dart';
import 'package:spam_delection_app/lib.dart';

class PermissionWidget extends StatelessWidget {
  final Permission permission;
  const PermissionWidget({super.key, required this.permission});

  @override
  Widget build(BuildContext context) {
    var permissionBloc =
        SelectionBloc(SelectStringState(DateTime.now().toString()));
    bool isAllowed = false;
    return BlocBuilder(
        bloc: permissionBloc,
        builder: (context, state) {
          if (state is SelectStringState) {
            return FutureBuilder(
                future: permission.isGranted,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    isAllowed = snapshot.data ?? false;
                    if (isAllowed) {
                      return SizedBox.shrink();
                    }
                    return Container(
                        decoration: BoxDecoration(color: Colors.red),
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${permission.name} permission not allowed. Allow access to sync your ${permission.name} in realtime.",
                                style: textTheme(context)
                                    .bodySmall
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  var status =
                                      await permissionRequest(permission);
                                  if (status?.isGranted ?? false) {
                                    isAllowed = true;
                                    await sync(context);
                                  } else {
                                    isAllowed = false;
                                  }
                                  permissionBloc.add(SelectStringEvent(
                                      DateTime.now().toString()));
                                },
                                child: Text("Allow"))
                          ],
                        ));
                  }
                  return Loader();
                });
          }
          return Loader();
        });
  }

  Future<void> sync(BuildContext context) async {
    switch (permission) {
      case Permission.contacts:
        context.read<ContactDBBloc>().add(SyncDBContacts());
      case Permission.phone:
        context.read<CallLogDBBloc>().add(SyncDBCallLogs());
      case Permission.sms:
        context.read<MessageDBBloc>().add(SyncMessagesWithServer());
    }
  }
}
