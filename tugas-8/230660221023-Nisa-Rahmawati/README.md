# Tugas 8 — UTS (Evaluasi Tengah Semester)

- **Nama:** Nisa Rahmawati
- **NIM:** 230660221023
- **Kelas:** SI-VIIA
- **Domain:** SI Perpustakaan Kampus
- **Aplikasi:** Sistem Informasi Perpustakaan Kampus Web

---

## Isi Berkas Repository (`tugas-8/230660221023-Nisa-Rahmawati/`)
1. `README.md` — Petunjuk jalannya aplikasi dan skenario pengujian.
2. `crud-lokal.dart` — Kode sumber Flutter Web interaktif (1 file utuh) dengan fitur CRUD dinamis.
3. `laporan-progress-uts.md` — Laporan evaluasi milestone M1–M4, matriks kebutuhan, dan kendala teknis.
4. `tes-konsep-uts.md` — Jawaban lengkap 10 soal esai teori UTS Pemrograman Aplikasi Bergerak.
5. `screenshot-daftar.png` — Tangkapan layar antarmuka Halaman Katalog Utama.
6. `screenshot-form.png` — Tangkapan layar antarmuka Form Input Data Buku.
7. `screenshot-hapus.png` — Tangkapan layar antarmuka Pop-up Konfirmasi Hapus Data.

---

## Cara Menjalankan Kode di DartPad

1. Buka peramban web dan akses [https://dartpad.dev](https://dartpad.dev).
2. Hapus seluruh kode bawaan yang ada pada layar DartPad.
3. Salin (*copy*) dan tempel (*paste*) seluruh isi kode dari file `crud-lokal.dart`.
4. Klik tombol **Run** di pojok kanan atas.
5. Aplikasi web interaktif akan langsung berjalan pada panel sebelah kanan.

---

## Skenario Pengujian Fitur Interaktif

1. **Lihat Katalog (Read):** Buka **Tab 1 (Katalog Buku)**. Perhatikan daftar 5 buku awal serta banner statistik ketersediaan.
2. **Tambah Buku (Create):** Pindah ke **Tab 2 (Form Input)** atau tekan tombol **+ Tambah Buku**. Isi judul *"Sistem Basis Data"*, penulis *"Fathansyah"*, pilih kategori dan status, lalu tekan **SIMPAN DATA BUKU**. Aplikasi akan otomatis berpindah ke Tab 1 dan buku baru tampil di urutan paling atas.
3. **Ubah Data (Update):** Tekan ikon pensil (Edit) pada salah satu buku di Tab 1. Ubah statusnya menjadi *"Sedang Dipinjam"*, lalu simpan. Tampilan status di katalog akan diperbarui secara langsung.
4. **Hapus Data (Delete):** Tekan ikon tempat sampah di Tab 1 atau buka **Tab 3 (Pop-up Hapus)**. Tekan tombol **Hapus** pada dialog konfirmasi. Data buku akan terhapus dan jumlah total koleksi di banner atas berkurang secara otomatis.