# Tugas 2 - Modul Hitung Nilai

**Nama:** Sharel Faturahman  
**NPM:** 230660221108  
**Kelas:** SI-VIIA  
**Mata kuliah:** Pemrograman Aplikasi Bergerak

## Penjelasan program

Program menyimpan lima komponen dalam `List<Map<String, Object>>` dengan kunci yang konsisten: `nama` bertipe `String`, serta `bobot` dan `skor` bertipe `int`.
Total bobot adalah 100 dan setiap skor tidak melebihi bobot komponennya.

Fungsi `double hitungRataRata(List<Map<String, Object>> komponen)` menghitung jumlah seluruh skor dibagi jumlah komponen, sesuai panduan.
Data program menghasilkan `(28 + 24 + 18 + 13 + 9) / 5 = 18,4`.
Perhitungan menggunakan skor mentah, tanpa normalisasi ke persentase; daftar kosong menghasilkan `0.0` untuk menghindari pembagian dengan nol.

Fungsi `String predikat(double nilai)` menggunakan rentang berikut pada rata-rata skor mentah, termasuk nilai desimal:

| Rentang nilai | Predikat |
|---|---|
| `nilai >= 18` | A |
| `16 <= nilai < 18` | B |
| `12 <= nilai < 16` | C |
| `nilai < 12` | Perlu perbaikan |

`main()` mencetak nama mata kuliah, semua komponen, rata-rata, lalu predikat berdasarkan rata-rata tersebut.

## Cara menjalankan

Jalankan melalui Command Prompt pada komputer yang telah memiliki Dart SDK:

```cmd
cd /d "D:\KULIAH\semester 7\sharel\SI-VIIA-Mobile\tugas-2\230660221108-SharelFaturahman"
dart hitung_nilai.dart
```

## Hasil eksekusi aktual

Keluaran berikut direkam langsung dari `dart hitung_nilai.dart` menggunakan Dart SDK 3.13.4 pada Windows.
Program selesai tanpa error dengan kode keluar `0`.

```text
Mata kuliah: Pemrograman Aplikasi Bergerak
Tugas: bobot=30, skor=28
Praktikum: bobot=25, skor=24
Kuis: bobot=20, skor=18
UTS: bobot=15, skor=13
UAS: bobot=10, skor=9
Rata-rata skor: 18.40
Predikat: A
```

## Refleksi

Sintaks dasar Dart yang paling perlu saya waspadai adalah operator pembagian `/` karena mudah tertukar dengan `~/` yang menghasilkan pembagian bulat. Pada `hitungRataRata`, penggunaan `~/` akan membuang bagian desimal sehingga 92 dibagi 5 menjadi 18, padahal hasil yang diperlukan adalah 18,4. Saya menggunakan `/` agar hasilnya bertipe `double` dan tetap mempertahankan pecahan untuk penentuan predikat.

## Acuan

- [Timeline PAB, bagian SI-VIIA](https://github.com/PBWFEND/PAB/blob/main/TIMELINE.md).
- [Materi Pertemuan 2: Dasar Dart](https://github.com/PBWFEND/PAB/blob/main/pertemuan-02/02-Pertemuan-2.md).
- [Panduan Tugas 2](https://github.com/PBWFEND/PAB/blob/main/pertemuan-02/contoh-tugas-2-mahasiswa.md).
