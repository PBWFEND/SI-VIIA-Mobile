# Catatan Keputusan Pengelolaan Data Lokal

| Field Model | Operasi CRUD | Kunci Data | Keputusan Persistensi | Alasan Rujukan Kebutuhan |
| :--- | :--- | :--- | :--- | :--- |
| `id`, `judul`, `penulis`, `kategori`, `status` | **Create:** Modal Form BottomSheet<br>**Read:** ListView.builder<br>**Update:** Form Edit (copyWith)<br>**Delete:** Dialog Konfirmasi Hapus | Unique `id` (`Timestamp.toString()`) | In-Memory State (`StatefulWidget` & `setState`) untuk rilis MVP awal | Memenuhi kebutuhan F-01 (Manajemen Buku) dan F-03 (Pencarian & Informasi Katalog) secara lokal dan responsif. |

---

## Penjelasan Rinci Keputusan

1. **Penggunaan Unique `id`:**  
   Menjamin setiap buku dalam `_katalogBuku` memiliki identitas unik saat operasi Update (`indexWhere`) dan Delete (`removeWhere`), sehingga tidak terjadi kesalahan manipulasi objek lain.
2. **Operasi CRUD In-Memory (`setState`):**  
   Setiap aksi penambahan, perubahan, dan penghapusan data dibungkus menggunakan `setState` agar UI Flutter secara otomatis melakukan *re-render* dan menampilkan perubahan data katalog secara real-time.
3. **Konfirmasi Penghapusan (Delete Safety):**  
   Penghapusan data dilengkapi dengan `AlertDialog` konfirmasi untuk mencegah hilangnya koleksi buku secara tidak sengaja oleh pengguna.