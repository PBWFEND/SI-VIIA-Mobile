# Catatan Integrasi API — Tugas 9

## 1. Endpoint yang Digunakan

| Operasi | Metode HTTP | URL Endpoint | Payload Request |
|:--------|:-----------|:-------------|:----------------|
| Ambil daftar | GET | `https://dummyjson.com/products?limit=8` | — |
| Kirim data baru | POST | `https://dummyjson.com/products/add` | `{"title":"...","category":"...","stock":1}` |

Endpoint DummyJSON dipakai sebagai layanan latihan; POST bersifat simulasi dan tidak dimaksudkan sebagai penyimpanan permanen.

## 2. Struktur Model Data

| Field | Tipe Dart | Key JSON | Sumber Nilai |
|:------|:----------|:---------|:-------------|
| `id` | `int` | `id` | Server |
| `judul` | `String` | `title` | Server atau form POST |
| `kategori` | `String` | `category` | Server atau form POST |
| `stok` | `int` | `stock` | Server |
| `status` | `String` | hasil perhitungan | `Tersedia` jika `stock > 0`, selain itu `Tidak tersedia` |

Factory `BukuApi.fromJson` memakai `??` untuk nilai yang null atau tidak tersedia agar UI tetap memiliki nilai aman.

## 3. Lapisan Service

`BukuApiService` menyimpan seluruh kode `http.get` dan `http.post`. Widget hanya memanggil `fetchBuku()` dan `createBuku()`, sehingga antarmuka tidak bergantung langsung pada detail URL, header, atau parsing JSON.

POST mengirim header `Content-Type: application/json` dan body melalui `jsonEncode`. Kedua method memakai `try-catch` dan `timeout` 10 detik.

## 4. Penanganan Error dan Kondisi UI

- **Loading:** `FutureBuilder` menampilkan `CircularProgressIndicator` dan teks saat GET belum selesai.
- **Sukses:** data API dibaca melalui `ListView.builder` dan setiap item menampilkan judul, kategori, stok, serta status.
- **Error:** UI menampilkan pesan `ApiException`, ikon koneksi terputus, dan tombol **Coba Lagi** yang memanggil GET ulang.
- **POST:** tombol Kirim dinonaktifkan saat `_mengirim == true` dan label berubah menjadi `Mengirim...`.
- **Validasi:** judul dan kategori wajib diisi sebelum POST dipanggil.
