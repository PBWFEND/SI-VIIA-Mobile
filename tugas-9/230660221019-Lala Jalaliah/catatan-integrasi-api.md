# Catatan Integrasi REST API
## Aplikasi Pengelolaan Surat Masuk UKM

### 1. Tujuan Integrasi API

Integrasi REST API dilakukan untuk menghubungkan aplikasi Pengelolaan Surat Masuk UKM dengan layanan server. Pada tugas ini, aplikasi menggunakan metode GET untuk mengambil data surat dan POST untuk mengirim data surat baru.

API yang digunakan adalah JSONPlaceholder sebagai layanan simulasi REST API.

### 2. Informasi API

| Keterangan | Detail |
|---|---|
| Nama API | JSONPlaceholder |
| Base URL | https://jsonplaceholder.typicode.com |
| Endpoint GET | `/posts` |
| Method GET | GET |
| Endpoint POST | `/posts` |
| Method POST | POST |
| Format data | JSON |
| Package | http |

### 3. Model Data

Aplikasi menggunakan model `SuratMasuk` untuk menampung data surat yang diterima dari server.

| Field pada Model | Sumber JSON | Tipe Data | Keterangan |
|---|---|---|---|
| id | id | int | Identitas surat |
| judul | title | String | Judul surat |
| pengirim | body | String | Informasi pengirim |
| status | status | String | Status pemeriksaan surat |

Model `SuratMasuk` memiliki fungsi `fromJson()` untuk mengubah data JSON menjadi objek Dart.

Selain itu, terdapat model `SuratMasukBaru` yang digunakan untuk menyiapkan data sebelum dikirim ke server melalui metode POST. Data yang dikirim terdiri dari judul, pengirim, dan userId.

### 4. Proses GET (Mengambil Data)

Metode GET digunakan untuk mengambil daftar surat dari endpoint:

`https://jsonplaceholder.typicode.com/posts`

Tahapan proses GET:
1. Aplikasi mengirim permintaan GET ke server.
2. Server memberikan respons berupa data JSON.
3. Data JSON diubah menjadi objek menggunakan fungsi `fromJson()`.
4. Data surat ditampilkan dalam daftar pada halaman aplikasi.

Pada implementasi ini, aplikasi mengambil maksimal 10 data pertama dari server.

### 5. Proses POST (Mengirim Data)

Metode POST digunakan untuk mengirim data surat baru ke endpoint:

`https://jsonplaceholder.typicode.com/posts`

Data yang dikirim meliputi:
- Judul surat.
- Nama atau informasi pengirim.
- User ID.

Pengiriman data menggunakan format JSON dengan header `Content-Type: application/json; charset=UTF-8`.

Jika server memberikan status HTTP 201, aplikasi menampilkan notifikasi bahwa surat berhasil dikirim dan menambahkan data tersebut ke daftar surat pada tampilan aplikasi.

**Catatan:** JSONPlaceholder merupakan layanan simulasi. Respons POST yang berhasil tidak berarti data tersimpan secara permanen di server.

### 6. Penanganan Loading dan Error

Aplikasi menyediakan beberapa kondisi untuk memberikan informasi kepada pengguna.

| Kondisi | Tampilan Aplikasi |
|---|---|
| Loading | Menampilkan indikator CircularProgressIndicator |
| Berhasil | Menampilkan daftar surat dari server |
| Error | Menampilkan pesan gagal memuat data dan tombol Coba Lagi |
| Pengiriman | Tombol berubah menjadi Mengirim dan menampilkan indikator proses |
| POST berhasil | Menampilkan notifikasi Surat berhasil dikirim |

Pada proses GET dan POST, aplikasi menggunakan `try-catch` untuk menangani kesalahan serta `timeout` selama 10 detik untuk membatasi waktu tunggu permintaan.

### 7. Pengujian Aplikasi

Pengujian dilakukan melalui browser Google Chrome dengan hasil sebagai berikut:

| No. | Pengujian | Hasil |
|---|---|---|
| 1 | Membuka aplikasi dan mengambil data menggunakan GET | Berhasil |
| 2 | Menampilkan indikator loading | Berhasil |
| 3 | Mengirim data surat menggunakan POST | Berhasil |
| 4 | Menampilkan surat baru pada daftar | Berhasil |
| 5 | Menguji kondisi ketika koneksi internet terputus | Berhasil |
| 6 | Menampilkan tombol Coba Lagi ketika terjadi error | Berhasil |

### 8. Kesimpulan

Integrasi REST API pada aplikasi Pengelolaan Surat Masuk UKM berhasil diterapkan menggunakan metode GET dan POST. Aplikasi dapat mengambil data dari server, mengirim data surat baru, serta menampilkan kondisi loading, berhasil, dan error. Melalui tugas ini, saya memahami dasar komunikasi antara aplikasi Flutter dengan layanan REST API menggunakan format JSON.