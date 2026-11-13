
// Tugas 2 - Modul Hitung Nilai
// Mata Kuliah: Pemrograman Aplikasi Bergerak

final String namaKuliah = 'Pemrograman Aplikasi Bergerak';

// Data lima komponen penilaian
final List<Map<String, Object>> komponen = [
  {'nama': 'Tugas', 'bobot': 20, 'skor': 85},
  {'nama': 'Kuis', 'bobot': 15, 'skor': 80},
  {'nama': 'Praktikum', 'bobot': 25, 'skor': 90},
  {'nama': 'UTS', 'bobot': 20, 'skor': 78},
  {'nama': 'UAS', 'bobot': 20, 'skor': 88},
];

// Fungsi menghitung rata-rata tertimbang
double hitungRataRata(List<Map<String, Object>> komponen) {
  if (komponen.isEmpty) {
    return 0.0;
  }

  int totalBobot = 0;
  double totalNilai = 0.0;

  for (final item in komponen) {
    final bobot = item['bobot'] as int;
    final skor = item['skor'] as num;

    totalBobot += bobot;
    totalNilai += skor * bobot;
  }

  if (totalBobot == 0) {
    return 0.0;
  }

  return totalNilai / totalBobot;
}

// Fungsi menentukan predikat
// A: >= 86, B: >= 76, C: >= 61, selain itu perlu perbaikan
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
  print('=== MODUL HITUNG NILAI PAB ===');
  print('Mata Kuliah: $namaKuliah');
  print('');

  int totalBobot = 0;

  print('Daftar Komponen Penilaian:');

  for (final item in komponen) {
    final nama = item['nama'] as String;
    final bobot = item['bobot'] as int;
    final skor = item['skor'] as num;

    totalBobot += bobot;

    print(
      '- $nama: Bobot $bobot%, '
      'Skor ${skor.toStringAsFixed(0)}',
    );
  }

  print('');
  print('Total bobot: $totalBobot%');

  if (totalBobot != 100) {
    print('Peringatan: Total bobot harus 100%.');
    return;
  }

  final nilaiAkhir = hitungRataRata(komponen);

  print('Nilai akhir: ${nilaiAkhir.toStringAsFixed(2)}');
  print('Predikat: ${predikat(nilaiAkhir)}');
}