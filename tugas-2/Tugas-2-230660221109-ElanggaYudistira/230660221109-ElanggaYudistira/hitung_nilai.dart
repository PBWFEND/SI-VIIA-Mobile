// Tugas 2 - Modul Hitung Nilai
// Nama: Elangga Yudistira
// NIM: 230660221109

final List<Map<String, Object>> komponen = [
  {'nama': 'Tugas', 'bobot': 30, 'skor': 28},
  {'nama': 'Praktikum', 'bobot': 25, 'skor': 24},
  {'nama': 'UTS', 'bobot': 20, 'skor': 18},
  {'nama': 'UAS', 'bobot': 20, 'skor': 17},
  {'nama': 'Kehadiran', 'bobot': 5, 'skor': 5},
];

double hitungRataRata(List<Map<String, Object>> komponen) {
  int totalSkor = 0;
  for (var item in komponen) {
    totalSkor += item['skor'] as int;
  }
  return totalSkor / komponen.length;
}

// Aturan predikat:
// >= 86 = A
// 76 - 85 = B
// 61 - 75 = C
// < 61 = Perlu Perbaikan
String predikat(double nilai) {
  if (nilai >= 86) {
    return 'A';
  } else if (nilai >= 76) {
    return 'B';
  } else if (nilai >= 61) {
    return 'C';
  } else {
    return 'Perlu Perbaikan';
  }
}

void main() {
  print('Mata Kuliah: Pemrograman Aplikasi Bergerak');
  print('================================');

  for (var item in komponen) {
    print('${item['nama']} | Bobot: ${item['bobot']} | Skor: ${item['skor']}');
  }

  double rataRata = hitungRataRata(komponen);

  print('================================');
  print('Rata-rata Nilai: ${rataRata.toStringAsFixed(2)}');
  print('Predikat Akhir: ${predikat(rataRata)}');
}
