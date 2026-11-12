# Catatan Integrasi REST API
## SiRuang Kampus

### 1. Deskripsi Integrasi

Integrasi REST API pada aplikasi SiRuang Kampus bertujuan untuk menghubungkan aplikasi Flutter dengan layanan API agar aplikasi dapat mengambil dan mengirim data peminjaman ruangan. Metode HTTP yang digunakan adalah GET untuk mengambil data dan POST untuk mengirim data peminjaman.

API yang digunakan dalam praktikum ini adalah JSONPlaceholder sebagai layanan API simulasi.

### 2. Endpoint API

| Metode | Endpoint | Fungsi |
|---|---|---|
| GET | `https://jsonplaceholder.typicode.com/posts` | Mengambil data dari API untuk ditampilkan pada daftar peminjaman. |
| POST | `https://jsonplaceholder.typicode.com/posts` | Mengirim data peminjaman ke API. |

### 3. Model Data Peminjaman

Model `Peminjaman` digunakan untuk menampung data peminjaman ruangan.

| Field | Tipe Data | JSON Key | Sumber Data |
|---|---|---|---|
| id | int? | id | Respons API |
| namaRuangan | String | namaRuangan | Data formulir / hasil pemetaan |
| kategori | String | kategori | Data formulir / hasil pemetaan |
| tanggal | String | tanggal | Data formulir / hasil pemetaan |
| waktu | String | waktu | Data formulir / hasil pemetaan |
| tujuan | String | tujuan | Data formulir / hasil pemetaan |
| status | String | status | Data formulir / nilai default |

Model dilengkapi constructor, `factory Peminjaman.fromJson()`, dan method `toJson()` untuk mengubah data menjadi format JSON.

### 4. Proses Integrasi API

**a. GET (Mengambil Data)**

Aplikasi menggunakan metode GET untuk mengambil data dari endpoint JSONPlaceholder. Data JSON yang diterima kemudian dipetakan menjadi objek `Peminjaman` dan ditampilkan menggunakan `ListView.builder`.

**b. POST (Mengirim Data)**

Aplikasi menggunakan metode POST untuk mengirim data formulir peminjaman. Data diubah menjadi JSON menggunakan `jsonEncode()` dan dikirim dengan header `Content-Type: application/json; charset=UTF-8`.

Jika server memberikan status HTTP 201, aplikasi menampilkan notifikasi bahwa data berhasil dikirim dan menambahkan hasil respons ke daftar peminjaman.

**Catatan:** JSONPlaceholder merupakan API simulasi. Data POST memberikan respons berhasil, tetapi tidak disimpan secara permanen pada server. Data yang ditampilkan setelah POST ditambahkan ke daftar aplikasi selama sesi berjalan.

### 5. Strategi Penanganan Error

Penanganan kesalahan dilakukan agar aplikasi tetap memberikan informasi kepada pengguna ketika proses komunikasi dengan API mengalami kendala.

1. **Loading:** Menampilkan CircularProgressIndicator ketika aplikasi sedang mengambil data.
2. **HTTP Status Code:** Memeriksa kode respons server. GET mengharapkan status 200, sedangkan POST mengharapkan status 201.
3. **Try-Catch:** Menangkap kesalahan selama proses pengambilan dan pengiriman data.
4. **Timeout:** Membatasi waktu permintaan API maksimal 15 detik.
5. **Error Message:** Menampilkan pesan ketika pengambilan data gagal.
6. **Retry:** Menyediakan tombol Coba Lagi agar pengguna dapat mengulangi proses pengambilan data.
7. **Submit Button:** Menonaktifkan tombol kirim sementara proses pengiriman data berlangsung agar tidak terjadi pengiriman berulang.

### 6. Kesimpulan

Integrasi REST API pada aplikasi SiRuang Kampus telah menerapkan metode GET dan POST. Aplikasi juga memiliki tampilan loading, penanganan error, tombol retry, serta indikator proses pengiriman data. Melalui praktikum ini, saya memahami proses komunikasi antara aplikasi Flutter dengan REST API menggunakan format JSON.