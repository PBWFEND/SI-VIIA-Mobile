# Catatan Integrasi API — Tugas 9

**Nama:** Tira Azzahra | **NIM:** 230660221021 | **Kelas:** SI-VIIA
**Domain:** SI Perpustakaan Kampus

## 1. Endpoint yang Digunakan

| Operasi | Metode HTTP | URL Endpoint | Payload Request |
|:--------|:-----------|:-------------|:----------------|
| Ambil daftar pengajuan | GET | `https://jsonplaceholder.typicode.com/posts?_limit=10` | — |
| Kirim pengajuan baru | POST | `https://jsonplaceholder.typicode.com/posts` | `{"userId": 21, "title": "judul buku", "body": "catatan"}` |

## 2. Struktur Model Data

| Field Dart | Tipe Dart | Key JSON | Sumber Nilai | Default jika null |
|:-----------|:----------|:---------|:-------------|:------------------|
| `id` | `int` | `"id"` | Server | `0` |
| `idPemohon` | `int` | `"userId"` | User/Server | `0` |
| `judulBuku` | `String` | `"title"` | User | `'Tanpa Judul'` |
| `catatan` | `String` | `"body"` | User | `'-'` |

## 3. Penanganan Error

- **Timeout 10 detik** pada setiap request (`.timeout(Duration(seconds: 10))`) agar aplikasi tidak loading selamanya saat server lambat.
- **Pengecekan status code**: GET harus `200`, POST harus `201`; selain itu dilempar `Exception` dengan pesan HTTP code-nya.
- **try-catch berlapis**: `TimeoutException` ditangkap terpisah agar pesan error ke pengguna lebih spesifik ("periksa koneksi internet").
- **Di UI**: error ditampilkan sebagai ikon awan merah + pesan + tombol **Coba Lagi** yang memanggil ulang `_muatData()`. Tombol kirim dinonaktifkan selama proses POST untuk mencegah pengiriman ganda.