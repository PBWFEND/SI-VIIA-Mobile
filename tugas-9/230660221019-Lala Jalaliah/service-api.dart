
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

// ==================================================
// MODEL DATA SURAT MASUK
// ==================================================

class SuratMasuk {
  final int id;
  final String judul;
  final String pengirim;
  final String status;

  const SuratMasuk({
    required this.id,
    required this.judul,
    required this.pengirim,
    required this.status,
  });

  factory SuratMasuk.fromJson(Map<String, dynamic> json) {
    return SuratMasuk(
      id: json['id'] as int? ?? 0,
      judul: json['title'] as String? ?? 'Tanpa Judul',
      pengirim: json['body'] as String? ?? 'Tidak diketahui',
      status: json['status'] as String? ?? 'Belum diperiksa',
    );
  }
}

// ==================================================
// MODEL DATA SURAT BARU
// ==================================================

class SuratMasukBaru {
  final String judul;
  final String pengirim;

  const SuratMasukBaru({
    required this.judul,
    required this.pengirim,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': judul,
      'body': pengirim,
      'userId': 1,
    };
  }
}

// ==================================================
// SERVICE API
// ==================================================

class SuratApiService {
  static const String baseUrl =
      'https://jsonplaceholder.typicode.com';

  // GET: Mengambil daftar surat
  static Future<List<SuratMasuk>> ambilDaftarSurat() async {
    final url = Uri.parse('$baseUrl/posts');

    try {
      final response = await http
          .get(url)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data =
            jsonDecode(response.body) as List<dynamic>;

        return data
            .take(10)
            .map(
              (item) => SuratMasuk.fromJson(
                item as Map<String, dynamic>,
              ),
            )
            .toList();
      } else {
        throw Exception(
          'Gagal mengambil data. HTTP ${response.statusCode}',
        );
      }
    } on TimeoutException {
      throw Exception('Koneksi timeout. Silakan coba lagi.');
    } on FormatException {
      throw Exception('Format data dari server tidak sesuai.');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  // POST: Mengirim surat baru
  static Future<SuratMasuk> tambahSurat(
    SuratMasukBaru surat,
  ) async {
    final url = Uri.parse('$baseUrl/posts');

    try {
      final response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(surat.toJson()),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        final Map<String, dynamic> data =
            jsonDecode(response.body) as Map<String, dynamic>;

        return SuratMasuk.fromJson(data);
      } else {
        throw Exception(
          'Gagal mengirim surat. HTTP ${response.statusCode}',
        );
      }
    } on TimeoutException {
      throw Exception('Pengiriman timeout. Silakan coba lagi.');
    } on FormatException {
      throw Exception('Format response server tidak sesuai.');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
