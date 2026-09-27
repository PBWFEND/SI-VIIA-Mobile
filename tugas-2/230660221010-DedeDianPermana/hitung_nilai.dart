final List<Map<String, Object>> komponen = [
  {'nama': 'Tugas', 'bobot': 25, 'skor': 85},
  {'nama': 'Praktikum', 'bobot': 25, 'skor': 90},
  {'nama': 'Kuis', 'bobot': 15, 'skor': 80},
  {'nama': 'UTS', 'bobot': 15, 'skor': 78},
  {'nama': 'UAS', 'bobot': 20, 'skor': 88},
];

double hitungRataRata(List<Map<String, Object>> komponen) {
  double totalSkor = 0;

  for (final item in komponen) {
    totalSkor += item['skor'] as int;
  }

  return totalSkor / komponen.length;
}

String predikat(double nilai) {
  if (nilai >= 85) {
    return 'A';
  } else if (nilai >= 75) {
    return 'B';
  } else if (nilai >= 65) {
    return 'C';
  } else if (nilai >= 50) {
    return 'D';
  } else {
    return 'E';
  }
}

void main() {
  const String mataKuliah = 'Pemrograman Aplikasi Bergerak';

  final double rataRata = hitungRataRata(komponen);
  final String hasilPredikat = predikat(rataRata);

  print('=== MODUL HITUNG NILAI ===');
  print('Mata Kuliah: $mataKuliah');
  print('');
  print('Daftar Komponen Penilaian:');

  for (final item in komponen) {
    print(
      '- ${item['nama']}: '
      'Bobot ${item['bobot']}%, '
      'Skor ${item['skor']}',
    );
  }

  print('');
  print('Rata-rata Skor: ${rataRata.toStringAsFixed(1)}');
  print('Predikat Akhir: $hasilPredikat');
}