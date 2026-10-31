# Laporan Progress Project — UTS Milestone M4

## 2.1 Identitas

| | |
|:--|:--|
| **Nama** | Elangga Yudistira |
| **NIM** | 230660221109 |
| **Kelas** | SI-VIIA |
| **Domain SI** | Pengelolaan keuangan pribadi mahasiswa |
| **Judul Aplikasi** | MoneyTrack Mahasiswa |
| **Tautan Repository** | https://github.com/elanggayudistira230660221109/SI-VIIA-Mobile/tree/main/tugas-8/230660221109-ElanggaYudistira |

## 2.2 Ringkasan Eksekutif Project

MoneyTrack Mahasiswa membantu mahasiswa mencatat pemasukan dan pengeluaran harian, melihat riwayat transaksi, dan memahami saldo secara cepat. Masalah yang diselesaikan adalah pencatatan transaksi kecil yang sering terlupa serta kesulitan menghitung kondisi keuangan secara berkala.

Aplikasi mobile dipilih karena mahasiswa membawa ponsel ketika berada di kampus, kos, atau perjalanan. Pencatatan dapat dilakukan segera setelah transaksi terjadi, sedangkan ringkasan saldo dapat dibaca dari satu halaman. MVP saat ini menggunakan data lokal di memori agar alur model data dan CRUD dapat diuji sebelum integrasi backend.

## 2.3 Ketercapaian Milestone M1 sampai M3

| Milestone | Deliverable | Status | Catatan / Bukti |
|:----------|:------------|:-------|:----------------|
| M1: Kebutuhan | Dokumen kebutuhan + User Flow | Selesai | Tugas-4/dokumen-kebutuhan.md dan Tugas-4/user-flow.mmd menjelaskan F-01 sampai F-06. |
| M2: UI/UX | Wireframe + Navigasi | Selesai | tugas-5/information-architecture.md, halaman-utama.dart, wireframe, serta tugas-6/navigation-flow.md dan form-interaksi.dart. |
| M3: MVP Awal | Model data + CRUD lokal | Selesai | tugas-7/model-data.md, crud-lokal.dart, catatan-keputusan-data.md, dan screenshot hasil Flutter Web. |

## 2.4 Matriks Kebutuhan ke Implementasi

| ID Kebutuhan | Deskripsi Kebutuhan | Prioritas MoSCoW | Halaman Pemenuh | Operasi Data Terkait |
|:-------------|:-------------------|:----------------:|:----------------|:---------------------|
| F-01 | Mahasiswa melihat ringkasan pemasukan dan pengeluaran | Must | Halaman utama MoneyTrack, bagian Ringkasan Keuangan | Read dan perhitungan total dari state |
| F-02 | Mahasiswa menambahkan transaksi baru | Must | Dialog Tambah Transaksi | Create dengan List.add di dalam setState |
| F-03 | Mahasiswa melihat riwayat transaksi | Must | Halaman utama, bagian Riwayat Transaksi | Read dengan ListView.builder |
| F-04 | Mahasiswa mengubah data transaksi | Must | Dialog Ubah Transaksi dari menu aksi item | Update dengan indexWhere berdasarkan id |
| F-05 | Mahasiswa menghapus transaksi | Should | Menu aksi item dan AlertDialog konfirmasi | Delete dengan removeWhere berdasarkan id |
| F-06 | Admin mengelola data aplikasi | Could | Belum ada pada MVP mahasiswa | Ditunda ke tahap backend dan hak akses admin |

## 2.5 Tangkapan Layar Aplikasi Berjalan

Ketiga berkas berikut diambil dari build Flutter Web MoneyTrack. Screenshot daftar menunjukkan hasil Create dan Read, screenshot form menunjukkan form dengan field yang memiliki validator, sedangkan screenshot hapus menunjukkan konfirmasi sebelum Delete.

| No. | File | Mengisi Bukti |
|:---:|:-----|:--------------|
| 1 | screenshot-daftar.png | Halaman utama, ringkasan saldo, dan daftar transaksi setelah transaksi baru ditambahkan. |
| 2 | screenshot-form.png | Dialog form Tambah Transaksi dengan input nama, jumlah, jenis, kategori, tanggal, catatan, dan validasi. |
| 3 | screenshot-hapus.png | AlertDialog konfirmasi sebelum transaksi dihapus. |

## 2.6 Kendala dan Solusi Teknis

| No. | Kendala | Cara Mengatasinya |
|:---:|:--------|:-------------------|
| 1 | Model data, field form, ringkasan, dan operasi CRUD harus memakai sumber data yang sama. | Menetapkan satu model Transaksi dengan field id, nama, jumlah, jenis, kategori, tanggal, dan catatan; total pemasukan, pengeluaran, dan saldo dihitung dari list yang sama. |
| 2 | Update dan Delete dapat salah sasaran jika memakai posisi item pada daftar. | Membuat id unik dari waktu saat transaksi disimpan, lalu memakai indexWhere untuk Update dan removeWhere untuk Delete. |
| 3 | Aplikasi Flutter Web sempat menampilkan template Flutter Demo karena main.dart proyek baru belum diganti. | Menyalin crud-lokal.dart ke tugas_7_web/lib/main.dart, menjalankan flutter clean, flutter pub get, lalu membangun ulang dengan flutter run -d chrome. |

## 2.7 Rencana Pengembangan Milestone M5 — REST API

Pada M5, data transaksi akan diambil dan disimpan melalui REST API backend. Endpoint yang dibutuhkan adalah GET /transactions untuk riwayat, GET /transactions/summary untuk ringkasan, POST /transactions untuk membuat transaksi, PUT atau PATCH /transactions/{id} untuk mengubah, dan DELETE /transactions/{id} untuk menghapus.

Backend juga perlu menyediakan autentikasi mahasiswa, validasi nominal dan jenis transaksi, penyimpanan database, serta respons JSON yang konsisten. Aplikasi Flutter akan menampilkan indikator loading, pesan error ketika jaringan gagal, dan melakukan sinkronisasi ulang setelah operasi berhasil. Data lokal dapat dipakai sebagai cache sementara agar daftar tetap dapat dibaca ketika koneksi tidak stabil.

## 2.8 Refleksi Pembelajaran Tengah Semester

Saya memahami bahwa arsitektur Flutter menghubungkan widget, State, model data, dan kebutuhan pengguna dalam satu alur yang harus konsisten. Tantangan terbesar adalah memastikan setiap perubahan data memakai setState dan id yang sama sehingga ringkasan serta riwayat selalu menunjukkan informasi yang benar. Saya juga belajar bahwa ListView.builder, validasi form, dan AlertDialog bukan hanya komponen tampilan, tetapi bagian dari bukti kebutuhan fungsional. Tahap berikutnya adalah memisahkan sumber data lokal dari layanan REST API tanpa mengubah alur pengguna yang sudah diuji.

## 2.9 Deklarasi Penggunaan AI

Deklarasi penggunaan AI: ChatGPT — membantu memeriksa pemetaan kebutuhan Tugas 4 ke model data, menyusun kerangka CRUD Flutter, menyiapkan draf jawaban konsep, dan merapikan dokumentasi; perbaikan kode, pengujian Flutter Web, pemeriksaan screenshot, dan pemahaman akhir dilakukan serta diverifikasi oleh penulis.

