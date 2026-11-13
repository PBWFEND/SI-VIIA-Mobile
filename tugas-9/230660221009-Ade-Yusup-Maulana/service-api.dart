
import 'dart:convert';
import 'package:http/http.dart' as http;

// ============================================================
// MODEL DATA API
// ============================================================

class BarangApi {
  final int id;
  final int userId;
  final String nama;
  final String deskripsi;

  BarangApi({
    required this.id,
    required this.userId,
    required this.nama,
    required this.deskripsi,
  });

  // Mengubah JSON menjadi objek BarangApi
  factory BarangApi.fromJson(Map<String, dynamic> json) {
    return BarangApi(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      nama: json['title'] ?? '',
      deskripsi: json['body'] ?? '',
    );
  }

  // Mengubah objek BarangApi menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': nama,
      'body': deskripsi,
    };
  }
}

// ============================================================
// SERVICE API
// ============================================================

class ServiceApi {
  // URL API YANG BENAR
  static const String baseUrl =
      'https://jsonplaceholder.typicode.com/posts';

  // ==========================================================
  // GET: Mengambil daftar data dari API
  // ==========================================================

  Future<List<BarangApi>> ambilDataBarang() async {
    try {
      final response = await http
          .get(Uri.parse(baseUrl))
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final List<dynamic> data =
            jsonDecode(response.body);

        return data
            .map(
              (item) => BarangApi.fromJson(
                item as Map<String, dynamic>,
              ),
            )
            .toList();
      } else {
        throw Exception(
          'Gagal mengambil data. Kode: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception(
        'Terjadi kesalahan saat mengambil data: $e',
      );
    }
  }

  // ==========================================================
  // POST: Mengirim data baru ke API
  // ==========================================================

  Future<BarangApi> tambahDataBarang({
    required String nama,
    required String deskripsi,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse(baseUrl),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'userId': 1,
              'title': nama,
              'body': deskripsi,
            }),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 201) {
        final Map<String, dynamic> data =
            jsonDecode(response.body);

        return BarangApi.fromJson(data);
      } else {
        throw Exception(
          'Gagal menambahkan data. Kode: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception(
        'Terjadi kesalahan saat mengirim data: $e',
      );
    }
  }
}
