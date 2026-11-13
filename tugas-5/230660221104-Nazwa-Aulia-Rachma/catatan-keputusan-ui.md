# Catatan Keputusan UI/UX — Tugas 5

| Keputusan | Pilihan Anda | Alasan (merujuk kebutuhan/persona/prinsip) |
|:----------|:-------------|:--------------------------------------------|
| Warna benih | `ColorScheme.fromSeed` dengan benih hijau lembut dan `useMaterial3: true` | Hijau lembut memberi kesan layanan akademik yang tenang, sedangkan seluruh warna komponen diturunkan dari tema agar konsisten untuk persona Alya dan Rani. |
| Bentuk status | `Chip` dengan warna ternary dari `ColorScheme`: `primary` untuk Tersedia, `tertiary` untuk Terbatas, dan `error` untuk status bermasalah | Status F-03 perlu terbaca sekilas; bentuk chip memisahkan status dari judul tanpa menambah langkah. |
| Posisi aksi utama | `FloatingActionButton.extended` di kanan bawah dengan label **Cari buku** | Aksi utama F-01 selalu dekat ibu jari pada ponsel dan tetap terlihat ketika daftar digulir. |
| Hierarki teks | Judul halaman dan bagian memakai `titleLarge`, judul buku memakai teks tebal, metadata memakai `bodyMedium`, dan jumlah hasil memakai `labelLarge` | Hierarki membantu Alya memindai koleksi dalam waktu singkat sesuai persona dan target kegunaan NF-02. |
| Keadaan kosong | `Center` dengan ikon `search_off_rounded`, pesan, dan `FilledButton.tonal` untuk menampilkan semua buku | Saat F-01 tidak menghasilkan data, pengguna mendapat penjelasan dan pemulihan langsung, bukan layar kosong tanpa arah. |
| Struktur daftar | `ListView.builder` di dalam `Expanded`, setiap entri memakai `Card` dan `ListTile` | Struktur ini mengikuti F-01/F-03 dan mencegah `RenderFlex overflow` saat koleksi lebih panjang dari layar. |

## Keterlacakan wireframe dan kode

- Layar utama pada `wireframe.png` adalah **Beranda / Cari buku**.
- Kartu ringkasan dan daftar koleksi mendukung F-01; label status pada setiap kartu mendukung F-03.
- Keadaan kosong yang dianotasi pada layar pendukung juga tersedia sebagai cabang `daftarBuku.isEmpty` pada `halaman-utama.dart`.
- Tidak ada `Navigator`; tombol menuju layar lain hanya memberi umpan balik sementara karena navigasi menjadi materi Pertemuan 6.


