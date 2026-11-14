// Aturan predikat:
// >= 85.0 -> Sangat Baik (A)
// 75.0 - 84.9 -> Baik (B)
// 65.0 - 74.9 -> Cukup (C)
// < 65.0 -> Perlu Perbaikan (D)
String predikat(double nilai) {
  if (nilai >= 85.0) {
    return 'Sangat Baik (A)';
  } else if (nilai >= 75.0) {
    return 'Baik (B)';
  } else if (nilai >= 65.0) {
    return 'Cukup (C)';
  } else {
    return 'Perlu Perbaikan (D)';
  }
}

double hitungRataRata(List<Map<String, Object>> komponen) {
  double totalSkor = 0.0;
  for (var k in komponen) {
    totalSkor += (k['skor'] as int).toDouble();
  }
  return totalSkor / komponen.length;
}

void main() {
  final mataKuliah = "Pemrograman Aplikasi Bergerak";

  final komponen = [
    {'nama': 'Tugas 1', 'bobot': 20, 'skor': 18},
    {'nama': 'Tugas 2', 'bobot': 20, 'skor': 19},
    {'nama': 'Praktikum', 'bobot': 20, 'skor': 17},
    {'nama': 'UTS', 'bobot': 20, 'skor': 16},
    {'nama': 'UAS', 'bobot': 20, 'skor': 18},
  ];

  print("Mata Kuliah: $mataKuliah");
  print("========================================");
  print("Daftar Komponen Penilaian:");

  for (var k in komponen) {
    print("- ${k['nama']}: Bobot ${k['bobot']}, Skor ${k['skor']}");
  }

  double rataRata = hitungRataRata(komponen);
  String predikatAkhir = predikat(rataRata);

  print("----------------------------------------");
  print("Rata-rata Skor : ${rataRata.toStringAsFixed(2)}");
  print("Predikat Akhir  : $predikatAkhir");
}