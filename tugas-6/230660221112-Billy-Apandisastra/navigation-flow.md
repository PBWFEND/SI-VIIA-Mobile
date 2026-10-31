# Navigation Flow: SI Perpustakaan Mobile

## 1. Daftar Route

| Nama Route | Layar (UI) | Kebutuhan (ID) | `initialRoute` |
| :--- | :--- | :--- | :--- |
| `/` | Halaman Katalog Buku | F-01 | Ya |
| `/detail` | Halaman Detail Buku | F-02 | Tidak |
| `/reservasi` | Halaman Form Reservasi | F-03 | Tidak |

## 2. Diagram Alur Navigasi
flowchart TD
A([Mulai: /]) -->|Klik buku & kirim data Map| B[/detail]
B -->|Klik tombol Reservasi| C[/reservasi]
C -->|Isi form & validasi gagal| C
C -->|Submit valid| D[Tampilkan SnackBar Sukses]
D -->|Navigator.pop| B
B -->|Navigator.pop| A

## 3. Alasan `initialRoute`
Route `/` (Halaman Katalog Buku) ditetapkan sebagai `initialRoute` karena fungsi utamanya memenuhi kebutuhan *Must have* tertinggi (F-01), yaitu mencari ketersediaan buku. Pengguna harus melihat daftar katalog terlebih dahulu sebelum bisa melakukan aksi lanjutan seperti melihat detail atau mengisi form reservasi.