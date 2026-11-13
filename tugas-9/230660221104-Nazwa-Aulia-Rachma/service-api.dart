import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiException implements Exception {
  const ApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

class BukuApi {
  const BukuApi({
    required this.id,
    required this.judul,
    required this.kategori,
    required this.stok,
    required this.status,
  });

  final int id;
  final String judul;
  final String kategori;
  final int stok;
  final String status;

  factory BukuApi.fromJson(Map<String, dynamic> json) {
    final stok = (json['stock'] as num?)?.toInt() ?? 0;
    return BukuApi(
      id: (json['id'] as num?)?.toInt() ?? 0,
      judul: json['title'] as String? ?? 'Judul tidak tersedia',
      kategori: json['category'] as String? ?? 'Umum',
      stok: stok,
      status: stok > 0 ? 'Tersedia' : 'Tidak tersedia',
    );
  }

  @override
  String toString() {
    return 'BukuApi(id: $id, judul: $judul, kategori: $kategori, status: $status)';
  }
}

class BukuApiService {
  BukuApiService({this.baseUrl = 'https://dummyjson.com/products'});

  final String baseUrl;
  static const _timeout = Duration(seconds: 10);

  Future<List<BukuApi>> fetchBuku() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl?limit=8'))
          .timeout(_timeout);

      if (response.statusCode != 200) {
        throw ApiException(
          'GET gagal (${response.statusCode}). Periksa endpoint API.',
        );
      }

      final decoded = jsonDecode(response.body) as Map<String, dynamic>;
      final rawProducts = decoded['products'] as List<dynamic>? ?? [];
      return rawProducts
          .whereType<Map<String, dynamic>>()
          .map(BukuApi.fromJson)
          .toList();
    } on TimeoutException {
      throw const ApiException(
        'Permintaan terlalu lama. Periksa koneksi internet lalu coba lagi.',
      );
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException('Gagal memuat katalog: $error');
    }
  }

  Future<BukuApi> createBuku({
    required String judul,
    required String kategori,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('https://dummyjson.com/products/add'),
            headers: const {'Content-Type': 'application/json'},
            body: jsonEncode({
              'title': judul,
              'category': kategori,
              'stock': 1,
            }),
          )
          .timeout(_timeout);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          'POST gagal (${response.statusCode}). Data belum tersimpan.',
        );
      }

      return BukuApi.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } on TimeoutException {
      throw const ApiException(
        'Pengiriman terlalu lama. Periksa koneksi internet lalu coba lagi.',
      );
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException('Gagal mengirim buku: $error');
    }
  }
}
