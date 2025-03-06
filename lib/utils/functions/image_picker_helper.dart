import 'package:spam_delection_app/lib.dart';

class ImagePickerHelper {
  static final _picker = ImagePicker();

  static Future<XFile?> takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        return photo;
        debugPrint("Photo taken: ${photo.path}");
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Error taking photo: $e");
      return null;
    }
  }

  static Future<XFile?> chooseFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        debugPrint("Image selected: ${image.path}");
        return image;
      } else {
        debugPrint("No image selected.");
        return null;
      }
      // Handle the selected image
    } catch (e) {
      debugPrint("Error selecting image: $e");
      return null;
    }
  }
}
