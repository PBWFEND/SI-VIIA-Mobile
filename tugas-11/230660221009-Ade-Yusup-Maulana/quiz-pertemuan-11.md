# Quiz Pertemuan 11 — Fitur Perangkat Sesuai Kebutuhan

**Mata Kuliah:** Pemrograman Aplikasi Bergerak  
**Pertemuan:** 11  
**Nama:** Ade Yusup Maulana  
**NIM:** 230660221009  
**Program Studi:** Sistem Informasi  

## 1. Pemilihan Fitur Perangkat

Fitur perangkat yang saya pilih adalah kamera dan galeri.

Fitur ini digunakan untuk mengambil foto kondisi ruangan atau fasilitas kampus sebagai bukti dokumentasi sebelum ruangan digunakan.

Kamera digunakan untuk mengambil foto secara langsung, sedangkan galeri digunakan untuk memilih foto yang sudah tersimpan pada perangkat.

## 2. Pengelolaan Izin Akses

Aplikasi perlu memperhatikan izin akses perangkat sesuai fitur yang digunakan.

- Jika izin diberikan, aplikasi dapat melanjutkan proses pengambilan foto.
- Jika izin ditolak, aplikasi memberikan informasi kepada pengguna.
- Jika izin ditolak secara permanen, pengguna dapat diarahkan ke pengaturan perangkat.
- Jika fitur tidak tersedia, aplikasi menampilkan pesan bahwa fitur tidak dapat digunakan.

## 3. Penanganan Pembatalan Pemilihan Foto

Pada penggunaan `image_picker`, hasil pemilihan foto menggunakan tipe `XFile?`.

Jika hasilnya bernilai `null`, berarti pengguna membatalkan proses pemilihan foto.

Aplikasi tidak perlu menganggap kondisi tersebut sebagai error. Foto sebelumnya tetap dipertahankan dan pengguna dapat mencoba kembali.

## 4. Pemisahan Service dan Widget

Service bertugas mengelola proses akses kamera dan galeri menggunakan package `image_picker`.

Widget bertugas menampilkan antarmuka aplikasi, tombol, pratinjau gambar, indikator loading, dan pesan kepada pengguna.

Pemisahan ini membuat kode lebih terstruktur dan mudah dikembangkan.

## 5. Pengelolaan State Aplikasi

Aplikasi perlu menangani beberapa kondisi berikut:

1. **Loading:** aplikasi sedang memproses pengambilan atau pemilihan foto.
2. **Success:** foto berhasil dipilih dan ditampilkan.
3. **Cancelled:** pengguna membatalkan pemilihan foto.
4. **Permission Denied:** akses perangkat ditolak.
5. **Error:** terjadi kesalahan ketika proses pengambilan atau pemilihan foto.

Setiap kondisi perlu ditangani sesuai kebutuhan agar pengguna mendapatkan informasi yang jelas.

## Kesimpulan

Fitur perangkat harus dipilih berdasarkan kebutuhan proses bisnis aplikasi. Penggunaan kamera dan galeri dapat membantu proses dokumentasi secara digital. Selain itu, pengelolaan izin akses, pembatalan, dan error diperlukan agar aplikasi lebih mudah digunakan.