import 'package:image_picker/image_picker.dart';

class AssetPickerService {
  static Future<XFile?> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      return image;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
