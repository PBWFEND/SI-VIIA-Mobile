# Catatan Integrasi API — Tugas 9

| Identitas | Detail |
|:---|:---|
| **Nama** | Nisa Rahmawati |
| **NIM** | 230660221023 |
| **Kelas** | SI-VIIA |
| **Domain Project** | Sistem Informasi Perpustakaan Kampus |

---

## 1. Endpoint yang Digunakan

| Operasi | Metode HTTP | URL Endpoint | Payload Request |
|:--------|:-----------|:-------------|:----------------|
| Ambil daftar buku | `GET` | `https://jsonplaceholder.typicode.com/posts` | — |
| Kirim data buku baru | `POST` | `https://jsonplaceholder.typicode.com/posts` | `{"title": "Sistem Basis Data", "judul": "Sistem Basis Data", "penulis": "Fathansyah", "kategori": "Sistem Informasi", "status": "Tersedia", "userId": 1}` |

---

## 2. Struktur Model Data

| Field | Tipe Dart | Key JSON | Sumber Nilai |
|:------|:----------|:---------|:-------------|
| `id` | `int` | `"id"` | Server (fallback `0`) |
| `judul` | `String` | `"judul"` / `"title"` | Server / Pemetaan katalog perpustakaan (fallback `'Tanpa Judul'`) |
| `penulis` | `String` | `"penulis"` / `"userId"` | Server / Form input (fallback `'Penulis Kampus'`) |
| `kategori` | `String` | `"kategori"` | Server / Form input (fallback `'Sistem Informasi'`) |
| `status` | `String` | `"status"` | Server / Form input (fallback `'Tersedia'`) |

---

## 3. Penanganan Error

1. **Isolasi `try-catch` pada Service Layer:** Seluruh pemanggilan `http.get` dan `http.post` di dalam kelas `PerpustakaanApiService` dibungkus dengan blok `try-catch` agar exception jaringan tidak menyebabkan *unhandled exception* pada UI.
2. **Batas Waktu Tunggu (`timeout`):** Setiap request HTTP dibatasi maksimal **10 detik** menggunakan `.timeout(const Duration(seconds: 10))`. Jika batas waktu terlewati, `TimeoutException` ditangkap dan diubah menjadi pesan ramah pengguna: *"Waktu tunggu habis (Timeout 10 detik). Periksa koneksi internet Anda."*
3. **Validasi HTTP Status Code:** Metode `GET` memeriksa `response.statusCode == 200` (dan menangani `404` secara spesifik), sedangkan metode `POST` memeriksa status `201` atau `200`. Kode status di luar kondisi sukses akan melempar `Exception` berisi nomor status HTTP terkait.
4. **Pemulihan Antarmuka (*Retry* & *Button Lock*):** Apabila terjadi error saat memuat daftar, layar menampilkan ikon peringatan, detail pesan error, dan tombol **Coba Lagi** untuk memanggil ulang `_muatKatalogBuku()`. Saat mengirim form `POST`, tombol kirim dinonaktifkan (`_sedangMengirim == true`) untuk mencegah pengiriman ganda.