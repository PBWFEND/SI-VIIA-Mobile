# Tugas 9 — Implementasi Konsumsi REST API

**Nama aplikasi:** Perpustakaan Kampus API  
**Nama:** Nazwa Aulia Rachma  
**NIM:** 230660221104  
**Domain:** Sistem informasi perpustakaan

## Deskripsi

Tugas ini menambahkan lapisan service REST API pada katalog perpustakaan. Aplikasi mengambil daftar buku melalui GET, mengirim buku baru melalui POST, mem-parsing JSON menjadi model `BukuApi`, dan menampilkan kondisi loading, sukses, atau error dengan tombol retry.

## Berkas

- `service-api.dart` — model, factory `fromJson`, GET, POST, timeout, dan error handling.
- `halaman-api.dart` — UI katalog, form POST, loading, sukses, error, dan retry.
- `screenshot-loading.png` — bukti indikator loading.
- `screenshot-sukses.png` — bukti data API berhasil tampil.
- `screenshot-error.png` — bukti pesan error dan tombol Coba Lagi.
- `catatan-integrasi-api.md` — endpoint, model, dan strategi error.

## Cara menjalankan

Tambahkan dependency HTTP pada proyek Flutter:

```bash
flutter pub add http
```

Salin `service-api.dart` dan `halaman-api.dart` ke folder `lib/`, lalu jalankan:

```bash
flutter run -d chrome
```

## Refleksi

Bagian yang paling sulit dipahami adalah hubungan antara `Future`, parsing JSON, dan perubahan kondisi UI karena hasil jaringan tidak tersedia secara langsung. Saya memisahkan service dari widget agar `try-catch`, timeout, status code, dan `fromJson` dapat diuji tanpa mencampurnya dengan layout. Setelah itu `FutureBuilder` membuat alur loading, sukses, dan error lebih mudah ditelusuri.

## Deklarasi penggunaan AI

Deklarasi penggunaan AI: ChatGPT — membantu meninjau pemisahan service dan widget, pola parsing JSON, timeout, retry, serta kelengkapan dokumentasi; perbaikan kode, pengujian, dan penjelasan dilakukan serta diverifikasi oleh penulis.

## Entry point untuk screenshot

Folder `demo_states/` berisi tiga file `main()` terpisah untuk mengambil screenshot kondisi tertentu:

- `main-loading.dart` — indikator loading.
- `main-sukses.dart` — daftar data berhasil.
- `main-error.dart` — pesan error dan tombol Coba Lagi.

Salin salah satu file ke `lib/main.dart`, jalankan `flutter run -d chrome`, lalu ambil screenshot sesuai nama kondisinya.
