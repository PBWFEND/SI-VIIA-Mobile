# Catatan Keputusan Data

| Keputusan | Pilihan Anda | Alasan (merujuk kebutuhan) |
| :--- | :--- | :--- |
| **Field model** | `id`, `namaPeminjam`, `nim`, `judulBuku`, `status` | Mencakup identitas minimum yang dibutuhkan pustakawan untuk memverifikasi anggota yang mengambil buku reservasi (F-03, F-05). |
| **Kunci data (`id`)** | String unik via `DateTime.now().millisecondsSinceEpoch` | Mudah dihasilkan oleh sistem lokal tanpa membutuhkan *package* eksternal dan menjamin agar aksi Hapus/Edit tidak salah sasaran. |
| **Operasi CRUD** | *Dialog Form* untuk *Create/Update*, tombol *ListTile* untuk *Delete* | Menjaga pengguna tetap berada di satu layar untuk memanipulasi *state* lokal secara instan tanpa perlu repot mengelola navigasi berulang. |
| **Persistensi** | *In-Memory* (tidak disimpan permanen) | Cukup untuk membuktikan MVP *state management* lokal (Tugas 7); penyimpanan permanen (SQLite/API) di luar cakupan tugas ini. |