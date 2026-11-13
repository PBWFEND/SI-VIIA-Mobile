
# TUGAS 9 — INTEGRASI REST API

## Identitas Mahasiswa

| Keterangan | Data |
|---|---|
| Nama | Ade Yusup Maulana |
| NIM | 230660221009 |
| Program Studi | Sistem Informasi |
| Fakultas | Fakultas Teknologi Informasi |
| Universitas | Universitas Sebelas April |
| Kelas | SI-VIIA |
| Mata Kuliah | Pemrograman Berbasis Framework |
| Pertemuan | 9 |
| Materi | Integrasi REST API |

## Deskripsi Project

Project ini merupakan pengembangan aplikasi Flutter PAB - Penjualan Warung yang sebelumnya telah memiliki fitur CRUD (Create, Read, Update, Delete) dan penyimpanan data lokal menggunakan SharedPreferences.

Pada Tugas 9, aplikasi dikembangkan dengan menambahkan integrasi REST API menggunakan package http.

Integrasi API menggunakan JSONPlaceholder sebagai layanan API publik untuk mengambil dan mengirim data melalui metode HTTP GET dan POST.

## Fitur yang Dikembangkan

1. Mengambil daftar data dari REST API menggunakan HTTP GET.
2. Mengirim data baru menggunakan HTTP POST.
3. Mengubah data JSON menjadi objek Dart menggunakan fromJson().
4. Menampilkan indikator loading ketika mengambil data.
5. Menampilkan data ketika permintaan berhasil.
6. Menampilkan pesan error ketika permintaan gagal.
7. Menyediakan tombol Coba Lagi untuk mengulangi permintaan.
8. Menggunakan try-catch dan timeout untuk penanganan kesalahan.

## Teknologi yang Digunakan

- Flutter
- Dart
- Package http
- JSON
- REST API
- JSONPlaceholder

## Struktur File

```text
230660221009-Ade-Yusup-Maulana/
├── README.md
├── service-api.dart
├── halaman-api.dart
├── screenshot-loading.png
├── screenshot-sukses.png
├── screenshot-error.png
└── catatan-integrasi-api.md
```

## Dokumentasi Screenshot

| Screenshot | Keterangan |
|---|---|
| screenshot-loading.png | Tampilan indikator loading saat mengambil data API |
| screenshot-sukses.png | Tampilan data berhasil diambil dan dikirim |
| screenshot-error.png | Tampilan ketika terjadi kesalahan koneksi atau permintaan API |

## Refleksi

Melalui Tugas 9, saya memahami cara menghubungkan aplikasi Flutter dengan REST API menggunakan package http. Saya mempelajari penggunaan HTTP GET dan POST, parsing JSON, serta penanganan loading dan error pada aplikasi. Pengembangan ini menambah pemahaman saya mengenai komunikasi data antara aplikasi Flutter dan server melalui REST API.

## Deklarasi Penggunaan AI

Dalam pengerjaan tugas ini, saya menggunakan ChatGPT sebagai alat bantu pembelajaran untuk memahami konsep REST API, memberikan arahan penulisan kode, membantu pemeriksaan kesalahan, dan menjelaskan proses integrasi API.

Seluruh proses implementasi, pengujian, dan penyesuaian aplikasi dilakukan serta diperiksa kembali oleh saya.
