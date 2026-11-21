// Tugas 2: Modul Hitung Nilai
// Nama: Sharel Faturahman | NPM: 230660221108
// Bantuan: ChatGPT/Codex untuk menyusun kode dan melakukan verifikasi eksekusi.

double hitungRataRata(List<Map<String, Object>> komponen) {
  // Daftar kosong menghasilkan 0.0 agar tidak terjadi pembagian dengan nol.
  if (komponen.isEmpty) {
    return 0.0;
  }

  int totalSkor = 0;
  for (final item in komponen) {
    totalSkor += item['skor'] as int;
  }

  return totalSkor / komponen.length;
}

// Aturan predikat untuk rata-rata skor mentah:
// nilai >= 18        -> A
// 16 <= nilai < 18   -> B
// 12 <= nilai < 16   -> C
// nilai < 12        -> Perlu perbaikan
// Batas memakai pertidaksamaan agar nilai desimal juga tercakup tanpa celah.
String predikat(double nilai) {
  if (nilai >= 18) {
    return 'A';
  } else if (nilai >= 16) {
    return 'B';
  } else if (nilai >= 12) {
    return 'C';
  } else {
    return 'Perlu perbaikan';
  }
}

void main() {
  const mataKuliah = 'Pemrograman Aplikasi Bergerak';
  final List<Map<String, Object>> komponen = [
    {'nama': 'Tugas', 'bobot': 30, 'skor': 28},
    {'nama': 'Praktikum', 'bobot': 25, 'skor': 24},
    {'nama': 'Kuis', 'bobot': 20, 'skor': 18},
    {'nama': 'UTS', 'bobot': 15, 'skor': 13},
    {'nama': 'UAS', 'bobot': 10, 'skor': 9},
  ];

  print('Mata kuliah: $mataKuliah');
  for (final item in komponen) {
    print('${item['nama']}: bobot=${item['bobot']}, skor=${item['skor']}');
  }

  final rataRata = hitungRataRata(komponen);
  print('Rata-rata skor: ${rataRata.toStringAsFixed(2)}');
  print('Predikat: ${predikat(rataRata)}');
}
