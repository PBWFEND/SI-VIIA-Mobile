// Bantuan: Gemini AI — Penyusunan struktur modul hitung_nilai.dart dan logika iterasi List<Map>
// Nama : Nisa Rahmawati
// NPM  : 230660221023
// Domain: Sistem Informasi Absensi Kampus

void main() {
  const String mataKuliah = 'Pemrograman Aplikasi Bergerak';
  const String namaMahasiswa = 'Nisa Rahmawati';
  const String npmMahasiswa = '230660221023';

  // 1. Deklarasi List<Map<String, Object>> berisi 5 komponen penilaian
  final List<Map<String, Object>> komponenPenilaian = [
    {'nama': 'Kehadiran & Absensi', 'bobot': 15, 'skor': 95},
    {'nama': 'Tugas Praktikum', 'bobot': 20, 'skor': 88},
    {'nama': 'Kuis Formatif', 'bobot': 15, 'skor': 82},
    {'nama': 'UTS (Ujian Tengah Semester)', 'bobot': 25, 'skor': 80},
    {'nama': 'UAS (Ujian Akhir Semester)', 'bobot': 25, 'skor': 85},
  ];

  print('===================================================');
  print('          SISTEM INFORMASI EVALUASI NILAI          ');
  print('===================================================');
  print('Mata Kuliah : $mataKuliah');
  print('Mahasiswa   : $namaMahasiswa ($npmMahasiswa)');
  print('---------------------------------------------------');
  print('Komponen Penilaian:');

  for (var k in komponenPenilaian) {
    print('- ${k['nama']}: Bobot ${k['bobot']}%, Skor: ${k['skor']}');
  }

  final double nilaiRataRata = hitungRataRata(komponenPenilaian);
  final String predikatAkhir = predikat(nilaiRataRata);

  print('---------------------------------------------------');
  print('Nilai Akhir (Terbobot) : ${nilaiRataRata.toStringAsFixed(2)}');
  print('Predikat               : $predikatAkhir');
  print('===================================================');
}

/// Fungsi menghitung nilai rata-rata terbobot
double hitungRataRata(List<Map<String, Object>> komponen) {
  double totalNilai = 0.0;
  for (var item in komponen) {
    final num bobot = item['bobot'] as num;
    final num skor = item['skor'] as num;
    totalNilai += skor * (bobot / 100.0);
  }
  return totalNilai;
}

/// Fungsi penentuan predikat berdasarkan rentang nilai
String predikat(double nilai) {
  if (nilai >= 86.0) {
    return 'A (Sangat Memuaskan)';
  } else if (nilai >= 76.0) {
    return 'B (Memuaskan)';
  } else if (nilai >= 61.0) {
    return 'C (Cukup)';
  } else {
    return 'Perlu Perbaikan';
  }
}