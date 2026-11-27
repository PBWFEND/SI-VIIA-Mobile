import 'dart:async';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

enum StatusHasilFoto {
  berhasil,
  dibatalkan,
  permissionDitolak,
  error,
}

class HasilLampiranFoto {
  const HasilLampiranFoto({
    required this.status,
    this.file,
    this.pesan,
    this.ukuranKb,
  });

  final StatusHasilFoto status;
  final XFile? file;
  final String? pesan;
  final double? ukuranKb;
}

class FotoPresensiService {
  FotoPresensiService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;
  static const int _maksUkuranBytes = 5 * 1024 * 1024; // 5 MB
  static const List<String> _ekstensiDiizinkan = [
    '.jpg',
    '.jpeg',
    '.png',
    '.webp',
  ];

  Future<HasilLampiranFoto> ambilLampiran({
    required ImageSource sumber,
  }) async {
    try {
      final XFile? berkas = await _picker.pickImage(
        source: sumber,
        maxWidth: 1600,
        imageQuality: 80,
      );

      if (berkas == null) {
        return const HasilLampiranFoto(
          status: StatusHasilFoto.dibatalkan,
          pesan: 'Pemilihan foto dibatalkan. Lampiran sebelumnya tetap dipertahankan.',
        );
      }

      final String namaLower = berkas.name.toLowerCase();
      final bool formatValid =
          _ekstensiDiizinkan.any((ext) => namaLower.endsWith(ext)) ||
              (berkas.mimeType?.startsWith('image/') ?? false);

      if (!formatValid && namaLower.contains('.')) {
        return const HasilLampiranFoto(
          status: StatusHasilFoto.error,
          pesan: 'Format file tidak didukung. Gunakan JPG, JPEG, PNG, atau WEBP.',
        );
      }

      final int ukuranBytes = await berkas.length();
      if (ukuranBytes > _maksUkuranBytes) {
        return const HasilLampiranFoto(
          status: StatusHasilFoto.error,
          pesan: 'Ukuran foto melebihi batas maksimal 5 MB.',
        );
      }

      final double ukuranKb = ukuranBytes / 1024;
      return HasilLampiranFoto(
        status: StatusHasilFoto.berhasil,
        file: berkas,
        ukuranKb: ukuranKb,
        pesan: 'Lampiran foto berhasil dimuat.',
      );
    } on PlatformException catch (e) {
      final String kode = e.code.toLowerCase();
      if (kode.contains('denied') ||
          kode.contains('permission') ||
          kode.contains('restricted')) {
        return const HasilLampiranFoto(
          status: StatusHasilFoto.permissionDitolak,
          pesan:
              'Akses kamera atau galeri ditolak atau diblokir oleh sistem. Periksa izin aplikasi pada pengaturan perangkat/browser lalu coba lagi.',
        );
      }
      return HasilLampiranFoto(
        status: StatusHasilFoto.error,
        pesan: 'Fitur perangkat tidak tersedia atau gagal diakses (${e.code}).',
      );
    } on UnsupportedError {
      return const HasilLampiranFoto(
        status: StatusHasilFoto.error,
        pesan:
            'Sumber foto ini tidak didukung pada target platform saat ini. Coba gunakan opsi lain atau perangkat fisik.',
      );
    } catch (_) {
      return const HasilLampiranFoto(
        status: StatusHasilFoto.error,
        pesan: 'Terjadi gangguan saat memproses lampiran foto. Silakan coba lagi.',
      );
    }
  }
}