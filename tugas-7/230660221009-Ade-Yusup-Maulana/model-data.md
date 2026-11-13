# Model Data

## Entity: Produk

Entity yang digunakan dalam aplikasi adalah **Produk** untuk menyimpan data produk pada sistem informasi penjualan warung.

| Field | Tipe Data | Keterangan | Sumber Nilai |
|---|---|---|---|
| `id` | String | ID unik untuk setiap produk | Dibuat oleh sistem |
| `nama` | String | Nama produk yang dijual | Diisi melalui form |
| `harga` | int | Harga produk dalam Rupiah | Diisi melalui form |
| `stok` | int | Jumlah stok produk | Diisi melalui form |
| `status` | String | Status ketersediaan produk | Ditentukan oleh sistem berdasarkan stok |

## Aturan Status

Status produk ditentukan berdasarkan jumlah stok:

- Jika stok lebih dari 0, maka status **Tersedia**.
- Jika stok sama dengan 0, maka status **Habis**.

## Kebutuhan CRUD

| Operasi | Penerapan |
|---|---|
| Create | Menambahkan produk baru melalui form |
| Read | Menampilkan seluruh produk dalam daftar |
| Update | Mengubah data produk yang sudah ada |
| Delete | Menghapus produk melalui menu dan konfirmasi |

## ID Produk

Setiap produk memiliki `id` yang dibuat oleh sistem menggunakan nilai waktu sehingga setiap data memiliki identitas yang berbeda. ID digunakan sebagai pembeda data dan sebagai acuan ketika melakukan proses update maupun delete.