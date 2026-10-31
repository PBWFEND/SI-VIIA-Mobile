# Model Data — Tugas 7

## Daftar Entitas Data Utama

| Entitas | Field | Tipe Data | Kebutuhan yang Dipenuhi (ID Tugas 4) |
|:---|:---|:---|:---|
| Buku / Item | `id` | `String` | Kunci unik operasi Update & Delete |
| Buku / Item | `judul` | `String` | F-01 (Input Form) |
| Buku / Item | `penulis` | `String` | F-01 (Input Form) |
| Buku / Item | `status` | `String` | F-03 (Status Ketersediaan) |

## Sumber Nilai Field

- `id`: Dihasilkan oleh sistem menggunakan timestamp (`DateTime.now().millisecondsSinceEpoch.toString()`).
- `judul`: Berasal dari input Form (pengguna).
- `penulis`: Berasal dari input Form (pengguna).
- `status`: Nilai default awal saat ditambahkan (misal: "Tersedia").