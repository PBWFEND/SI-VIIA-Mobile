// Tugas 2 — Modul Hitung Nilai
// Mahasiswa: Nazwa Aulia Rachma (230660221104)

final List<Map<String, Object>> komponen = [
  {'nama': 'Tugas', 'bobot': 30, 'skor': 28},
  {'nama': 'Praktikum', 'bobot': 25, 'skor': 24},
  {'nama': 'Kuis', 'bobot': 15, 'skor': 13},
  {'nama': 'UTS', 'bobot': 15, 'skor': 14},
  {'nama': 'UAS', 'bobot': 15, 'skor': 12},
];

double hitungRataRata(List<Map<String, Object>> komponen) {
  if (komponen.isEmpty) {
    return 0.0;
  }

  var totalSkor = 0;
  for (final item in komponen) {
    totalSkor += item['skor'] as int;
  }
  return totalSkor / komponen.length;
}

// Aturan predikat berdasarkan rata-rata skor per komponen (skala 0–20):
// >= 17 -> A
// 14 - 16.99 -> B
// 10 - 13.99 -> C
// < 10 -> Perlu perbaikan
String predikat(double nilai) {
  if (nilai >= 17) {
    return 'A';
  } else if (nilai >= 14) {
    return 'B';
  } else if (nilai >= 10) {
    return 'C';
  }
  return 'Perlu perbaikan';
}

void main() {
  const mataKuliah = 'Pemrograman Aplikasi Bergerak';
  final rataRata = hitungRataRata(komponen);

  print('Mata kuliah: $mataKuliah');
  print('Daftar komponen penilaian:');
  for (final item in komponen) {
    final nama = item['nama'] as String;
    final bobot = item['bobot'] as int;
    final skor = item['skor'] as int;
    print('- $nama | Bobot: $bobot | Skor: $skor');
  }
  print('Rata-rata skor: ${rataRata.toStringAsFixed(2)}');
  print('Predikat akhir: ${predikat(rataRata)}');
}
