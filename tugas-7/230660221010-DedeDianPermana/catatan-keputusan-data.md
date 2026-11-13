\# Catatan Keputusan Data – SiRuang Kampus



\## 1. Keputusan Model Data



Model data yang digunakan adalah `Peminjaman`. Model ini memiliki tujuh atribut, yaitu `id`, `namaRuangan`, `kategori`, `tanggal`, `waktu`, `tujuan`, dan `status`. Atribut tersebut dipilih untuk mendukung proses pengajuan peminjaman ruang kelas serta menampilkan informasi status peminjaman sesuai kebutuhan F-01, F-03, dan F-04 pada Tugas 4.



\## 2. Keputusan Penggunaan ID



Setiap data peminjaman memiliki atribut `id` yang bersifat unik. ID dibuat menggunakan `DateTime.now().microsecondsSinceEpoch` sehingga setiap data mempunyai identitas berbeda. ID digunakan sebagai acuan untuk memperbarui dan menghapus data agar tidak bergantung pada posisi atau nomor indeks dalam daftar.



\## 3. Keputusan Implementasi CRUD



Operasi Create digunakan untuk menambahkan data peminjaman melalui formulir. Operasi Read ditampilkan menggunakan `ListView.builder` agar daftar peminjaman dapat ditampilkan secara dinamis. Operasi Update dilakukan dengan mencari data berdasarkan ID menggunakan `indexWhere`, kemudian mengganti objek lama dengan objek baru. Operasi Delete dilakukan menggunakan `removeWhere` berdasarkan ID dan dilengkapi dialog konfirmasi sebelum penghapusan.



\## 4. Keputusan Penyimpanan Data



Pada MVP awal ini, data disimpan sementara di dalam variabel `List<Peminjaman>` pada State dari `StatefulWidget`. Setiap perubahan data menggunakan `setState` agar tampilan diperbarui secara langsung. Penyimpanan permanen menggunakan database lokal belum diterapkan karena fokus tugas ini adalah membuktikan alur CRUD dasar sesuai kebutuhan sistem SiRuang Kampus. Data akan kembali ke kondisi awal ketika aplikasi dijalankan ulang.



\## 5. Keterkaitan dengan Kebutuhan Tugas 4



Implementasi data peminjaman mendukung kebutuhan F-01 untuk informasi ruangan, F-03 untuk pengajuan peminjaman, dan F-04 untuk menampilkan status peminjaman. Data status menggunakan nilai Menunggu, Disetujui, dan Ditolak agar sesuai dengan alur permohonan peminjaman yang telah dirancang pada Tugas 4.

