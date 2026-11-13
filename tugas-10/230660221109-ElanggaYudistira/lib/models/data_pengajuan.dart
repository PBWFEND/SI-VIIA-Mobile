class DataPengajuan {
  final int id;
  final int userId;
  final String judul;
  final String status;
  final String deskripsi;

  const DataPengajuan({
    required this.id,
    required this.userId,
    required this.judul,
    required this.status,
    required this.deskripsi,
  });

  factory DataPengajuan.fromJson(Map<String, dynamic> json) {
    final userId = (json['userId'] as num?)?.toInt() ?? 0;
    final rawStatus = (json['status'] as String?)?.trim();

    return DataPengajuan(
      id: (json['id'] as num?)?.toInt() ?? 0,
      userId: userId,
      judul: (json['title'] as String?)?.trim() ?? 'Pengajuan tanpa judul',
      status: rawStatus?.isNotEmpty == true
          ? rawStatus!
          : userId.isEven
          ? 'Diproses'
          : 'Menunggu',
      deskripsi:
          (json['body'] as String?)?.trim() ?? 'Deskripsi tidak tersedia',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': judul,
      'status': status,
      'body': deskripsi,
    };
  }
}
