// Tugas 2: Modul Hitung Nilai
// Skema: Penilaian mata kuliah Pemrograman Aplikasi Bergerak (PAB)

void main() {
  final String mataKuliah = 'Pemrograman Aplikasi Bergerak';

  // 1. Struktur data: List<Map<String, Object>>
  final List<Map<String, Object>> komponen = [
    {'nama': 'Tugas', 'bobot': 30, 'skor': 28},
    {'nama': 'Praktikum', 'bobot': 25, 'skor': 24},
    {'nama': 'Kuis', 'bobot': 10, 'skor': 9},
    {'nama': 'UTS', 'bobot': 15, 'skor': 13},
    {'nama': 'UAS', 'bobot': 20, 'skor': 17},
  ];

//2. Fungsi hitung RataRata 
double hitungRataRata(List<Map<String, Object>> komponen) {
 // jumlahkan seluruh skor, bagi dengan jumlah komponen
  int totalSkor = 0;

  for (final item in komponen) {
    totalSkor += item['skor'] as int;
  }

  return totalSkor / komponen.length;
}

//3. Fungsi predikat
// Aturan predikat:
// >= 86      -> A
// 76 - 85    -> B
// 61 - 75    -> C
// < 61       -> Perlu perbaikan
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

  // 4. Blok main() — tampilkan nama mata kuliah
  print('Mata Kuliah: $mataKuliah');
  print('---------------------------------');

  // Tampilkan daftar komponen: nama, bobot, skor
  for (final item in komponen) {
    print('${item['nama']} | Bobot: ${item['bobot']} | Skor: ${item['skor']}');
  }

  // Hitung dan tampilkan rata-rata
  final double rataRata = hitungRataRata(komponen);
  print('---------------------------------');
  print('Rata-rata skor: ${rataRata.toStringAsFixed(2)}');

  // Tampilkan predikat akhir
  final String hasilPredikat = predikat(rataRata);
  print('Predikat akhir: $hasilPredikat');
}



