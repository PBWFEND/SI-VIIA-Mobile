# Catatan Keputusan Pengelolaan Data

## 1. Penggunaan List

Aplikasi menggunakan struktur data `List<Barang>` untuk menyimpan kumpulan data barang.

List dipilih karena sesuai dengan kebutuhan aplikasi yang menerapkan CRUD lokal sederhana tanpa menggunakan database.

## 2. Penggunaan Model Barang

Data barang dibuat menggunakan class `Barang` agar setiap barang memiliki struktur atribut yang konsisten, yaitu ID, nama, kategori, harga, stok, dan batas stok minimum.

## 3. Penggunaan ID Unik

Setiap barang memiliki ID sebagai identitas pembeda. ID digunakan untuk menemukan data yang akan diperbarui atau dihapus.

Pada data awal, ID diberikan secara langsung. Sementara itu, barang baru mendapatkan ID berdasarkan nilai waktu dalam mikrodetik.

## 4. Penggunaan StatefulWidget dan setState()

`StatefulWidget` digunakan karena data barang dapat mengalami perubahan selama aplikasi berjalan.

`setState()` digunakan untuk memperbarui tampilan setelah proses penambahan, pengeditan, atau penghapusan barang.

## 5. Keputusan Penyimpanan Data

Penyimpanan menggunakan List di dalam memori aplikasi (*in-memory storage*). Pendekatan ini dipilih karena sesuai dengan tujuan latihan CRUD lokal.

Kelebihannya adalah implementasi sederhana dan tidak membutuhkan konfigurasi database tambahan.

## 6. Keterbatasan

Data tidak tersimpan secara permanen. Ketika aplikasi ditutup atau dimulai ulang, perubahan data akan hilang dan aplikasi kembali menggunakan data awal.

Dengan demikian, aplikasi ini digunakan untuk menerapkan konsep pengelolaan data lokal, bukan sebagai sistem penyimpanan permanen.