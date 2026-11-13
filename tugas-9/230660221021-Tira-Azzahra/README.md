# Tugas 9 — Integrasi REST API

- **Nama:** Tira Azzahra
- **NIM:** 230660221021
- **Kelas:** SI-VIIA
- **Domain:** SI Perpustakaan Kampus (Pengajuan Peminjaman Buku)

## Isi Folder
| File | Keterangan |
|:--|:--|
| `service-api.dart` | Model data (`fromJson`/`toJson`) + service layer HTTP (GET & POST) |
| `halaman-api.dart` | Halaman UI: loading, sukses, error + retry, form POST |
| `screenshot-loading.png` | Bukti indikator loading |
| `screenshot-sukses.png` | Bukti data berhasil dimuat |
| `screenshot-error.png` | Bukti penanganan error + tombol Coba Lagi |
| `catatan-integrasi-api.md` | Tabel endpoint, model data, strategi error |

## Cara Menjalankan
1. Buat project Flutter: `flutter create app_uji && cd app_uji && flutter pub add http`
2. Salin `service-api.dart` dan `halaman-api.dart` ke folder `lib/`
3. Ganti isi `lib/main.dart` agar memanggil `HalamanPengajuanAPI`
4. Jalankan: `flutter run -d chrome`

## Refleksi (3 kalimat)
Bagian yang paling sulit saya pahami adalah asynchronous programming, karena saya harus memahami bahwa `await` menunda eksekusi tanpa membekukan UI dan state loading harus diatur manual sebelum-sesudah request. Parsing JSON menjadi lebih mudah setelah memakai pola factory `fromJson` dengan operator `??` untuk mencegah error null. Penanganan error juga menantang karena harus membedakan error timeout, error status code, dan error jaringan agar pesan ke pengguna tetap informatif.

## Deklarasi Penggunaan AI
Deklarasi penggunaan AI: ChatGPT/Claude — membantu menjelaskan pemetaan field JSON ke factory constructor `fromJson`, pola pemisahan service layer, dan strategi penanganan tiga state UI; kode, penanganan error, dan pengujian di Chrome diverifikasi oleh penulis.