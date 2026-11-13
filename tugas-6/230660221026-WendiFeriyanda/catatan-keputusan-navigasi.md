# Catatan Keputusan Navigasi — SI RAKUS

| Keputusan | Pilihan | Alasan berdasarkan IA/kebutuhan |
|---|---|---|
| Nama route utama | `/katalog` | Sesuai layar Katalog Buku pada IA dan menjadi titik awal untuk kebutuhan Must have F-01 dan F-02. |
| Nama route detail | `/detail-buku` | Sesuai layar Detail Buku pada IA; memenuhi F-03 dan menampilkan ketersediaan F-04. |
| Nama route akun | `/masuk` | Sesuai layar Masuk/Verifikasi Akun pada IA dan mendukung F-09. |
| Nama route peminjaman | `/peminjaman-saya` | Sesuai layar Peminjaman Saya pada IA dan mendukung F-05. |
| Nama route riwayat | `/riwayat-peminjaman` | Sesuai layar Riwayat Peminjaman pada IA dan mendukung F-06. |
| `initialRoute` | `/katalog` | Mahasiswa langsung dapat melihat katalog dan melakukan pencarian; layar ini memenuhi kebutuhan Must have. |
| Data antarlayar | Objek `DataBuku` dikirim dari Katalog Buku ke Detail Buku melalui `arguments`. | Detail harus menampilkan buku yang dipilih pengguna, bukan data buku yang ditulis ulang secara terpisah. |
| Pemeriksaan arguments | `args is DataBuku`; jika null atau tipe berbeda, tampilkan pesan pengganti. | Mencegah kesalahan cast dan membuat layar tetap dapat ditampilkan saat data tidak tersedia. |
| Field form | NIM dan kata sandi pada Halaman Masuk/Verifikasi Akun. | F-09 menyatakan mahasiswa masuk dengan akun perpustakaan yang valid. Pada prototype, field hanya diperiksa kelengkapan/formatnya. |
| Validator NIM | Wajib diisi dan tidak boleh hanya berisi spasi. | Identitas diperlukan untuk konteks akun mahasiswa; validasi format lebih lanjut disesuaikan dengan aturan akun uji. |
| Validator kata sandi | Wajib diisi; gunakan batas minimum yang ditentukan pada implementasi uji dan jelaskan alasannya. | Mencegah pengiriman form kosong. Batas minimum pada prototype bukan bukti kebijakan kata sandi resmi perpustakaan. |
| Feedback form | Pesan validator tampil di bawah field; setelah input lolos validasi, tampilkan `SnackBar` yang menyebutkan bahwa proses masih simulasi. | Pesan validator menjelaskan kesalahan pada field, sedangkan `SnackBar` memberi konfirmasi atas aksi kirim. |
| Navigasi maju | `Navigator.pushNamed`. | Menambahkan layar baru ke stack, misalnya dari katalog ke detail atau dari halaman masuk ke peminjaman. |
| Navigasi kembali | `Navigator.pop` pada layar yang dibuka dari route lain. | Mengembalikan pengguna ke layar sebelumnya dan mempertahankan konteks. Katalog sebagai route awal tidak diberi tombol pop. |

## Catatan batasan prototype

Belum ada integrasi backend, database akun, atau data transaksi perpustakaan. Karena itu, validasi lokal hanya menunjukkan bahwa input memenuhi aturan form yang ditulis. `SnackBar` tidak boleh mengklaim akun benar-benar berhasil diverifikasi dan halaman peminjaman/riwayat dapat memakai data contoh atau keterangan bahwa data belum terhubung.
