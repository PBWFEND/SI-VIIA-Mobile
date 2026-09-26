# Tugas 2: Modul Hitung Nilai

**Nama:** Muhammad Aulia Ramadhani
**NIM:** 230660221013  
**Kelas:** SI-VIIA
---

### Hasil Output Program (`dart hitung_nilai.dart`)

```text
Mata Kuliah: Pemrograman Aplikasi Bergerak
========================================
Daftar Komponen Penilaian:
- Tugas 1: Bobot 20, Skor 18
- Tugas 2: Bobot 20, Skor 19
- Praktikum: Bobot 20, Skor 17
- UTS: Bobot 20, Skor 16
- UAS: Bobot 20, Skor 18
----------------------------------------
Rata-rata Skor : 17.60
Predikat Akhir  : Perlu Perbaikan (D)

Refleksi
Sintaks dasar Dart yang paling sering saya salahgunakan adalah type casting saat mengambil nilai bertipe Object dari Map<String, Object>. Saya sering lupa melakukan konversi eksplisit dengan as int sebelum menjumlahkan nilai skor ke variabel berjenis numerik. Hal ini menyebabkan eror kompilasi karena Dart menerapkan type safety secara ketat pada tipe data generik.