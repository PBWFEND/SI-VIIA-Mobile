# UTS Pemrograman Aplikasi Bergerak — SI RAKUS

| | |
|:--|:--|
| **Nama** | Wendi Feriyanda |
| **NIM** | 230660221026 |
| **Kelas** | SI-VIIA |
| **Program Studi** | Sistem Informasi |
| **Domain** | Sistem Informasi Perpustakaan Kampus |
| **Aplikasi** | SI RAKUS (Sistem Rak Kampus) |

SI RAKUS adalah aplikasi mobile (Flutter + Dart) untuk membantu mahasiswa mencari buku dan mengetahui ketersediaan stoknya. Data pada prototype berupa data contoh lokal (in-memory) dan belum terhubung dengan katalog resmi perpustakaan.

## Isi Folder `tugas-8/`

| Berkas | Keterangan |
|:--|:--|
| `tes-konsep-uts.md` | Jawaban Tes Konsep Soal 1–10 (dikerjakan mandiri). |
| `laporan-progress-uts.md` | Laporan progress project (M1–M3, matriks kebutuhan, kendala, rencana M5, refleksi, deklarasi AI). |
| `screenshot-daftar.png` | Bukti halaman daftar berisi data. |
| `screenshot-form.png` | Bukti form pengisian data dengan validasi. |
| `screenshot-hapus.png` | Bukti dialog konfirmasi hapus. |
| `dokumen-kebutuhan.md` dan `user-flow.png` | Dokumen kebutuhan + user flow (Tugas 4). |
| `information-architecture.md`, `wireframe.png`, `catatan-keputusan-ui.md`, `halaman-utama.dart` | Prototype UI/UX (Tugas 5). |
| `navigation-flow.md`, `catatan-keputusan-navigasi.md`, `form-interaksi.dart` | Navigasi dan interaksi (Tugas 6). |
| `model-data.md`, `catatan-keputusan-data.md`, `crud-lokal.dart` | Model data dan CRUD lokal (Tugas 7). |

## Cara Menjalankan

1. Salin `crud-lokal.dart` ke `lib/main.dart` pada proyek Flutter yang memiliki `pubspec.yaml`.
2. Jalankan `flutter pub get`.
3. Jalankan `flutter run -d chrome`.

## Batasan Prototype

- Operasi Create, Update, dan Delete hanya mengelola dataset contoh lokal untuk latihan CRUD, bukan katalog resmi perpustakaan.
- Data disimpan in-memory sehingga kembali ke data awal saat aplikasi dijalankan ulang.
- Validasi form masuk bersifat simulasi; belum ada autentikasi dan backend.

## Deklarasi Penggunaan AI

Deklarasi penggunaan AI: ChatGPT — membantu meninjau konsistensi dokumen kebutuhan, IA, navigation flow, model data, serta menjelaskan dan memeriksa struktur kode Flutter/CRUD; Claude — membantu merapikan susunan laporan progress, README, dan kerangka file tes konsep; perbaikan kode, pengujian, dan penjelasan dilakukan serta diverifikasi oleh penulis. AI tidak digunakan untuk menjawab Tes Konsep UTS.
