# Tugas 7: MVP Awal dengan Data Lokal

**Nama:** Galih Permana Sidik | **NIM:** 230660221002 | **Kelas:** SI-VIIA
**Domain:** SiLapor Kampus (pelaporan kerusakan fasilitas kampus)

## Deskripsi Singkat

Tugas ini melanjutkan alur navigasi Tugas 6 menjadi MVP awal yang datanya benar-benar berubah. Model `Laporan` menyimpan laporan kerusakan, daftar berada pada `State` halaman utama, dan CRUD berjalan dari antarmuka: laporan dibuat lewat form (Create), ditampilkan dan dicari pada daftar (Read), statusnya diubah lewat dialog simulasi petugas (Update), dan laporan berstatus Menunggu dapat dibatalkan setelah konfirmasi (Delete). Kode hanya memakai API bawaan Flutter dan dapat dijalankan di DartPad atau dengan `flutter run -d chrome`. Data bersifat in-memory dan hilang saat aplikasi ditutup.


## Refleksi

Bagian yang paling sulit dijaga konsistensinya adalah Update, karena F-06 adalah pekerjaan petugas sedangkan data lokal hanya hidup di satu ponsel, sehingga CRUD di kode tampak memenuhi kebutuhan padahal baru mensimulasikannya. Saya menamai tombolnya "simulasi petugas" dan mencatat F-05, F-06, dan F-09 sebagai kebutuhan yang menunggu backend, supaya model data, kode, dan klaim kebutuhan tidak saling bertentangan. Field `tanggal` yang saya simpan sebagai teks juga memaksa saya mencatat bahwa urutan terbaru pada F-05 kini hanya bergantung pada urutan penyisipan, sebuah kompromi yang harus diganti ketika data pindah ke server.

## Deklarasi Penggunaan AI

AI (Claude) dipakai pada bagian berikut:

- Mengusulkan pola agar form dan detail mengembalikan hasil lewat `Navigator.pop`, sehingga hanya satu `State` yang memegang dan mengubah data
- Menyarankan bunyi pesan validator, `SnackBar`, dan teks dialog

Seluruh hasilnya dibaca ulang dan dicocokkan dengan dokumen kebutuhan Tugas 4, IA Tugas 5, dan alur navigasi Tugas 6.
