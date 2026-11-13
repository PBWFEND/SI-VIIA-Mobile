# Catatan Integrasi API — Tugas 9

| | |
|:--|:--|
| **Nama** | Fajar |
| **NIM** | 230660221093 |
| **Kelas** | SI-VIIA |
| **Domain** | Usaha mikro jasa — Glazent.pro (glass cleaning & nanocoating) |

---

## 1. Endpoint yang Digunakan

API yang dipakai adalah API tiruan publik `jsonplaceholder.typicode.com`, sesuai contoh pada materi Pertemuan 9. Backend Glazent.pro yang sebenarnya belum tersedia.

| Operasi | Metode HTTP | URL Endpoint | Payload Request |
|:--------|:------------|:-------------|:----------------|
| Ambil daftar pesanan (F-02) | GET | `https://jsonplaceholder.typicode.com/posts?_limit=8` | — |
| Kirim pesanan baru (F-01) | POST | `https://jsonplaceholder.typicode.com/posts` | `{"title": "Cleaning Kaca Rumah", "body": "Jl. Merdeka No. 10 — Senin, 2 Nov", "status": "menunggu", "userId": 1}` |

Header pada POST: `Content-Type: application/json; charset=UTF-8`.

Contoh response POST yang berhasil (HTTP 201): server memantulkan data yang dikirim dan menambahkan `"id": 101`.

Keterbatasan API tiruan:
- Data yang dikirim lewat POST tidak benar-benar tersimpan, sehingga pesanan baru tidak muncul pada daftar GET berikutnya. Bukti POST berhasil adalah SnackBar yang menampilkan `id` dari server.
- Isi `title` dan `body` pada GET berupa teks acak (bahasa Latin), bukan nama layanan Glazent.pro.
- Operasi Update dan Delete (PATCH, DELETE) tidak dikerjakan karena cakupan Pertemuan 9 hanya GET dan POST.

## 2. Struktur Model Data

Model `DataPesanan` melanjutkan model Tugas 7. Karena API tiruan hanya memiliki field `title` dan `body`, field `alamat` dan `tanggal` pada Tugas 7 digabung menjadi satu field `keterangan`.

| Field | Tipe Dart | Key JSON | Sumber Nilai |
|:------|:----------|:---------|:-------------|
| `id` | `int` | `"id"` | Server (default `0` bila tidak ada) |
| `layanan` | `String` | `"title"` | Form pemesanan, field "Jenis Layanan" (default `'Tanpa Nama Layanan'`) |
| `keterangan` | `String` | `"body"` | Form pemesanan, gabungan "Alamat" dan "Tanggal Layanan" dengan format `alamat — tanggal` (default `'-'`) |
| `status` | `String` | `"status"` | Klien mengirim `'menunggu'` saat POST; pada GET API tiruan tidak mengirim status, sehingga bernilai `'menunggu'` melalui nilai default |

Pembacaan JSON memakai `factory DataPesanan.fromJson` dengan operator `??` untuk setiap field, dan pengiriman memakai `toJson`.

## 3. Penanganan Error

Seluruh pemanggilan HTTP berada pada `PesananService` (`service-api.dart`) dan dibungkus `try-catch` dengan batas waktu 10 detik (`.timeout`). Semua kegagalan diubah menjadi `ApiException` yang berisi pesan siap tampil, sehingga widget hanya perlu menampilkan `pesan` tanpa memeriksa jenis error.

| Kondisi | Penyebab | Pesan kepada Pengguna |
|:--------|:---------|:----------------------|
| `TimeoutException` | Server tidak menjawab dalam 10 detik | Waktu tunggu habis. Periksa koneksi internet Anda. |
| `http.ClientException` | Tidak ada koneksi, alamat server salah, atau permintaan diblokir peramban | Tidak dapat terhubung ke server. Periksa koneksi internet Anda. |
| HTTP 400 | Data yang dikirim tidak valid | Data yang dikirim tidak valid (HTTP 400). |
| HTTP 404 | Endpoint tidak ditemukan | Data tidak ditemukan di server (HTTP 404). |
| HTTP 5xx | Kesalahan di sisi server | Server sedang bermasalah (HTTP 5xx). Coba lagi nanti. |
| Status lain (mis. 403) | Permintaan ditolak | Permintaan ditolak server (HTTP kode). |
| `FormatException` | Body response bukan JSON yang valid | Format data dari server tidak dikenali. |
| Kesalahan lain | Mis. JSON berupa objek padahal diharapkan daftar | Terjadi kesalahan tak terduga: detail. |

Penanganan pada antarmuka (`halaman-api.dart`):
- **Loading:** `CircularProgressIndicator` tampil selama GET berlangsung.
- **Error:** pesan dari `ApiException` tampil dengan ikon dan tombol "Coba Lagi" yang memanggil ulang GET.
- **Kirim pesanan:** tombol "Kirim Pemesanan" dinonaktifkan selama POST berlangsung agar tidak terjadi pesanan ganda, dan kegagalan ditampilkan lewat SnackBar berwarna error.
- **Keamanan state:** setiap `setState` setelah `await` didahului pemeriksaan `mounted`.

## 4. Cara Mengambil Tangkapan Layar

| File | Cara Memicu |
|:-----|:------------|
| `screenshot-loading.png` | Ubah `jedaUji` pada `service-api.dart` menjadi `Duration(seconds: 3)`, jalankan ulang, lalu tangkap layar saat indikator berputar. Kembalikan ke `Duration.zero` setelahnya |
| `screenshot-sukses.png` | Jalankan normal, tunggu daftar tampil, lalu tangkap layar |
| `screenshot-error.png` | Ubah `_baseUrl` pada `service-api.dart` menjadi `'https://jsonplaceholder.typicode.com/salah'`, jalankan ulang, lalu tangkap layar pesan error. Kembalikan URL setelahnya |
