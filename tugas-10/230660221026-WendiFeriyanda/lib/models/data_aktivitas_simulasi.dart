/// Model data dari endpoint GET /posts.
///
/// JSONPlaceholder /posts bukan transaksi peminjaman buku.
/// Data ini hanya digunakan sebagai aktivitas simulasi untuk latihan
/// menghubungkan userId dengan pengguna dari endpoint /users.
class DataAktivitasSimulasi {
  const DataAktivitasSimulasi({
    required this.id,
    required this.userId,
    required this.judulAktivitas,
    required this.deskripsiAktivitas,
  });

  final int id;
  final int userId;
  final String judulAktivitas;
  final String deskripsiAktivitas;

  factory DataAktivitasSimulasi.fromJson(Map<String, dynamic> json) {
    return DataAktivitasSimulasi(
      id: json['id'] is num ? (json['id'] as num).toInt() : 0,
      userId: json['userId'] is num
          ? (json['userId'] as num).toInt()
          : 0,
      judulAktivitas: json['title'] as String? ?? 'Tanpa Judul',
      deskripsiAktivitas: json['body'] as String? ?? '-',
    );
  }
}
