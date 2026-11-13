# Catatan Keputusan Navigasi — Pengelolaan Surat Masuk UKM

## 1. Keputusan Route

| Route | Keputusan | Alasan |
|---|---|---|
| `/` | Digunakan sebagai halaman awal | Pengguna dapat melihat daftar surat masuk terlebih dahulu. |
| `/detail` | Digunakan untuk menampilkan detail surat | Pengguna dapat melihat informasi surat yang dipilih dari daftar. |
| `/form` | Digunakan untuk menampilkan form tambah surat | Pengguna dapat mengisi informasi surat melalui form. |

## 2. Keputusan Pengiriman Data

Data surat dikirim dari halaman Daftar Surat Masuk ke halaman Detail Surat menggunakan `Navigator.pushNamed` dengan parameter `arguments`. Halaman Detail Surat memeriksa tipe data dan menyediakan kondisi alternatif jika data tidak tersedia.

## 3. Keputusan Validasi Form

- **Judul surat:** wajib diisi agar informasi surat memiliki judul.
- **Nama pengirim:** wajib diisi agar identitas pengirim tercatat.
- **Status pemeriksaan:** wajib dipilih agar status surat memiliki nilai yang jelas.

Validasi dilakukan menggunakan `Form` dan `GlobalKey<FormState>` sebelum notifikasi ditampilkan.

## 4. Keputusan Feedback

| Aksi | Feedback |
|---|---|
| Memilih surat | Halaman Detail Surat terbuka dengan data surat yang dipilih. |
| Kembali dari detail | Pengguna kembali ke Daftar Surat Masuk menggunakan `Navigator.pop`. |
| Mengirim form kosong | Pesan validasi ditampilkan pada kolom yang belum valid. |
| Mengirim form valid | SnackBar menampilkan pesan bahwa data surat berhasil divalidasi. |
| Membatalkan form | Pengguna kembali ke halaman sebelumnya menggunakan `Navigator.pop`. |

## 5. Catatan Implementasi

Data surat pada daftar masih berupa data contoh. Form hanya melakukan validasi dan menampilkan SnackBar; data baru belum disimpan ke daftar maupun penyimpanan permanen. Aplikasi ini dibuat untuk mendemonstrasikan alur navigasi dan interaksi sesuai ruang lingkup Tugas 6.
