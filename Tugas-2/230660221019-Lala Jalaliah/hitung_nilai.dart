final List<Map<String, Object>> komponen = [
  {
    'nama': 'Tugas',
    'bobot': 30,
    'skor': 28,
  },
  {
    'nama': 'Praktikum',
    'bobot': 25,
    'skor': 24,
  },
  {
    'nama': 'Kuis',
    'bobot': 20,
    'skor': 18,
  },
  {
    'nama': 'UTS',
    'bobot': 15,
    'skor': 14,
  },
  {
    'nama': 'UAS',
    'bobot': 10,
    'skor': 9,
  },
];

double hitungRataRata(List<Map<String, Object>> komponen) {
  var totalSkor = 0;

  for (final item in komponen) {
    totalSkor += item['skor'] as int;
  }

  return totalSkor / komponen.length;
}

// Aturan predikat:
// >= 86 -> A
// 76 - 85 -> B
// 61 - 75 -> C
// < 61 -> Perlu perbaikan

String predikat(double nilai) {
  if (nilai >= 86) {
    return 'A';
  } else if (nilai >= 76) {
    return 'B';
  } else if (nilai >= 61) {
    return 'C';
  } else {
    return 'Perlu perbaikan';
  }
}

void main() {
  print('=== MODUL HITUNG NILAI ===');
  print('Mata Kuliah: Pemrograman Aplikasi Bergerak');
  print('');

  print('Daftar Komponen:');

  for (final item in komponen) {
    print(
      '${item['nama']} | Bobot: ${item['bobot']} | Skor: ${item['skor']}',
    );
  }

  final rataRata = hitungRataRata(komponen);
  final hasilPredikat = predikat(rataRata);

  print('');
  print('Rata-rata: $rataRata');
  print('Predikat: $hasilPredikat');
}