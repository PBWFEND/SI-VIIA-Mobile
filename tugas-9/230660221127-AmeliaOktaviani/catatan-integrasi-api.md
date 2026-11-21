# Catatan Integrasi API â€” Tugas 9

## 1. Endpoint yang Digunakan

| Operasi | Metode HTTP | URL Endpoint | Payload Request |
|---|---|---|---|
| Mengambil daftar produk | GET | `https://dummyjson.com/products?limit=10` | Tidak ada |
| Mengirim produk baru | POST | `https://dummyjson.com/products/add` | JSON berisi nama, harga, stok, dan kategori |

### Contoh Payload POST

```json
{
  "title": "Beras 5 Kg",
  "price": 75000,
  "stock": 10,
  "category": "Kebutuhan Warung"
}
```

Header yang digunakan:

`Content-Type: application/json`

## 2. Struktur Model Data

| Field | Tipe Dart | Key JSON | Sumber Nilai |
|---|---|---|---|
| id | int | `id` | Server |
| nama | String | `title` | Server / input pengguna |
| harga | double | `price` | Server / input pengguna |
| stok | int | `stock` | Server / input pengguna |
| kategori | String | `category` | Server / input pengguna |

Model data menggunakan class `ProdukApi`. Factory `fromJson` digunakan untuk mengubah data JSON menjadi objek Dart, sedangkan `toJson` digunakan untuk mengubah objek Dart menjadi format JSON saat mengirim data.

## 3. Penanganan Error

Penanganan error dilakukan menggunakan `try-catch` pada setiap pemanggilan HTTP. Aplikasi memeriksa status code respons untuk memastikan permintaan berhasil. Apabila terjadi timeout, aplikasi menampilkan pesan timeout. Jika terjadi kegagalan lainnya, aplikasi menampilkan pesan error yang sesuai.

Pada halaman antarmuka, kondisi loading ditampilkan menggunakan `CircularProgressIndicator`. Jika data berhasil diperoleh, data ditampilkan menggunakan `ListView.builder`. Jika terjadi kegagalan pengambilan data, aplikasi menampilkan pesan error dan tombol Coba Lagi untuk mengulangi permintaan GET.

Pada proses POST, tombol Kirim Produk dinonaktifkan selama proses pengiriman berlangsung untuk mencegah pengiriman berulang. Apabila pengiriman berhasil, aplikasi menampilkan notifikasi keberhasilan dan data produk ditambahkan ke daftar tampilan.

## 4. Catatan API

DummyJSON digunakan sebagai API simulasi untuk keperluan pengujian GET dan POST. Data yang dikirim melalui endpoint POST merupakan respons simulasi dan tidak disimpan secara permanen pada server.
