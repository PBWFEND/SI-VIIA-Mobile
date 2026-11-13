// ============================================================================
// PAB — Tugas 9: Implementasi Konsumsi REST API
// Berkas: service-api.dart — model data + lapisan service (tanpa widget)
// Domain project: Glazent.pro (usaha jasa glass cleaning & nanocoating)
// ============================================================================
//
// Bantuan: Claude — menyusun kerangka model, service GET/POST, dan penanganan
// error mengikuti pola demo-rest-api-flutter.dart, dengan data dan konteks
// disesuaikan ke domain Glazent.pro (melanjutkan Tugas 7: model pesanan).
//
// Seluruh kode jaringan (http.get / http.post) berada di berkas ini, bukan di
// widget. Antarmuka ada di halaman-api.dart.
//
// Endpoint (API tiruan publik, aman untuk latihan):
//   GET  https://jsonplaceholder.typicode.com/posts?_limit=8
//   POST https://jsonplaceholder.typicode.com/posts
//
// Catatan: jsonplaceholder tidak benar-benar menyimpan data. Response POST
// hanya memantulkan data yang dikirim ditambah id baru (101), sehingga pesanan
// baru tidak muncul pada daftar GET berikutnya.
// ============================================================================

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

/// Kegagalan komunikasi dengan server, dengan pesan yang siap ditampilkan
/// kepada pengguna. Kelas terpisah dipakai agar pesan tidak terbungkus
/// berulang kali (mis. "Exception: Gagal: Exception: ...").
class ApiException implements Exception {
  const ApiException(this.pesan);

  final String pesan;

  @override
  String toString() => pesan;
}

/// Model data — satu pesanan layanan Glazent.pro dari server.
///
/// API tiruan hanya memiliki field `title` dan `body`, sehingga:
///   - `layanan`    <- `title` (jenis layanan)
///   - `keterangan` <- `body`  (alamat dan tanggal digabung)
///   - `status`     <- `status` (bernilai 'menunggu' bila server tidak
///                     mengirimkannya)
///
/// Contoh JSON:
///   {"userId": 1, "id": 1, "title": "Cleaning Kaca Rumah",
///    "body": "Jl. Merdeka No. 10 — Senin, 2 Nov", "status": "menunggu"}
class DataPesanan {
  const DataPesanan({
    required this.id,
    required this.layanan,
    required this.keterangan,
    required this.status,
  });

  final int id;
  final String layanan;
  final String keterangan;
  final String status;

  /// Mengubah Map hasil jsonDecode menjadi objek DataPesanan. Nilai default
  /// (`??`) dipakai bila field tidak ada, sehingga aplikasi tidak error saat
  /// struktur JSON tidak lengkap.
  factory DataPesanan.fromJson(Map<String, dynamic> json) {
    return DataPesanan(
      id: json['id'] as int? ?? 0,
      layanan: json['title'] as String? ?? 'Tanpa Nama Layanan',
      keterangan: json['body'] as String? ?? '-',
      status: json['status'] as String? ?? 'menunggu',
    );
  }

  /// Mengubah objek menjadi Map untuk dikirim sebagai body JSON (POST).
  Map<String, dynamic> toJson() {
    return {
      'title': layanan,
      'body': keterangan,
      'status': status,
      'userId': 1,
    };
  }
}

/// Lapisan service — mengisolasi seluruh interaksi HTTP pada satu tempat,
/// sehingga widget hanya mengurus tampilan, bukan URL dan parsing JSON.
class PesananService {
  /// Alamat dasar API. Untuk membuat screenshot-error, ubah sementara menjadi
  /// 'https://jsonplaceholder.typicode.com/salah', jalankan ulang, lalu
  /// kembalikan seperti semula.
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  /// Batas waktu tunggu setiap pemanggilan HTTP.
  static const Duration _timeout = Duration(seconds: 10);

  /// Jeda buatan sebelum GET, hanya untuk pengujian. Nilai 2 detik membuat
  /// indikator loading sempat terlihat dan mudah di-screenshot. Untuk
  /// pemakaian normal, ubah kembali menjadi Duration.zero.
  static const Duration jedaUji = Duration(seconds: 2);

  /// GET — mengambil daftar pesanan dari server.
  static Future<List<DataPesanan>> ambilDaftar() async {
    try {
      final url = Uri.parse('$_baseUrl/posts?_limit=8');
      await Future<void>.delayed(jedaUji);
      final response = await http.get(url).timeout(_timeout);

      if (response.statusCode == 200) {
        final List<dynamic> dataMentah =
            jsonDecode(response.body) as List<dynamic>;
        return dataMentah
            .map((item) => DataPesanan.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      throw ApiException(_pesanStatus(response.statusCode));
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw const ApiException(
        'Waktu tunggu habis. Periksa koneksi internet Anda.',
      );
    } on http.ClientException {
      throw const ApiException(
        'Tidak dapat terhubung ke server. Periksa koneksi internet Anda.',
      );
    } on FormatException {
      throw const ApiException('Format data dari server tidak dikenali.');
    } catch (e) {
      throw ApiException('Terjadi kesalahan tak terduga: $e');
    }
  }

  /// POST — mengirim pesanan baru ke server. Alamat dan tanggal digabung
  /// menjadi satu field `keterangan` (lihat catatan pada kelas DataPesanan).
  static Future<DataPesanan> kirimPesanan({
    required String layanan,
    required String alamat,
    required String tanggal,
  }) async {
    final dataBaru = DataPesanan(
      id: 0,
      layanan: layanan,
      keterangan: '$alamat — $tanggal',
      status: 'menunggu',
    );

    try {
      final url = Uri.parse('$_baseUrl/posts');
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode(dataBaru.toJson()),
          )
          .timeout(_timeout);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> jsonItem =
            jsonDecode(response.body) as Map<String, dynamic>;
        return DataPesanan.fromJson(jsonItem);
      }
      throw ApiException(_pesanStatus(response.statusCode));
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw const ApiException(
        'Waktu tunggu habis saat mengirim pesanan. Coba lagi.',
      );
    } on http.ClientException {
      throw const ApiException(
        'Tidak dapat terhubung ke server. Pesanan belum terkirim.',
      );
    } on FormatException {
      throw const ApiException('Format balasan server tidak dikenali.');
    } catch (e) {
      throw ApiException('Terjadi kesalahan tak terduga: $e');
    }
  }

  /// Menerjemahkan status code HTTP menjadi pesan yang mudah dipahami.
  static String _pesanStatus(int kode) {
    if (kode == 400) return 'Data yang dikirim tidak valid (HTTP 400).';
    if (kode == 404) return 'Data tidak ditemukan di server (HTTP 404).';
    if (kode >= 500) {
      return 'Server sedang bermasalah (HTTP $kode). Coba lagi nanti.';
    }
    return 'Permintaan ditolak server (HTTP $kode).';
  }
}
