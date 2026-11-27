# Tugas 9 — Integrasi REST API (PresenGo)

- **Nama:** Amelia Putri Latifah
- **NIM:** 230660221101
- **Kelas:** SI-VIIA
- **Domain SI:** Sistem Absensi Organisasi (PresenGo)

## Daftar Berkas
- `service-api.dart`
- `halaman-api.dart`
- `screenshot-loading.png`
- `screenshot-sukses.png`
- `screenshot-error.png`
- `catatan-integrasi-api.md`
- `README.md`

## Refleksi Pembelajaran
Melalui praktikum integrasi REST API pada aplikasi PresenGo ini, saya memahami bagaimana aplikasi Flutter berkomunikasi secara asinkron dengan server terpusat menggunakan `Future`, `async/await`, dan `package:http` agar antarmuka tidak membeku saat menunggu respons jaringan. Pemisahan logika HTTP ke dalam lapisan `Service` serta penggunaan model `fromJson` dan `toJson` membuat pengelolaan data JSON jauh lebih terstruktur dan aman dari kesalahan tipe data. Selain itu, penanganan tiga kondisi tampilan (`loading`, `sukses`, dan `error` dengan tombol *retry*) memastikan pengguna tetap mendapatkan umpan balik yang jelas ketika terjadi gangguan koneksi atau batas waktu habis.

## Deklarasi Penggunaan AI
Deklarasi penggunaan AI: Gemini — membantu menyusun struktur lapisan service HTTP GET/POST, pemetaan model `fromJson`/`toJson`, serta penanganan tiga state antarmuka; seluruh kode, pengujian di browser, dan pengambilan screenshot diverifikasi langsung oleh penulis.