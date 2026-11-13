# Tugas 3 — Halaman Aplikasi Sederhana

**Nama aplikasi:** Perpustakaan Kampus  
**Nama:** Nazwa Aulia Rachma  
**NIM:** 230660221104  
**Domain SI:** Perpustakaan

## Deskripsi halaman

Halaman ini merupakan beranda sederhana untuk sistem informasi perpustakaan kampus. Pengguna dapat melihat sapaan, jumlah buku yang sedang dipinjam, tanggal jatuh tempo, serta daftar layanan perpustakaan yang tersedia pada hari ini. Data layanan disimpan statis di dalam kode dan ditampilkan menggunakan kartu serta daftar yang dapat digulir.

## Struktur widget

Diagram widget tree tersedia pada `widget-tree.mmd` dan hasil gambarnya pada `widget-tree.png`.

Halaman menggunakan `Column`, `Row`, `Stack`, `Padding`, dan `ListView.builder`. `Expanded` dipakai untuk membungkus `ListView.builder` agar daftar dapat digulir tanpa menyebabkan `RenderFlex overflow`.

## Cara menjalankan

Dari folder proyek Flutter yang memuat file ini, jalankan:

```bash
flutter run -d chrome
```

## Refleksi

Widget yang paling sulit saya rangkai adalah `ListView.builder` di dalam `Column` karena harus menggunakan `Expanded` agar tinggi daftar mengikuti ruang yang tersedia. Saya juga perlu mengatur `Stack` dan `Positioned` supaya ikon dekorasi tetap berada di sudut banner tanpa menutupi teks. Setelah memahami batasan ruang setiap widget, susunan halaman menjadi lebih mudah dibaca dan tidak mengalami overflow.
