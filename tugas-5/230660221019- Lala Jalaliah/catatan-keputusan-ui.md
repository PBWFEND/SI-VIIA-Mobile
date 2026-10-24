# Catatan Keputusan UI/UX

Dokumen ini menjelaskan alasan pemilihan tampilan pada prototipe aplikasi Pengelolaan Surat Masuk UKM. Keputusan desain disesuaikan dengan kebutuhan anggota/pengurus UKM dan sekretaris UKM agar informasi surat lebih mudah dilihat, dicari, dan diperiksa.

## Tabel Keputusan Desain

| No. | Bagian UI | Keputusan Desain | Alasan |
|---|---|---|---|
| 1 | Warna aplikasi | Menggunakan warna ungu sebagai warna utama melalui `ColorScheme.fromSeed`. | Agar tampilan konsisten dan warna komponen mengikuti tema aplikasi. |
| 2 | Kartu ringkasan | Menampilkan jumlah Total Surat dan Belum Dicek di bagian atas halaman. | Membantu sekretaris mengetahui jumlah surat dan surat yang belum diperiksa dengan cepat. |
| 3 | Status surat | Status “Belum diperiksa” berwarna merah, sedangkan “Sudah diperiksa” berwarna ungu. | Membantu sekretaris membedakan surat yang perlu diperiksa dan surat yang sudah diperiksa. |
| 4 | Daftar surat | Menggunakan `Card` dan `ListTile` untuk menampilkan judul surat, pengirim, dan status. | Agar informasi utama setiap surat mudah dibaca dan dibedakan. |
| 5 | Kolom pencarian | Menyediakan kolom pencarian untuk mencari surat berdasarkan judul atau nama pengirim. | Memudahkan pengguna menemukan surat yang dibutuhkan. |
| 6 | Tombol utama | Meletakkan tombol “Tambah Surat” di pojok kanan bawah menggunakan `FloatingActionButton.extended`. | Agar anggota atau pengurus UKM mudah menemukan tindakan untuk menambahkan surat. |
| 7 | Hierarki teks | Judul bagian dibuat lebih besar dan tebal daripada informasi pendukung. | Agar pengguna dapat membedakan judul bagian dan informasi surat. |
| 8 | Kondisi kosong | Menyediakan ikon dan teks “Belum ada surat masuk” jika daftar surat kosong. | Agar pengguna mengetahui bahwa belum ada data surat yang ditampilkan. |

## Kesimpulan

Desain prototipe dibuat sederhana agar informasi surat masuk mudah dibaca, dicari, dan diperiksa. Kartu ringkasan membantu pengguna melihat jumlah surat, sedangkan kolom pencarian dan perbedaan warna status membantu pengguna menemukan serta mengenali kondisi surat dengan lebih mudah.
