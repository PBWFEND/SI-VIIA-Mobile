
# Catatan Integrasi REST API
## Tugas 9 - Pertemuan 9

### 1. Identitas Mahasiswa

| Keterangan | Data |
|---|---|
| Nama | Ade Yusup Maulana |
| NIM | 230660221009 |
| Program Studi | Sistem Informasi |
| Fakultas | Fakultas Teknologi Informasi |
| Universitas | Universitas Sebelas April |
| Kelas | SI-VIIA |
| Mata Kuliah | Pemrograman Aplikasi Bergerak |

### 2. Deskripsi Integrasi API

Pada tugas ini, aplikasi Flutter PAB - Penjualan Warung diintegrasikan dengan REST API menggunakan package `http`.

API yang digunakan adalah JSONPlaceholder sebagai layanan API untuk mengambil dan mengirim data barang secara simulasi.

Integrasi API menggunakan dua metode HTTP, yaitu GET dan POST. Data yang diterima dari server diubah menjadi objek Dart menggunakan proses parsing JSON.

### 3. Endpoint API

Base URL:

```text
https://jsonplaceholder.typicode.com/posts
```

Endpoint yang digunakan:

| Metode | Endpoint | Fungsi |
|---|---|---|
| GET | /posts | Mengambil daftar data |
| POST | /posts | Mengirim data baru |

### 4. Implementasi HTTP GET

HTTP GET digunakan untuk mengambil daftar data dari server.

URL:

```text
https://jsonplaceholder.typicode.com/posts
```

Proses implementasi:
1. Aplikasi mengirim permintaan GET menggunakan package `http`.
2. Server memberikan respons dalam format JSON.
3. Aplikasi memeriksa status code HTTP.
4. Jika status code 200, respons JSON diproses.
5. Data JSON diubah menjadi objek `BarangApi`.
6. Data ditampilkan pada halaman aplikasi Flutter.

Contoh respons JSON:

```json
{
  "userId": 1,
  "id": 1,
  "title": "sunt aut facere repellat",
  "body": "quia et suscipit suscipit recusandae"
}
```

### 5. Implementasi HTTP POST

HTTP POST digunakan untuk mengirim data baru ke server.

URL:

```text
https://jsonplaceholder.typicode.com/posts
```

Header:

```text
Content-Type: application/json; charset=UTF-8
```

Contoh request body:

```json
{
  "userId": 1,
  "title": "Buku Tulis",
  "body": "Buku tulis untuk kebutuhan sekolah"
}
```

Proses implementasi:
1. Pengguna menekan tombol Tambah Data.
2. Pengguna mengisi nama dan deskripsi barang.
3. Aplikasi memeriksa kelengkapan data.
4. Data dikirim menggunakan metode POST.
5. Server memberikan respons.
6. Jika status code 201, data dianggap berhasil dikirim.
7. Data respons ditampilkan pada daftar aplikasi.

Contoh respons JSON:

```json
{
  "userId": 1,
  "title": "Buku Tulis",
  "body": "Buku tulis untuk kebutuhan sekolah",
  "id": 101
}
```

Catatan: JSONPlaceholder merupakan API simulasi. Permintaan POST memberikan respons berhasil, tetapi data tidak disimpan secara permanen pada server.

### 6. Model Data dan Parsing JSON

Model data yang digunakan adalah `BarangApi`.

Atribut model:

| Atribut Dart | Field JSON | Tipe Data |
|---|---|---|
| id | id | int |
| userId | userId | int |
| nama | title | String |
| deskripsi | body | String |

Fungsi `fromJson()` digunakan untuk mengubah data JSON menjadi objek `BarangApi`.

Fungsi `toJson()` digunakan untuk mengubah objek `BarangApi` menjadi format JSON.

### 7. Penanganan Loading dan Error

Aplikasi menerapkan beberapa mekanisme penanganan proses API.

| Kondisi | Penanganan |
|---|---|
| Sedang mengambil data | Menampilkan CircularProgressIndicator |
| Data berhasil diterima | Menampilkan daftar data |
| Pengambilan data gagal | Menampilkan pesan error |
| Pengiriman data berhasil | Menampilkan notifikasi berhasil |
| Pengiriman data gagal | Menampilkan notifikasi gagal |
| Permintaan terlalu lama | Menggunakan timeout 15 detik |
| Kesalahan HTTP | Memeriksa status code respons |
| Terjadi kesalahan program atau koneksi | Menggunakan try-catch |
| Pengambilan data gagal | Menyediakan tombol Coba Lagi |

### 8. Package yang Digunakan

Package utama:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.6.0
```

Package `http` digunakan untuk melakukan komunikasi HTTP dengan server REST API.

Library `dart:convert` digunakan untuk proses encoding dan decoding JSON.

### 9. Kesimpulan

Berdasarkan implementasi yang dilakukan, aplikasi Flutter telah berhasil diintegrasikan dengan REST API menggunakan metode HTTP GET dan POST.

Aplikasi dapat mengambil daftar data dari server, mengirim data baru, melakukan parsing JSON, serta menampilkan kondisi loading, berhasil, dan error.

Melalui integrasi ini, mahasiswa memperoleh pemahaman mengenai komunikasi data antara aplikasi Flutter dengan server menggunakan REST API.
