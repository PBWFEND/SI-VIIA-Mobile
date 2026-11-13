# Catatan Keputusan Data

Berikut keputusan yang digunakan dalam perancangan data pada aplikasi Tugas 7.

| Keputusan | Penerapan | Alasan |
|---|---|---|
| Field model | Menggunakan `id`, `nama`, `harga`, `stok`, dan `status` | Field tersebut diperlukan untuk menyimpan informasi utama produk pada penjualan warung |
| Key/ID | Menggunakan `id` berupa String yang dibuat oleh sistem | Setiap produk membutuhkan ID yang berbeda agar dapat dibedakan saat update dan delete |
| Create | Data produk ditambahkan melalui form | Pengguna dapat memasukkan nama, harga, dan stok produk secara langsung |
| Read | Data ditampilkan menggunakan daftar produk | Pengguna dapat melihat seluruh data produk yang tersimpan |
| Update | Data dicari berdasarkan `id` kemudian diganti dengan objek baru | Cara ini memudahkan perubahan data produk tertentu tanpa mengubah produk lainnya |
| Delete | Data dihapus berdasarkan `id` setelah konfirmasi | Konfirmasi digunakan agar data tidak terhapus secara tidak sengaja |
| Persistence | Menggunakan `List` di dalam aplikasi dan belum menggunakan penyimpanan permanen | Fokus tugas adalah penerapan CRUD lokal, sedangkan persistence bersifat opsional |
| Status produk | Status ditentukan berdasarkan jumlah stok | Produk dengan stok lebih dari 0 berstatus Tersedia, sedangkan stok 0 berstatus Habis |