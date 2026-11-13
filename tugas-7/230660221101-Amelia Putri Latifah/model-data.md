# Model Data
**Nama**: Amelia Putri Latifah  
**NIM**: 230660221101  
**Domain**: Sistem Absensi Organisasi (PresenGo)

## 1. Daftar Entitas Utama
| Entitas | Field | Tipe Data | Kebutuhan yang Dipenuhi | Sumber Nilai |
| :--- | :--- | :--- | :--- | :--- |
| `DataKegiatan` | `id` | `String` | F-04, F-05 | Sistem (`DateTime.now().millisecondsSinceEpoch`) |
| | `nama` | `String` | F-01, F-04 | Input pengguna (Form Tambah Jadwal) |
| | `waktu` | `String` | F-01, F-04 | Input pengguna (Form Tambah Jadwal) |
| | `lokasi` | `String` | F-01, F-04 | Input pengguna (Form Tambah Jadwal) |
| | `status` | `String` | F-01, F-05 | Default 'Segera', diubah via tombol sistem |

## 2. Penjelasan Sumber Nilai
Semua *field* teks (`nama`, `waktu`, `lokasi`) didapatkan dari input pengurus saat mengisi form di Halaman Form Jadwal untuk memastikan jadwal yang tampil relevan dengan kebutuhan anggota. *Field* `id` dan `status` di-*generate* secara otomatis oleh sistem; `id` sebagai pengenal unik agar operasi ubah/hapus tidak keliru, dan `status` diberikan nilai awal 'Segera' yang dapat diubah ke 'Selesai' saat acara berakhir.