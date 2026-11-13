import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ============================================================================
// 1. MODEL DATA BUKU (SERIALISASI & DESERIALISASI JSON)
// ============================================================================
class BukuApi {
  final int id;
  final String judul;
  final String penulis;
  final String kategori;
  final String status;

  const BukuApi({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.kategori,
    required this.status,
  });

  /// Factory constructor fromJson dengan penanganan null safety (??)
  factory BukuApi.fromJson(Map<String, dynamic> json) {
    final int parsedId = json['id'] as int? ?? 0;

    // Pemetaan judul katalog perpustakaan untuk simulasi mock API JSONPlaceholder
    const daftarJudulKatalog = [
      'Analisis dan Perancangan Sistem Informasi',
      'Object-Oriented Programming in C++',
      'Pengantar Psikologi Umum',
      'Metode Penelitian Kualitatif',
      'Dasar Sistem Informasi',
      'Manajemen Basis Data',
      'Algoritma dan Pemrograman',
      'Rekayasa Perangkat Lunak',
      'Jaringan Komputer Lanjut',
      'Interaksi Manusia dan Komputer',
    ];

    final String judulFallback = (parsedId >= 1 && parsedId <= daftarJudulKatalog.length)
        ? daftarJudulKatalog[parsedId - 1]
        : (json['title'] as String? ?? 'Tanpa Judul');

    return BukuApi(
      id: parsedId,
      judul: json['judul'] as String? ?? judulFallback,
      penulis: json['penulis'] as String? ?? 'Penulis Kampus #${json['userId'] ?? 1}',
      kategori: json['kategori'] as String? ??
          ((parsedId % 2 == 0) ? 'Sistem Informasi' : 'Informatika'),
      status: json['status'] as String? ??
          ((parsedId % 3 == 0) ? 'Sedang Dipinjam' : 'Tersedia'),
    );
  }

  /// Konversi objek BukuApi menjadi Map JSON untuk dikirim melalui POST
  Map<String, dynamic> toJson() {
    return {
      'title': judul,
      'judul': judul,
      'penulis': penulis,
      'kategori': kategori,
      'status': status,
      'userId': 1,
    };
  }
}

// ============================================================================
// 2. LAPISAN SERVICE REST API (TERPISAH DARI WIDGET UI)
// ============================================================================
class PerpustakaanApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  static const String _invalidUrl = 'https://jsonplaceholder.typicode.com/posts-salah-endpoint';
  static const Duration _timeoutDuration = Duration(seconds: 10);

  /// HTTP GET: Mengambil daftar koleksi buku dari endpoint REST API
  Future<List<BukuApi>> ambilDaftarBuku({bool simulasiError = false}) async {
    final Uri url = Uri.parse(simulasiError ? _invalidUrl : _baseUrl);

    try {
      final response = await http.get(url).timeout(_timeoutDuration);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
        return jsonList
            .take(10)
            .map((item) => BukuApi.fromJson(item as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 404) {
        throw Exception('Endpoint katalog buku tidak ditemukan (HTTP 404).');
      } else {
        throw Exception('Gagal memuat katalog buku (HTTP ${response.statusCode}).');
      }
    } on TimeoutException {
      throw Exception('Waktu tunggu habis (Timeout 10 detik). Periksa koneksi internet Anda.');
    } on http.ClientException {
      throw Exception('Gagal terhubung ke server perpustakaan. Pastikan jaringan aktif.');
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  /// HTTP POST: Mengirim data buku baru ke server dengan header JSON
  Future<BukuApi> kirimBukuBaru(BukuApi bukuBaru) async {
    final Uri url = Uri.parse(_baseUrl);

    try {
      final response = await http
          .post(
            url,
            headers: const {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(bukuBaru.toJson()),
          )
          .timeout(_timeoutDuration);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
            jsonDecode(response.body) as Map<String, dynamic>;

        return BukuApi(
          id: jsonResponse['id'] as int? ?? DateTime.now().millisecondsSinceEpoch,
          judul: bukuBaru.judul,
          penulis: bukuBaru.penulis,
          kategori: bukuBaru.kategori,
          status: bukuBaru.status,
        );
      } else {
        throw Exception('Server menolak penambahan data (HTTP ${response.statusCode}).');
      }
    } on TimeoutException {
      throw Exception('Pengiriman data melebihi batas waktu (Timeout 10 detik).');
    } on http.ClientException {
      throw Exception('Koneksi jaringan terputus saat mengirim data ke server.');
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}