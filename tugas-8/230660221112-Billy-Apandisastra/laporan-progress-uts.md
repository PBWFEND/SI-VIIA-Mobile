# Laporan Progress UTS: Aplikasi SI Perpustakaan Mobile

### 2.1 Tabel Identitas
| | |
|:--|:--|
| **Nama** | Billy Apandisastra |
| **NIM** | 230660221112 |
| **Kelas** | SI- VIIA |
| **Domain SI** | Sistem Informasi Perpustakaan |
| **Judul Aplikasi** | SI Perpustakaan Mobile |
| **Tautan Repository** | https://github.com/BillyApandisastra230660221112/SI-VIIA-Mobile/tree/main/tugas-8/230660221112-BillyApandisastra |

### 2.2 Ringkasan Eksekutif Project
SI Perpustakaan Mobile adalah aplikasi yang memecahkan masalah antrean administrasi dan lambatnya layanan sirkulasi manual di perpustakaan. Penggunanya adalah mahasiswa (anggota) dan pustakawan. Solusi berbasis aplikasi *mobile* dipilih agar mahasiswa dapat mengecek ketersediaan buku dan melakukan reservasi peminjaman dari mana saja, sementara pustakawan dapat mengelola status sirkulasi secara *real-time* langsung dari genggaman tanpa harus menetap di depan layar komputer meja.

### 2.3 Ketercapaian Milestone (M1 s.d. M3)
| Milestone | Deliverable | Status | Catatan / Bukti |
|:----------|:------------|:----------------|:----------------|
| M1: Kebutuhan | Dokumen kebutuhan + User Flow | Selesai | File ada di direktori `tugas-4` |
| M2: UI/UX | Wireframe + Navigasi | Selesai | File ada di direktori `tugas-5` dan `tugas-6` |
| M3: MVP Awal | Model data + CRUD lokal | Selesai | File `crud-lokal.dart` ada di direktori `tugas-7` |

### 2.4 Matriks Kebutuhan ke Implementasi
| ID Kebutuhan | Deskripsi Kebutuhan | Prioritas MoSCoW | Halaman Pemenuh | Operasi Data Terkait |
|:-------------|:-------------------|:----------------:|:----------------|:---------------------|
| F-01 | Anggota dapat melihat daftar pencarian buku. | Must | Halaman Katalog (`/`) | Read |
| F-02 | Anggota dapat melihat detail informasi buku. | Must | Halaman Detail (`/detail`) | Read |
| F-03 | Anggota dapat meminjam/mereservasi buku. | Must | Form Reservasi (`/reservasi`) | Create |
| F-04 | Admin dapat memverifikasi & menghapus data. | Must | Halaman Kelola Data | Update, Delete |

### 2.5 Tangkapan Layar Aplikasi Berjalan
*(Anda harus menyiapkan file `screenshot-daftar.png`, `screenshot-form.png`, dan `screenshot-hapus.png` dari aplikasi DartPad/VS Code Anda).*

| No. | File | Mengisi Bukti |
|:---:|:-----|:--------------|
| 1 | `screenshot-daftar.png` | Bukti Halaman Katalog / Read berjalan. |
| 2 | `screenshot-form.png` | Bukti Halaman form input dengan validasi *error*. |
| 3 | `screenshot-hapus.png` | Bukti Dialog *AlertDialog* konfirmasi Hapus. |

### 2.6 Kendala dan Solusi Teknis
| No. | Kendala | Cara Mengatasinya |
|:---:|:--------|:-------------------|
| 1 | Terjadi layar *blank/error* saat menangkap argumen navigasi dari route katalog ke rute detail karena tipe datanya tertukar. | Menambahkan validasi tipe `is Map<String, String>` menggunakan kondisi IF dan `ModalRoute.of` sebelum merender komponen detail. |
| 2 | Kesulitan mempertahankan `status` lama saat mengeksekusi fitur *Update* menggunakan `indexWhere` karena objek *final* tidak bisa dimutasi. | Membuat instansiasi *class* model baru untuk diletakkan pada indeks tersebut dengan mendaur ulang properti lama `status` dan mengganti properti teks form. |

### 2.7 Rencana Pengembangan Milestone M5 (REST API)
Pada minggu 9-10, aplikasi ini akan beralih dari memori lokal ke sistem *backend*. Data daftar buku (*katalog*) akan diambil menggunakan metode HTTP `GET` dari REST API server SI Perpustakaan. Selain itu, form reservasi (operasi *Create*) akan dikirim dengan metode `POST` ke *endpoint* API terkait agar status inventaris *database* perpustakaan utama berubah secara otomatis.

### 2.8 Refleksi Pembelajaran Tengah Semester
Memasuki pertengahan semester, saya memahami bahwa pengembangan aplikasi *mobile* di Flutter menuntut pemikiran reaktif berbasis komponen (*Widget*). Pemisahan antara arsitektur antarmuka UI (`Stateless`) dan pengelolaan data lokal (`Stateful`) menyadarkan saya betapa krusialnya mengelola *state* dengan efisien. Tantangan terbesar adalah membiasakan logika perpindahan data antar *route* secara asinkron tanpa mengganggu pengalaman antarmuka pengguna.

### 2.9 Deklarasi Penggunaan AI
Deklarasi penggunaan AI: Gemini — membantu merumuskan draf struktur UTS, penjelasan teoretis, dan memformulasikan kalimat *markdown*; pemahaman teknis dan eksekusi dilakukan serta diverifikasi oleh penulis.