
# Tugas 10 - Integrasi Data dan Proses Bisnis

## Identitas Mahasiswa

- Nama: Ade Yusup Maulana
- NIM: 230660221009
- Program Studi: Sistem Informasi
- Mata Kuliah: Pemrograman Aplikasi Bergerak
- Pertemuan: 10

## Deskripsi

Aplikasi ini merupakan implementasi integrasi data menggunakan Flutter dan REST API.

Aplikasi mengambil data dari dua endpoint, yaitu data pengguna dan data pengajuan. Kedua data tersebut kemudian digabungkan berdasarkan identifier userId.

## Endpoint API

1. Data Pengguna:
   https://jsonplaceholder.typicode.com/users

2. Data Pengajuan:
   https://jsonplaceholder.typicode.com/posts

## Field Mapping

| Data Aplikasi | Field API | Keterangan |
|---|---|---|
| ID Pengguna | id | Identitas pengguna |
| Nama Pengguna | name | Nama pengguna |
| ID Pengajuan | id | Identitas pengajuan |
| User ID | userId | Penghubung pengguna dan pengajuan |
| Judul | title | Judul pengajuan |
| Deskripsi | body | Deskripsi pengajuan |

Catatan: API JSONPlaceholder digunakan sebagai simulasi data pengajuan. Data posts diperlakukan sebagai data pengajuan untuk keperluan pembelajaran.

## Struktur Folder

lib/
- main.dart
- models/
  - data_pengguna.dart
  - data_pengajuan.dart
- services/
  - integrasi_service.dart
- screens/
  - halaman_integrasi.dart

## Proses Integrasi

1. Aplikasi mengambil data pengguna dari endpoint /users.
2. Aplikasi mengambil data pengajuan dari endpoint /posts.
3. Kedua permintaan dijalankan menggunakan Future.wait.
4. Data digabungkan berdasarkan userId.
5. Hasil integrasi ditampilkan pada halaman aplikasi.

## Cara Menjalankan

1. Pastikan Flutter sudah terpasang.
2. Buka folder project melalui VS Code.
3. Jalankan perintah:

   flutter pub get

4. Jalankan aplikasi:

   flutter run -d chrome

## Fitur Aplikasi

- Menampilkan loading.
- Menampilkan data hasil integrasi.
- Menampilkan kondisi data kosong.
- Menampilkan pesan error.
- Tombol coba lagi.
- Refresh data.

## Bukti Pengujian

- screenshot-sukses.png
- screenshot-loading.png
- screenshot-error.png
