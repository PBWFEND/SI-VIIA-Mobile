# Catatan Keputusan Data — Tugas 7

| Keputusan | Pilihan Anda | Alasan (merujuk kebutuhan) |
|:----------|:-------------|:---------------------------|
| Field model | `id`, `judul`, `penulis`, `kategori`, `status`, dan `rak` pada class `Buku` dengan field `final` | Setiap field dipakai oleh F-01, F-02, F-03, atau F-07 sehingga model tidak menyimpan data yang tidak berhubungan dengan kebutuhan. |
| Kunci data (`id`) | `int` unik dari `_nextId`, bukan index daftar | F-07 membutuhkan perubahan status pada buku yang tepat dan operasi delete harus tetap benar setelah item lain dihapus. |
| Operasi CRUD per kebutuhan | Create dari form, Read melalui `ListView.builder`, Update memakai `indexWhere`, Delete memakai `removeWhere` setelah `AlertDialog` | Pembagian ini membuat setiap aksi dapat diuji dari antarmuka dan sesuai dengan pola pengelolaan state Pertemuan 7. |
| Keputusan persistensi | Data disimpan in-memory pada `State` untuk versi MVP awal | Tugas meminta data lokal tanpa package tambahan; persistensi permanen ditunda sampai kebutuhan penyimpanan dan database ditetapkan. |
| Konfirmasi delete | `AlertDialog` dengan pilihan Batal dan Hapus | Penghapusan adalah aksi destruktif dan perlu konfirmasi agar data koleksi tidak hilang karena salah tekan. |
| Feedback aksi | `SnackBar` setelah tambah dan hapus | Pengguna memperoleh bukti langsung bahwa state berubah setelah Create atau Delete berhasil. |
