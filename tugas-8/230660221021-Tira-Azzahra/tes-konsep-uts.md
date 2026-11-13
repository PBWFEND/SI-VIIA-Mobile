# Tes Konsep UTS — Tira Azzahra (230660221021)

## Soal 1 — Konsep Aplikasi Bergerak dalam SI (CPMK-1)
1. **Portabilitas dan Aksesibilitas On-the-Go:**
   - *Penjelasan:* Perangkat mobile selalu dibawa pengguna, memungkinkan akses layanan Sistem Informasi kapan saja dan di mana saja.
   - *Contoh Peminjaman Buku/Surat:* Mahasiswa dapat mengajukan peminjaman buku atau cek status pengajuan dari smartphone di sela-sela perpindahan kelas tanpa perlu mengantre di loket perpustakaan.
2. **Umpan Balik Seketika (Push Notification & Real-time Feedback):**
   - *Penjelasan:* Mobile mendukung notifikasi sistem untuk memberi informasi kritis tanpa menunggu pengguna membuka web desktop.
   - *Contoh Peminjaman Buku/Surat:* Mahasiswa menerima notifikasi langsung ketika buku mendekati batas tanggal pengembalian atau ketika surat siap diambil di tata usaha.
3. **Sesi Penggunaan Singkat & Efisien (Micro-interactions):**
   - *Penjelasan:* Antarmuka mobile dirancang fokus pada tugas spesifik dengan alur interaksi cepat (1–2 menit).
   - *Contoh Peminjaman Buku/Surat:* Alur peminjaman diringkas menjadi 3 langkah sederhana: cari buku -> isi durasi -> kirim.

## Soal 2 — Dasar Pemrograman Dart (CPMK-1)
- `List<String>`: Tipe data koleksi terurut yang menyimpan sekumpulan data bertipe `String`.
- `String jenis`: Parameter input fungsi bernama `jenis` dengan tipe data teks (`String`).
- `isEmpty`: Properti boolean yang mengembalikan `true` jika variabel string tidak berisi karakter sama sekali (panjang = 0).
- `return`: Kata kunci untuk menghentikan eksekusi fungsi secara langsung dan kembali ke pemanggil ketika kondisi error ditemukan.
- `add`: Method untuk menambahkan elemen baru ke urutan paling akhir dari koleksi `List`.
- Perulangan `for`: Kontrol alur untuk mengiterasi setiap elemen dalam `List` berdasarkan indeks dari 0 hingga `length - 1`.
- **Kesalahan umum jika `isEmpty` dihapus:** Data berupa spasi kosong (`""`) atau string tanpa karakter akan lolos masuk ke `List`, menghasilkan item kosong pada antarmuka pengguna tanpa peringatan error.

## Soal 3 — Struktur Flutter dan Widget (CPMK-1)
- `MaterialApp`: Root widget yang mengatur tema Material Design, lokalisasi, dan peta navigasi aplikasi.
- `Scaffold`: Struktur dasar tata letak layar Material (menyediakan AppBar, Body, FloatingActionButton, SnackBar).
- `AppBar`: Bilah navigasi utama di bagian atas layar.
- `Column`: Widget tata letak untuk menyusun widget anak secara vertikal.
- `Text`: Widget untuk menampilkan string teks berformat ke layar.
- `ListView.builder`: Widget daftar berulang yang efisien dalam mengolah data besar karena merender elemen secara lazily (hanya yang terlihat di layar).
- **Masalah jika `ListView.builder` dalam `Column` tanpa `Expanded`:**
  - *Error:* `Vertical viewport was given unbounded height` (Unbounded Height Error).
  - *Penyebab:* `Column` memberikan ruang vertikal tak terbatas ke anaknya, sementara `ListView.builder` mencoba mengambil tinggi tak terbatas.
  - *Perbaikan:* Bungkus `ListView.builder` dengan widget `Expanded` agar `ListView` menggunakan sisa ruang yang tersedia di dalam `Column`.

## Soal 4 — Analisis Kebutuhan dan User Flow (CPMK-2)

| No. | Permintaan Mahasiswa | Fungsional/Nonfungsional | Prioritas MoSCoW | Alasan Prioritas |
|:---:|:---|:---:|:---:|:---|
| 1 | "Saya ingin mengajukan peminjaman buku / surat." | Fungsional | Must | Fitur transaksi utama; tanpa fitur ini aplikasi tidak bernilai bisnis. |
| 2 | "Saya ingin melihat status pengajuan peminjaman saya." | Fungsional | Must | Kebutuhan konfirmasi pengguna terhadap data transaksi yang dikirim. |
| 3 | "Saya ingin menerima notifikasi saat surat/buku siap." | Fungsional | Should | Meningkatkan pengalaman pengguna, tetapi alur transaksi tetap dapat berjalan tanpa notifikasi. |

**User Flow untuk Kebutuhan Must (Peminjaman Buku Perpustakaan):**
1. Mahasiswa membuka aplikasi Perpustakaan Kampus.
2. Sistem menampilkan Halaman Utama (Daftar Peminjaman & Bar Pencarian).
3. Mahasiswa menekan tombol "Pinjam Buku" (`FloatingActionButton`).
4. Sistem menampilkan Dialog Form Peminjaman.
5. Mahasiswa mengisi NIM, Nama, Judul Buku, dan Durasi Pinjam, lalu menekan "Tambah/Kirim".
6. Sistem memvalidasi input. Jika tidak valid, pesan error tampil di bawah field. Jika valid, sistem menyimpan data ke `List`, menampilkan `SnackBar`, dan menutup dialog.
7. Halaman Utama merefresh tampilan dan menampilkan peminjaman baru pada daftar.

## Soal 5 — UI/UX Mobile (CPMK-2)
1. **Prinsip Ukuran Target Sentuh (Touch Target Size >= 48dp):**
   - *Keputusan Desain:* Menggunakan `FloatingActionButton.extended` dan tombol ikon edit/delete dengan padding minimal 48x48dp.
   - *Alasan:* Mencegah kesalahan ketuk (*fat-finger effect*) pada layar mobile.
2. **Prinsip Hierarki Visual & Skannabilitas:**
   - *Keputusan Desain:* Menggunakan `Card` dengan judul buku tebal, informasi subtitle berukuran sedang, serta status transaksi berupa `Chip` berwarna menonjol.
   - *Alasan:* Pengguna mobile membaca secara cepat (skimming); hierarki yang jelas mempercepat pemahaman informasi status.
3. **Prinsip Feedback Interaksi Seketika:**
   - *Keputusan Desain:* Menampilkan `SnackBar` mengambang di bawah layar setiap kali aksi Create, Update, atau Delete berhasil dieksekusi.
   - *Alasan:* Memberikan kepastian psikologis kepada pengguna bahwa sistem telah merespons aksi mereka.

## Soal 6 — Navigasi dan Interaksi (CPMK-2)
- `push`: Membuka halaman baru di atas stack navigasi saat ini.
- `pushNamed`: Membuka halaman baru menggunakan nama route yang terdaftar pada peta `routes` di `MaterialApp`.
- `pop`: Menghapus halaman teratas dari stack navigasi dan kembali ke halaman sebelumnya.
- **Pengiriman Data Antarlayar:** Mengirim objek data melalui parameter `arguments` pada `Navigator.pushNamed(context, '/detail', arguments: transaksi)`. Di halaman tujuan, data dibaca secara aman memakai `ModalRoute.of(context)?.settings.arguments` dengan pemeriksaan tipe (`is TransaksiPinjam`).
- **Feedback Setelah Form:** Menampilkan `SnackBar` melalui `ScaffoldMessenger.of(context).showSnackBar(...)` lalu memanggil `Navigator.pop(context)`.

## Soal 7 — Model Data dan State (CPMK-3)
- **Mengapa field bersifat `final`:** Menjamin imutabilitas (*immutability*). Objek data tidak boleh diubah secara sengaja di sembarang tempat; perubahan data harus melalui pembuatan objek baru (misal via method `copyWith`).
- **Mengapa `id` wajib ada:** Sebagai identifikasi unik (Primary Key) untuk memastikan operasi Update dan Delete memperbarui objek yang tepat, meskipun ada judul atau nama yang identik.
- **StatelessWidget vs StatefulWidget:** `StatelessWidget` adalah widget statis yang UI-nya tidak berubah setelah di-build. `StatefulWidget` memiliki objek `State` yang dapat diperbarui sepanjang siklus hidup widget.
- **Pilihan Halaman Daftar:** Menggunakan `StatefulWidget` karena daftar data bersifat dinamis (dapat ditambah, diedit, dihapus, dan difilter).
- **Fungsi `setState`:** Memberitahu framework Flutter bahwa terjadi perubahan variabel state internal, memicu panggilan ulang method `build()` untuk memperbarui tampilan UI. Jika data bertambah tanpa `setState`, data berubah di memori tetapi layar tidak akan berubah.

## Soal 8 — CRUD Lokal (CPMK-3)

| Operasi CRUD | Method `List` / Mekanisme pada Flutter |
|:---|:---|
| **Create** | `list.add(newItem)` |
| **Read** | `list.where((item) => ...).toList()` dan `ListView.builder` |
| **Update** | `final index = list.indexWhere((item) => item.id == target.id); list[index] = itemDiperbarui;` |
| **Delete** | `list.removeWhere((item) => item.id == targetId)` |

- **Mengapa `id` digunakan sebagai kunci (bukan index):** Indeks koleksi `List` berubah secara dinamis saat terjadi penyaringan (search/filter) atau penghapusan elemen. Jika operasi update/delete menggunakan indeks daftar, sistem akan salah mengedit/menghapus data pengguna lain.

## Soal 9 — Persistensi Data Lokal (CPMK-3)
- **Perbedaan In-Memory vs Persistensi:** In-memory menyimpan data sementara di RAM (data hilang ketika aplikasi ditutup/direfresh). Persistensi (`shared_preferences` / SQLite) menyimpan data ke media penyimpanan fisik perangkat (data tetap tersimpan saat aplikasi ditutup).
- **Mengapa `shared_preferences` Asinkron (`Future`):** Proses I/O membaca dan menulis ke media penyimpanan membutuhkan waktu. Sifat asinkron mencegah antarmuka aplikasi membeku (*freezing*) selama operasi penyimpanan berlangsung.
- **Jika `await` diabaikan:** Kode di baris berikutnya akan dieksekusi sebelum data selesai ditulis, menyebabkan potensi *race condition* atau data belum tersimpan saat dibaca kembali.
- **Situasi In-Memory Cukup:** Prototype/demo aplikasi, state pencarian sementara, atau data navigasi antar layar.
- **Situasi Persistensi Mutlak:** Menyimpan token autentikasi login, preferensi tema aplikasi, atau draf formulir lokal offline.

## Soal 10 — Integrasi Konsep Lintas Pertemuan (CPMK-1 s.d. CPMK-3)
1. **Arsitektur:** Aplikasi Mobile Flutter bertindak sebagai *Frontend Presentation Layer*. Data lokal dikelola sementara dalam `State` (`List<TransaksiPinjam>`), dan disinkronkan ke *Backend SI Perpustakaan* melalui HTTP REST API dengan format data JSON.
2. **Kebutuhan & Alur:**
   - *Must 1:* F-01 Mengajukan peminjaman buku.
   - *Must 2:* F-02 Melihat status transaksi peminjaman.
   - *Alur:* Pengguna membuka aplikasi -> Sistem merender Katalog Peminjaman -> Klik Tambah -> Isi Form Validasi -> Klik Kirim -> State bertambah -> UI ter-refresh.
3. **Struktur Komponen:**
   - `MaterialApp` -> `HalamanUtamaPeminjaman` (`StatefulWidget`).
   - Halaman utama memiliki `TextField` pencarian, `ListView.builder` tempat merender `Card`, serta `FloatingActionButton` untuk memicu `AlertDialog` form.
4. **Data & State:**
   - Model `TransaksiPinjam` dengan field: `id`, `nim`, `namaMahasiswa`, `judulBuku`, `durasiHari`, `status`.
   - Operasi *Create* dipicu via method `_tambahTransaksi()` yang memanggil `setState(() => _daftarPinjam.add(baru))`. Operasi *Read* dikelola dinamis melalui method `where` pencarian yang langsung dirender oleh `ListView.builder`.