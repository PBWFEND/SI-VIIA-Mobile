:::writing{variant="document" id="73102"}
# Model Data – Aplikasi Penjualan Warung

## 1. Deskripsi

Model data digunakan untuk merepresentasikan informasi barang yang dikelola dalam aplikasi Penjualan Warung.

Pada implementasi Tugas 7, aplikasi menggunakan satu entitas utama, yaitu `Barang`. Pengelolaan data dilakukan menggunakan struktur data `List` sebagai penyimpanan sementara selama aplikasi berjalan.

## 2. Entitas Barang

Entitas `Barang` digunakan untuk menyimpan informasi barang yang tersedia di warung.

| Field | Tipe Data | Sumber Data | Keterangan |
|---|---|---|---|
| id | String | Sistem | Identitas unik setiap barang |
| nama | String | Form | Nama barang |
| kategori | String | Form | Kategori barang |
| harga | int | Form | Harga satuan barang |
| stok | int | Form | Jumlah stok barang |
| batasStokMinimum | int | Sistem | Batas minimum untuk menentukan kondisi stok menipis |

## 3. Aturan Pengelolaan Data

1. Setiap barang memiliki ID unik.
2. Nama barang wajib diisi.
3. Kategori barang wajib diisi.
4. Harga harus berupa bilangan bulat lebih dari nol.
5. Stok harus berupa bilangan bulat nol atau lebih.
6. Status stok ditentukan berdasarkan jumlah stok dan batas stok minimum.
7. Barang dengan stok nol memiliki status Habis.
8. Barang dengan stok lebih dari nol dan kurang dari atau sama dengan batas minimum memiliki status Stok Menipis.
9. Barang dengan stok di atas batas minimum memiliki status Tersedia.
10. Perubahan data dikelola menggunakan `setState()`.

## 4. Operasi CRUD

| Operasi | Implementasi | Keterangan |
|---|---|---|
| Create | `daftarBarang.add()` | Menambahkan barang baru |
| Read | `ListView.builder` | Menampilkan daftar barang |
| Update | `daftarBarang[index] = hasil` | Memperbarui data barang |
| Delete | `removeWhere()` | Menghapus barang berdasarkan ID |

## 5. Penyimpanan Data

Data barang disimpan sementara menggunakan struktur data `List` di dalam aplikasi. Implementasi ini belum menggunakan database maupun penyimpanan permanen.

Data yang berubah selama aplikasi berjalan akan kembali ke data awal ketika aplikasi dimulai ulang.

## 6. Batasan Implementasi

Implementasi Tugas 7 berfokus pada pengelolaan data barang melalui fitur CRUD lokal. Entitas transaksi penjualan belum diterapkan dalam kode aplikasi. Pengembangan fitur transaksi dan penyimpanan permanen dapat dipertimbangkan pada tahap pengembangan berikutnya.
:::