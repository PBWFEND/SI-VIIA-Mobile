import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/data_pengajuan.dart';
import '../models/data_pengguna.dart';
import '../models/pengajuan_terintegrasi.dart';

class IntegrasiApiException implements Exception {
  final String message;
  final int? statusCode;

  const IntegrasiApiException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class IntegrasiService {
  final http.Client _client;
  final String baseUrl;
  static const _timeout = Duration(seconds: 10);

  IntegrasiService({
    http.Client? client,
    this.baseUrl = 'https://jsonplaceholder.typicode.com',
  }) : _client = client ?? http.Client();

  Future<List<DataPengguna>> ambilPengguna() async {
    try {
      final response = await _client
          .get(Uri.parse(baseUrl + '/users?_limit=8'))
          .timeout(_timeout);
      _pastikanBerhasil(response, 'pengguna');
      return _decodeList(response.body, DataPengguna.fromJson);
    } on IntegrasiApiException {
      rethrow;
    } on TimeoutException {
      throw const IntegrasiApiException(
        'Request pengguna melewati batas waktu 10 detik.',
      );
    } on FormatException {
      throw const IntegrasiApiException('JSON pengguna tidak valid.');
    } catch (error) {
      throw IntegrasiApiException(
        'Gagal mengambil data pengguna: ' + error.toString(),
      );
    }
  }

  Future<List<DataPengajuan>> ambilPengajuan() async {
    try {
      final response = await _client
          .get(Uri.parse(baseUrl + '/posts?_limit=8'))
          .timeout(_timeout);
      _pastikanBerhasil(response, 'pengajuan');
      return _decodeList(response.body, DataPengajuan.fromJson);
    } on IntegrasiApiException {
      rethrow;
    } on TimeoutException {
      throw const IntegrasiApiException(
        'Request pengajuan melewati batas waktu 10 detik.',
      );
    } on FormatException {
      throw const IntegrasiApiException('JSON pengajuan tidak valid.');
    } catch (error) {
      throw IntegrasiApiException(
        'Gagal mengambil data pengajuan: ' + error.toString(),
      );
    }
  }

  Future<List<PengajuanTerintegrasi>> ambilDataTerintegrasi() async {
    final hasil = await Future.wait<dynamic>([
      ambilPengguna(),
      ambilPengajuan(),
    ]);

    final pengguna = hasil[0] as List<DataPengguna>;
    final pengajuan = hasil[1] as List<DataPengajuan>;
    final penggunaById = <int, DataPengguna>{
      for (final item in pengguna) item.id: item,
    };

    return pengajuan
        .map(
          (item) => PengajuanTerintegrasi(
            pengajuan: item,
            pemohon: penggunaById[item.userId],
          ),
        )
        .toList();
  }

  List<T> _decodeList<T>(
    String body,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final decoded = jsonDecode(body);
    if (decoded is! List) {
      throw const IntegrasiApiException('Respons API tidak berupa array JSON.');
    }
    return decoded.whereType<Map<String, dynamic>>().map(fromJson).toList();
  }

  void _pastikanBerhasil(http.Response response, String sumber) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw IntegrasiApiException(
        'Request ' +
            sumber +
            ' gagal dengan HTTP ' +
            response.statusCode.toString() +
            '.',
        statusCode: response.statusCode,
      );
    }
  }

  void dispose() => _client.close();
}
