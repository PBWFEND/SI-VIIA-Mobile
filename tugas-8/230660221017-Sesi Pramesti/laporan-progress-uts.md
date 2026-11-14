# LAPORAN PROGRESS UTS
# PROYEK SI-FASKAM – SISTEM INFORMASI PENGADUAN FASILITAS KAMPUS

## 2.1 Identitas

- **Nama:** Sesi Prasmesti
- **NIM:** 230660221017
- **Program Studi:** Sistem Informasi
- **Mata Kuliah:** Pemrograman Aplikasi Bergerak (PAB)
- **Nama Proyek:** SI-FASKAM (Sistem Informasi Pengaduan Fasilitas Kampus)
- **Teknologi:** Flutter dan Dart

## 2.2 Executive Summary

SI-FASKAM merupakan aplikasi berbasis Flutter yang dikembangkan untuk membantu mahasiswa menyampaikan pengaduan mengenai fasilitas kampus yang mengalami kerusakan atau membutuhkan perbaikan.

Pengembangan aplikasi dilakukan secara bertahap, dimulai dari analisis kebutuhan, perancangan antarmuka, navigasi antarhalaman, hingga penerapan CRUD lokal. Saat ini aplikasi telah memiliki fitur tambah pengaduan, melihat daftar dan detail pengaduan, mengedit data, menghapus data, mengubah status, serta mencari pengaduan.

Pengelolaan data masih menggunakan List di dalam aplikasi sehingga data bersifat sementara dan belum tersimpan secara permanen ke database.

## 2.3 Progress Milestone

### Milestone 1 – Analisis Kebutuhan (Tugas 4)

Pada tahap ini dilakukan identifikasi kebutuhan aplikasi SI-FASKAM. Hasilnya berupa dokumentasi kebutuhan fungsional dan nonfungsional, prioritas fitur menggunakan metode MoSCoW, serta user flow proses pengiriman pengaduan oleh mahasiswa.

User flow menggambarkan tahapan mahasiswa membuka aplikasi, memilih menu pengaduan, mengisi formulir, melakukan validasi, mengirim pengaduan, dan melihat konfirmasi.

**Hasil:** Dokumentasi kebutuhan dan user flow aplikasi.

### Milestone 2 – Perancangan UI/UX (Tugas 5)

Pada tahap ini dilakukan perancangan struktur informasi dan antarmuka aplikasi. Struktur aplikasi terdiri dari halaman daftar pengaduan, formulir pengaduan, halaman konfirmasi, dan halaman detail pengaduan.

Keputusan desain meliputi penggunaan warna utama biru, komponen Card dan ListTile, penekanan informasi status pengaduan, serta tombol utama untuk membuat pengaduan baru.

**Hasil:** Information Architecture dan Catatan Keputusan UI/UX.

### Milestone 3 – Navigasi dan Interaksi (Tugas 6)

Pada tahap ini dikembangkan navigasi antarhalaman aplikasi, meliputi halaman daftar pengaduan, formulir, konfirmasi, dan detail. Formulir dilengkapi validasi agar data yang dikirim tidak kosong. Aplikasi juga memberikan umpan balik menggunakan SnackBar.

**Hasil:** Implementasi halaman dan interaksi pengaduan.

**Catatan evaluasi:** Kode aplikasi yang diperiksa saat ini menggunakan MaterialPageRoute untuk berpindah halaman. Dokumentasi Tugas 6 yang menggunakan Named Routes perlu disesuaikan dengan implementasi atau kode perlu disesuaikan apabila Named Routes diwajibkan.

### Milestone 4 – CRUD Lokal (Tugas 7)

Pada tahap ini diterapkan pengelolaan data pengaduan menggunakan model Pengaduan dan List<Pengaduan>. Data memiliki lima atribut, yaitu id, kategori, lokasi, deskripsi, dan status.

Fitur yang telah diimplementasikan meliputi:
- Create: menambahkan pengaduan baru.
- Read: menampilkan daftar dan detail pengaduan.
- Update: mengubah informasi dan status pengaduan.
- Delete: menghapus pengaduan melalui dialog konfirmasi.

Aplikasi menggunakan StatefulWidget dan setState() untuk memperbarui tampilan setelah terjadi perubahan data.

**Hasil:** Implementasi CRUD lokal pada aplikasi SI-FASKAM.

## 2.4 Requirement-to-Implementation Matrix

| Kebutuhan | Implementasi | Status |
|---|---|---|
| Membuat pengaduan | Formulir tambah pengaduan | Selesai |
| Melihat daftar pengaduan | ListView | Selesai |
| Melihat detail pengaduan | HalamanDetail | Selesai |
| Mengedit pengaduan | FormPengaduan mode edit | Selesai |
| Menghapus pengaduan | Dialog konfirmasi hapus | Selesai |
| Mengubah status | Menu ubah status | Selesai |
| Mencari pengaduan | TextField pencarian | Selesai |
| Validasi formulir | Form dan validator | Selesai |
| Penyimpanan permanen | Database lokal atau server | Belum |

## 2.5 Dokumentasi Screenshot

Masukkan screenshot asli aplikasi pada bagian berikut:

1. **Screenshot halaman daftar pengaduan:** menampilkan daftar laporan, status, pencarian, dan tombol Buat Pengaduan.
2. **Screenshot formulir pengaduan:** menampilkan kolom kategori, lokasi, deskripsi, dan contoh validasi.
3. **Screenshot konfirmasi penghapusan:** menampilkan dialog sebelum pengaduan dihapus.
4. **Screenshot tambahan (jika tersedia):** halaman detail atau hasil perubahan status.

## 2.6 Kendala dan Solusi

### Kendala 1 – Penyesuaian Navigasi

Dalam proses evaluasi, ditemukan perbedaan antara dokumentasi navigasi Tugas 6 yang menggunakan Named Routes dengan kode aplikasi yang menggunakan MaterialPageRoute.

**Solusi:** Menyesuaikan dokumentasi dengan implementasi yang benar-benar digunakan atau mengubah kode apabila penggunaan Named Routes diwajibkan dalam penilaian.

### Kendala 2 – Penyimpanan Data

Data pengaduan saat ini masih dikelola menggunakan List sehingga data dapat hilang ketika aplikasi dijalankan ulang.

**Solusi:** Pada pengembangan berikutnya, penyimpanan data akan dikembangkan menggunakan REST API dan database agar data dapat disimpan secara permanen.

## 2.7 Rencana Pengembangan M5 – REST API

Pada tahap berikutnya, aplikasi SI-FASKAM direncanakan menggunakan REST API agar pengelolaan data tidak hanya berlangsung di dalam aplikasi.

Rencana fitur API:

| Method | Endpoint | Fungsi |
|---|---|---|
| GET | /api/pengaduan | Mengambil seluruh data pengaduan |
| GET | /api/pengaduan/{id} | Mengambil detail pengaduan |
| POST | /api/pengaduan | Menambahkan pengaduan |
| PUT | /api/pengaduan/{id} | Memperbarui pengaduan |
| DELETE | /api/pengaduan/{id} | Menghapus pengaduan |

Data yang dikirim dan diterima API akan menggunakan format JSON dengan atribut id, kategori, lokasi, deskripsi, dan status.

Pengembangan ini diharapkan dapat membuat data tersimpan secara permanen, memudahkan pengelolaan data, dan memungkinkan aplikasi terhubung dengan layanan backend.

## 2.8 Refleksi

Melalui pengerjaan proyek SI-FASKAM, saya memperoleh pengalaman dalam mengembangkan aplikasi menggunakan Flutter dan Dart. Saya belajar mulai dari menganalisis kebutuhan pengguna, merancang antarmuka, membuat navigasi, hingga menerapkan fitur CRUD lokal. Saya juga memahami bahwa pengelolaan data menggunakan List masih memiliki keterbatasan sehingga diperlukan pengembangan lebih lanjut menggunakan REST API dan database.

## 2.9 Deklarasi Penggunaan AI

Dalam proses pengerjaan proyek ini, saya menggunakan ChatGPT sebagai alat bantu untuk memahami materi, memeriksa konsistensi dokumentasi, mengevaluasi kode program, dan membantu menyusun laporan progress. Saya tetap melakukan pemeriksaan dan penyesuaian terhadap hasil bantuan tersebut berdasarkan kode aplikasi dan hasil pengerjaan proyek saya sendiri.