# Laporan Progress UTS — Milestone M4

## 2.1 Tabel Identitas

| | |
|:--|:--|
| **Nama** | Nazwa Aulia Rachma |
| **NIM** | 230660221104 |
| **Kelas** | SI-VIIA |
| **Domain SI** | Sistem Informasi Perpustakaan |
| **Judul Aplikasi** | Perpustakaan Kampus |
| **Tautan Repository** | [Nazwa230660221104/SI-VIIA-Mobile](https://github.com/Nazwa230660221104/SI-VIIA-Mobile) |

## 2.2 Ringkasan Eksekutif Project

Perpustakaan Kampus membantu mahasiswa menemukan koleksi, memeriksa ketersediaan, mengajukan peminjaman, dan memantau pinjaman aktif tanpa harus mengantre di meja layanan. Pustakawan juga mendapat rancangan untuk memperbarui status eksemplar secara lebih teratur.

Solusi mobile dipilih karena mahasiswa dan pustakawan dapat mengakses layanan dari ponsel atau tablet ketika berada di lingkungan kampus. MVP sampai M4 berfokus pada kebutuhan, alur UI, navigasi, model data, dan CRUD lokal sebelum integrasi REST API pada milestone M5.

## 2.3 Ketercapaian Milestone M1–M3

| Milestone | Deliverable | Status | Catatan / Bukti |
|:----------|:------------|:-------|:----------------|
| M1: Kebutuhan | Dokumen kebutuhan + User Flow | **Selesai** | Folder `tugas-4/`: dokumen kebutuhan, user flow, dan dua persona. |
| M2: UI/UX | Wireframe + Navigasi | **Selesai** | Folder `tugas-5/` berisi IA, wireframe, halaman utama; folder `tugas-6/` berisi route, form, dan feedback. |
| M3: MVP Awal | Model data + CRUD lokal | **Selesai** | Folder `tugas-7/`: model data, `crud-lokal.dart`, dan operasi Create, Read, Update, Delete. |

## 2.4 Matriks Kebutuhan ke Implementasi

| ID Kebutuhan | Deskripsi Kebutuhan | Prioritas MoSCoW | Halaman Pemenuh | Operasi Data Terkait |
|:-------------|:-------------------|:----------------:|:----------------|:---------------------|
| F-01 | Mahasiswa mencari buku berdasarkan judul, penulis, atau kategori. | Must | Beranda / Cari buku | Read |
| F-02 | Mahasiswa membuka detail buku dan lokasi rak. | Must | Detail buku | Read |
| F-03 | Mahasiswa melihat status dan jumlah ketersediaan buku. | Must | Beranda / Detail buku | Read |
| F-04 | Mahasiswa mengajukan peminjaman buku tersedia. | Must | Konfirmasi peminjaman | Create |
| F-05 | Mahasiswa melihat pinjaman aktif dan jatuh tempo. | Must | Pinjaman aktif | Read |
| F-06 | Mahasiswa mendaftarkan pengingat buku kosong. | Should | Detail buku kosong / Profil | Create, Read |
| F-07 | Pustakawan memperbarui status eksemplar. | Could | Panel pustakawan | Update |
| F-08 | Mahasiswa membayar denda melalui aplikasi. | Won't pada versi ini | Belum dibangun | Belum ada; menunggu kebijakan pembayaran |

## 2.5 Tangkapan Layar Aplikasi Berjalan

| No. | File | Mengisi Bukti |
|:---:|:-----|:--------------|
| 1 | `screenshot-daftar.png` | Halaman dashboard dan daftar buku setelah data ditambah. |
| 2 | `screenshot-form.png` | Form tambah buku dengan validasi field. |
| 3 | `screenshot-hapus.png` | Dialog konfirmasi penghapusan data. |

## 2.6 Kendala dan Solusi Teknis

| No. | Kendala | Cara Mengatasinya |
|:---:|:--------|:-------------------|
| 1 | `ListView.builder` dapat menyebabkan overflow ketika ditempatkan langsung dalam `Column`. | Membungkus daftar dengan `Expanded` dan memberi batas tinggi melalui layout halaman. |
| 2 | Data update dan delete dapat salah sasaran jika hanya memakai index daftar. | Menambahkan `id` unik pada model, memakai `indexWhere` untuk Update, dan `removeWhere` untuk Delete. |
| 3 | Arguments antar route bisa null atau bertipe tidak sesuai. | Memeriksa arguments dengan `is`, menyediakan cabang null, dan menampilkan feedback aman kepada pengguna. |
| 4 | Tampilan desktop perlu tetap rapi saat daftar bertambah. | Menggunakan `ConstrainedBox` dengan lebar maksimum, kartu konsisten, dan `ListView.builder` untuk area daftar. |

## 2.7 Rencana Pengembangan Milestone M5 — REST API

Pada M5, katalog buku akan diambil dari endpoint `GET /books` dengan parameter pencarian judul, penulis, atau kategori. Pengajuan peminjaman dikirim melalui `POST /loans`, daftar pinjaman aktif melalui `GET /loans?status=active`, dan status eksemplar diperbarui melalui `PATCH /books/{id}` untuk akun pustakawan. Backend perlu menyediakan autentikasi pengguna, validasi aturan jumlah pinjaman, status HTTP yang konsisten, dan pesan error yang dapat ditampilkan sebagai `SnackBar`.

## 2.8 Refleksi Pembelajaran Tengah Semester

Saya memahami bahwa Flutter menyusun tampilan dari widget, sedangkan perubahan data harus dikelola pada state yang tepat dan diberi tahu melalui `setState`. Tantangan terbesar adalah menjaga kebutuhan, route, model, dan UI tetap memakai istilah serta id yang sama dari satu milestone ke milestone berikutnya. CRUD lokal membantu saya memahami alur data sebelum aplikasi bergantung pada REST API. Saya siap mengembangkan model lokal menjadi repository yang membaca dan mengirim data ke backend pada M5.

## 2.9 Deklarasi Penggunaan AI

Deklarasi penggunaan AI: ChatGPT — membantu meninjau struktur laporan, keterlacakan kebutuhan ke implementasi, dan rencana REST API; perbaikan kode, pengujian, dan penjelasan dilakukan serta diverifikasi oleh penulis.
