# 📚 SI Perpustakaan Mobile (Tugas 8 - UTS)

Selamat datang di repositori pengumpulan Ujian Tengah Semester (Milestone M4) untuk mata kuliah Pemrograman Mobile / Sistem Informasi. 

Proyek ini adalah **Sistem Informasi Perpustakaan Mobile**, sebuah solusi digital untuk memecahkan masalah antrean administrasi dan lambatnya layanan sirkulasi manual di perpustakaan kampus.

---

## 👤 Identitas Mahasiswa

| Informasi | Keterangan |
| :--- | :--- |
| **Nama** | Billy Apandisastra |
| **NIM** | 230660221112 |
| **Kelas** | SI-VIIA |
| **Domain SI** | Sistem Informasi Perpustakaan |

---

## 🚀 Fitur Utama (MVP Awal)

Berdasarkan analisis kebutuhan, aplikasi ini telah mengimplementasikan operasi data lokal (CRUD *in-memory*) untuk fitur-fitur esensial (Must Have) berikut:

1. **Katalog Buku (Read):** Anggota dapat melihat daftar pencarian buku yang tersedia.
2. **Detail Buku (Read):** Anggota dapat melihat detail spesifikasi informasi buku.
3. **Form Reservasi (Create):** Anggota dapat meminjam/mereservasi buku secara langsung.
4. **Kelola Data (Update & Delete):** Pustakawan/Admin dapat memverifikasi status reservasi dan menghapus data yang sudah selesai.

---

## 📁 Struktur File Pengumpulan UTS

Folder `230660221112-BillyApandisastra` ini memuat berkas-berkas evaluasi UTS sesuai panduan pengerjaan:

- 📄 **`laporan-progress-uts.md`** : Dokumen laporan progres proyek Milestone 1 hingga Milestone 3, refleksi pembelajaran, matriks kebutuhan, dan deklarasi AI.
- 📄 **`tes-konsep-uts.md`** : Dokumen yang berisi jawaban analitis dan teknis dari 10 soal Tes Konsep UTS.
- 🖼️ **`screenshot-daftar.png`** : Tangkapan layar bukti halaman Katalog (Read) berjalan.
- 🖼️ **`screenshot-form.png`** : Tangkapan layar bukti form input berjalan lengkap dengan validasi *error*.
- 🖼️ **`screenshot-hapus.png`** : Tangkapan layar bukti dialog peringatan (*AlertDialog*) saat mengonfirmasi penghapusan data.

---

## 🛠️ Teknologi yang Digunakan

- **Framework:** Flutter (Material 3 Design)
- **Bahasa:** Dart
- **State Management & Data:** `StatefulWidget` & *In-Memory List* (Lokal)
- **Arsitektur Navigasi:** Named Routes (`pushNamed`, `pop`, *Arguments*)

> **Catatan:** Pada pengembangan selanjutnya (Milestone M5), pengelolaan data aplikasi ini akan diintegrasikan dengan sistem *backend* menggunakan layanan REST API.