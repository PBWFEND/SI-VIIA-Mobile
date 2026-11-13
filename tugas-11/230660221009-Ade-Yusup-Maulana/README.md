# Tugas 11 — Integrasi Fitur Perangkat

## Identitas Mahasiswa

- **Nama:** Ade Yusup Maulana
- **NIM:** 230660221009
- **Program Studi:** Sistem Informasi
- **Mata Kuliah:** Pemrograman Aplikasi Bergerak
- **Pertemuan:** 11

## Deskripsi Aplikasi

Aplikasi ini merupakan implementasi integrasi fitur perangkat pada Flutter menggunakan kamera dan galeri.

Aplikasi memungkinkan pengguna mengambil foto secara langsung atau memilih gambar dari galeri untuk dokumentasi kondisi ruangan atau fasilitas.

## Fitur Aplikasi

1. Mengambil foto menggunakan kamera.
2. Memilih foto dari galeri.
3. Menampilkan pratinjau gambar.
4. Menampilkan indikator loading.
5. Menangani pembatalan pemilihan gambar.
6. Menampilkan pesan ketika terjadi kesalahan.

## Teknologi yang Digunakan

- Flutter
- Dart
- Package `image_picker`

## Struktur Folder

```text
tugas-11/
├── lib/
│   ├── main.dart
│   ├── pages/
│   │   └── halaman_foto.dart
│   └── services/
│       └── foto_service.dart
├── android/
├── ios/
├── web/
├── pubspec.yaml
├── README.md
├── dokumen-fitur-perangkat.md
├── skenario-pengujian.md
├── refleksi.md
└── quiz-pertemuan-11.md
```

## Instalasi Dependensi

Jalankan perintah:

```bash
flutter pub get
```

Package utama:

```yaml
image_picker: ^1.1.2
```

## Cara Menjalankan Aplikasi

Jalankan aplikasi melalui Chrome:

```bash
flutter run -d chrome
```

Untuk menjalankan pada perangkat Android:

```bash
flutter devices
flutter run -d <device_id>
```

## Pemeriksaan Kode

Untuk memeriksa kesalahan kode, jalankan:

```bash
flutter analyze
```

## Dokumentasi Tugas

- `dokumen-fitur-perangkat.md`: penjelasan fitur perangkat.
- `skenario-pengujian.md`: skenario dan hasil pengujian.
- `quiz-pertemuan-11.md`: jawaban kuis pertemuan 11.
- `refleksi.md`: refleksi penggunaan AI dalam pengerjaan tugas.