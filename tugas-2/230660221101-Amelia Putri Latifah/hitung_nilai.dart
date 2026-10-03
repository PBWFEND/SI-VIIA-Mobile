// hitung_nilai.dart

void main() {
  // 1. Deklarasi List<Map<String, Object>>
  // Domain Sistem: Absensi & Evaluasi Kinerja Organisasi
  final List<Map<String, Object>> komponen = [
    {'nama': 'Kehadiran Rapat', 'bobot': 100, 'skor': 90},
    {'nama': 'Kehadiran Program Kerja', 'bobot': 100, 'skor': 85},
    {'nama': 'Penyelesaian Tugas Divisi', 'bobot': 100, 'skor': 88},
    {'nama': 'Keaktifan Forum', 'bobot': 100, 'skor': 75},
    {'nama': 'Kedisiplinan & Sikap', 'bobot': 100, 'skor': 92},
  ];

  // 4. Blok main() menampilkan keluaran
  print('=== Modul Sistem Evaluasi Kinerja Anggota Organisasi ===\n');

  print('Daftar Komponen Penilaian:');
  for (final k in komponen) {
    print('- ${k['nama']}: Bobot ${k['bobot']}, Skor ${k['skor']}');
  }

  final rataRata = hitungRataRata(komponen);
  print('\nRata-rata Skor: $rataRata');

  final hasilPredikat = predikat(rataRata);
  print('Predikat Akhir: $hasilPredikat');
}

// 2. Fungsi hitungRataRata
double hitungRataRata(List<Map<String, Object>> komponen) {
  double totalSkor = 0;
  for (final k in komponen) {
    // Karena value di Map bertipe Object, kita perlu casting (as) ke int
    final skor = k['skor'] as int;
    totalSkor += skor;
  }
  // Jumlahkan seluruh skor, bagi dengan jumlah komponen
  return totalSkor / komponen.length;
}

// 3. Fungsi predikat
// Aturan predikat Evaluasi Kinerja Organisasi:
// >= 86    -> A (Sangat Aktif)
// 76 - 85  -> B (Aktif)
// 61 - 75  -> C (Cukup Aktif)
// < 61     -> Perlu perbaikan (Evaluasi Keanggotaan)
String predikat(double nilai) {
  if (nilai >= 86) {
    return 'A (Sangat Aktif)';
  } else if (nilai >= 76) {
    return 'B (Aktif)';
  } else if (nilai >= 61) {
    return 'C (Cukup Aktif)';
  } else {
    return 'Perlu perbaikan (Evaluasi Keanggotaan)';
  }
}