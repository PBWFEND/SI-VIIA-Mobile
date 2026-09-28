void main() {
  // Daftar komponen penilaian
  final List<Map<String, Object>> komponen = [
    {'nama': 'Tugas', 'bobot': 30, 'skor': 28},
    {'nama': 'Praktikum', 'bobot': 25, 'skor': 23},
    {'nama': 'Kuis', 'bobot': 20, 'skor': 16},
    {'nama': 'UTS', 'bobot': 15, 'skor': 14},
    {'nama': 'UAS', 'bobot': 10, 'skor': 9},
  ];

  // Nama mata kuliah
  print('Mata Kuliah: Pemrograman Aplikasi Bergerak');
  print('==========================================');

  // Menampilkan semua komponen
  print('Daftar Komponen Penilaian:');

  for (final item in komponen) {
    print(
      '${item['nama']} - '
      'Bobot: ${item['bobot']} - '
      'Skor: ${item['skor']}',
    );
  }

  print('==========================================');

  // Menghitung rata-rata
  final rataRata = hitungRataRata(komponen);

  print('Rata-rata Skor: ${rataRata.toStringAsFixed(2)}');

  // Menentukan predikat
  final hasilPredikat = predikat(rataRata);

  print('Predikat Akhir: $hasilPredikat');
}


// Menghitung rata-rata seluruh skor
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


// Aturan predikat:
// >= 17.2 -> A
// >= 15.2 -> B
// >= 12.2 -> C
// < 12.2 -> Perlu perbaikan
String predikat(double nilai) {
  if (nilai >= 17.2) {
    return 'A';
  }

  if (nilai >= 15.2) {
    return 'B';
  }

  if (nilai >= 12.2) {
    return 'C';
  }

  return 'Perlu perbaikan';
}