# Catatan Keputusan UI/UX — SI RAKUS

Dokumen ini menjelaskan keputusan antarmuka pada wireframe Katalog Buku dan Detail Buku serta penerapannya pada kode halaman utama Flutter. Keputusan dibuat dengan mengacu pada kebutuhan mahasiswa untuk menemukan buku dan mengetahui ketersediaan koleksi.

| Keputusan | Pilihan | Alasan berdasarkan kebutuhan/persona/prinsip |
|---|---|---|
| Warna benih | Teal (`Colors.teal`) melalui `ColorScheme.fromSeed` | Warna didefinisikan terpusat di `ThemeData` agar komponen konsisten dan mudah disesuaikan. Warna tidak ditulis satu per satu pada setiap widget. |
| Bentuk status | Label berbentuk kotak bersudut membulat dengan teks “Tersedia” atau “Stok habis” beserta jumlah eksemplar | Mahasiswa dapat membedakan kondisi stok dengan cepat. Status menggunakan teks dan warna sekaligus sehingga informasi tidak bergantung pada warna saja. Warna diambil dari `primaryContainer` dan `errorContainer` pada tema. |
| Posisi aksi utama | Tombol “Lihat detail” ditempatkan di bagian bawah setiap kartu buku | Tombol berada dekat dengan informasi buku yang dipilih sehingga hubungan antara buku dan aksinya jelas. Bentuk `FilledButton` mengikuti tombol yang ditampilkan pada wireframe dan memenuhi kebutuhan F-03. |
| Hierarki teks | Judul halaman dibuat menonjol; judul buku tebal; penulis dan status sebagai informasi pendukung | Mahasiswa dapat memindai daftar dengan cepat dan membedakan nama buku dari informasi tambahan. Ukuran dan gaya teks menggunakan `textTheme` dari tema Flutter. |
| Keadaan kosong | Ikon, judul, dan petunjuk ditampilkan di tengah area daftar | Ketika pencarian tidak menemukan buku, aplikasi memberi feedback yang jelas dan menyarankan pengguna mencoba kata kunci lain, bukan menampilkan area kosong tanpa penjelasan. |
| Konsistensi kartu | Setiap buku memakai struktur kartu yang sama | Struktur yang berulang membuat daftar lebih mudah dipindai dan dapat dibangun menggunakan `ListView.builder`, `Card`, dan `ListTile`. |

## Hubungan dengan kebutuhan

- **F-01:** daftar buku ditampilkan dalam kartu pada layar Katalog Buku.
- **F-02:** kolom pencarian ditempatkan di bagian atas agar mudah ditemukan.
- **F-03:** tombol “Lihat detail” berada di dalam kartu buku yang sesuai. Pada Tugas 5, tombol memberikan feedback sementara; navigasi ke layar Detail Buku belum diterapkan karena menjadi materi Pertemuan 6.
- **F-04:** status dan jumlah stok terlihat pada setiap kartu buku.

## Pemeriksaan konsistensi

Nama layar, contoh buku, label status, dan fungsi utama perlu tetap konsisten antara wireframe, kode Flutter, dan dokumen kebutuhan. Target keterbacaan dan kenyamanan area sentuh perlu diperiksa kembali ketika aplikasi dijalankan pada ukuran layar target. Catatan ini menjelaskan keputusan rancangan dan bukan hasil pengujian usability formal.
