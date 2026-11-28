import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

import '../models/berkas_perpustakaan_model.dart';

/// Exception khusus ketika izin akses penyimpanan/file ditolak oleh sistem atau pengguna
class PermissionBerkasException implements Exception {
  final String pesan;
  const PermissionBerkasException(this.pesan);

  @override
  String toString() => pesan;
}

class BerkasPerangkatService {
  static const List<String> ekstensiDiizinkan = ['pdf', 'jpg', 'jpeg', 'png'];
  static const int batasMaksimalBytes = 5 * 1024 * 1024; // 5 MB

  /// Mengambil berkas dokumen perpustakaan dari penyimpanan perangkat.
  /// Mengembalikan [BerkasPerpustakaanModel] jika berhasil,
  /// atau `null` apabila pengguna membatalkan dialog pemilihan file.
  Future<BerkasPerpustakaanModel?> pilihBerkasPerpustakaan({
    bool simulasiPermissionDitolak = false,
    bool simulasiErrorPerangkat = false,
  }) async {
    // Simulasi skenario pengujian Permission Ditolak
    if (simulasiPermissionDitolak) {
      await Future.delayed(const Duration(milliseconds: 500));
      throw const PermissionBerkasException(
        'Izin akses penyimpanan perangkat ditolak (Permission Denied). '
        'Aktifkan izin akses file pada pengaturan browser atau perangkat Anda.',
      );
    }

    // Simulasi skenario pengujian Error Perangkat / Package
    if (simulasiErrorPerangkat) {
      await Future.delayed(const Duration(milliseconds: 500));
      throw Exception(
        'Gagal mengakses sistem berkas perangkat (Platform/Storage I/O Error).',
      );
    }

    try {
      final FilePickerResult? hasil = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ekstensiDiizinkan,
        withData: true, // Wajib true agar bytes tersedia pada target Web
      );

      // Pengguna menutup dialog tanpa memilih file -> dianggap batal (bukan error)
      if (hasil == null || hasil.files.isEmpty) {
        return null;
      }

      final PlatformFile fileTerpilih = hasil.files.first;

      if (fileTerpilih.size > batasMaksimalBytes) {
        throw Exception(
          'Ukuran berkas (${(fileTerpilih.size / (1024 * 1024)).toStringAsFixed(2)} MB) '
          'melebihi batas maksimal 5 MB.',
        );
      }

      return BerkasPerpustakaanModel(
        namaFile: fileTerpilih.name,
        ekstensi: (fileTerpilih.extension ?? 'unknown').toUpperCase(),
        ukuranBytes: fileTerpilih.size,
        waktuDipilih: DateTime.now(),
        bytes: fileTerpilih.bytes,
      );
    } on PlatformException catch (e) {
      if (e.code.toLowerCase().contains('permission') ||
          e.code.toLowerCase().contains('denied')) {
        throw const PermissionBerkasException(
          'Izin akses berkas ditolak oleh sistem operasi. '
          'Berikan izin penyimpanan lalu coba kembali.',
        );
      }
      throw Exception('Kesalahan platform perangkat: ${e.message ?? e.code}');
    } catch (e) {
      if (e is PermissionBerkasException) rethrow;
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}