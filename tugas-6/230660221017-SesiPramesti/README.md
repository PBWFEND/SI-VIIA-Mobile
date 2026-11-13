# Tugas 6 — Navigation Flow dan Interaksi

## 1. Identitas Proyek

| Keterangan | Detail |
|---|---|
| Nama Aplikasi | SI-FASKAM |
| Nama Sistem | Sistem Informasi Pengaduan Fasilitas Kampus |
| Nama Mahasiswa | Sesi Pramesti |
| NIM | 230660221017 |
| Mata Kuliah | PAB |
| Tugas | Tugas 6 — Navigation Flow dan Interaksi |

## 2. Deskripsi Aplikasi

SI-FASKAM merupakan aplikasi Sistem Informasi Pengaduan Fasilitas Kampus yang dirancang untuk membantu mahasiswa menyampaikan pengaduan terkait fasilitas kampus.

Aplikasi ini memiliki beberapa halaman utama, yaitu:

1. **Beranda:** Menampilkan daftar pengaduan yang tersedia.
2. **Formulir Pengaduan:** Digunakan untuk memasukkan informasi pengaduan.
3. **Konfirmasi Pengaduan:** Menampilkan informasi bahwa pengaduan berhasil dibuat.
4. **Detail Pengaduan:** Menampilkan informasi lengkap mengenai pengaduan yang dipilih.

## 3. Implementasi Navigasi dan Interaksi

Implementasi Tugas 6 menggunakan beberapa fitur Flutter, yaitu:

- `MaterialApp` untuk mengatur konfigurasi aplikasi.
- `initialRoute` untuk menentukan halaman awal aplikasi.
- `routes` untuk mendefinisikan named route.
- `Navigator.pushNamed()` untuk berpindah halaman.
- `Navigator.pop()` untuk kembali ke halaman sebelumnya.
- `arguments` untuk mengirimkan data pengaduan antarhalaman.
- `Form` dan `GlobalKey<FormState>` untuk mengelola validasi formulir.
- `TextEditingController` untuk mengelola input pengguna.
- `SnackBar` untuk memberikan feedback kepada pengguna.

## 4. Struktur File Tugas

```text
tugas-6/
└── [NIM]-[Nama]/
    ├── navigation-flow.md
    ├── form-interaksi.dart
    ├── catatan-keputusan-navigasi.md
    ├── screenshot-alur.png
    ├── screenshot-feedback.png
    └── README.md
```

## 5. Dokumentasi Screenshot

### Screenshot Alur Navigasi

File: `screenshot-alur.png`

Berisi dokumentasi tampilan atau proses perpindahan halaman pada aplikasi SI-FASKAM, mulai dari Beranda hingga halaman Detail Pengaduan.

### Screenshot Feedback

File: `screenshot-feedback.png`

Berisi dokumentasi feedback aplikasi, seperti pesan SnackBar setelah pengguna melakukan tindakan pada aplikasi.

## 6. Pernyataan Penggunaan AI

Dalam pengerjaan Tugas 6 ini, AI digunakan sebagai alat bantu untuk memahami materi navigasi Flutter, memberikan saran implementasi kode, serta membantu penyusunan dokumentasi tugas.

Seluruh hasil bantuan AI diperiksa dan disesuaikan kembali dengan struktur serta kebutuhan aplikasi SI-FASKAM.

## 7. Refleksi

Melalui pengerjaan Tugas 6, saya memahami cara menerapkan navigasi antarhalaman menggunakan named route, `Navigator.pushNamed()`, dan `Navigator.pop()` pada Flutter. Saya juga mempelajari cara mengirimkan data antarhalaman menggunakan arguments serta melakukan validasi formulir agar data yang dimasukkan pengguna sesuai dengan ketentuan. Dari tugas ini, saya memahami pentingnya navigasi dan feedback dalam membangun aplikasi yang lebih terstruktur dan mudah digunakan.