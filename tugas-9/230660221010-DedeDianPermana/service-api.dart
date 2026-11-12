
import 'dart:convert';
import 'package:http/http.dart' as http;

// Model data peminjaman SiRuang Kampus
class Peminjaman {
  final int? id;
  final String namaRuangan;
  final String kategori;
  final String tanggal;
  final String waktu;
  final String tujuan;
  final String status;

  Peminjaman({
    this.id,
    required this.namaRuangan,
    required this.kategori,
    required this.tanggal,
    required this.waktu,
    required this.tujuan,
    this.status = 'Menunggu',
  });

  // Mengubah JSON dari server menjadi objek Peminjaman
  factory Peminjaman.fromJson(Map<String, dynamic> json) {
    return Peminjaman(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
      namaRuangan: json['namaRuangan']?.toString() ?? '',
      kategori: json['kategori']?.toString() ?? '',
      tanggal: json['tanggal']?.toString() ?? '',
      waktu: json['waktu']?.toString() ?? '',
      tujuan: json['tujuan']?.toString() ?? '',
      status: json['status']?.toString() ?? 'Menunggu',
    );
  }

  // Mengubah objek Peminjaman menjadi JSON untuk dikirim ke server
  Map<String, dynamic> toJson() {
    return {
      'namaRuangan': namaRuangan,
      'kategori': kategori,
      'tanggal': tanggal,
      'waktu': waktu,
      'tujuan': tujuan,
      'status': status,
    };
  }
}

// Class service untuk komunikasi dengan REST API
class PeminjamanApiService {
  // Endpoint pengujian REST API
  // Nanti dapat diganti dengan URL backend SiRuang Kampus.
  static const String baseUrl =
      'https://jsonplaceholder.typicode.com/posts';

  // Mengambil daftar data peminjaman menggunakan GET
  Future<List<Peminjaman>> getPeminjaman() async {
    try {
      final response = await http
          .get(
            Uri.parse(baseUrl),
            headers: {'Accept': 'application/json'},
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data.map((item) {
          final json = item as Map<String, dynamic>;

          // Menyesuaikan data pengujian dengan model peminjaman
          return Peminjaman(
            id: json['id'] as int?,
            namaRuangan: 'Ruang ${json['id']}',
            kategori: 'Ruang Kelas',
            tanggal: '2026-11-12',
            waktu: '08.00 - 10.00',
            tujuan: json['title']?.toString() ?? '',
            status: 'Menunggu',
          );
        }).toList();
      } else {
        throw Exception(
          'Gagal mengambil data. Kode HTTP: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat mengambil data: $e');
    }
  }

  // Mengirim data peminjaman menggunakan POST
  Future<Peminjaman> tambahPeminjaman(Peminjaman peminjaman) async {
    try {
      final response = await http
          .post(
            Uri.parse(baseUrl),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Accept': 'application/json',
            },
            body: jsonEncode(peminjaman.toJson()),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        return Peminjaman(
          id: data['id'] is int ? data['id'] : null,
          namaRuangan:
              data['namaRuangan']?.toString() ?? peminjaman.namaRuangan,
          kategori: data['kategori']?.toString() ?? peminjaman.kategori,
          tanggal: data['tanggal']?.toString() ?? peminjaman.tanggal,
          waktu: data['waktu']?.toString() ?? peminjaman.waktu,
          tujuan: data['tujuan']?.toString() ?? peminjaman.tujuan,
          status: data['status']?.toString() ?? peminjaman.status,
        );
      } else {
        throw Exception(
          'Gagal mengirim data. Kode HTTP: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat mengirim data: $e');
    }
  }
}
