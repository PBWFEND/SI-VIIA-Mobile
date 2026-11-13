# Catatan Keputusan Navigasi — Glazent.pro

| | |
|:--|:--|
| **Nama** | Fajar |
| **NIM** | 230660221093 |
| **Kelas** | SI-VIIA |

---

| Keputusan | Pilihan Anda | Alasan (merujuk IA/kebutuhan) |
|:----------|:-------------|:--------------------------------|
| Nama route | `/` (status pesanan), `/form` (form pemesanan), `/detail` (detail pesanan) | Nama route langsung merujuk nama layar pada IA Tugas 5 agar mudah ditelusuri; `/` dipakai sebagai `initialRoute` karena memenuhi F-02 (Must) dan menjadi titik masuk utama |
| Data antarlayar | Objek `DataPesanan` (layanan, tanggal, status) dikirim sebagai arguments saat kartu pesanan diketuk menuju `/detail` | Rani (Persona 1, Tugas 4) sering lupa detail pesanannya; detail bersifat read-only karena pengubahan status bukan wewenang pelanggan (hanya pemilik/teknisi yang mengubah status, F-06) |
| Validator tiap field | Tiga field (jenis layanan, alamat, tanggal) wajib diisi — menolak nilai kosong/hanya spasi dengan pesan spesifik per field | F-01 mensyaratkan pemesanan berisi jenis layanan, alamat, dan tanggal; menolak input kosong mencegah pesanan tidak lengkap sampai ke teknisi, sesuai keluhan "bentrokan jadwal" pada observasi Tugas 4 |
| Feedback tiap aksi | `SnackBar` "Pemesanan ... dikirim (simulasi)." setelah kirim valid; `splashColor` tema pada kartu saat diketuk | Pelanggan memesan di sela waktu singkat (observasi Tugas 4) sehingga perlu kepastian langsung bahwa pesanannya tercatat, bukan sekadar berpindah layar tanpa konfirmasi |
