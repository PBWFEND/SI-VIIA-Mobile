# Catatan Integrasi API — Tugas 9

## 1. Endpoint yang Digunakan

Endpoint berasal dari JSONPlaceholder, yaitu API demo yang mendukung GET dan POST untuk latihan. Respons POST pada endpoint demo tidak dimaksudkan sebagai penyimpanan permanen, tetapi cukup untuk membuktikan alur pengiriman data dari aplikasi.

| Operasi | Metode HTTP | URL Endpoint | Payload Request |
|:--------|:-----------|:-------------|:----------------|
| Ambil daftar | GET | https://jsonplaceholder.typicode.com/posts?_limit=8 | — |
| Kirim data baru | POST | https://jsonplaceholder.typicode.com/posts | {"title":"Top Up E-Wallet","amount":75000,"type":"Pengeluaran","category":"E-Wallet","body":"Dikirim dari form","userId":1} |

## 2. Struktur Model Data

| Field | Tipe Dart | Key JSON | Sumber Nilai |
|:------|:----------|:---------|:-------------|
| id | int | id | Server; fallback 0 |
| nama | String | title | Server; fallback Transaksi tanpa nama |
| jumlah | int | amount | Server; jika tidak ada dihitung dari userId |
| jenis | String | type | Server; jika tidak ada diturunkan dari userId |
| kategori | String | category | Server; fallback API Demo |
| tanggal | String | date | Server; fallback Data dari REST API |
| catatan | String | body | Server; fallback Catatan tidak tersedia |

Factory fromJson memakai operator null-aware dan nilai cadangan sehingga respons yang tidak lengkap tetap dapat ditampilkan. Payload POST memakai nama field API dan dikirim melalui jsonEncode.

## 3. Lapisan Service

Class TransaksiApiService berada di file service-api.dart dan menjadi satu-satunya tempat yang memanggil http.get dan http.post. Widget halaman hanya memanggil ambilTransaksi atau tambahTransaksi sehingga UI tidak bergantung pada detail URL, header, atau proses decoding JSON.

## 4. Penanganan Error

Setiap pemanggilan HTTP dibungkus try-catch dan diberi timeout 10 detik. Status selain kelompok 2xx menghasilkan ApiException dengan status code agar pesan kegagalan dapat dibedakan dari error jaringan. Timeout, JSON tidak valid, format respons salah, dan exception jaringan diubah menjadi pesan yang dapat dibaca pengguna. Pada halaman, error ditampilkan bersama tombol Coba Lagi yang memanggil GET ulang. Saat POST berjalan, tombol Kirim dinonaktifkan dan menampilkan CircularProgressIndicator agar pengguna tidak mengirim data berulang.

## 5. Tiga Kondisi Antarmuka

- Loading: _loading bernilai true dan halaman menampilkan CircularProgressIndicator.
- Sukses: data hasil GET disimpan pada state dan dibaca oleh ListView.builder.
- Error: _error berisi pesan ApiException, lalu halaman menampilkan pesan informatif dan tombol Coba Lagi.

## 6. Cara Menguji Error

Screenshot error dibuat dengan menjalankan build yang sama menggunakan nilai API_BASE_URL yang sengaja diarahkan ke endpoint yang salah. Kode sumber default tetap memakai endpoint yang benar, sedangkan variasi endpoint salah hanya dipakai untuk membuktikan bahwa kondisi error dan retry bekerja.
