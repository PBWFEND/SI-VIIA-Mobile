# Tugas 7 — Data Lokal dan CRUD

**Nama:** Ade Yusup Maulana  
**NIM:** 230660221009  
**Program Studi:** Sistem Informasi  
**Mata Kuliah:** Pemrograman Aplikasi Bergerak

## Deskripsi

Tugas ini membuat aplikasi sederhana untuk mengelola data produk pada sistem informasi penjualan warung. Data produk yang digunakan terdiri dari ID, nama produk, harga, stok, dan status produk.

Aplikasi menerapkan proses CRUD (Create, Read, Update, Delete) menggunakan data lokal dalam bentuk `List` di dalam aplikasi. Pengguna dapat menambahkan produk, melihat daftar produk, mengubah data produk, serta menghapus produk dengan konfirmasi.

## Fitur

- Menambahkan data produk
- Menampilkan daftar produk
- Mengubah data produk
- Menghapus data produk dengan konfirmasi
- Menentukan status produk berdasarkan stok
- Menampilkan harga dalam format Rupiah

## Struktur Data

Entity yang digunakan adalah **Produk** dengan beberapa field:

- `id` — String
- `nama` — String
- `harga` — int
- `stok` — int
- `status` — String

## Penggunaan AI

Dalam pengerjaan tugas ini, AI digunakan sebagai alat bantu untuk membantu menyusun dan memperbaiki kode program, terutama pada bagian implementasi CRUD dan penanganan form input. Kode yang dihasilkan kemudian diuji kembali secara langsung menggunakan Flutter dan disesuaikan dengan kebutuhan tugas.

## Refleksi

Pada tugas ini saya belajar bagaimana membuat model data dan menerapkan proses CRUD menggunakan data lokal pada Flutter. Saya juga belajar bahwa penggunaan `setState` diperlukan agar perubahan data dapat langsung ditampilkan pada halaman aplikasi. Setelah melakukan pengujian tambah, edit, dan hapus data, saya menjadi lebih memahami alur pengelolaan data pada aplikasi sederhana.