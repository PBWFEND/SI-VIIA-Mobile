# Dokumentasi Fitur Perangkat — Tugas 11

**Nama:** Ade Yusup Maulana  
**NIM:** 230660221009  
**Program Studi:** Sistem Informasi  
**Mata Kuliah:** Pemrograman Aplikasi Bergerak  

## 1. Nama Fitur

Integrasi fitur kamera dan galeri pada aplikasi Flutter menggunakan package `image_picker`.

## 2. Tujuan Fitur

Fitur ini digunakan untuk mengambil foto secara langsung menggunakan kamera perangkat atau memilih gambar yang sudah tersimpan di galeri. Foto digunakan sebagai bukti dokumentasi kondisi ruangan atau fasilitas sebelum digunakan.

## 3. Aktor yang Terlibat

Pengguna aplikasi, yaitu mahasiswa atau pemohon yang melakukan dokumentasi kondisi ruangan.

## 4. Data yang Dihasilkan

Data yang dihasilkan berupa:
- File gambar dengan format yang didukung perangkat.
- Nama file gambar.
- Data gambar untuk ditampilkan sebagai pratinjau aplikasi.

## 5. Izin Akses

Aplikasi menggunakan akses perangkat sesuai fitur yang dipilih.

- **Kamera:** diperlukan ketika pengguna mengambil foto secara langsung.
- **Galeri:** digunakan ketika pengguna memilih gambar yang sudah tersedia.
- Jika akses ditolak atau tidak tersedia, aplikasi perlu menampilkan informasi kepada pengguna.

## 6. Batasan Platform

- Android: menggunakan kamera dan pemilih gambar perangkat.
- Web: menggunakan pemilih file browser; dukungan kamera bergantung pada browser dan perangkat.
- iOS: mengikuti ketentuan izin akses kamera dan foto pada sistem operasi.
- Fitur membutuhkan perangkat atau lingkungan pengujian yang mendukung akses gambar.

## 7. Teknologi yang Digunakan

- Flutter dan bahasa pemrograman Dart.
- Package `image_picker`.
- Package `cross_file` melalui dependensi image_picker.

## 8. Kesimpulan

Fitur kamera dan galeri berhasil diimplementasikan pada aplikasi Flutter. Pengguna dapat memilih gambar dan melihat hasilnya melalui pratinjau aplikasi. Fitur ini membantu proses dokumentasi kondisi ruangan atau fasilitas secara digital.