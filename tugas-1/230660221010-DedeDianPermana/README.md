# Tugas 1 - Identifikasi Kebutuhan Aplikasi Bergerak

**Nama:** Dede Dian Permana  
**NIM:** 230660221010  
**Kelas:** SI-VIIA  
**Domain:** Peminjaman Ruang Kelas

## 1. Deskripsi Sistem

SiRuang Kampus merupakan aplikasi mobile yang digunakan mahasiswa dan pihak kampus untuk melihat ketersediaan serta melakukan peminjaman ruang kelas. Pengguna dapat melihat informasi ruangan, jadwal penggunaan, dan mengajukan peminjaman melalui aplikasi. Aplikasi ini menggunakan perangkat mobile karena pengguna membutuhkan akses informasi secara cepat saat berada di lingkungan kampus, serta menggunakan interaksi layar sentuh yang praktis untuk melakukan pemilihan ruangan dan pengajuan peminjaman. Sistem juga dapat memberikan informasi terbaru melalui koneksi internet sehingga pengguna dapat mengetahui perubahan status ruangan.

## 2. Arsitektur Sistem

Alur sistem SiRuang Kampus terdiri dari aplikasi mobile sebagai antarmuka pengguna, backend sebagai pengelola proses sistem, dan database sebagai tempat penyimpanan data. Aplikasi mobile mengirimkan HTTP Request dalam format JSON ke backend, kemudian backend melakukan query atau perubahan data pada database. Setelah proses selesai, backend mengirimkan HTTP Response dalam format JSON kembali ke aplikasi mobile.

## 3. Kebutuhan Sistem

| Permintaan | Pengguna | Karakteristik Mobile yang Terkait | Fitur Aplikasi | Materi Pemenuh |
|---|---|---|---|---|
| Melihat daftar ruang yang tersedia | Mahasiswa | Sesi singkat | Daftar ruangan | UI Flutter |
| Melihat jadwal penggunaan ruangan | Mahasiswa | Keterbatasan ukuran layar | Jadwal ruangan | UI Flutter |
| Memilih ruangan untuk dipinjam | Mahasiswa | Interaksi layar sentuh | Pemilihan ruangan | Form Flutter |
| Mengajukan peminjaman ruang | Mahasiswa | Sesi singkat | Form peminjaman | Form dan HTTP Request |
| Melihat status pengajuan peminjaman | Mahasiswa | Akses saat berpindah tempat | Status peminjaman | HTTP Request dan Response |
| Mengirim dan menerima data peminjaman | Aplikasi Mobile dan Backend | Keterbatasan koneksi | Komunikasi API | HTTP Request/Response |
| Menyimpan dan mengelola data ruangan, jadwal, dan peminjaman | Backend SI | Di luar karakteristik mobile | Pengelolaan database | Di luar lingkup (backend SI) |

## 4. Refleksi

Fitur perangkat yang paling relevan untuk SiRuang Kampus adalah notifikasi karena pengguna dapat menerima informasi mengenai status pengajuan peminjaman ruangan. Notifikasi dapat membantu pengguna mengetahui apakah pengajuan diterima, ditolak, atau mengalami perubahan jadwal tanpa harus selalu membuka aplikasi. Fitur ini mendukung penggunaan aplikasi mobile yang memungkinkan pengguna menerima informasi secara cepat saat berada di lingkungan kampus.