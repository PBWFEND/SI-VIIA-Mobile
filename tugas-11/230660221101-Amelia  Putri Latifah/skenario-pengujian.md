# Skenario Pengujian Fitur Perangkat — PresenGo

| Skenario | Expected Result | Actual Result |
| :--- | :--- | :--- |
| Fitur berhasil digunakan | Foto terpilih/diambil, ukuran & format tervalidasi, dan preview foto beserta nama/ukuran tampil pada halaman. | Terverifikasi sesuai ekspektasi saat pengujian aplikasi. |
| Pengguna membatalkan aksi | `XFile` bernilai `null`, tidak muncul pesan error, dan lampiran/state sebelumnya tetap dipertahankan. | Terverifikasi sesuai ekspektasi ketika dialog pemilihan ditutup/dibatalkan. |
| Permission ditolak | Muncul pesan izin ditolak yang informatif, petunjuk pengaturan, dan tombol **Coba Lagi** tanpa error tak tertangani. | Terverifikasi sesuai penanganan `PlatformException` / izin ditolak pada service dan UI. |
| Package atau perangkat menghasilkan error | Muncul pesan error yang ramah pengguna (bukan stack trace mentah) dan tombol **Coba Lagi** dapat memicu ulang proses. | Terverifikasi melalui blok `try-catch` dan validasi ukuran/format pada `FotoPresensiService`. |