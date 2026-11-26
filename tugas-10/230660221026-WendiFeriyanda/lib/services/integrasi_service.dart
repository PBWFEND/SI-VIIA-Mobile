import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/data_aktivitas_simulasi.dart';
import '../models/data_pengguna.dart';
import '../models/riwayat_simulasi_ringkas.dart';

/// Service untuk mengambil dan menggabungkan dua endpoint simulasi.
///
/// GET /users menyediakan data pengguna.
/// GET /posts menyediakan data aktivitas simulasi dengan userId.
///
/// Catatan: endpoint ini bukan backend Libsys dan bukan data peminjaman asli.
class IntegrasiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const Duration _timeout = Duration(seconds: 10);

  Future<List<DataPengguna>> ambilPengguna() async {
    final uri = Uri.parse('$_baseUrl/users');

    try {
      final response = await http.get(uri).timeout(_timeout);

      if (response.statusCode != 200) {
        throw Exception(
          'Gagal mengambil data pengguna (HTTP ${response.statusCode}).',
        );
      }

      final dynamic decoded = jsonDecode(response.body);
      if (decoded is! List) {
        throw const FormatException(
          'Format response pengguna bukan berupa daftar.',
        );
      }

      return decoded
          .whereType<Map>()
          .map(
            (item) => DataPengguna.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList();
    } on TimeoutException {
      throw Exception('Waktu mengambil data pengguna habis.');
    } on FormatException catch (error) {
      throw Exception('Format data pengguna tidak valid: $error');
    } on http.ClientException {
      throw Exception('Tidak dapat terhubung ke layanan pengguna.');
    }
  }

  Future<List<DataAktivitasSimulasi>> ambilAktivitas() async {
    final uri = Uri.parse('$_baseUrl/posts');

    try {
      final response = await http.get(uri).timeout(_timeout);

      if (response.statusCode != 200) {
        throw Exception(
          'Gagal mengambil data aktivitas (HTTP ${response.statusCode}).',
        );
      }

      final dynamic decoded = jsonDecode(response.body);
      if (decoded is! List) {
        throw const FormatException(
          'Format response aktivitas bukan berupa daftar.',
        );
      }

      return decoded
          .whereType<Map>()
          .map(
            (item) => DataAktivitasSimulasi.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList();
    } on TimeoutException {
      throw Exception('Waktu mengambil data aktivitas habis.');
    } on FormatException catch (error) {
      throw Exception('Format data aktivitas tidak valid: $error');
    } on http.ClientException {
      throw Exception('Tidak dapat terhubung ke layanan aktivitas.');
    }
  }

  /// Mengambil kedua endpoint secara bersamaan karena keduanya independen.
  /// Setelah kedua response diterima, data dihubungkan dengan userId.
  Future<List<RiwayatSimulasiRingkas>> ambilDataTerintegrasi() async {
    try {
      final hasil = await Future.wait<dynamic>([
        ambilPengguna(),
        ambilAktivitas(),
      ]);

      final daftarPengguna = hasil[0] as List<DataPengguna>;
      final daftarAktivitas = hasil[1] as List<DataAktivitasSimulasi>;

      // Membuat indeks pencarian pengguna berdasarkan ID.
      final penggunaById = <int, DataPengguna>{
        for (final pengguna in daftarPengguna) pengguna.id: pengguna,
      };

      // Menggabungkan aktivitas dengan pengguna berdasarkan userId.
      return daftarAktivitas.map((aktivitas) {
        final pengguna = penggunaById[aktivitas.userId];

        return RiwayatSimulasiRingkas(
          id: aktivitas.id,
          userId: aktivitas.userId,
          namaPengguna: pengguna?.nama ?? 'Pengguna tidak ditemukan',
          emailPengguna: pengguna?.email ?? '-',
          judulAktivitas: aktivitas.judulAktivitas,
          deskripsiAktivitas: aktivitas.deskripsiAktivitas,
        );
      }).toList();
    } on TimeoutException {
      throw Exception('Permintaan integrasi melewati batas waktu.');
    }
  }
}
