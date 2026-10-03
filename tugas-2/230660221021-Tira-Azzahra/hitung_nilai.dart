// ==========================================
// Tugas 2: Modul Hitung Nilai
// Nama: Tira Azzahra
// NIM: 230660221021
// ==========================================

// 1. Fungsi hitungRataRata
double hitungRataRata(List<Map<String, Object>> komponen) {
  // jumlahkan seluruh skor, bagi dengan jumlah komponen
  int totalSkor = 0;
  for (final item in komponen) {
    totalSkor += (item['skor'] as int);
  }
  return totalSkor / komponen.length;
}

// 2. Fungsi predikat
// Aturan predikat:
// >= 86 -> A
// 76 - 85 -> B
// 61 - 75 -> C
// < 61 -> Perlu perbaikan
String predikat(double nilai) {
  if (nilai >= 86) return 'A';
  if (nilai >= 76) return 'B';
  if (nilai >= 61) return 'C';
  return 'Perlu perbaikan';
}

// 3. Blok main()
void main() {
  final namaMataKuliah = 'Pemrograman Aplikasi Bergerak';

  // Deklarasi List<Map<String, Object>> minimal 5 komponen
  // Catatan: skor di sini diasumsikan sudah dalam skala 0-100 
  // agar rata-ratanya selaras dengan aturan predikat.
  final List<Map<String, Object>> komponen = [
    {'nama': 'Tugas', 'bobot': 30, 'skor': 88},
    {'nama': 'Praktikum', 'bobot': 25, 'skor': 92},
    {'nama': 'Kuis', 'bobot': 10, 'skor': 75},
    {'nama': 'UTS', 'bobot': 15, 'skor': 81},
    {'nama': 'UAS', 'bobot': 20, 'skor': 86},
  ];

  // Menampilkan nama mata kuliah
  print('Mata Kuliah: $namaMataKuliah');
  
  // Menampilkan daftar komponen (satu baris per komponen)
  print('Daftar Komponen:');
  for (final item in komponen) {
    final nama = item['nama'] as String;
    final bobot = item['bobot'] as int;
    final skor = item['skor'] as int;
    print('- $nama | Bobot: $bobot% | Skor: $skor');
  }

  // Menghitung rata-rata dan predikat
  final rataRata = hitungRataRata(komponen);
  final predikatAkhir = predikat(rataRata);

  // Menampilkan rata-rata skor dan predikat akhir
  print('\nRata-rata skor: ${rataRata.toStringAsFixed(2)}');
  print('Predikat akhir: $predikatAkhir');
}