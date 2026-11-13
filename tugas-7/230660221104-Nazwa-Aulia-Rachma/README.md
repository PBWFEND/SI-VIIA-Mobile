# Tugas 7 — MVP Awal dengan Data Lokal

**Nama aplikasi:** Perpustakaan Kampus  
**Nama:** Nazwa Aulia Rachma  
**NIM:** 230660221104  
**Domain:** Sistem informasi perpustakaan

## Deskripsi

Tugas ini membuat MVP lokal untuk mengelola daftar buku perpustakaan tanpa package tambahan. Pengguna dapat menambah buku melalui form, melihat data dengan `ListView.builder`, mengubah status berdasarkan `id`, dan menghapus buku setelah konfirmasi dialog.

## Berkas

- `model-data.md` — entitas, field, kebutuhan, dan sumber nilai.
- `crud-lokal.dart` — model `Buku` dan antarmuka CRUD lokal.
- `screenshot-daftar.png` — bukti daftar berisi data setelah Create dan Read.
- `screenshot-hapus.png` — bukti dialog konfirmasi Delete.
- `catatan-keputusan-data.md` — keputusan field, id, CRUD, persistensi, dan feedback.

## Cara menjalankan

Salin `crud-lokal.dart` sebagai `lib/main.dart` pada proyek Flutter, lalu jalankan:

```bash
flutter run -d chrome
```

## Refleksi

Bagian yang paling sulit dipertahankan konsistensinya adalah memastikan `id` tetap menjadi acuan saat objek diganti atau dihapus dari daftar. Saya memakai `indexWhere` untuk Update dan `removeWhere` untuk Delete agar operasi tidak bergantung pada posisi kartu yang dapat berubah. Model `Buku`, state daftar, dan tabel kebutuhan kemudian menggunakan field yang sama sehingga setiap aksi CRUD tetap dapat ditelusuri ke kebutuhan perpustakaan.

## Deklarasi penggunaan AI

Deklarasi penggunaan AI: ChatGPT — membantu meninjau model data, pola CRUD lokal, validasi form, dan kelengkapan bukti visual; hasilnya dirumuskan ulang oleh penulis.
