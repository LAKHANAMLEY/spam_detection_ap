import 'package:spam_delection_app/lib.dart';
import 'package:spam_delection_app/utils/image_picker_helper.dart';

Future<dynamic> showImagePickerDialog(
    BuildContext context, SelectionBloc selectImageBloc) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choose an option',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blue),
              title: const Text('Take a Photo'),
              onTap: () async {
                // Call your camera function here
                ImagePickerHelper.takePhoto().then((file) {
                  selectImageBloc.add(SelectFileEvent(file));
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.green),
              title: const Text('Choose from Gallery'),
              onTap: () async {
                ImagePickerHelper.chooseFromGallery().then((file) {
                  selectImageBloc.add(SelectFileEvent(file));
                  Navigator.pop(context);
                });
              },
            ),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );
    },
  );
}
