
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/data_pengguna.dart';
import '../models/data_pengajuan.dart';

class IntegrasiService {
  // URL API normal
  final String baseUrl =
      'https://jsonplaceholder.typicode.com';

  // Mengambil data pengguna dari API
  Future<List<DataPengguna>> ambilPengguna() async {
    final response = await http
        .get(Uri.parse('$baseUrl/users'))
        .timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data
          .map((item) => DataPengguna.fromJson(item))
          .toList();
    }

    throw Exception('Gagal mengambil data pengguna');
  }

  // Mengambil data pengajuan dari API
  Future<List<DataPengajuan>> ambilPengajuan() async {
    final response = await http
        .get(Uri.parse('$baseUrl/posts'))
        .timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data
          .map((item) => DataPengajuan.fromJson(item))
          .toList();
    }

    throw Exception('Gagal mengambil data pengajuan');
  }

  // Menggabungkan data pengguna dan pengajuan
  // berdasarkan userId menggunakan Future.wait
  Future<List<Map<String, dynamic>>> ambilDataTerintegrasi() async {
    final hasil = await Future.wait([
      ambilPengguna(),
      ambilPengajuan(),
    ]);

    final List<DataPengguna> pengguna =
        hasil[0] as List<DataPengguna>;

    final List<DataPengajuan> pengajuan =
        hasil[1] as List<DataPengajuan>;

    final List<Map<String, dynamic>> dataGabungan = [];

    for (final item in pengajuan) {
      final user = pengguna.firstWhere(
        (user) => user.id == item.userId,
        orElse: () => DataPengguna(
          id: 0,
          nama: 'Pengguna tidak ditemukan',
        ),
      );

      dataGabungan.add({
        'id': item.id,
        'userId': item.userId,
        'nama': user.nama,
        'judul': item.judul,
        'deskripsi': item.deskripsi,
      });
    }

    return dataGabungan;
  }
}
