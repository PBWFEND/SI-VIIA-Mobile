import 'dart:convert';
import 'package:http/http.dart' as http;

// =============================================================================
// 1. MODEL DATA
// =============================================================================
class MenuKantin {
  final String id;
  final String namaMenu;
  final int harga;

  MenuKantin({
    required this.id,
    required this.namaMenu,
    required this.harga,
  });

  factory MenuKantin.fromJson(Map<String, dynamic> json) {
    return MenuKantin(
      id: json['id'].toString(),
      namaMenu: (json['title'] ?? 'Menu Kantin').toString().toUpperCase(),
      harga: (int.tryParse(json['id'].toString()) ?? 1) * 1000 + 10000,
    );
  }
}

// =============================================================================
// 2. CLASS SERVICE REST API
// =============================================================================
class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/posts?_limit=10';
  static const String postUrl = 'https://jsonplaceholder.typicode.com/posts';

  // Method GET: Mengambil daftar menu kantin
  Future<List<MenuKantin>> fetchMenu() async {
    try {
      final response = await http.get(Uri.parse(baseUrl)).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Koneksi timeout (lebih dari 10 detik).'),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => MenuKantin.fromJson(item)).toList();
      } else {
        throw Exception('Gagal memuat data (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan jaringan: $e');
    }
  }

  // Method POST: Mengirim data menu baru ke server
  Future<MenuKantin> tambahMenu(String nama, int harga) async {
    try {
      final response = await http.post(
        Uri.parse(postUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"title": nama, "harga": harga}),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Koneksi timeout.'),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return MenuKantin(
          id: data['id'].toString(),
          namaMenu: nama.toUpperCase(),
          harga: harga,
        );
      } else {
        throw Exception('Gagal menambah data (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan jaringan: $e');
    }
  }
}