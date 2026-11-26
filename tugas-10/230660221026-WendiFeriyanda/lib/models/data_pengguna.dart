/// Model pengguna yang berasal dari endpoint GET /users.
/// API ini adalah API simulasi, bukan data mahasiswa kampus yang sebenarnya.
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
      id: json['id'] is num ? (json['id'] as num).toInt() : 0,
      nama: json['name'] as String? ?? 'Tanpa Nama',
      email: json['email'] as String? ?? '-',
    );
  }
}
