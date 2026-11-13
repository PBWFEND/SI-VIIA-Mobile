# Dokumen Kebutuhan: SI Perpustakaan Mobile

## 1. Deskripsi Aplikasi
Aplikasi SI Perpustakaan Mobile adalah platform yang memudahkan anggota perpustakaan untuk mencari, meminjam, dan memantau riwayat peminjaman buku mereka. Masalah utama pengguna saat ini adalah antrean panjang di meja administrasi untuk sekadar mengecek ketersediaan buku fisik di rak dan seringnya anggota terlambat mengembalikan buku karena lupa tenggat waktu. Solusi berbasis aplikasi mobile dipilih karena smartphone selalu dibawa oleh pengguna, sehingga notifikasi pengingat pengembalian lebih efektif dan pengecekan katalog dapat dilakukan di mana saja sebelum datang ke perpustakaan.

## 2. User Persona

**Persona 1: Anggota Perpustakaan**
*   **Nama dan Peran:** Andi (Mahasiswa/Anggota Perpustakaan)
*   **Tujuan:** Menemukan buku referensi tugas dan meminjamnya dengan cepat.
*   **Kendala:** Sering kesulitan mengetahui ketersediaan buku sebelum datang ke perpustakaan dan sering lupa jadwal pengembalian.
*   **Perangkat dan Konteks:** Smartphone Android, digunakan saat berada di kampus, kafe, atau rumah.
*   **Frekuensi Penggunaan:** 1-2 kali seminggu saat musim tugas/ujian.

**Persona 2: Pustakawan**
*   **Nama dan Peran:** Budi (Pustakawan/Admin)
*   **Tujuan:** Mengelola status sirkulasi (peminjaman dan pengembalian) buku dengan akurat dan cepat.
*   **Kendala:** Terlalu banyak melayani pertanyaan ketersediaan buku secara manual yang menyita waktu pelayanan sirkulasi.
*   **Perangkat dan Konteks:** Tablet atau Smartphone, digunakan secara *stand-by* di meja sirkulasi perpustakaan.
*   **Frekuensi Penggunaan:** Setiap hari kerja sepanjang jam operasional.

## 3. Kebutuhan Fungsional

*   **F-01:** Anggota dapat mencari data buku berdasarkan judul untuk melihat status ketersediaannya di rak.
*   **F-02:** Anggota dapat melihat detail informasi buku untuk mengetahui sinopsis dan lokasi rak spesifik.
*   **F-03:** Anggota dapat melakukan reservasi peminjaman pada buku yang berstatus tersedia untuk diambil di hari yang sama.
*   **F-04:** Anggota dapat melihat daftar riwayat peminjaman untuk memantau tenggat waktu pengembalian buku.
*   **F-05:** Pustakawan dapat mengubah status peminjaman buku menjadi "Dipinjam" saat buku fisik diserahkan ke anggota.
*   **F-06:** Pustakawan dapat mengubah status peminjaman buku menjadi "Tersedia" saat anggota mengembalikan buku fisik.

## 4. Kebutuhan Nonfungsional

*   **NF-01 (Kinerja):** Aplikasi harus dapat memuat dan menampilkan hasil pencarian katalog buku dalam waktu maksimal 2 detik pada koneksi internet 4G.
*   **NF-02 (Kompatibilitas):** Antarmuka aplikasi harus responsif dan tidak mengalami *overflow* (terpotong) pada layar smartphone berukuran mulai dari 4.7 inci hingga 6.8 inci.

## 5. Prioritas MoSCoW

*   **Must Have:** F-01, F-02, F-04, F-05, F-06.
    *   *Alasan:* Kelima fitur ini adalah inti dari siklus sirkulasi perpustakaan; tanpanya, tujuan utama aplikasi untuk memfasilitasi pinjam-kembali buku tidak bisa berjalan.
*   **Should Have:** F-03.
    *   *Alasan:* Reservasi sangat membantu mengatasi kendala anggota, tetapi sistem masih bisa beroperasi murni dengan anggota datang langsung mencari buku (seperti sistem lama).
*   **Could Have:** Anggota dapat memberikan rating dan ulasan pada buku yang telah selesai dipinjam (F-07).
    *   *Alasan:* Bagus untuk interaksi, tetapi bukan fokus utama untuk menyelesaikan masalah antrean.
*   **Won't Have (saat ini):** Fitur pembayaran denda keterlambatan secara online.
    *   *Alasan:* Ditunda untuk iterasi berikutnya karena membutuhkan integrasi pihak ketiga (*payment gateway*) yang terlalu kompleks untuk tahap awal pengembangan.

## 6. User Flow (Alur Pencarian dan Reservasi Buku)
mermaid
flowchart TD
A([Mulai Buka Aplikasi]) --> B[Masukkan kata kunci judul buku]
B --> C{Apakah buku ditemukan?}
C -- Tidak --> D[Tampilkan pesan "Buku tidak ditemukan"]
D --> B
C -- Ya --> E[Tampilkan daftar hasil pencarian]
E --> F[Klik salah satu buku]
F --> G[Sistem menampilkan halaman Detail Buku]
G --> H[Klik tombol 'Reservasi']
H --> I{Apakah stok tersedia?}
I -- Tidak --> J[Tampilkan pesan "Stok habis / Sedang dipinjam"]
J --> G
I -- Ya --> K[Proses reservasi buku]
K --> L[Tampilkan notifikasi "Reservasi Berhasil"]
L --> M([Selesai])

## 7. Pemetaan Kebutuhan ke Antarmuka

| Kebutuhan | Halaman Tujuan | Rencana Widget Utama |
| :--- | :--- | :--- |
| F-01 | Halaman Pencarian | `TextField`, `ListView.builder`, `Card`, `Row` |
| F-02 | Halaman Detail Buku | `Column`, `Image`, `Text`, `Padding` |
| F-03 | Halaman Detail Buku | `ElevatedButton`, `AlertDialog` (untuk konfirmasi) |
| F-04 | Halaman Riwayat Pinjam | `ListView.builder`, `Container` (untuk label status), `Row` |
| F-05 & F-06 | Halaman Dashboard Admin | `ListView.builder`, `Switch` / `ElevatedButton`, `Row` |