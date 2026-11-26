enum StatusJadwal { segera, selesai }

String labelStatusJadwal(StatusJadwal status) {
  return status == StatusJadwal.selesai ? 'Selesai' : 'Segera';
}

class DataPengguna {
  const DataPengguna({
    required this.id,
    required this.nama,
    required this.email,
  });

  final int id;
  final String nama;
  final String email;

  factory DataPengguna.fromJson(Map<String, dynamic> json) {
    return DataPengguna(
      id: (json['id'] as num?)?.toInt() ?? 0,
      nama: (json['name'] as String?)?.trim().isNotEmpty == true
          ? (json['name'] as String).trim()
          : 'Pengurus Organisasi',
      email: (json['email'] as String?)?.trim() ?? '-',
    );
  }
}

class DataKegiatanApi {
  const DataKegiatanApi({
    required this.id,
    required this.userId,
    required this.roomId,
    required this.judulAsli,
    required this.status,
  });

  final int id;
  final int userId;
  final int roomId;
  final String judulAsli;
  final StatusJadwal status;

  factory DataKegiatanApi.fromJson(Map<String, dynamic> json) {
    final int parsedId = (json['id'] as num?)?.toInt() ?? 0;
    final int parsedUserId = (json['userId'] as num?)?.toInt() ?? 0;
    final int parsedRoomId =
        (json['roomId'] as num?)?.toInt() ??
        (parsedId > 0 ? ((parsedId - 1) % 5) + 1 : 1);

    final StatusJadwal parsedStatus =
        parsedId % 2 == 0 ? StatusJadwal.selesai : StatusJadwal.segera;

    return DataKegiatanApi(
      id: parsedId,
      userId: parsedUserId,
      roomId: parsedRoomId,
      judulAsli: (json['title'] as String?)?.trim() ?? 'Kegiatan #$parsedId',
      status: parsedStatus,
    );
  }
}

class DataRuangSimulasi {
  const DataRuangSimulasi({
    required this.id,
    required this.namaRuang,
    required this.waktuSesi,
  });

  final int id;
  final String namaRuang;
  final String waktuSesi;

  factory DataRuangSimulasi.fromJson(Map<String, dynamic> json) {
    final int parsedId = (json['id'] as num?)?.toInt() ?? 0;
    const daftarRuang = [
      'Ruang Sekre',
      'Sekretariat Himsif',
      'Sekretariat Himsif',
      'Lab Sistem Informasi',
      'Aula Kampus',
    ];
    const daftarWaktu = [
      '10:00 WIB',
      '10.00 - 13.00',
      '10.00 - 12.00',
      '13.30 - 15.00',
      '15.30 - 17.00',
    ];
    final int idx = parsedId > 0 ? (parsedId - 1) % daftarRuang.length : 0;

    return DataRuangSimulasi(
      id: parsedId,
      namaRuang: daftarRuang[idx],
      waktuSesi: daftarWaktu[idx],
    );
  }
}

class DataJadwalTerintegrasi {
  const DataJadwalTerintegrasi({
    required this.id,
    required this.userId,
    required this.namaKegiatan,
    required this.namaPemohon,
    required this.waktu,
    required this.lokasiRuang,
    required this.status,
  });

  final int id;
  final int userId;
  final String namaKegiatan;
  final String namaPemohon;
  final String waktu;
  final String lokasiRuang;
  final StatusJadwal status;

  DataJadwalTerintegrasi copyWith({
    StatusJadwal? status,
  }) {
    return DataJadwalTerintegrasi(
      id: id,
      userId: userId,
      namaKegiatan: namaKegiatan,
      namaPemohon: namaPemohon,
      waktu: waktu,
      lokasiRuang: lokasiRuang,
      status: status ?? this.status,
    );
  }
}