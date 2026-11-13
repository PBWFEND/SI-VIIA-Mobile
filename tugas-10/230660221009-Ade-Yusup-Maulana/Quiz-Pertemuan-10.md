# Quiz Pertemuan 10 — Integrasi Data dan Proses Bisnis Sistem Informasi

**Mata Kuliah:** Pemrograman Aplikasi Bergerak  
**Pertemuan:** 10  
**Nama:** Ade Yusup Maulana  
**NIM:** 230660221009  
**Program Studi:** Sistem Informasi  

## 1. Mengapa integrasi data membutuhkan identifier?

Integrasi data membutuhkan identifier karena identifier digunakan untuk menghubungkan data dari sumber yang berbeda agar data yang berhubungan dapat dikenali dengan tepat.

Pada proyek Tugas 10, saya menggunakan API `/users` untuk mengambil data pengguna dan API `/posts` untuk mengambil data pengajuan. Kedua data tersebut dihubungkan menggunakan `userId`.

Contohnya, data pengajuan yang memiliki `userId = 1` akan dihubungkan dengan pengguna yang memiliki `id = 1`. Dengan demikian, nama pengguna dapat ditampilkan bersama judul dan deskripsi pengajuannya.

## 2. Apa perbedaan penggunaan Future.wait dan menjalankan request secara berurutan?

`Future.wait` digunakan untuk menjalankan beberapa proses asynchronous secara bersamaan dan menunggu seluruh proses tersebut selesai.

Sementara itu, request secara berurutan menjalankan proses pertama terlebih dahulu, kemudian menjalankan proses berikutnya setelah proses pertama selesai.

Pada proyek Tugas 10, saya menggunakan `Future.wait` untuk mengambil data pengguna dari `/users` dan data pengajuan dari `/posts` secara bersamaan.

Penggunaan `Future.wait` lebih efisien karena kedua API tidak saling bergantung ketika proses pengambilan data dilakukan. Setelah keduanya selesai, data dapat digabungkan berdasarkan `userId`.

## 3. Jelaskan field pada model DataPengajuan dan fungsi fromJson.

Model `DataPengajuan` digunakan untuk menampung data pengajuan yang diperoleh dari API `/posts`.

Field yang digunakan adalah:

- `id`: menyimpan ID pengajuan.
- `userId`: menyimpan ID pengguna yang membuat pengajuan.
- `judul`: menyimpan judul pengajuan.
- `deskripsi`: menyimpan isi atau deskripsi pengajuan.

Fungsi `fromJson` digunakan untuk mengubah data JSON dari API menjadi objek Dart sehingga data lebih mudah dikelola di dalam aplikasi.

Contohnya, field `title` dari JSON API diubah menjadi field `judul` pada model `DataPengajuan`.

## 4. Mengapa service layer lebih baik daripada menempatkan request API langsung di widget?

Service layer lebih baik karena memisahkan proses pengambilan dan pengolahan data dari tampilan aplikasi.

Jika request API ditempatkan langsung di widget, kode tampilan akan bercampur dengan proses komunikasi API sehingga lebih sulit dikelola dan diperbaiki.

Pada proyek Tugas 10, saya membuat `integrasi_service.dart` untuk menangani request ke API `/users` dan `/posts`, serta menggabungkan kedua data tersebut.

Sementara itu, `halaman_integrasi.dart` bertugas menampilkan data, mengatur kondisi loading, error, data kosong, dan data berhasil dimuat.

Dengan pemisahan tersebut, kode menjadi lebih terstruktur dan mudah dikembangkan.

## 5. Jelaskan fungsi loading, data, kosong, dan error pada halaman aplikasi. Apa perbedaan data kosong dan error?

Keempat kondisi tersebut digunakan untuk memberikan informasi kepada pengguna mengenai proses pengambilan data.

- **Loading:** ditampilkan ketika aplikasi sedang mengambil data dari API. Pada proyek Tugas 10, kondisi ini ditampilkan menggunakan `CircularProgressIndicator`.
- **Data:** ditampilkan ketika data berhasil diperoleh dari API dan tersedia untuk ditampilkan dalam bentuk daftar.
- **Kosong:** ditampilkan ketika proses pengambilan data berhasil, tetapi tidak terdapat data yang dapat ditampilkan.
- **Error:** ditampilkan ketika proses pengambilan data mengalami kegagalan, misalnya karena koneksi internet bermasalah atau server tidak dapat diakses.

Perbedaan data kosong dan error adalah data kosong menunjukkan bahwa proses berhasil tetapi tidak menghasilkan data, sedangkan error menunjukkan bahwa proses pengambilan data tidak berhasil.

Pada proyek Tugas 10, saya menyediakan tombol **Coba Lagi** agar pengguna dapat mengulangi proses pengambilan data ketika terjadi error.

---

**Kesimpulan**

Dari Quiz Pertemuan 10 ini, saya memahami bahwa integrasi data membutuhkan identifier untuk menghubungkan data, penggunaan `Future.wait` untuk menjalankan request secara bersamaan, model untuk mengolah JSON, service layer untuk memisahkan proses API dari tampilan, serta pengelolaan kondisi loading, data, kosong, dan error agar aplikasi lebih mudah digunakan.