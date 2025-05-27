import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<XFile?> _pickImage(ImageSource source) async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        debugPrint("Image picked from $source: ${pickedFile.path}");
        return pickedFile;
      } else {
        debugPrint("No image selected from $source.");
        return null;
      }
    } catch (e) {
      debugPrint("Error picking image from $source: $e");
      return null;
    }
  }

  static Future<XFile?> takePhoto() async {
    return _pickImage(ImageSource.camera);
  }

  static Future<XFile?> chooseFromGallery() async {
    return _pickImage(ImageSource.gallery);
  }
}
