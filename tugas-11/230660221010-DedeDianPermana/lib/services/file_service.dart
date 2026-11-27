import 'package:file_picker/file_picker.dart';

class FileTerpilih {
  final String nama;
  final int ukuran;

  FileTerpilih({
    required this.nama,
    required this.ukuran,
  });
}

class FileService {
  Future<FileTerpilih?> pilihFile() async {
    try {
      final file = await FilePicker.pickFile(
        type: FileType.any,
      );

      if (file == null) {
        return null;
      }

      final ukuran = file.lengthSync() ?? await file.length();

      return FileTerpilih(
        nama: file.name,
        ukuran: ukuran,
      );
    } catch (e) {
      throw Exception('Gagal memilih file: $e');
    }
  }
}
