# Catatan Keputusan Navigasi — Tugas 6

| Keputusan | Pilihan Anda | Alasan (merujuk IA/kebutuhan) |
|:----------|:-------------|:------------------------------|
| Nama route | `/`, `/detail-buku`, `/konfirmasi-peminjaman`, `/pinjaman-aktif` | Nama route sama persis antara diagram, peta `routes`, dan setiap pemanggilan `pushNamed`, sehingga layar IA Tugas 5 mudah ditelusuri. |
| Data antarlayar | `Map<String, String>` berisi judul, penulis, kategori, status, dan rak | Data yang dikirim dari Beranda ke Detail lalu Form mendukung F-02, F-03, dan F-04 tanpa membuat model tambahan di luar cakupan pertemuan. |
| Pemeriksaan arguments | `is Map<String, String>`, fallback `Map`, dan cabang `null` | Detail dan form tetap menampilkan keadaan aman ketika route dibuka tanpa data; ini memenuhi pemeriksaan tipe dan null pada materi. |
| Validator tiap field | Nama minimal 3 karakter, durasi wajib dipilih, catatan maksimal 120 karakter | Validasi langsung menjelaskan kesalahan sebelum F-04 dikirim dan menjaga data peminjaman tetap terbaca. |
| Posisi aksi kirim | `FilledButton.icon` di bawah seluruh field | Aksi utama mudah ditemukan setelah pengguna mengisi form dan tetap berada dalam alur satu layar. |
| Feedback tiap aksi | `SnackBar` setelah form valid atau ketika arguments tidak tersedia | Pengguna mendapat konfirmasi langsung setelah kirim, sedangkan error data diberi pesan yang dapat dipahami. |
| Jalan kembali | `Navigator.pop` pada layar detail, form, dan pinjaman aktif | Pengguna dapat kembali ke konteks sebelumnya tanpa mengulang pencarian pada alur Must have. |

## Batasan

Implementasi memakai API bawaan Flutter tanpa package tambahan. Data masih statis karena pengelolaan database dan autentikasi bukan bagian dari cakupan Pertemuan 6.
