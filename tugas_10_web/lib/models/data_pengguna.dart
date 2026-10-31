class DataPengguna {
  final int id;
  final String nama;
  final String email;
  final String organisasi;

  const DataPengguna({
    required this.id,
    required this.nama,
    required this.email,
    required this.organisasi,
  });

  factory DataPengguna.fromJson(Map<String, dynamic> json) {
    final company = json['company'];
    final companyMap = company is Map<String, dynamic>
        ? company
        : const <String, dynamic>{};

    return DataPengguna(
      id: (json['id'] as num?)?.toInt() ?? 0,
      nama: (json['name'] as String?)?.trim() ?? 'Nama tidak tersedia',
      email: (json['email'] as String?)?.trim() ?? 'Email tidak tersedia',
      organisasi:
          (companyMap['name'] as String?)?.trim() ??
          'Organisasi tidak tersedia',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': nama,
      'email': email,
      'company': {'name': organisasi},
    };
  }
}
