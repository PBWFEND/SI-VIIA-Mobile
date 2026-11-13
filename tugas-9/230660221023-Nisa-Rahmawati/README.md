# Pengumpulan Tugas 9: Implementasi Konsumsi REST API

| Identitas | Detail |
|:---|:---|
| **Nama** | Nisa Rahmawati |
| **NIM** | 230660221023 |
| **Kelas** | SI-VIIA |
| **Mata Kuliah** | Pemrograman Aplikasi Bergerak |
| **Domain SI** | Sistem Informasi Perpustakaan Kampus |
| **Repository** | [PBWFEND/SI-VIIA-Mobile](https://github.com/PBWFEND/SI-VIIA-Mobile) |

---

## 1. Berkas Pengumpulan Tugas 9

1. **`service-api.dart`** — Lapisan service terisolasi yang mengelola model data `BukuApi`, parsing JSON, pemanggilan HTTP `GET` dan `POST`, header JSON, `timeout`, serta penanganan exception jaringan.
2. **`halaman-api.dart`** — Antarmuka pengguna yang menangani 3 kondisi state (*loading*, *sukses dengan ListView*, dan *error dengan tombol retry*) serta form input `POST` dengan tombol kirim yang dinonaktifkan (*state-locked*) saat pengiriman data.
3. **`catatan-integrasi-api.md`** — Catatan teknis yang memuat tabel endpoint, pemetaan struktur JSON ke model Dart, serta strategi penanganan error dan timeout.
4. **`screenshot-loading.png`** — Tangkapan layar bukti indikator loading aktif saat data sedang dimuat dari server API.
5. **`screenshot-sukses.png`** — Tangkapan layar bukti data katalog buku berhasil dimuat dan dirender dalam `ListView.builder`.
6. **`screenshot-error.png`** — Tangkapan layar bukti pesan error informatif dan tombol "Coba Lagi" saat kegagalan endpoint terjadi.

---

## 2. Refleksi Pembelajaran (Tepat 3 Kalimat)

Di antara ketiga materi utama, bagian penanganan error (*error handling*) merupakan aspek yang paling sulit saya pahami karena memerlukan simulasi berbagai kondisi kegagalan jaringan seperti *timeout* dan *HTTP status code* secara tepat. Kesulitan ini muncul karena saya harus memetakan setiap kemungkinan pengecualian (*exception*) agar antarmuka pengguna tetap stabil tanpa memicu *app crash*. Namun, setelah mencoba mengombinasikan blok `try-catch` dengan tombol *retry* pada Flutter, saya dapat memahami alur penanganan kondisi batas tersebut secara menyeluruh.

---

## 3. Deklarasi Penggunaan AI

Deklarasi penggunaan AI: ChatGPT & Gemini — digunakan sebagai *coding assistant* untuk mengecek sintaksis penanganan `TimeoutException`, simulasi payload JSON, serta validasi kelengkapan berkas sesuai rubrik Tugas 9; seluruh penulisan logika bisnis, perbaikan kode, dan verifikasi akhir dilakukan secara mandiri oleh mahasiswa.

---

## 4. Cara Menjalankan Aplikasi

### Jalur 1: DartPad (Browser)
1. Buka [https://dartpad.dev](https://dartpad.dev).
2. Gabungkan isi `service-api.dart` dan `halaman-api.dart` ke dalam satu lembar kerja DartPad.
3. Klik **Run** untuk menguji pemanggilan REST API secara langsung.

### Jalur 2: Flutter SDK (Target Web / Chrome)
```cmd
flutter pub add http
flutter run -d chrome