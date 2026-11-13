# Tugas 9 — Implementasi Konsumsi REST API

| | |
|:--|:--|
| **Nama** | Fajar |
| **NIM** | 230660221093 |
| **Kelas** | SI-VIIA |
| **Domain** | Usaha mikro jasa — Glazent.pro (glass cleaning & nanocoating) |

---

## 1. Deskripsi Singkat

Tugas ini mengganti data lokal Tugas 7 dengan data dari REST API. Layar "Status Pesanan Saya" mengambil daftar pesanan melalui HTTP GET (F-02) dan form pemesanan mengirim pesanan baru melalui HTTP POST (F-01). Logika jaringan dipisah pada [`service-api.dart`](service-api.dart) (model `DataPesanan` dengan `fromJson`/`toJson`, `PesananService` dengan GET dan POST, serta penanganan error), sedangkan antarmuka ada pada [`halaman-api.dart`](halaman-api.dart) dengan tiga kondisi: loading, sukses, dan error beserta tombol "Coba Lagi". Rincian endpoint, model, dan penanganan error ada pada [`catatan-integrasi-api.md`](catatan-integrasi-api.md).

## 2. Cara Menjalankan

Dari folder project Flutter (target web):

```bash
flutter pub add http
```

Salin `service-api.dart` dan `halaman-api.dart` ke folder `lib/`, lalu jalankan:

```bash
flutter run -d chrome -t lib/halaman-api.dart
```

## 3. Bukti Eksekusi

| Kondisi | Berkas |
|:--------|:-------|
| Indikator loading aktif | [`screenshot-loading.png`](screenshot-loading.png) |
| Data berhasil dimuat | [`screenshot-sukses.png`](screenshot-sukses.png) |
| Pesan error tampil | [`screenshot-error.png`](screenshot-error.png) |

## 4. Refleksi

Bagian yang paling sulit bagi saya adalah asynchronous programming, terutama memahami mengapa await pada http.get membuat fungsi harus ditandai async dan mengembalikan Future, padahal kodenya terlihat berjalan berurutan seperti biasa. Saya sering bingung kapan data benar-benar sudah tersedia: kalau lupa menulis await, variabel yang saya terima ternyata Future dan bukan datanya, sehingga muncul error tipe yang pesannya sulit saya baca. Parsing JSON dengan fromJson dan operator ?? serta try-catch dengan timeout terasa lebih mudah, karena polanya jelas dan hasilnya bisa langsung dilihat, sedangkan alur async sulit saya bayangkan karena kodenya tidak berjalan sesuai urutan baris yang saya tulis.

## 5. Deklarasi Penggunaan AI

Deklarasi penggunaan AI: Claude (Anthropic) — membantu menyusun kerangka model data, service GET/POST, penanganan error, antarmuka tiga kondisi, dan catatan integrasi API berdasarkan domain Glazent.pro dari Tugas 7; perbaikan kode, pengujian, dan penjelasan dilakukan serta diverifikasi oleh penulis.
