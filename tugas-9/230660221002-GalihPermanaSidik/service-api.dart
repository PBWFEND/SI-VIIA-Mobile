import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

/// Kegagalan komunikasi dengan pesan yang siap ditampilkan kepada pengguna.
/// Service mengubah semua jenis error (timeout, koneksi, status code, JSON rusak)
/// menjadi satu tipe ini, sehingga halaman cukup menangkap ApiException.
class ApiException implements Exception {
  const ApiException(this.pesan);

  final String pesan;

  @override
  String toString() => pesan;
}

/// Model laporan hasil response server.
class Laporan {
  const Laporan({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.status,
  });

  final int id; // dibuat server
  final String judul; // JSON "title"
  final String deskripsi; // JSON "body"
  final String status; // JSON "status", default 'Menunggu'

  /// Mengubah Map hasil jsonDecode menjadi Laporan. Setiap field punya nilai
  /// pengganti agar response yang tidak lengkap tidak membuat aplikasi error.
  factory Laporan.fromJson(Map<String, dynamic> json) {
    return Laporan(
      id: json['id'] as int? ?? 0,
      judul: json['title'] as String? ?? 'Tanpa judul',
      deskripsi: json['body'] as String? ?? '-',
      status: json['status'] as String? ?? 'Menunggu',
    );
  }
}

/// Data laporan baru yang dikirim lewat POST. Belum punya id karena id dibuat server.
class LaporanBaru {
  const LaporanBaru({
    required this.kategori,
    required this.lokasi,
    required this.deskripsi,
  });

  final String kategori; // dari form
  final String lokasi; // dari form
  final String deskripsi; // dari form

  Map<String, dynamic> toJson() {
    return {
      'title': '$kategori di $lokasi',
      'body': deskripsi,
      'userId': 1, // pengganti identitas pelapor; autentikasi dibahas Pertemuan 12
      'status': 'Menunggu',
    };
  }
}

/// Lapisan service: satu-satunya tempat kode HTTP berada.
class LaporanService {
  static const String _host = 'jsonplaceholder.typicode.com';

  // Untuk screenshot-error: ubah menjadi '/postsx' (server membalas 404).
  static const String _endpoint = '/posts';

  static const Duration _batasWaktu = Duration(seconds: 10);

  // Alat bantu screenshot-loading: isi 3 agar indikator loading tampil 3 detik
  // dan sempat ditangkap. Kembalikan ke 0 sebelum mengumpulkan.
  static const int jedaSimulasiDetik = 0;

  /// GET: mengambil daftar laporan (maksimal 10 data, pagination di luar cakupan).
  static Future<List<Laporan>> ambilDaftar() {
    return _jalankan(() async {
      final uri = Uri.https(_host, _endpoint, {'_limit': '10'});
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw _kesalahanStatus(response.statusCode);
      }

      final data = jsonDecode(response.body);
      if (data is! List) {
        throw const ApiException('Format data dari server tidak sesuai.');
      }
      return data
          .map((item) => Laporan.fromJson(item as Map<String, dynamic>))
          .toList();
    });
  }

  /// POST: mengirim laporan baru. Server membalas 201 Created beserta data
  /// laporan yang sudah memiliki id.
  static Future<Laporan> kirim(LaporanBaru baru) {
    return _jalankan(() async {
      final uri = Uri.https(_host, _endpoint);
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(baru.toJson()),
      );

      if (response.statusCode != 201) {
        throw _kesalahanStatus(response.statusCode);
      }

      final data = jsonDecode(response.body);
      if (data is! Map<String, dynamic>) {
        throw const ApiException('Format balasan dari server tidak sesuai.');
      }
      return Laporan.fromJson(data);
    });
  }

  /// Membungkus setiap pemanggilan HTTP dengan timeout dan try-catch, sehingga
  /// tidak ada pemanggilan yang lolos tanpa penanganan error.
  static Future<T> _jalankan<T>(Future<T> Function() aksi) async {
    try {
      if (jedaSimulasiDetik > 0) {
        await Future.delayed(const Duration(seconds: jedaSimulasiDetik));
      }
      return await aksi().timeout(_batasWaktu);
    } on ApiException {
      rethrow; // sudah berpesan jelas, jangan dibungkus ulang
    } on TimeoutException {
      throw const ApiException(
        'Waktu tunggu habis. Periksa jaringan Anda, lalu coba lagi.',
      );
    } on http.ClientException {
      // Koneksi putus, tidak ada internet, atau alamat tidak dapat dijangkau.
      throw const ApiException(
        'Tidak dapat terhubung ke server. Pastikan perangkat terhubung ke internet.',
      );
    } on FormatException {
      throw const ApiException(
        'Data dari server tidak dapat dibaca (format JSON tidak valid).',
      );
    } catch (e) {
      throw ApiException('Terjadi kegagalan yang tidak terduga: $e');
    }
  }

  /// Menerjemahkan status code HTTP menjadi pesan untuk pengguna.
  static ApiException _kesalahanStatus(int kode) {
    if (kode == 400) {
      return const ApiException('Permintaan tidak valid (400). Periksa data yang dikirim.');
    }
    if (kode == 404) {
      return const ApiException('Data laporan tidak ditemukan di server (404). Periksa alamat endpoint.');
    }
    if (kode >= 500) {
      return ApiException('Server sedang bermasalah (kode $kode). Coba lagi beberapa saat lagi.');
    }
    return ApiException('Server mengembalikan kode yang tidak diharapkan: $kode.');
  }
}
