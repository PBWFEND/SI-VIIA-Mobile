# Tugas 8 — Persiapan UTS

**Nama:** Lala Jalaliah  
**NIM:** 230660221019  
**Mata Kuliah:** Pemrograman Aplikasi Bergerak  
**Aplikasi:** Pengelolaan Surat Masuk UKM

## Aplikasi Pengelolaan Surat Masuk UKM

Folder ini berisi dokumen yang digunakan untuk memenuhi persiapan Ujian Tengah Semester (UTS) pada mata kuliah Pemrograman Aplikasi Bergerak.

### Daftar File

| File | Keterangan |
|---|---|
| `laporan-progress-uts.md` | Berisi laporan perkembangan proyek, mulai dari analisis kebutuhan, desain UI/UX, implementasi, hingga rencana pengembangan. |
| `tes-konsep-uts.md` | Berisi jawaban dan persiapan Tes Konsep UTS. |
| `screenshot-daftar.png` | Bukti tampilan halaman daftar surat masuk. |
| `screenshot-form.png` | Bukti tampilan form tambah surat. |
| `screenshot-hapus.png` | Bukti tampilan dialog konfirmasi hapus surat. |

### Deskripsi Proyek

Aplikasi Pengelolaan Surat Masuk UKM merupakan aplikasi berbasis Flutter yang dibuat untuk membantu pencatatan dan pengelolaan surat masuk.

Fitur yang dikembangkan meliputi:

- Menambahkan data surat masuk.
- Melihat daftar dan detail surat.
- Mencari surat berdasarkan judul atau pengirim.
- Mengubah status pemeriksaan surat.
- Mengedit dan menghapus data surat sesuai hak akses pengguna.

### Hak Akses Pengguna

Aplikasi memiliki dua pilihan peran pengguna:

- **Pengurus:** dapat melihat daftar surat, mencari surat, melihat detail, dan menambahkan surat masuk.
- **Sekretaris:** dapat menggunakan seluruh fitur Pengurus serta mengedit dan menghapus data surat.

### Demo Aplikasi

Kode sumber aplikasi tersedia pada file `crud-lokal.dart` dan dapat dijalankan melalui [DartPad Flutter](https://dartpad.dev/?template=app) dengan menggunakan kode yang tersedia pada file tersebut.

### Catatan

Penyimpanan data pada versi saat ini masih menggunakan `List` di dalam memori aplikasi. Data belum tersimpan secara permanen sehingga dapat hilang ketika aplikasi dijalankan ulang.

### Referensi Tugas Sebelumnya

Artefak tugas sebelumnya dapat dilihat pada folder berikut:

- Tugas 4: `tugas-4/230660221019-Lala Jalaliah/`
- Tugas 5: `tugas-5/230660221019- Lala Jalaliah/`
- Tugas 6: `tugas-6/230660221019- Lala Jalaliah/`
- Tugas 7: `tugas-7/230660221019-Lala Jalaliah/`