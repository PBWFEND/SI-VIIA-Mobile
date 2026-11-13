# Model Data — SI RAKUS

## Identitas

| Keterangan | Data |
|---|---|
| Nama | Wendi Feriyanda |
| NIM | 230660221026 |
| Program Studi | Sistem Informasi |
| Mata Kuliah | Pemrograman Aplikasi Bergerak (PAB) |
| Nama aplikasi | SI RAKUS (Sistem Rak Kampus) |
| Domain | Perpustakaan kampus |

## 1. Tujuan Model Data

Model data SI RAKUS pada Tugas 7 digunakan untuk menggambarkan satu data buku yang ditampilkan pada katalog dan halaman detail. Field dipilih dengan mengacu pada kebutuhan F-01 (melihat katalog), F-02 (mencari buku), F-03 (melihat detail buku), F-04 (melihat stok atau ketersediaan), dan F-08 (menyaring buku berdasarkan kategori) pada Tugas 4. Data pada prototype ini merupakan data contoh yang dikelola secara lokal di dalam aplikasi, bukan salinan atau perubahan terhadap katalog resmi perpustakaan.

## 2. Entitas Data

### Entitas: DataBuku

| No. | Field | Tipe data | Kebutuhan terkait | Kegunaan |
|---:|---|---|---|---|
| 1 | `id` | `String` | Kunci untuk operasi CRUD; mendukung pengelolaan data F-01 sampai F-04 dan F-08 | Identitas unik setiap data buku agar operasi ubah dan hapus tidak bergantung pada posisi/index daftar. |
| 2 | `judul` | `String` | F-01, F-02, F-03 | Menampilkan nama buku, menjadi salah satu dasar pencarian, dan ditampilkan pada detail buku. |
| 3 | `penulis` | `String` | F-01, F-02, F-03 | Menampilkan penulis, menjadi informasi yang dapat dicari, dan ditampilkan pada detail buku. |
| 4 | `penerbit` | `String` | F-03 | Menampilkan penerbit pada informasi detail buku. |
| 5 | `tahunTerbit` | `int` | F-03 | Menampilkan tahun terbit sebagai bagian dari informasi detail buku. |
| 6 | `kategori` | `String` | F-03, F-08 | Menampilkan kategori buku dan menjadi dasar penyaringan katalog berdasarkan kategori. |
| 7 | `ringkasan` | `String` | F-03 | Menampilkan ringkasan atau deskripsi singkat pada halaman detail buku. |
| 8 | `stok` | `int` | F-04 | Menyimpan jumlah eksemplar yang tersedia pada data contoh dan menjadi dasar penentuan status ketersediaan. |

### Status ketersediaan

Status tidak disimpan sebagai field terpisah karena nilainya dapat diturunkan dari field `stok`. Aturannya adalah:

- Jika `stok > 0`, status ditampilkan sebagai **Tersedia**.
- Jika `stok == 0`, status ditampilkan sebagai **Stok habis**.

Dengan aturan tersebut, status tidak perlu diubah secara manual ketika jumlah stok berubah. Tampilan status dihitung dari nilai stok terbaru.

## 3. Sumber Nilai Setiap Field

| Field | Sumber nilai | Penjelasan |
|---|---|---|
| `id` | Sistem | Dibuat otomatis ketika data buku baru ditambahkan, misalnya menggunakan waktu saat ini dalam milidetik yang diubah menjadi `String`. Nilainya harus unik untuk setiap data. |
| `judul` | Data contoh awal atau form | Dua data awal mengikuti contoh pada wireframe Tugas 5. Data baru diisi melalui form tambah buku untuk latihan CRUD. |
| `penulis` | Data contoh awal atau form | Diisi dari data contoh atau input pengguna pada form. |
| `penerbit` | Data contoh awal atau form | Diisi dari data contoh atau input pengguna pada form. |
| `tahunTerbit` | Data contoh awal atau form | Diisi sebagai bilangan bulat; input teks dari form perlu dikonversi dan divalidasi menjadi `int`. |
| `kategori` | Data contoh awal atau form | Diisi dari data contoh atau pilihan/input kategori pada form. Field ini juga dapat digunakan untuk latihan filter F-08. |
| `ringkasan` | Data contoh awal atau form | Diisi sebagai teks singkat yang menjelaskan isi buku. |
| `stok` | Data contoh awal atau form | Diisi sebagai bilangan bulat dan tidak boleh bernilai negatif. Status ketersediaan dihitung dari nilai ini. |

## 4. Hubungan Model dengan Kebutuhan Tugas 4

| ID kebutuhan | Kebutuhan Tugas 4 | Field yang digunakan | Cara model mendukung kebutuhan |
|---|---|---|---|
| F-01 | Mahasiswa dapat melihat daftar buku yang tercatat dalam katalog perpustakaan. | `id`, `judul`, `penulis`, `stok` | Daftar buku dibaca dari `List<DataBuku>` dan ditampilkan pada katalog. |
| F-02 | Mahasiswa dapat mencari buku berdasarkan judul atau kata kunci. | `judul`, `penulis` | Pencarian mencocokkan kata kunci dengan judul dan penulis. |
| F-03 | Mahasiswa dapat melihat detail dari buku yang dipilih. | `judul`, `penulis`, `penerbit`, `tahunTerbit`, `kategori`, `ringkasan` | Objek buku yang dipilih diteruskan ke layar detail untuk menampilkan informasinya. |
| F-04 | Mahasiswa dapat melihat jumlah stok atau status ketersediaan buku. | `stok` | Jumlah stok ditampilkan dan status dihitung berdasarkan apakah stok lebih dari nol atau sama dengan nol. |
| F-08 | Mahasiswa dapat menyaring daftar buku berdasarkan kategori. | `kategori` | Daftar dapat disaring dengan membandingkan kategori buku terhadap kategori yang dipilih. |

F-05 dan F-06 berkaitan dengan informasi peminjaman milik mahasiswa, bukan atribut dari entitas buku. Keduanya tidak dimasukkan ke dalam `DataBuku` agar data buku dan data transaksi/peminjaman tidak tercampur. Jika fitur peminjaman dikembangkan lebih lanjut, entitas peminjaman perlu dirancang secara terpisah dan disesuaikan dengan sumber data serta integrasi sistem perpustakaan.

F-07 adalah kebutuhan pengelolaan koleksi oleh petugas dan ditetapkan sebagai *Won't have* untuk antarmuka mobile mahasiswa pada Tugas 4. Karena itu, operasi tambah, ubah, dan hapus dalam latihan CRUD Tugas 7 hanya digunakan untuk mengelola dataset contoh secara lokal selama demonstrasi pembelajaran. Operasi tersebut bukan klaim bahwa mahasiswa dapat menambah, mengubah, atau menghapus katalog resmi perpustakaan.

## 5. Rencana Penggunaan Model pada CRUD Lokal

| Operasi | Rencana penerapan pada prototype | Batasan makna |
|---|---|---|
| Create | Menambahkan objek `DataBuku` baru dari form ke `List<DataBuku>`. | Penambahan hanya terjadi pada dataset lokal contoh. |
| Read | Membaca daftar buku dari state dan menampilkannya menggunakan `ListView.builder`; detail membaca objek buku yang dipilih. | Data yang tampil belum diambil dari Libsys atau server perpustakaan. |
| Update | Mengganti objek buku berdasarkan `id`, misalnya memperbarui nilai stok. | Perubahan hanya berlaku pada data lokal prototype. |
| Delete | Menghapus objek buku berdasarkan `id` setelah pengguna menyetujui `AlertDialog`. | Penghapusan tidak memengaruhi katalog resmi perpustakaan. |

Setiap perubahan daftar dilakukan melalui `setState` agar tampilan dibangun ulang sesuai data terbaru. `id` digunakan sebagai kunci pencarian data saat update dan delete, bukan nomor urut/index kartu pada layar.

## 6. Keputusan Penyimpanan Data

Pada implementasi awal, data direncanakan disimpan dalam `List<DataBuku>` di dalam `State` sebuah `StatefulWidget` (in-memory). Pendekatan ini digunakan agar operasi CRUD dapat dipelajari dan diuji tanpa package tambahan, sesuai batas minimum Tugas 7. Konsekuensinya, data akan kembali ke data awal ketika aplikasi ditutup atau dijalankan ulang.

Persistensi menggunakan `shared_preferences` bersifat opsional menurut panduan tugas. Persistensi dapat ditambahkan setelah CRUD in-memory berjalan benar. Jika persistensi tidak diterapkan, keterbatasan bahwa data tidak bertahan setelah aplikasi ditutup perlu ditulis secara jelas pada catatan keputusan.

## 7. Batasan Model dan Asumsi

1. Data buku yang digunakan merupakan data contoh untuk menguji fungsi aplikasi, bukan hasil sinkronisasi dengan katalog resmi perpustakaan.
2. Model `DataBuku` hanya mewakili informasi buku. Data peminjaman aktif dan riwayat peminjaman tidak disimpan dalam model ini.
3. `stok` harus berupa bilangan bulat dan tidak boleh negatif.
4. `tahunTerbit` harus berupa bilangan bulat yang masuk akal untuk data contoh.
5. `id` dibuat otomatis oleh sistem dan dipertahankan saat objek buku diperbarui.
6. Status ketersediaan dihitung dari `stok`, bukan diisi secara terpisah.
7. Operasi Create, Update, dan Delete pada Tugas 7 adalah simulasi CRUD lokal untuk pembelajaran, bukan fitur pengelolaan koleksi resmi yang ditujukan kepada mahasiswa.

## 8. Pemeriksaan Mandiri

- [ ] Setiap field pada `DataBuku` memiliki kebutuhan terkait.
- [ ] Setiap field memiliki sumber nilai yang dijelaskan.
- [ ] `id` digunakan sebagai identitas unik untuk update dan delete.
- [ ] Status ketersediaan dihitung dari `stok`.
- [ ] Field buku tidak dicampur dengan data peminjaman mahasiswa.
- [ ] Ruang lingkup CRUD lokal dijelaskan sebagai simulasi dataset, bukan perubahan katalog resmi.
- [ ] Nama field pada dokumen ini sama dengan nama field pada class model di `crud-lokal.dart`.

## Referensi Dokumen Internal

- Dokumen Kebutuhan SI RAKUS — Tugas 4, khususnya bagian Kebutuhan Fungsional, Prioritas MoSCoW, dan Pemetaan Kebutuhan ke Antarmuka.
- Information Architecture SI RAKUS — Tugas 5.
- Panduan Pengerjaan Tugas 7 dan materi Pertemuan 7 — Pengelolaan Data Lokal.
