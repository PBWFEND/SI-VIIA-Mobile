# Model Data: SI Perpustakaan Mobile

## 1. Daftar Entitas (Reservasi)

| Entitas | Field | Tipe Data | Kebutuhan (ID) |
| :--- | :--- | :--- | :--- |
| Reservasi | `id` | String | F-03, F-04, F-05 |
| Reservasi | `namaPeminjam` | String | F-03 |
| Reservasi | `nim` | String | F-03 |
| Reservasi | `judulBuku` | String | F-03, F-04 |
| Reservasi | `status` | String | F-04, F-05, F-06 |

## 2. Sumber Nilai
*   **`id`**: Dihasilkan oleh sistem menggunakan *timestamp* (waktu saat ini dalam milidetik) agar unik.
*   **`namaPeminjam`**: Berasal dari input pengguna melalui *form* teks.
*   **`nim`**: Berasal dari input pengguna melalui *form* teks.
*   **`judulBuku`**: Berasal dari input pengguna (bisa juga dari data yang dilempar oleh sistem).
*   **`status`**: Ditetapkan oleh sistem secara otomatis menjadi "Menunggu" saat dibuat, lalu bisa diubah melalui aksi *Update*.