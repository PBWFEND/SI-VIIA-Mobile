# UTS PAB: Tes Konsep dan Evaluasi Progress Project

| | |
|:--|:--|
| **Nama** | Galih Permana Sidik |
| **NIM** | 230660221002 |
| **Kelas** | SI-VIIA |
| **Project** | SiLapor Kampus (pelaporan kerusakan fasilitas kampus) |


Berkas aplikasi yang didemokan adalah `crud-lokal.dart` pada Tugas 7, yang melanjutkan kode Tugas 6.

## Menjalankan Aplikasi

1. Buka [DartPad](https://dartpad.dev/?template=app), ganti seluruh isi dengan `crud-lokal.dart`, lalu tekan Run.
2. Atau gunakan sebagai `lib/main.dart` pada project `flutter create`, lalu jalankan `flutter run -d chrome`.

Berkas ini tidak memakai package tambahan. Data bersifat in-memory dan kembali ke data contoh saat aplikasi dimulai ulang.

## Skenario Demo

1. Halaman utama: daftar laporan, ringkasan jumlah laporan Menunggu, dan pencarian (F-03, F-07).
2. Ketuk Buat Laporan, lalu Kirim dengan form kosong: pesan validator muncul pada setiap field wajib (F-01).
3. Isi lokasi `Gedung B, R. 204`: aplikasi membuka halaman laporan serupa dan laporan belum terkirim (F-04).
4. Isi lokasi lain dengan data valid: `SnackBar` muncul dan laporan baru berada di paling atas daftar (Create).
5. Ketuk laporan: halaman detail menampilkan data yang dikirim lewat arguments (Read).
6. Ubah status dengan catatan penanganan, simulasi petugas: status pada daftar ikut berubah (Update, F-06).
7. Buka laporan berstatus Menunggu, ketuk Batalkan laporan, konfirmasi: laporan hilang dari daftar (Delete, F-08).

## Status Milestone

M1 dan M2 selesai untuk alur mahasiswa. M3 berstatus Sebagian: persistensi serta kebutuhan petugas F-05 dan F-06 yang sebenarnya menunggu backend pada M5. Rinciannya ada pada `laporan-progress-uts.md`.
