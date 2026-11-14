# Tugas 9: Implementasi Konsumsi REST API

| | |
|:--|:--|
| **Nama** | Galih Permana Sidik |
| **NIM** | 230660221002 |
| **Kelas** | SI-VIIA |
| **Project** | SiLapor Kampus (pelaporan kerusakan fasilitas kampus) |

## Deskripsi Singkat

Tugas ini mengganti data lokal Tugas 7 dengan data dari REST API. Halaman daftar mengambil laporan lewat GET dan menangani tiga kondisi (loading, sukses, error dengan tombol Coba Lagi), sedangkan form mengirim laporan baru lewat POST dengan tombol yang dinonaktifkan selama pengiriman. Seluruh kode HTTP berada di class `LaporanService` pada `service-api.dart`, terpisah dari widget. Backend SiLapor belum tersedia, sehingga endpoint simulasi JSONPlaceholder dipakai sebagai pengganti.

## Isi Folder

- `service-api.dart`: model `Laporan`, `LaporanBaru`, `ApiException`, dan `LaporanService` (GET, POST, timeout, error handling)
- `halaman-api.dart`: halaman daftar, form kirim, dan `main()`
- `catatan-integrasi-api.md`: tabel endpoint, struktur model, penanganan error, keputusan teknis
- `screenshot-loading.png`, `screenshot-sukses.png`, `screenshot-error.png`: bukti tiga kondisi

## Menjalankan Aplikasi

**DartPad:** buka [DartPad](https://dartpad.dev/?template=app), tempel isi `service-api.dart` lalu isi `halaman-api.dart` pada satu editor. Hapus baris `import 'service-api.dart';` karena kedua berkas kini satu, lalu tekan Run.

**Flutter SDK:**

1. Pada project hasil `flutter create`, jalankan `flutter pub add http`.
2. Salin `service-api.dart` dan `halaman-api.dart` ke folder `lib/`.
3. Jalankan `flutter run -d chrome -t lib/halaman-api.dart`.

Cara memicu tiga kondisi untuk tangkapan layar ada pada `catatan-integrasi-api.md` bagian 5.

## Refleksi

Bagian yang paling sulit bagi saya adalah penanganan error, karena satu kegagalan bisa datang dalam bentuk yang sangat berbeda (waktu tunggu habis, koneksi putus, kode 404 atau 5xx, JSON rusak, atau tipe data tidak cocok) dan semuanya harus berujung pada satu kalimat yang bisa dipahami mahasiswa yang sedang terburu-buru. Saya menampung semua jenis kegagalan itu di satu helper pada service yang mengubahnya menjadi `ApiException` berpesan jelas, sehingga halaman hanya perlu menangkap satu tipe error. Async dan parsing JSON terasa lebih jinak karena hasilnya langsung terlihat, sedangkan penanganan error baru terbukti bekerja bila alamat endpoint sengaja dirusak dan pesannya diperiksa di layar.

## Deklarasi Penggunaan AI

Claude dipakai untuk menyusun kerangka `LaporanService`, termasuk helper `_jalankan` yang memasang timeout dan `try-catch` pada setiap pemanggilan HTTP, serta untuk memetakan field JSON ke model `Laporan` lewat `fromJson` yang aman terhadap nilai null dan `toJson` untuk data yang dikirim. Claude juga membantu menyusun pola tiga kondisi (loading, sukses, error) pada `State`, pengecekan `mounted` setelah `await`, dan tombol kirim yang nonaktif selama request berjalan, lalu menulis draf tabel endpoint, struktur model, dan penanganan error pada catatan teknis. Seluruh hasilnya dibaca ulang dan dicocokkan dengan model Tugas 7 serta rencana endpoint pada laporan progress UTS.
