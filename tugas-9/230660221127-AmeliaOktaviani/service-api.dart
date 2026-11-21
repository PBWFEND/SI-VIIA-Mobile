
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

// Model data produk
class ProdukApi {
  final int id;
  final String nama;
  final double harga;
  final int stok;
  final String kategori;

  const ProdukApi({
    required this.id,
    required this.nama,
    required this.harga,
    required this.stok,
    required this.kategori,
  });

  // Mengubah JSON menjadi objek ProdukApi
  factory ProdukApi.fromJson(Map<String, dynamic> json) {
    return ProdukApi(
      id: int.tryParse('${json['id'] ?? 0}') ?? 0,
      nama: json['title']?.toString() ?? 'Produk tanpa nama',
      harga: double.tryParse('${json['price'] ?? 0}') ?? 0.0,
      stok: int.tryParse('${json['stock'] ?? 0}') ?? 0,
      kategori: json['category']?.toString() ?? 'Tidak diketahui',
    );
  }

  // Mengubah objek ProdukApi menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'title': nama,
      'price': harga,
      'stock': stok,
      'category': kategori,
    };
  }
}

// Service untuk komunikasi dengan REST API
class ProdukApiService {
  static const String baseUrl = 'https://dummyjson.com/products';

  // GET: Mengambil daftar produk
  Future<List<ProdukApi>> getProduk() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl?limit=10'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        throw Exception(
          'Gagal mengambil data. Status HTTP: ${response.statusCode}',
        );
      }

      final data = jsonDecode(response.body);

      if (data is! Map<String, dynamic>) {
        throw Exception('Format respons API tidak sesuai.');
      }

      final produkJson = data['products'];

      if (produkJson is! List) {
        throw Exception('Data produk tidak ditemukan.');
      }

      return produkJson.map((item) {
        if (item is! Map<String, dynamic>) {
          throw Exception('Format data produk tidak sesuai.');
        }

        return ProdukApi.fromJson(item);
      }).toList();
    } on TimeoutException {
      throw Exception('Permintaan GET timeout. Periksa koneksi internet.');
    } on FormatException {
      throw Exception('Format JSON dari API tidak valid.');
    } catch (e) {
      throw Exception(
        e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  // POST: Mengirim produk baru
  Future<ProdukApi> tambahProduk(ProdukApi produk) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/add'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(produk.toJson()),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200 &&
          response.statusCode != 201) {
        throw Exception(
          'Gagal menambahkan produk. Status HTTP: ${response.statusCode}',
        );
      }

      final data = jsonDecode(response.body);

      if (data is! Map<String, dynamic>) {
        throw Exception('Format respons POST tidak sesuai.');
      }

      return ProdukApi.fromJson(data);
    } on TimeoutException {
      throw Exception('Permintaan POST timeout. Periksa koneksi internet.');
    } on FormatException {
      throw Exception('Format JSON respons POST tidak valid.');
    } catch (e) {
      throw Exception(
        e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }
}
