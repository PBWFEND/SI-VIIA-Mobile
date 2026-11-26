import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/model-integrasi.dart';

class IntegrasiPresenGoService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const Duration _timeout = Duration(seconds: 10);

  static const List<String> _templateKegiatan = [
    'Rapat BPH Mingguan',
    'Rapat Rutin Mingguan',
    'Rapat Departemen Kaderisasi Organisasi',
    'Koordinasi Program Kerja HIMSIF',
    'Evaluasi Bulanan Pengurus',
  ];

  static Future<List<DataPengguna>> ambilDaftarPengguna() async {
    final uri = Uri.parse('$_baseUrl/users');
    try {
      final response = await http.get(uri).timeout(_timeout);
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body) as List<dynamic>;
        return decoded
            .map((item) => DataPengguna.fromJson(item as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 404) {
        throw Exception('Endpoint data pengguna tidak ditemukan (HTTP 404).');
      } else if (response.statusCode >= 500) {
        throw Exception(
            'Server data pengguna sedang bermasalah (HTTP ${response.statusCode}).');
      } else {
        throw Exception(
            'Gagal memuat data pengguna (HTTP ${response.statusCode}).');
      }
    } on TimeoutException {
      throw Exception('Koneksi timeout saat memuat data pengguna.');
    } on FormatException {
      throw Exception('Format respons JSON pengguna tidak valid.');
    } catch (e) {
      throw Exception('Gangguan koneksi pengguna: $e');
    }
  }

  static Future<List<DataKegiatanApi>> ambilDaftarKegiatan() async {
    final uri = Uri.parse('$_baseUrl/posts');
    try {
      final response = await http.get(uri).timeout(_timeout);
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body) as List<dynamic>;
        return decoded
            .take(5)
            .map((item) => DataKegiatanApi.fromJson(item as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 404) {
        throw Exception('Endpoint jadwal kegiatan tidak ditemukan (HTTP 404).');
      } else if (response.statusCode >= 500) {
        throw Exception(
            'Server jadwal kegiatan sedang bermasalah (HTTP ${response.statusCode}).');
      } else {
        throw Exception(
            'Gagal memuat jadwal kegiatan (HTTP ${response.statusCode}).');
      }
    } on TimeoutException {
      throw Exception('Koneksi timeout saat memuat jadwal kegiatan.');
    } on FormatException {
      throw Exception('Format respons JSON jadwal tidak valid.');
    } catch (e) {
      throw Exception('Gangguan koneksi jadwal: $e');
    }
  }

  static Future<List<DataRuangSimulasi>> ambilDaftarRuang() async {
    final uri = Uri.parse('$_baseUrl/comments');
    try {
      final response = await http.get(uri).timeout(_timeout);
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body) as List<dynamic>;
        return decoded
            .take(5)
            .map((item) =>
                DataRuangSimulasi.fromJson(item as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 404) {
        throw Exception('Endpoint data ruang tidak ditemukan (HTTP 404).');
      } else if (response.statusCode >= 500) {
        throw Exception(
            'Server data ruang sedang bermasalah (HTTP ${response.statusCode}).');
      } else {
        throw Exception('Gagal memuat data ruang (HTTP ${response.statusCode}).');
      }
    } on TimeoutException {
      throw Exception('Koneksi timeout saat memuat data ruang.');
    } on FormatException {
      throw Exception('Format respons JSON ruang tidak valid.');
    } catch (e) {
      throw Exception('Gangguan koneksi ruang: $e');
    }
  }

  static Future<List<DataJadwalTerintegrasi>> ambilJadwalTerintegrasi() async {
    try {
      final hasil = await Future.wait<dynamic>([
        ambilDaftarPengguna(),
        ambilDaftarKegiatan(),
        ambilDaftarRuang(),
      ]);

      final listPengguna = hasil[0] as List<DataPengguna>;
      final listKegiatan = hasil[1] as List<DataKegiatanApi>;
      final listRuang = hasil[2] as List<DataRuangSimulasi>;

      if (listKegiatan.isEmpty) {
        return [];
      }

      final mapPengguna = <int, DataPengguna>{
        for (final u in listPengguna) u.id: u,
      };
      final mapRuang = <int, DataRuangSimulasi>{
        for (final r in listRuang) r.id: r,
      };

      return List<DataJadwalTerintegrasi>.generate(listKegiatan.length, (i) {
        final kegiatan = listKegiatan[i];
        final pemohon = mapPengguna[kegiatan.userId];
        final ruang = mapRuang[kegiatan.roomId];
        final namaKegiatan = i < _templateKegiatan.length
            ? _templateKegiatan[i]
            : kegiatan.judulAsli;

        return DataJadwalTerintegrasi(
          id: kegiatan.id,
          userId: kegiatan.userId,
          namaKegiatan: namaKegiatan,
          namaPemohon: pemohon?.nama ?? 'Pengurus #${kegiatan.userId}',
          waktu: ruang?.waktuSesi ?? '10:00 WIB',
          lokasiRuang: ruang?.namaRuang ?? 'Ruang Sekre',
          status: kegiatan.status,
        );
      });
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}