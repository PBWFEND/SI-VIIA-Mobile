# LAPORAN PROGRESS PROJECT UTS
## SiRuang Kampus – Sistem Informasi Peminjaman Ruang Kelas

### 2.1 Identitas

| Keterangan | Identitas |
|---|---|
| Nama | Dede Dian Permana |
| NIM | 230660221010 |
| Kelas | SI-VIIA |
| Domain SI | Sistem Informasi Peminjaman Ruang Kelas |
| Judul Aplikasi | SiRuang Kampus |
| Repository | https://github.com/PBWFEND/SI-VIIA-Mobile/tree/main/tugas-8 |

### 2.2 Ringkasan Eksekutif Project

SiRuang Kampus merupakan aplikasi mobile yang dikembangkan untuk membantu proses peminjaman ruang kelas di lingkungan kampus. Permasalahan yang ingin diselesaikan adalah kesulitan mahasiswa dalam memperoleh informasi mengenai ketersediaan ruangan dan proses pengajuan peminjaman yang sebelumnya harus dilakukan dengan menghubungi petugas secara langsung. Melalui aplikasi ini, mahasiswa diharapkan dapat melihat daftar ruangan, mengetahui jadwal penggunaan, mengajukan peminjaman, dan memantau status permohonan.

Aplikasi ini ditujukan untuk dua pengguna utama, yaitu mahasiswa dan petugas kampus. Mahasiswa menggunakan aplikasi untuk mencari ruangan dan mengajukan peminjaman, sedangkan petugas bertugas memeriksa permohonan serta memberikan keputusan. Solusi mobile dipilih karena dapat memberikan kemudahan akses melalui smartphone sehingga pengguna dapat memperoleh informasi dan melakukan pengajuan dengan lebih praktis.

### 2.3 Ketercapaian Milestone (M1–M3)

| Milestone | Deliverable | Status | Catatan / Bukti |
|---|---|---|---|
| M1: Kebutuhan | Dokumen kebutuhan dan User Flow | Selesai | Tugas 4: `dokumen-kebutuhan.md`, `user-flow.mmd`, dan `user-flow.png` |
| M2: UI/UX | Wireframe dan Navigasi | Selesai | Tugas 5: wireframe dan Information Architecture. Tugas 6: navigation flow dan interaksi |
| M3: MVP Awal | Model data dan CRUD lokal | Selesai | Tugas 7: `model-data.md` dan `crud-lokal.dart`, termasuk pengujian Create, Read, Update, dan Delete |

### 2.4 Matriks Kebutuhan ke Implementasi

| ID | Deskripsi Kebutuhan | Prioritas | Halaman Pemenuh | Operasi Data |
|---|---|---|---|---|
| F-01 | Mahasiswa melihat daftar ruangan, kategori, dan status ketersediaan | Must | Halaman Daftar Ruangan | Read |
| F-02 | Mahasiswa melihat jadwal penggunaan ruangan berdasarkan tanggal | Should | Halaman Detail dan Jadwal Ruangan | Read |
| F-03 | Mahasiswa mengajukan peminjaman ruangan dengan mengisi data pengajuan | Must | Halaman Formulir Peminjaman | Create |
| F-04 | Mahasiswa melihat status pengajuan peminjaman | Should | Halaman Status Peminjaman | Read |
| F-05 | Petugas melihat daftar permohonan yang masuk | Must | Halaman Daftar Permohonan Petugas | Read |
| F-06 | Petugas memeriksa jadwal untuk mengetahui bentrok peminjaman | Must | Halaman Pemeriksaan Permohonan | Read |
| F-07 | Petugas menyetujui permohonan peminjaman | Must | Halaman Detail Permohonan Petugas | Update |
| F-08 | Petugas menolak permohonan dengan memberikan alasan | Could | Halaman Detail Permohonan Petugas | Update |

**Catatan implementasi:** Pada MVP Tugas 7, CRUD sudah diterapkan pada data lokal peminjaman. Fitur pengelolaan permohonan oleh petugas, pemeriksaan bentrok, dan keputusan persetujuan belum menjadi alur operasional lengkap.

### 2.5 Tangkapan Layar Aplikasi Berjalan

| No. | File | Bukti yang Ditampilkan |
|---|---|---|
| 1 | `screenshot-daftar.png` | Daftar data peminjaman setelah berhasil menambahkan data |
| 2 | `screenshot-form.png` | Formulir penambahan atau pengubahan data peminjaman |
| 3 | `screenshot-hapus.png` | Dialog konfirmasi sebelum menghapus data |

**Catatan:** Screenshot `screenshot-daftar.png` dan `screenshot-hapus.png` sudah tersedia dari Tugas 7. Screenshot `screenshot-form.png` perlu diambil saat formulir tambah atau edit sedang terbuka.

### 2.6 Kendala dan Solusi Teknis

| No. | Kendala | Cara Mengatasinya |
|---|---|---|
| 1 | Aplikasi Flutter tidak dapat dijalankan ketika perintah dijalankan dari folder tugas yang tidak memiliki `pubspec.yaml`. | Menjalankan aplikasi dari direktori proyek Flutter utama yang memiliki konfigurasi `pubspec.yaml`. |
| 2 | Muncul kesalahan `Method not found: runApp` karena import Flutter belum tersedia pada file `main.dart`. | Menambahkan `import 'package:flutter/material.dart';` sehingga fungsi `runApp` dapat dikenali. |
| 3 | Terjadi penyesuaian navigasi dan pengiriman argumen antarhalaman pada Tugas 6. | Menggunakan `Navigator.pushNamed`, memeriksa tipe argumen yang diterima, dan menyediakan penanganan ketika argumen tidak sesuai. |

### 2.7 Rencana Pengembangan Milestone M5 (REST API)

Pada milestone berikutnya, SiRuang Kampus akan dikembangkan dengan menghubungkan aplikasi Flutter ke backend menggunakan REST API. Data ruangan, kategori, status ketersediaan, jadwal penggunaan, dan pengajuan peminjaman nantinya akan diperoleh dari server sehingga informasi dapat dikelola secara terpusat.

Layanan backend yang dibutuhkan meliputi API untuk mengambil daftar ruangan, melihat jadwal, membuat pengajuan peminjaman, mengambil status pengajuan, serta mengelola permohonan oleh petugas. Selain itu, diperlukan autentikasi dan pengaturan hak akses berdasarkan peran mahasiswa dan petugas. Dengan integrasi ini, data tidak hanya tersimpan sementara di perangkat, tetapi dapat dikelola dan diakses melalui server.

### 2.8 Refleksi Pembelajaran Tengah Semester

Selama mengerjakan project SiRuang Kampus, saya memahami bahwa pengembangan aplikasi Flutter membutuhkan keterkaitan antara kebutuhan pengguna, rancangan antarmuka, navigasi, model data, dan pengelolaan state. Saya juga memahami penerapan operasi CRUD menggunakan `List`, `StatefulWidget`, dan `setState` untuk memperbarui tampilan berdasarkan perubahan data. Kendala yang dihadapi mengajarkan saya untuk lebih teliti dalam mengatur struktur folder, import, serta proses pengujian aplikasi. Ke depannya, saya ingin mengembangkan aplikasi ini dengan REST API agar pengelolaan data menjadi lebih terpusat dan dapat digunakan oleh beberapa pengguna.

### 2.9 Deklarasi Penggunaan AI

Deklarasi penggunaan AI: ChatGPT — membantu memahami instruksi tugas, menyusun dokumentasi, memberikan arahan implementasi kode Flutter, dan membantu analisis kendala teknis; perbaikan kode, pengujian, dan penjelasan dilakukan serta diverifikasi oleh penulis.