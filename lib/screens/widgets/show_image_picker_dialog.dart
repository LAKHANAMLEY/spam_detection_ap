import 'package:spam_delection_app/lib.dart'; // Assuming lib.dart contains necessary imports like ImagePickerHelper, SelectionBloc, and SelectFileEvent

Future<void> showImagePickerDialog(
  BuildContext context,
  SelectionBloc selectImageBloc,
) async {
  await showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (BuildContext context) {
      final localizations = appLocalization(context);
      final textTheme = Theme.of(context).textTheme;

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              localizations.chooseOption,
              style: textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            _buildImageOptionTile(
              icon: Icons.camera_alt,
              color: Colors.blue,
              text: localizations.takePhoto,
              onTap: () async {
                final file = await ImagePickerHelper.takePhoto();
                if (file != null) {
                  selectImageBloc.add(SelectFileEvent(file));
                }
                Navigator.pop(context);
              },
            ),
            _buildImageOptionTile(
              icon: Icons.photo_library,
              color: Colors.green,
              text: localizations.chooseGallery,
              onTap: () async {
                final file = await ImagePickerHelper.chooseFromGallery();
                if (file != null) {
                  selectImageBloc.add(SelectFileEvent(file));
                }
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                localizations.cancelText,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildImageOptionTile({
  required IconData icon,
  required Color color,
  required String text,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(text),
    onTap: onTap,
  );
}
