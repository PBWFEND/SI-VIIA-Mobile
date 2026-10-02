void main() {
  const String namaMataKuliah = 'Pemrograman Aplikasi Bergerak';
  final List<Map<String, Object>> komponen = [
    {'nama': 'Tugas', 'bobot': 30, 'skor': 90},
    {'nama': 'Praktikum', 'bobot': 25, 'skor': 95},
    {'nama': 'Kuis', 'bobot': 10, 'skor': 85},
    {'nama': 'UTS', 'bobot': 15, 'skor': 78},
    {'nama': 'UAS', 'bobot': 20, 'skor': 92},
  ];

  final double rataRata = hitungRataRata(komponen);

  final String predikatAkhir = predikat(rataRata);

  print('Mata kuliah: $namaMataKuliah');
  print('');
  print('Daftar komponen penilaian:');
  for (final item in komponen) {
    print('- ${item['nama']}: bobot ${item['bobot']}, skor ${item['skor']}');
  }
  print('');
  print('Rata-rata skor: ${rataRata.toStringAsFixed(2)}');
  print('Predikat akhir: $predikatAkhir');
}

double hitungRataRata(List<Map<String, Object>> komponen) {
  var totalSkor = 0;
  for (final item in komponen) {
    totalSkor += item['skor'] as int;
  }
  return totalSkor / komponen.length;
}

String predikat(double nilai) {
  if (nilai >= 86) return 'A';
  if (nilai >= 76) return 'B';
  if (nilai >= 61) return 'C';
  return 'Perlu perbaikan';
}
