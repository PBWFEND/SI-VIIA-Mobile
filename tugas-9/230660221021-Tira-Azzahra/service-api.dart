import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// ============================================
/// MODEL DATA — SI Perpustakaan Kampus
/// Tira Azzahra | 230660221021 | SI-VIIA
/// ============================================

/// Model untuk data yang DITERIMA dari server (GET)
class PengajuanPinjam {
  final int id;
  final int idPemohon;
  final String judulBuku;
  final String catatan;

  const PengajuanPinjam({
    required this.id,
    required this.idPemohon,
    required this.judulBuku,
    required this.catatan,
  });

  /// fromJson dengan penanganan null yang aman (??)
  factory PengajuanPinjam.fromJson(Map<String, dynamic> json) {
    return PengajuanPinjam(
      id: json['id'] as int? ?? 0,
      idPemohon: json['userId'] as int? ?? 0,
      judulBuku: json['title'] as String? ?? 'Tanpa Judul',
      catatan: json['body'] as String? ?? '-',
    );
  }
}

/// Model untuk data yang DIKIRIM ke server (POST)
class PengajuanBaru {
  final int idPemohon;
  final String judulBuku;
  final String catatan;

  const PengajuanBaru({
    required this.idPemohon,
    required this.judulBuku,
    required this.catatan,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': idPemohon,
      'title': judulBuku,
      'body': catatan,
    };
  }
}

/// ============================================
/// SERVICE LAYER — Semua logika HTTP di sini,
/// terpisah dari widget UI
/// ============================================
class PerpustakaanApiService {
  // ⚠️ UNTUK SCREENSHOT ERROR:
  // ubah '/posts' menjadi '/postssalah', save, lalu hot restart (R).
  // Setelah itu KEMBALIKAN lagi ke '/posts'.
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/postssalah';
  static const Duration _timeout = Duration(seconds: 10);

  /// GET — ambil daftar pengajuan peminjaman
  static Future<List<PengajuanPinjam>> ambilDaftarPengajuan() async {
    try {
      final url = Uri.parse('$_baseUrl?_limit=10');
      final response = await http.get(url).timeout(_timeout);

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        return body
            .map((item) => PengajuanPinjam.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Server error: HTTP ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Waktu tunggu habis (timeout). Periksa koneksi internet.');
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Gagal menghubungi server: $e');
    }
  }

  /// POST — kirim pengajuan baru
  static Future<PengajuanPinjam> kirimPengajuan(PengajuanBaru dataBaru) async {
    try {
      final url = Uri.parse(_baseUrl);
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode(dataBaru.toJson()),
          )
          .timeout(_timeout);

      if (response.statusCode == 201) {
        return PengajuanPinjam.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      } else {
        throw Exception('Gagal mengirim data: HTTP ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Waktu tunggu habis saat mengirim data.');
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Gagal mengirim pengajuan: $e');
    }
  }
}