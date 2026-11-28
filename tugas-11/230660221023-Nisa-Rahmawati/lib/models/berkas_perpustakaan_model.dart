import 'dart:typed_data';

class BerkasPerpustakaanModel {
  final String namaFile;
  final String ekstensi;
  final int ukuranBytes;
  final DateTime waktuDipilih;
  final Uint8List? bytes;

  const BerkasPerpustakaanModel({
    required this.namaFile,
    required this.ekstensi,
    required this.ukuranBytes,
    required this.waktuDipilih,
    this.bytes,
  });

  String get ukuranTerformat {
    if (ukuranBytes < 1024) return '$ukuranBytes B';
    if (ukuranBytes < 1024 * 1024) {
      return '${(ukuranBytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(ukuranBytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }

  bool get adalahGambar =>
      ['jpg', 'jpeg', 'png'].contains(ekstensi.toLowerCase());
}