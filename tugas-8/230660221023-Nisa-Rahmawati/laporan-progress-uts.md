# Laporan Progress Project UTS (Milestone M4)

| Identitas | Detail |
|:--|:--|
| **Nama** | Nisa Rahmawati |
| **NIM** | 230660221023 |
| **Kelas** | SI-VIIA |
| **Domain SI** | Sistem Informasi Perpustakaan Kampus |
| **Judul Aplikasi** | Perpustakaan Kampus Web |
| **Repository** | [PBWFEND/SI-VIIA-Mobile](https://github.com/PBWFEND/SI-VIIA-Mobile) |

---

## 1. Ringkasan Eksekutif Project
Aplikasi Mobile & Web Perpustakaan Kampus dibangun untuk mempermudah mahasiswa dalam mengecek ketersediaan koleksi buku dan mengelola peminjaman secara mandiri. Solusi ini memfasilitasi akses informasi katalog secara cepat (*ubiquitous access*).

---

## 2. Ketercapaian Milestone

| Milestone | Deliverable | Status | Catatan |
|:---|:---|:---:|:---|
| **M1** | Analisis Kebutuhan + User Flow | **Selesai** | Metrik MoSCoW & persona terpetakan. |
| **M2** | UI/UX Design & Navigation | **Selesai** | Tampilan 3 tab antarmuka Flutter Web. |
| **M3** | MVP Aplikasi Web & CRUD | **Selesai** | Berkas `crud-lokal.dart` dapat dijalankan di Chrome & DartPad. |

---

## 3. Matriks Kebutuhan ke Implementasi Visual

| ID | Deskripsi Kebutuhan | Prioritas | Tampilan Pemenuh | Operasi Data |
|:---|:---|:---:|:---|:---:|
| F-01 | Pengajuan / penambahan buku | Must | Tab 2: Form Input (`screenshot-form.png`) | Create |
| F-02 | Melihat katalog & ketersediaan | Must | Tab 1: Katalog Utama (`screenshot-daftar.png`) | Read |
| F-03 | Mengubah detail data & status | Should | Tab 2: Form Input (`screenshot-form.png`) | Update |
| F-04 | Menghapus entitas buku | Could | Tab 3: Pop-up Hapus (`screenshot-hapus.png`) | Delete |

---

## 4. Kendala & Solusi Teknis
1. **Navigasi Multi-Halaman pada Peramban Web:** Pindah antarmuka memerlukan integrasi yang efisien tanpa me-load ulang peramban. **Solusi:** Menggunakan widget `BottomNavigationBar` dengan `IndexedStack` untuk memuat 3 halaman utama sekaligus secara instan.
2. **Sinkronisasi Data Antar-Tampilan:** Mengatur agar penambahan data pada Tab 2 dan penghapusan pada Tab 3 langsung tercermin pada Tab 1. **Solusi:** Menerapkan *Lifting State Up* pada widget `PerpustakaanAppWeb` utama.

---

## 5. Rencana Milestone M5 & Refleksi Pembelajaran
Pada Milestone M5, aplikasi akan dihubungkan dengan backend REST API perpustakaan kampus via package `http`. Pengalaman menyusun aplikasi hingga M4 memberikan pemahaman mendalam tentang arsitektur UI deklaratif Flutter Web dan sinkronisasi komponen antarmuka.

---

## Deklarasi Penggunaan AI
Deklarasi penggunaan AI: ChatGPT & Gemini — digunakan untuk membantu sintaksis kode Dart dan pemeriksaan error analyzer; penulisan laporan dan verifikasi kode dilakukan secara mandiri oleh mahasiswa.