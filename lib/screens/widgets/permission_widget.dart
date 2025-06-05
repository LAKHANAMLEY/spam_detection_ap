import 'package:permission_handler/permission_handler.dart';
import 'package:spam_delection_app/lib.dart';

class PermissionWidget extends StatelessWidget {
  final Permission permission;
  const PermissionWidget({super.key, required this.permission});

  @override
  Widget build(BuildContext context) {
    context
        .read<PermissionBloc>()
        .add(GetSinglePermissionStatusEvent(permission));
    return BlocConsumer<PermissionBloc, PermissionState>(
      listener: (context, state) {
        if (state is SinglePermissionStatusLoadedState) {
          if (state.statuses[permission]?.isDenied ?? false) {}
        }
      },
      builder: (context, state) {
        if (state.statuses.containsKey(permission)) {
          final isAllowed =
              state.statuses[permission] == PermissionStatus.granted;
          if (isAllowed || Platform.isIOS) {
            return const SizedBox.shrink();
          }
          return Container(
            decoration: const BoxDecoration(color: Colors.red),
            padding: const EdgeInsets.all(5),
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
                  onPressed: () {
                    context
                        .read<PermissionBloc>()
                        .add(RequestSinglePermissionEvent(permission));
                  },
                  child: const Text("Allow"),
                ),
              ],
            ),
          );
        }
        // Initial state or loading state for this specific permission
        return const Loader();
      },
    );
  }
}
