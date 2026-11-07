### 2. File 

# Catatan Keputusan Navigasi

| Keputusan | Pilihan Anda | Alasan (merujuk IA/kebutuhan) |
| :--- | :--- | :--- |
| **Nama route** | `/`, `/detail`, `/form` | Pendek, standar, dan sangat deskriptif menggambarkan hierarki layar sesuai rancangan Arsitektur Informasi (IA) pada Tugas 5. |
| **Data antarlayar** | Mengirim objek `Map<String, String>` dari `/` ke `/detail` via `arguments` | Layar detail bersifat *read-only* (hanya menampilkan informasi lanjutan dari F-01). Pola ini lebih ringan karena tidak perlu memanggil ulang data, cukup meneruskan data yang ditekan dari daftar. |
| **Validator tiap field** | Mengecek nilai kosong atau hanya spasi (`value == null \|\| value.trim().isEmpty`) | Menjamin integritas data jadwal (F-04). Pengurus tidak boleh membuat jadwal fiktif tanpa nama atau lokasi, karena akan membingungkan anggota yang melihat jadwal. |
| **Feedback tiap aksi** | Memunculkan `SnackBar` konfirmasi berhasil dan langsung `pop` kembali ke daftar | Memberikan konfirmasi visual kepada pengurus bahwa jadwal tercatat (simulasi), sehingga mencegah mereka menekan tombol "Kirim" berulang kali dan menduplikasi data. |