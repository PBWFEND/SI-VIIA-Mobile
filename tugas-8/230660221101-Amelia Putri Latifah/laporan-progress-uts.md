# Laporan Progress Project UTS (Milestone M4)

## 1. Identitas
| | |
|:--|:--|
| **Nama** | Amelia Putri Latifah |
| **NIM** | 230660221101 |
| **Kelas** | SI-VIIA |
| **Domain SI** | Sistem Absensi Organisasi |
| **Judul Aplikasi** | PresenGo |
| **Tautan Repository** | https://github.com/ameliapl3/SI-VIIA-Mobile.git

---
## 2. Ringkasan Eksekutif Project
PresenGo adalah aplikasi presensi *mobile* yang menyelesaikan masalah inefisiensi rekap kehadiran dan kecurangan "titip absen" melalui tautan jarak jauh pada kegiatan keanggotaan mahasiswa. Pengguna utamanya adalah anggota biasa yang membutuhkan kepraktisan (akses saat bergerak) dan pengurus/sekretaris yang membutuhkan rekap instan. Solusi ini dibangun berbasis *mobile* untuk memanfaatkan portabilitas, kamera (*QR Code*), serta mempercepat *check-in* di ruang lapangan dengan mobilitas tinggi.

## 3. Ketercapaian Milestone (M1 s.d. M3)
| Milestone | Deliverable | Status (Selesai / Sebagian) | Catatan / Bukti |
|:----------|:------------|:----------------------------|:----------------|
| M1: Kebutuhan | Dokumen kebutuhan + User Flow | Selesai | File `dokumen-kebutuhan.md` di Tugas 4 |
| M2: UI/UX | Wireframe + Navigasi | Selesai | File rancangan IA & `wireframe.png` di Tugas 5 |
| M3: MVP Awal | Model data + CRUD lokal | Selesai | Form navigasi & `crud-lokal.dart` di Tugas 6 & 7 |

## 4. Matriks Kebutuhan ke Implementasi
| ID Kebutuhan | Deskripsi Kebutuhan | Prioritas MoSCoW | Halaman Pemenuh | Operasi Data Terkait |
|:-------------|:-------------------|:----------------:|:----------------|:---------------------|
| F-01 | Anggota dapat melihat daftar jadwal terdekat | Must | Halaman Utama | Read |
| F-04 | Pengurus dapat membuat jadwal kegiatan baru | Must | Halaman Form | Create |
| F-05 | Pengurus dapat memantau (merespons status) kegiatan | Must | Halaman Detail/Utama | Update |
| F-0x | Membatalkan pembuatan jadwal salah | Must | Halaman Utama | Delete |

## 5. Tangkapan Layar Aplikasi Berjalan
*(Tangkapan layar dapat dicek langsung pada repository di folder `tugas-7` berupa `screenshot-daftar.png`, `screenshot-form.png`, dan `screenshot-hapus.png` yang telah saya lampirkan dari tugas sebelumnya).*

## 6. Kendala dan Solusi Teknis
| No. | Kendala | Cara Mengatasinya |
|:---:|:--------|:------------------|
| 1 | **UI/UX Material 3:** Kesulitan menyamakan warna *Chip status* di *Card* karena *ThemeData* M3 mendikte palet warna tanpa *hardcode*. | Menggunakan fungsi *ternary operator* logika warna dinamis `tertiaryContainer` dari `tema.colorScheme`. |
| 2 | **Inkonsistensi State:** Saat awal navigasi dari Form ke Daftar, list tidak otomatis memunculkan data kegiatan baru padahal `setState` sudah berjalan. | Memindahkan deklarasi inisialisasi `_databaseLokal` menjadi *global variable* (sementara) agar `pushNamed` bisa memicu penyegaran pada navigasi balik `pop`. |

## 7. Rencana Pengembangan Milestone M5 (REST API)
Pada paruh kedua semester, fungsi data *dummy in-memory* akan digantikan dengan modul penarik JSON. Saya akan mengintegrasikan `http.get` untuk memuat riwayat kegiatan sesungguhnya langsung dari *database* *backend*, serta memanfaatkan *POST request* yang dilempar dari Halaman Pemindai (F-02) agar data anggota yang hadir terekap instan di *Dashboard* panitia, lengkap dengan penanganan *loading progress bar*.

## 8. Refleksi Pembelajaran Tengah Semester
Memasuki pertengahan semester, saya baru menyadari bahwa membuat antarmuka UI/UX di Flutter (M2) belumlah cukup jika tidak disertai manajemen status (M3) yang kokoh. *State* bagaikan "otak" aplikasi; tanpanya, desain sebagus apa pun tidak ada artinya karena tidak merespons input *user*. Tantangan terberat saat ini adalah menjaga kedisiplinan alur *data binding* (CRUD) agar tidak merusak logika yang sudah ditetapkan sejak tahap Dokumen Kebutuhan.

## 9. Deklarasi Penggunaan AI
Deklarasi penggunaan AI: Gemini — membantu menelaah pesan *error* "Unbounded height" pada *ListView*, memberikan struktur logika asinkron saat perancangan diagram *flowchart* Mermaid, serta memberikan referensi konsep penerapan UI/UX Material 3 pada komponen navigasi; perbaikan kode, pengujian, dan penjelasan dilakukan serta diverifikasi oleh penulis.