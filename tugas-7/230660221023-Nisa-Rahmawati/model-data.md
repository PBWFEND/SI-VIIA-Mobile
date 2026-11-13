# Model Data — Sistem Informasi Perpustakaan Kampus

**Nama:** Nisa Rahmawati  
**NIM:** 230660221023  
**Kelas:** SI-VIIA  
**Mata Kuliah:** Pemrograman Aplikasi Bergerak  

---

## 1. Daftar Entitas Data Utama

Entitas utama yang dikelola pada aplikasi Sistem Informasi Perpustakaan Kampus adalah **`Buku`** (digunakan untuk mengelola katalog koleksi dan status ketersediaan buku perpustakaan).

| Field | Tipe Data | Kebutuhan Dipenuhi | Sumber Nilai | Deskripsi & Alasan |
| :--- | :--- | :--- | :--- | :--- |
| `id` | `String` | F-01, F-03 | Sistem (Timestamp / Unique ID) | Kunci unik entitas untuk mengidentifikasi setiap judul buku agar operasi Update dan Delete tepat sasaran. |
| `judul` | `String` | F-01, F-03 | Form Input (User) | Judul buku perpustakaan (misal: "Analisis dan Perancangan Sistem Informasi"). Wajib diisi pengguna. |
| `penulis` | `String` | F-01, F-03 | Form Input (User) | Nama pengarang/penulis buku (misal: "Jogiyanto HM"). |
| `kategori` | `String` | F-01 | Form Input (Dropdown) | Klasifikasi bidang ilmu ("Informatika", "Psikologi", "Metodologi", "Sistem Informasi"). |
| `status` | `String` | F-02, F-03 | Form Input / Sistem | Status ketersediaan buku ("Tersedia" atau "Sedang Dipinjam"). |

---

## 2. Rincian Sumber Nilai dan Keterkaitannya

1. **Form Input (Pengguna):**
   - `judul`, `penulis`, `kategori`, dan `status` berasal langsung dari inputan pengguna/petugas melalui form modal *tambah/edit buku*.
2. **Sistem (Otomatis):**
   - `id` dibangkitkan otomatis menggunakan format string berbasis stempel waktu (`DateTime.now().millisecondsSinceEpoch.toString()`) saat buku baru ditambahkan ke katalog.