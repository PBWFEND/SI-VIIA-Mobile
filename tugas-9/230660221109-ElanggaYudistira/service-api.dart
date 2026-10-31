import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class TransaksiApi {
  final int id;
  final String nama;
  final int jumlah;
  final String jenis;
  final String kategori;
  final String tanggal;
  final String catatan;

  const TransaksiApi({
    required this.id,
    required this.nama,
    required this.jumlah,
    required this.jenis,
    required this.kategori,
    required this.tanggal,
    required this.catatan,
  });

  factory TransaksiApi.fromJson(Map<String, dynamic> json) {
    final userId = (json['userId'] as num?)?.toInt() ?? 1;
    final nominal = (json['amount'] as num?)?.toInt() ?? userId * 10000;
    final jenisApi = (json['type'] as String?)?.trim();

    return TransaksiApi(
      id: (json['id'] as num?)?.toInt() ?? 0,
      nama: (json['title'] as String?)?.trim() ?? 'Transaksi tanpa nama',
      jumlah: nominal,
      jenis: jenisApi?.isNotEmpty == true
          ? jenisApi!
          : userId.isEven
          ? 'Pemasukan'
          : 'Pengeluaran',
      kategori: (json['category'] as String?)?.trim() ?? 'API Demo',
      tanggal: (json['date'] as String?)?.trim() ?? 'Data dari REST API',
      catatan: (json['body'] as String?)?.trim() ?? 'Catatan tidak tersedia',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': nama,
      'amount': jumlah,
      'type': jenis,
      'category': kategori,
      'date': tanggal,
      'body': catatan,
    };
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class TransaksiApiService {
  final http.Client _client;
  final String baseUrl;
  static const _timeout = Duration(seconds: 10);

  TransaksiApiService({
    http.Client? client,
    this.baseUrl = 'https://jsonplaceholder.typicode.com/posts',
  }) : _client = client ?? http.Client();

  Future<List<TransaksiApi>> ambilTransaksi() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 900));
      final response = await _client
          .get(Uri.parse(baseUrl + '?_limit=8'))
          .timeout(_timeout);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiException(
          'GET gagal dengan status HTTP ' +
              response.statusCode.toString() +
              '.',
          statusCode: response.statusCode,
        );
      }

      final decoded = jsonDecode(response.body);
      if (decoded is! List) {
        throw const ApiException(
          'Format respons GET tidak berupa daftar data.',
        );
      }

      return decoded
          .whereType<Map<String, dynamic>>()
          .map(TransaksiApi.fromJson)
          .toList();
    } on TimeoutException {
      throw const ApiException('Permintaan GET melewati batas waktu 10 detik.');
    } on FormatException {
      throw const ApiException('Respons GET bukan JSON yang valid.');
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(
        'Tidak dapat mengambil data transaksi: ' + error.toString(),
      );
    }
  }

  Future<TransaksiApi> tambahTransaksi({
    required String nama,
    required int jumlah,
    required String jenis,
    required String kategori,
    required String catatan,
  }) async {
    try {
      final response = await _client
          .post(
            Uri.parse(baseUrl),
            headers: const {'Content-Type': 'application/json'},
            body: jsonEncode({
              'title': nama,
              'amount': jumlah,
              'type': jenis,
              'category': kategori,
              'body': catatan,
              'userId': 1,
            }),
          )
          .timeout(_timeout);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiException(
          'POST gagal dengan status HTTP ' +
              response.statusCode.toString() +
              '.',
          statusCode: response.statusCode,
        );
      }

      final decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) {
        throw const ApiException('Format respons POST tidak valid.');
      }

      return TransaksiApi.fromJson(decoded);
    } on TimeoutException {
      throw const ApiException(
        'Pengiriman POST melewati batas waktu 10 detik.',
      );
    } on FormatException {
      throw const ApiException('Respons POST bukan JSON yang valid.');
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException('Tidak dapat mengirim transaksi: ' + error.toString());
    }
  }

  void dispose() => _client.close();
}
