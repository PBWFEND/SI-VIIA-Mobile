import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// Model Data Kegiatan PresenGo (type-safe dengan fromJson & toJson)
class DataKegiatan {
  const DataKegiatan({
    required this.id,
    required this.nama,
    required this.waktu,
    required this.lokasi,
    required this.status,
  });

  final String id;
  final String nama;
  final String waktu;
  final String lokasi;
  final String status;

  /// Mengonversi Map JSON dari REST API menjadi objek DataKegiatan
  factory DataKegiatan.fromJson(Map<String, dynamic> json) {
    final int rawId = (json['id'] as num?)?.toInt() ?? 0;

    // Daftar contoh nama & lokasi kegiatan organisasi agar tampilan API rapi dan kontekstual
    const daftarAgenda = [
      'Rapat BPH Mingguan',
      'Rapat Rutin Mingguan',
      'Rapat Departemen Kaderisasi Organisasi',
      'Koordinasi Program Kerja HIMSIF',
      'Evaluasi Bulanan Pengurus',
    ];
    const daftarWaktu = [
      '10:00 WIB',
      '10.00 - 13.00',
      '10.00 - 12.00',
      '13.30 - 15.00',
      '15.30 - 17.00',
    ];
    const daftarLokasi = [
      'Ruang Sekre',
      'Sekretariat Himsif',
      'Sekretariat Himsif',
      'Lab Sistem Informasi',
      'Aula Kampus',
    ];

    final int idx = rawId > 0 ? (rawId - 1) % daftarAgenda.length : 0;

    return DataKegiatan(
      id: rawId.toString(),
      nama: daftarAgenda[idx],
      waktu: daftarWaktu[idx],
      lokasi: daftarLokasi[idx],
      status: rawId % 2 == 0 ? 'Selesai' : 'Segera',
    );
  }

  /// Mengonversi objek DataKegiatan menjadi Map JSON untuk request HTTP POST
  Map<String, dynamic> toJson() {
    return {
      'title': nama,
      'body': '$waktu • $lokasi',
      'userId': 1,
    };
  }

  DataKegiatan copyWith({
    String? id,
    String? nama,
    String? waktu,
    String? lokasi,
    String? status,
  }) {
    return DataKegiatan(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      waktu: waktu ?? this.waktu,
      lokasi: lokasi ?? this.lokasi,
      status: status ?? this.status,
    );
  }
}

/// Lapisan Service — mengisolasi komunikasi HTTP GET & POST dari UI
class KegiatanApiService {
  // Ganti sementara ke 'https://jsonplaceholder.typicode.com/salah-endpoint'
  // untuk mengambil bukti screenshot-error.png
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  static const Duration _timeout = Duration(seconds: 10);

  /// HTTP GET: Mengambil daftar jadwal kegiatan dari server REST API
  static Future<List<DataKegiatan>> ambilDaftarKegiatan() async {
    final uri = Uri.parse(baseUrl);

    try {
      final response = await http.get(uri).timeout(_timeout);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList =
            jsonDecode(response.body) as List<dynamic>;
        return jsonList
            .take(5)
            .map((item) => DataKegiatan.fromJson(item as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 404) {
        throw Exception('Endpoint jadwal kegiatan tidak ditemukan (HTTP 404).');
      } else {
        throw Exception(
            'Gagal memuat jadwal dari server (HTTP ${response.statusCode}).');
      }
    } on TimeoutException {
      throw Exception(
          'Waktu koneksi habis (Timeout 10 detik). Periksa jaringan Anda.');
    } on FormatException {
      throw Exception('Format respons JSON dari server tidak valid.');
    } catch (e) {
      throw Exception('Terjadi gangguan koneksi: $e');
    }
  }

  /// HTTP POST: Mengirim data jadwal kegiatan baru ke server REST API
  static Future<DataKegiatan> tambahKegiatanBaru({
    required String nama,
    required String waktu,
    required String lokasi,
  }) async {
    final uri = Uri.parse(baseUrl);
    final dataKirim = DataKegiatan(
      id: '0',
      nama: nama,
      waktu: waktu,
      lokasi: lokasi,
      status: 'Segera',
    );

    try {
      final response = await http
          .post(
            uri,
            headers: const {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(dataKirim.toJson()),
          )
          .timeout(_timeout);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> responJson =
            jsonDecode(response.body) as Map<String, dynamic>;
        final String idBaru = ((responJson['id'] as num?)?.toInt() ??
                DateTime.now().millisecondsSinceEpoch)
            .toString();

        return DataKegiatan(
          id: idBaru,
          nama: nama,
          waktu: waktu,
          lokasi: lokasi,
          status: 'Segera',
        );
      } else {
        throw Exception(
            'Gagal menyimpan jadwal baru ke server (HTTP ${response.statusCode}).');
      }
    } on TimeoutException {
      throw Exception('Waktu pengiriman data habis (Timeout). Coba lagi.');
    } catch (e) {
      throw Exception('Gagal terhubung ke server saat mengirim data: $e');
    }
  }
}