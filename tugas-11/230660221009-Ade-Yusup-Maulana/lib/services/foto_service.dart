
import 'package:image_picker/image_picker.dart';

class FotoService {
  final ImagePicker _picker = ImagePicker();

  // Mengambil foto menggunakan kamera
  Future<XFile?> ambilFotoDariKamera() async {
    return await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1600,
      imageQuality: 80,
    );
  }

  // Memilih foto dari galeri
  Future<XFile?> pilihFotoDariGaleri() async {
    return await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
      imageQuality: 80,
    );
  }
}
