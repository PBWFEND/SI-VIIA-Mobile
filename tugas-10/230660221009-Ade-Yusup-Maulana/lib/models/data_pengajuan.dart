
class DataPengajuan {
  final int id;
  final int userId;
  final String judul;
  final String deskripsi;

  DataPengajuan({
    required this.id,
    required this.userId,
    required this.judul,
    required this.deskripsi,
  });

  factory DataPengajuan.fromJson(Map<String, dynamic> json) {
    return DataPengajuan(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      judul: json['title'] ?? 'Tanpa Judul',
      deskripsi: json['body'] ?? 'Tidak ada deskripsi',
    );
  }
}
