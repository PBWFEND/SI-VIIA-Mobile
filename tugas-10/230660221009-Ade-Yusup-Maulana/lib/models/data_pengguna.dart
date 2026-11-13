
class DataPengguna {
  final int id;
  final String nama;

  DataPengguna({
    required this.id,
    required this.nama,
  });

  factory DataPengguna.fromJson(Map<String, dynamic> json) {
    return DataPengguna(
      id: json['id'] ?? 0,
      nama: json['name'] ?? 'Tanpa Nama',
    );
  }
}
