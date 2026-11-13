# LAPORAN PROGRESS PROYEK UTS
## Pemrograman Aplikasi Bergerak

## 2.1 Identitas Proyek

| Keterangan | Informasi |
|---|---|
| Nama | Amelia Oktaviani |
| NIM | 230660221127 |
| Kelas | SI-VIIA |
| Domain Sistem Informasi | Penjualan Warung |
| Judul Aplikasi | Aplikasi Penjualan Warung |
| Teknologi | Flutter dan Dart |
| Repository | https://github.com/ameliaoktaviani/SI-VIIA-Mobile |
| Branch | 230660221127 |

## 2.2 Ringkasan Eksekutif

Proyek ini mengembangkan aplikasi mobile sederhana bernama Penjualan Warung. Aplikasi dirancang untuk membantu pemilik warung dalam mengelola data barang, meliputi nama barang, kategori, harga, dan jumlah stok.

Permasalahan yang menjadi perhatian dalam pengembangan aplikasi ini adalah kebutuhan pengelolaan data barang yang sederhana dan mudah digunakan. Aplikasi mobile dipilih karena memungkinkan pengguna mengakses dan mengelola data melalui perangkat secara praktis.

Pada tahap UTS, aplikasi telah mengimplementasikan fitur dasar pengelolaan data barang menggunakan Flutter dan Dart. Fitur yang telah dikembangkan meliputi menampilkan, menambahkan, mengubah, dan menghapus data barang (*Create, Read, Update, Delete* atau CRUD) secara lokal.

Implementasi saat ini berfokus pada pengelolaan data barang sebagai bagian dari MVP (*Minimum Viable Product*). Fitur pencatatan transaksi penjualan, perhitungan total transaksi, dan riwayat transaksi masih menjadi bagian dari rencana pengembangan berikutnya.

## 2.3 Status Pencapaian Milestone

| Milestone | Hasil Pekerjaan | Status | Bukti |
|---|---|---|---|
| M1 - Analisis Kebutuhan | Menyusun persona, kebutuhan fungsional dan nonfungsional, serta *user flow* aplikasi | Selesai | `kebutuhan.md` |
| M2 - Desain UI/UX dan Navigasi | Menyusun struktur informasi, *wireframe*, rancangan navigasi, serta interaksi formulir dan umpan balik | Selesai | `information-architecture.md`, `wireframe.png`, `navigation-flow.md`, `catatan-keputusan-navigasi.md` |
| M3 - Model Data dan CRUD Lokal | Menyusun model data Barang dan mengimplementasikan fitur CRUD menggunakan penyimpanan lokal sementara berupa `List` | Selesai | `model-data.md`, `catatan-keputusan-data.md`, `crud-lokal.dart` |

Capaian milestone menunjukkan bahwa tahapan analisis kebutuhan, perancangan, navigasi, serta implementasi pengelolaan data lokal telah dikerjakan. Meskipun demikian, selesainya milestone tersebut tidak berarti seluruh kebutuhan fungsional yang direncanakan telah direalisasikan. Implementasi aplikasi saat ini masih berfokus pada pengelolaan data barang.

## 2.4 Pemetaan Kebutuhan terhadap Implementasi

Pemetaan berikut menggunakan ID kebutuhan yang telah ditetapkan pada dokumen analisis kebutuhan Tugas 4.

| ID | Kebutuhan | Prioritas | Halaman Pemenuh | Operasi Data Terkait | Status |
|---|---|---|---|---|---|
| F-01 | Pemilik warung dapat menambahkan data barang beserta harga dan jumlah stok awal | Must Have | Form Tambah Barang | Create - menambahkan data barang | Selesai |
| F-02 | Pemilik warung dapat mencatat transaksi penjualan dan menghitung total harga secara otomatis | Must Have | Halaman Kasir/Transaksi | Create - menyimpan transaksi dan menghitung total | Belum |
| F-03 | Pemilik warung dapat melihat daftar stok barang beserta status peringatan stok minimum | Must Have | Dashboard/Daftar Barang | Read - menampilkan data dan status stok | Selesai |
| F-04 | Pemilik warung dapat melihat riwayat transaksi penjualan harian | Should Have | Halaman Riwayat Transaksi | Read - menampilkan riwayat transaksi | Belum |
| F-05 | Pemilik warung dapat memperbarui data harga dan stok barang | Should Have | Form Edit Barang | Update - mengubah data barang | Selesai |
| F-06 | Pemasok dapat melihat rekap daftar barang yang memerlukan pengadaan stok ulang | Could Have | Halaman Laporan Stok Pemasok | Read - menampilkan rekap kebutuhan stok | Belum |

Berdasarkan hasil implementasi hingga tahap UTS, kebutuhan F-01, F-03, dan F-05 telah direalisasikan melalui fitur pengelolaan data barang. Aplikasi dapat menambahkan, menampilkan, dan mengubah data barang. Informasi status stok juga ditampilkan berdasarkan jumlah stok barang.

Selain kebutuhan yang telah dipetakan, aplikasi juga menyediakan fitur penghapusan data barang melalui dialog konfirmasi. Fitur tersebut melengkapi operasi CRUD pada pengelolaan data barang, meskipun penghapusan belum dicantumkan sebagai kebutuhan fungsional tersendiri dalam dokumen analisis kebutuhan awal.

Sementara itu, kebutuhan F-02, F-04, dan F-06 belum diimplementasikan. Kebutuhan tersebut meliputi pencatatan transaksi penjualan, riwayat transaksi harian, dan rekap stok untuk pemasok.

Dengan demikian, capaian proyek pada tahap UTS masih berfokus pada MVP pengelolaan data barang dan belum mencakup seluruh kebutuhan aplikasi yang direncanakan pada tahap analisis.

## 2.5 Dokumentasi Tampilan Aplikasi

Screenshot digunakan sebagai bukti implementasi dan pengujian fitur aplikasi.

1. **Daftar Barang**

   Menampilkan daftar barang yang tersimpan dalam aplikasi, termasuk informasi nama barang, kategori, harga, jumlah stok, dan status ketersediaan stok.

   File: `screenshot/screenshot-daftar.png`

2. **Form Barang**

   Menampilkan formulir untuk menambahkan atau mengubah data barang. Dokumentasi ini juga memperlihatkan validasi input ketika pengguna mencoba menyimpan formulir dengan data yang belum lengkap.

   File: `screenshot/screenshot-form.png`

3. **Konfirmasi Hapus**

   Menampilkan dialog konfirmasi sebelum data barang dihapus untuk menghindari penghapusan yang tidak disengaja.

   File: `screenshot/screenshot-hapus.png`

## 2.6 Tantangan Teknis dan Solusi

### Tantangan 1: Pengelolaan TextEditingController

Pada pengembangan fitur tambah dan edit barang, sempat terjadi kendala ketika formulir digunakan. Kendala tersebut berkaitan dengan siklus hidup (*lifecycle*) `TextEditingController`, sehingga pengelolaan controller pada formulir perlu diperbaiki.

**Solusi:** Pengelolaan formulir dipisahkan ke dalam widget `FormBarangDialog` yang memiliki siklus hidup sendiri. Controller dibuat dan dihapus sesuai dengan siklus hidup widget tersebut. Dengan perbaikan ini, fitur tambah dan edit barang dapat digunakan kembali dengan baik.

### Tantangan 2: Menjalankan Perintah Flutter

Pada tahap awal pengembangan, terminal tidak mengenali perintah `flutter` ketika menjalankan perintah pengelolaan proyek.

**Solusi:** Pemeriksaan dilakukan terhadap lokasi instalasi Flutter dan konfigurasi lingkungan terminal. Setelah konfigurasi diperbaiki, perintah Flutter dapat digunakan kembali untuk mengambil dependensi, menjalankan aplikasi, dan melakukan analisis kode.

## 2.7 Rencana Pengembangan M5

Setelah tahap UTS, pengembangan berikutnya direncanakan mencakup integrasi REST API agar aplikasi dapat menggunakan dan mengelola data melalui layanan eksternal.

Rencana pengembangan meliputi:

1. Mempelajari konsep komunikasi antara aplikasi Flutter dan REST API.
2. Menentukan layanan atau sumber API yang sesuai dengan kebutuhan aplikasi.
3. Mengimplementasikan proses pengambilan dan pengiriman data melalui API.
4. Menyesuaikan pengelolaan data aplikasi dengan respons dari API.
5. Menguji proses komunikasi serta penanganan respons dan kesalahan dari API.

Selain integrasi REST API, pengembangan selanjutnya juga dapat diarahkan pada implementasi fitur transaksi penjualan dan riwayat transaksi yang belum tersedia pada tahap UTS.

Seluruh kegiatan tersebut merupakan rencana pengembangan berikutnya dan belum termasuk dalam implementasi UTS.

## 2.8 Refleksi Pembelajaran

Melalui pengerjaan proyek ini, saya memahami tahapan pengembangan aplikasi mobile mulai dari analisis kebutuhan, perancangan antarmuka, navigasi, hingga pengelolaan data lokal. Saya juga memperoleh pengalaman dalam menerapkan konsep CRUD menggunakan Flutter dan Dart. Selama proses pengembangan, saya menghadapi beberapa kendala teknis, terutama dalam pengelolaan controller pada formulir, yang membantu saya memahami siklus hidup widget. Ke depannya, saya ingin mengembangkan aplikasi dengan pengelolaan data yang lebih baik melalui integrasi REST API dan penambahan fitur sesuai kebutuhan pengguna.

## 2.9 Deklarasi Penggunaan AI

Dalam pengerjaan proyek ini, ChatGPT digunakan sebagai alat bantu untuk memahami pesan kesalahan Flutter, menelusuri dan memperbaiki kendala teknis pada pengelolaan controller formulir, serta membantu penyusunan dan pemeriksaan dokumentasi proyek. Implementasi kode, pengujian fitur, dan verifikasi hasil dilakukan oleh penulis.