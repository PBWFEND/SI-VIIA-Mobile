# Tugas 7 - CRUD Lokal Penjualan Warung

**Nama:** Amelia Oktaviani  
**NIM:** 230660221127  
**Kelas:** SI-VIIA  
**Mata Kuliah:** Pemrograman Aplikasi Bergerak

## 1. Deskripsi Aplikasi

Aplikasi Penjualan Warung merupakan aplikasi sederhana berbasis Flutter yang digunakan untuk mengelola data barang secara lokal.

Aplikasi menerapkan konsep CRUD (*Create, Read, Update, Delete*) menggunakan struktur data `List`, `StatefulWidget`, dan `setState()`.

## 2. Fitur Aplikasi

- Menampilkan daftar barang.
- Menambahkan barang baru.
- Mengedit data barang.
- Menghapus barang dengan konfirmasi.
- Menampilkan harga dan jumlah stok.
- Menampilkan status ketersediaan stok barang.

## 3. Struktur Data

Aplikasi menggunakan model `Barang` dengan atribut:

- `id`: identitas unik barang.
- `nama`: nama barang.
- `kategori`: kategori barang.
- `harga`: harga satuan barang.
- `stok`: jumlah stok barang.
- `batasStokMinimum`: batas minimum untuk menentukan status stok menipis.

## 4. Teknologi yang Digunakan

- Flutter
- Bahasa pemrograman Dart
- `MaterialApp` dan `Scaffold`
- `StatefulWidget`
- `List`
- `setState()`
- `TextEditingController`
- `Form` dan validasi input

## 5. Cara Menjalankan Aplikasi

1. Buka folder proyek menggunakan Visual Studio Code.
2. Buka terminal pada folder proyek.
3. Jalankan `flutter pub get`.
4. Jalankan `flutter run`.

## 6. Penyimpanan Data

Aplikasi menggunakan struktur data `List` sebagai penyimpanan sementara di dalam memori aplikasi. Data yang ditambahkan, diedit, atau dihapus dapat ditampilkan selama aplikasi berjalan.

Data belum disimpan ke database atau penyimpanan permanen. Oleh karena itu, data akan kembali ke kondisi awal ketika aplikasi dimulai ulang.

## 7. Dokumentasi

Dokumentasi screenshot digunakan sebagai bukti implementasi dan pengujian fitur daftar barang, pengisian form, serta konfirmasi penghapusan barang.