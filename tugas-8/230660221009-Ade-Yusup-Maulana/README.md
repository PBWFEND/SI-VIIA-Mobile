# UTS Pemrograman Berbasis Framework (PAB)

## Aplikasi Penjualan Warung

### Identitas Mahasiswa
- **Nama:** Ade Yusup Maulana
- **NIM:** 230660221009
- **Program Studi:** Sistem Informasi
- **Kelas:** SI-VIIA
- **Fakultas:** Teknologi Informasi
- **Universitas:** Universitas Sebelas April

## Deskripsi Aplikasi

Aplikasi Penjualan Warung merupakan aplikasi sederhana berbasis Flutter yang digunakan untuk mengelola data barang pada sebuah warung. Aplikasi ini dibuat menggunakan bahasa pemrograman Dart dan menerapkan penyimpanan data lokal menggunakan SharedPreferences.

## Fitur Aplikasi

1. **Menampilkan Barang** – Menampilkan daftar barang yang tersimpan.
2. **Tambah Barang** – Menambahkan nama barang, harga, dan stok.
3. **Edit Barang** – Mengubah informasi barang.
4. **Hapus Barang** – Menghapus barang melalui konfirmasi.
5. **Validasi Formulir** – Memastikan nama, harga, dan stok diisi dengan benar.
6. **Penyimpanan Lokal** – Mempertahankan data setelah aplikasi dimuat ulang menggunakan SharedPreferences.

## Teknologi yang Digunakan

- Flutter
- Dart
- Visual Studio Code
- SharedPreferences

## Cara Menjalankan Aplikasi

1. Pastikan Flutter sudah terpasang.
2. Buka folder proyek Flutter.
3. Jalankan perintah:

   ```bash
   flutter pub get
   ```

4. Jalankan aplikasi:

   ```bash
   flutter run
   ```

## Dokumentasi Pengujian

Dokumentasi pengujian aplikasi terdapat pada file berikut:

- `screenshot-daftar.png` – Tampilan daftar barang.
- `screenshot-form.png` – Tampilan formulir dan validasi.
- `screenshot-hapus.png` – Konfirmasi penghapusan barang.

## Struktur Folder Pengumpulan

```text
230660221009-Ade-Yusup-Maulana/
├── README.md
├── laporan-progress-uts.md
├── tes-konsep-uts.md
├── screenshot-daftar.png
├── screenshot-form.png
└── screenshot-hapus.png
```

## Penyimpanan Data

Data barang disimpan secara lokal menggunakan SharedPreferences dalam format JSON. Data dapat dimuat kembali ketika aplikasi dibuka atau halaman dimuat ulang.

## Penutup

Aplikasi ini dibuat sebagai bagian dari Ujian Tengah Semester mata kuliah Pemrograman Berbasis Framework (PAB), dengan menerapkan konsep pengelolaan data, validasi formulir, operasi CRUD, dan penyimpanan data lokal.