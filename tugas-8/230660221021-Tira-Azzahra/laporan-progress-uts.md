# Laporan Progress Project UTS (Milestone M4)

| | |
|:--|:--|
| **Nama** | Tira Azzahra |
| **NIM** | 230660221021 |
| **Kelas** | SI-VIIA |
| **Domain SI** | Sistem Informasi Perpustakaan Kampus |
| **Judul Aplikasi** | Aplikasi Peminjaman Buku Perpustakaan Kampus |
| **Tautan Repository** | [Folder UTS - Tira Azzahra](https://github.com/PBWFEND/SI-VIIA-Mobile/tree/230660221021/tugas-8/230660221021-Tira-Azzahra) |

---

## 1. Ringkasan Eksekutif Project
Aplikasi ini mengatasi antrean pencatatan manual di perpustakaan dengan digitalisasi transaksi peminjaman buku. Target penggunanya adalah mahasiswa, memungkinkan mereka secara mandiri mengajukan, mengecek, dan mengelola transaksi pinjam secara responsif dari browser web (Chrome) maupun mobile.

## 2. Ketercapaian Milestone (M1 s.d. M3)
| Milestone | Deliverable | Status | Bukti |
|:---|:---|:---:|:---|
| M1: Kebutuhan | Dokumen kebutuhan & User Flow | Selesai | File Tugas 4 |
| M2: UI/UX | Wireframe & Navigasi | Selesai | File Tugas 5 & 6 |
| M3: MVP Awal | Model data & CRUD lokal | Selesai | File `crud-lokal.dart` di UTS |

## 3. Matriks Kebutuhan ke Implementasi
| ID | Deskripsi Kebutuhan | MoSCoW | Halaman Pemenuh | Operasi CRUD |
|:---|:---|:---:|:---|:---|
| F-01 | Mengajukan peminjaman buku | Must | Dialog Form Peminjaman | Create |
| F-02 | Melihat katalog / riwayat peminjaman | Must | Halaman Utama (Daftar) | Read |
| F-03 | Mengedit data/status peminjaman | Should | Dialog Edit Form | Update |
| F-04 | Menghapus riwayat transaksi | Could | Dialog Konfirmasi Hapus | Delete |

## 4. Tangkapan Layar Aplikasi Berjalan
1. `screenshot-daftar.png` — Tampilan katalog utama dengan fitur pencarian.
2. `screenshot-form.png` — Form dialog tambah data lengkap dengan validasi error.
3. `screenshot-hapus.png` — Umpan balik perlindungan penghapusan via `AlertDialog`.

## 5. Kendala dan Solusi Teknis
1. **Unbounded Height Error:** Menggunakan `ListView` di dalam `Column` memunculkan error overflow. **Solusi:** Membungkus widget daftar dengan widget `Expanded`.
2. **Data UI Tidak Sinkron saat Form Dialog Ditutup:** Perubahan di form tidak ter-*render* di halaman utama. **Solusi:** Memastikan operasi add/edit berada di dalam blok `setState()` milik `State` utama Halaman Utama.

## 6. Rencana Pengembangan Milestone M5 (REST API)
Pada pertemuan 9-10, *In-Memory Database* sementara akan digantikan dengan package HTTP. Aplikasi akan mengambil dan melempar JSON ke backend perpustakaan sesungguhnya (`GET`, `POST`, `PUT`, `DELETE`).

## 7. Refleksi Pembelajaran Tengah Semester
Membuat aplikasi Flutter membantu saya memahami betapa powerful-nya UI Deklaratif. Saya menyadari pentingnya *state management* yang rapi. Memisahkan *immutable model* dengan logika `setState` sangat krusial agar aliran data CRUD tetap konsisten dan tidak *buggy* saat dipresentasikan ke pengguna.