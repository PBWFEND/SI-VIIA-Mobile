# Tugas 8 - Ujian Tengah Semester (UTS)

**Nama:** Amelia Oktaviani  
**NIM:** 230660221127  
**Kelas:** SI-VIIA  
**Mata Kuliah:** Pemrograman Aplikasi Bergerak

## 1. Deskripsi Proyek

Proyek ini merupakan aplikasi mobile sederhana berbasis Flutter dengan tema **Penjualan Warung**. Aplikasi dibuat untuk membantu pengguna mengelola data barang, meliputi nama barang, kategori, harga, dan jumlah stok.

## 2. Teknologi

- Flutter
- Dart
- Material Design
- StatefulWidget
- List sebagai penyimpanan data sementara
- setState() untuk memperbarui tampilan

## 3. Fitur yang Diimplementasikan

- Menampilkan daftar barang.
- Menambahkan barang baru.
- Mengedit data barang.
- Menghapus barang dengan konfirmasi.
- Validasi input pada formulir.
- Menampilkan informasi harga dan stok barang.

## 4. Struktur Dokumentasi

| File | Keterangan |
|---|---|
| `kebutuhan.md` | Dokumen kebutuhan aplikasi |
| `information-architecture.md` | Struktur informasi aplikasi |
| `wireframe.png` | Rancangan antarmuka |
| `navigation-flow.md` | Alur navigasi |
| `catatan-keputusan-navigasi.md` | Catatan keputusan navigasi |
| `model-data.md` | Rancangan model data |
| `catatan-keputusan-data.md` | Catatan keputusan pengelolaan data |
| `crud-lokal.dart` | Implementasi CRUD lokal |
| `laporan-progress-uts.md` | Laporan perkembangan proyek |
| `tes-konsep-uts.md` | Lembar tes konsep UTS |
| `screenshot/` | Dokumentasi tampilan aplikasi |

## 5. Penyimpanan Data

Aplikasi menggunakan struktur data `List` untuk menyimpan data barang selama aplikasi berjalan. Data belum menggunakan database atau penyimpanan permanen sehingga dapat kembali ke kondisi awal ketika aplikasi dimulai ulang.

## 6. Cara Menjalankan Aplikasi

1. Buka folder proyek Flutter.
2. Jalankan `flutter pub get` melalui terminal.
3. Jalankan aplikasi menggunakan `flutter run`.

## 7. Repository

Repository: https://github.com/ameliaoktaviani/SI-VIIA-Mobile