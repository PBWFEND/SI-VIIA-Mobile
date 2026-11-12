# Dokumen Kebutuhan dan User Flow — Aplikasi Mobile Pengelolaan Penjualan Warung

## 1. Deskripsi Aplikasi
Aplikasi Mobile Pengelolaan Penjualan Warung adalah aplikasi berbasis mobile yang dirancang untuk membantu pemilik warung kelontong kecil dalam mengelola pencatatan stok barang dan transaksi penjualan harian. Masalah utama yang dihadapi pengguna adalah pencatatan kasir yang masih menggunakan buku manual sehingga rentan hilang, rusak, serta memicu kesalahan perhitungan stok dan pendapatan. Alasan solusi ini berbentuk aplikasi mobile adalah untuk memberikan kemudahan bagi pemilik warung agar dapat menginput transaksi secara cepat dan praktis langsung dari genggaman ponsel pintar di sela-sela melayani pembeli.

---

## 2. User Persona

### Persona 1 — Ibu Sri — Pemilik Warung Kelontong
| Komponen | Isi |
| :--- | :--- |
| **Nama dan peran** | Ibu Sri — Pemilik Warung Kelontong |
| **Tujuan** | Mencatat transaksi penjualan harian dengan cepat dan memantau sisa stok barang secara akurat tanpa menghitung ulang secara manual. |
| **Kendala** | Sering lupa mencatat barang yang keluar saat warung ramai dan kesulitan mengetahui barang apa saja yang stoknya sudah habis. |
| **Perangkat dan konteks** | Smartphone Android; digunakan langsung di area kasir warung sambil melayani pelanggan. |
| **Frekuensi penggunaan** | Setiap hari (berkali-kali sesuai jumlah transaksi harian). |

### Persona 2 — Pak Budi — Pemasok Barang Sembako
| Komponen | Isi |
| :--- | :--- |
| **Nama dan peran** | Pak Budi — Pemasok Barang Sembako |
| **Tujuan** | Melihat daftar kebutuhan pasokan barang yang sudah menipis di warung agar pengiriman barang sesuai kebutuhan. |
| **Kendala** | Sering keliru membawakan jumlah pasokan barang karena informasi stok dari pemilik warung kurang akurat. |
| **Perangkat dan konteks** | Smartphone Android; digunakan saat mengonfirmasi pesanan stok dari pemilik warung. |
| **Frekuensi penggunaan** | 1–2 kali per minggu saat jadwal pasok barang. |

---

## 3. Kebutuhan Fungsional

| ID | Rumusan Kebutuhan | Terkait Persona |
| :---: | :--- | :---: |
| **F-01** | Pemilik warung dapat menambahkan data barang baru beserta harga dan jumlah stok awal. | Persona 1 |
| **F-02** | Pemilik warung dapat mencatat transaksi penjualan dengan memilih barang, jumlah, dan mengalkulasi total harga secara otomatis. | Persona 1 |
| **F-03** | Pemilik warung dapat melihat daftar stok barang terkini beserta status peringatan stok minimum. | Persona 1 |
| **F-04** | Pemilik warung dapat melihat riwayat transaksi penjualan harian. | Persona 1 |
| **F-05** | Pemilik warung dapat memperbarui data harga dan stok barang yang tersedia. | Persona 1 |
| **F-06** | Pemasok dapat melihat rekap daftar barang yang memerlukan pengadaan stok ulang. | Persona 2 |

---

## 4. Kebutuhan Nonfungsional

| ID | Kategori | Rumusan | Kriteria Terukur |
| :---: | :--- | :--- | :--- |
| **NF-01** | Kegunaan | Proses pencatatan transaksi penjualan mudah diselesaikan oleh pemilik warung. | Tugas utama pencatatan satu transaksi selesai maksimal dalam 4 langkah interaksi layar. |
| **NF-02** | Kinerja | Halaman aplikasi dapat dimuat dengan cepat saat dibuka di warung. | Halaman daftar stok barang dan dashboard tampil kurang dari 2 detik pada perangkat Android target. |

---

## 5. Prioritas Fitur (MoSCoW)

| Prioritas | ID Kebutuhan | Alasan |
| :--- | :---: | :--- |
| **Must have** | F-01, F-02, F-03 | Fitur inti wajib (MVP) untuk mengelola data barang, melayani transaksi harian, dan mencegah kehabisan stok. Tanpa fitur ini aplikasi tidak memenuhi tujuan utama. |
| **Should have** | F-04, F-05 | Fitur penting untuk pemantauan omzet dan penyesuaian harga modal, tetapi transaksi harian masih bisa berjalan sementara tanpanya. |
| **Could have** | F-06 | Menambah nilai kepraktisan bagi pemasok dalam memantau barang, tetapi tidak mengganggu operasional utama jika belum diimplementasikan. |
| **Won't have (saat ini)** | - | Seluruh kebutuhan teridentifikasi sudah masuk ke dalam prioritas pengembangan hingga akhir semester. |

---

## 6. Pemetaan Kebutuhan ke Antarmuka

| ID Kebutuhan | Rumusan (ringkas) | Prioritas | Halaman yang Memenuhi | Widget yang Direncanakan (P3) |
| :---: | :--- | :---: | :--- | :--- |
| **F-01** | Tambah data barang & stok | Must | Halaman Form Tambah Barang | `Scaffold` + `Column` + `TextField` + `ElevatedButton` |
| **F-02** | Catat transaksi penjualan | Must | Halaman Kasir / Transaksi | `Scaffold` + `ListView.builder` + `Card` + `ElevatedButton` |
| **F-03** | Lihat daftar stok barang | Must | Halaman Dashboard Utama | `Scaffold` + `ListView.builder` + `ListTile` + `Text` |
| **F-04** | Lihat riwayat penjualan | Should | Halaman Riwayat Transaksi | `Scaffold` + `ListView.builder` + `Card` |
| **F-05** | Edit data harga & stok | Should | Halaman Edit Barang | `Scaffold` + `Column` + `TextField` + `ElevatedButton` |
| **F-06** | Rekap barang perlu restok | Could | Halaman Laporan Stok Pemasok | `Scaffold` + `ListView.builder` + `ListTile` |