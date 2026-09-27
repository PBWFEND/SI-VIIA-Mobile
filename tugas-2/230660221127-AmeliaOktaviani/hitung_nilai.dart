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
    'nama': 'UTS',
    'bobot': 20,
    'skor': 18,
  },
  {
    'nama': 'UAS',
    'bobot': 15,
    'skor': 14,
  },
  {
    'nama': 'Kuis',
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

// Aturan predikat berdasarkan rata-rata skor:
// >= 25 -> A
// 20 - <25 -> B
// 15 - <20 -> C
// < 15 -> Perlu perbaikan
String predikat(double nilai) {
  if (nilai >= 25) {
    return 'A';
  } else if (nilai >= 20) {
    return 'B';
  } else if (nilai >= 15) {
    return 'C';
  } else {
    return 'Perlu perbaikan';
  }
}

void main() {
  const namaMataKuliah = 'Pemrograman Aplikasi Bergerak';

  print('=== HASIL PERHITUNGAN NILAI ===');
  print('Mata Kuliah: $namaMataKuliah');
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
  print('Rata-rata Skor: $rataRata');
  print('Predikat Akhir: $hasilPredikat');
}