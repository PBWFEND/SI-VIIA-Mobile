# CATATAN KEPUTUSAN DATA SI-FASKAM

## 1. Tujuan
Catatan keputusan data ini dibuat untuk menjelaskan struktur data yang digunakan dalam aplikasi SI-FASKAM (Sistem Informasi Fasilitas Kampus). Data ini digunakan untuk menyimpan dan mengelola informasi pengaduan fasilitas kampus yang disampaikan oleh mahasiswa.

## 2. Keputusan Struktur Data

Aplikasi SI-FASKAM menggunakan satu entitas utama, yaitu **Pengaduan Fasilitas Kampus**, dengan atribut sebagai berikut:

| No. | Nama Field | Tipe Data | Keterangan |
|---|---|---|---|
| 1 | id | String | Identitas unik setiap pengaduan |
| 2 | kategori | String | Jenis fasilitas yang diadukan |
| 3 | lokasi | String | Lokasi fasilitas yang mengalami masalah |
| 4 | deskripsi | String | Penjelasan mengenai masalah fasilitas |
| 5 | status | String | Kondisi atau perkembangan pengaduan |

## 3. Alasan Pemilihan Field

Keputusan penggunaan lima field tersebut didasarkan pada kebutuhan utama aplikasi SI-FASKAM.

- **id** digunakan sebagai identitas agar setiap pengaduan dapat dibedakan satu sama lain.
- **kategori** digunakan untuk mengetahui jenis fasilitas yang mengalami masalah, seperti ruang kelas, toilet, laboratorium, atau fasilitas lainnya.
- **lokasi** digunakan untuk mengetahui tempat terjadinya masalah agar lebih mudah ditindaklanjuti.
- **deskripsi** digunakan untuk memberikan informasi lebih jelas mengenai kerusakan atau kendala yang dialami.
- **status** digunakan untuk mengetahui perkembangan penanganan pengaduan, seperti Menunggu, Diproses, dan Selesai.

## 4. Keputusan Pengelolaan Data

Data pengaduan dikelola menggunakan struktur `List<Pengaduan>` pada aplikasi Flutter. Struktur ini dipilih karena sesuai dengan kebutuhan tugas CRUD lokal dan mudah diterapkan dalam aplikasi sederhana.

Pengelolaan data dilakukan melalui beberapa proses:

1. **Create (Tambah):** Mahasiswa mengisi formulir pengaduan, kemudian data baru ditambahkan ke dalam List.
2. **Read (Tampil):** Data pengaduan ditampilkan pada halaman utama dan halaman detail.
3. **Update (Ubah):** Data pengaduan dapat diperbarui, termasuk mengubah informasi atau status pengaduan.
4. **Delete (Hapus):** Data pengaduan dapat dihapus apabila diperlukan.

Setiap perubahan data menggunakan `setState()` agar tampilan aplikasi diperbarui sesuai dengan kondisi data terbaru.

## 5. Keputusan Penyimpanan Data

Pada tahap pengembangan ini, aplikasi menggunakan penyimpanan lokal sementara melalui List di dalam aplikasi. Data belum disimpan ke database atau penyimpanan permanen.

Dengan demikian, data yang ditambahkan hanya tersedia selama aplikasi berjalan dan dapat hilang ketika aplikasi dimulai ulang. Penggunaan database dapat dipertimbangkan untuk pengembangan selanjutnya agar data pengaduan dapat tersimpan secara permanen.

## 6. Kesimpulan

Berdasarkan kebutuhan aplikasi SI-FASKAM, struktur data Pengaduan Fasilitas Kampus dengan lima field, yaitu `id`, `kategori`, `lokasi`, `deskripsi`, dan `status`, dinilai sudah sesuai. Struktur tersebut dapat mendukung proses CRUD lokal, mulai dari menambahkan, menampilkan, mengubah, hingga menghapus data pengaduan.

Keputusan ini dibuat agar pengelolaan data dalam aplikasi menjadi sederhana, terstruktur, dan sesuai dengan kebutuhan tugas Pemrograman Aplikasi Bergerak.