import 'package:image_picker/image_picker.dart';

class CameraService {
  final ImagePicker _picker;
  CameraService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  Future<XFile?> takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      return photo;
    } catch (e) {
      throw Exception('Gagal mengakses kamera: $e');
    }
  }

  Future<XFile?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      return image;
    } catch (e) {
      throw Exception('Gagal memilih gambar dari galeri: $e');
    }
  }
}
