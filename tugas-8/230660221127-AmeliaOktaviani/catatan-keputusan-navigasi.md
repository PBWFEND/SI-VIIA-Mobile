# Catatan Keputusan Navigasi

## Tujuan

Dokumen ini menjelaskan keputusan navigasi dan interaksi pada aplikasi inventaris dalam Tugas 6.

## Tabel Keputusan

| Aspek | Keputusan | Alasan |
|---|---|---|
| Halaman awal | Route `/` menampilkan daftar barang. | Pengguna dapat langsung melihat barang yang tersedia saat aplikasi dibuka. |
| Halaman detail | Route `/detail` menampilkan informasi barang yang dipilih. | Pengguna membutuhkan informasi barang tertentu tanpa harus melihat semua detail pada halaman utama. |
| Halaman transaksi | Route `/form` menampilkan formulir transaksi. | Formulir dipisahkan dari halaman daftar agar interaksi input lebih terarah. |
| Pengiriman data | Data barang dikirim melalui route arguments menggunakan `Navigator.pushNamed`. | Halaman detail dapat menampilkan barang yang dipilih tanpa menentukan barang secara tetap di halaman detail. |
| Pemeriksaan argumen | Argumen diperiksa menggunakan `is` dan tersedia kondisi alternatif jika argumen tidak sesuai. | Mencegah aplikasi langsung menggunakan data dengan tipe yang tidak sesuai. |
| Navigasi kembali | `Navigator.pop` digunakan untuk kembali ke halaman sebelumnya. | Mempertahankan alur navigasi yang mudah dipahami. |
| Validasi formulir | `Form` dan `GlobalKey<FormState>` digunakan untuk memeriksa input sebelum diproses. | Data wajib perlu diperiksa agar tidak dikirim dalam keadaan kosong atau tidak sesuai. |
| Pengelolaan input | `TextEditingController` digunakan untuk membaca input dan dibersihkan melalui `dispose`. | Mengelola siklus hidup controller dengan baik. |
| Umpan balik | `SnackBar` ditampilkan setelah formulir valid dikirim. | Pengguna memperoleh konfirmasi bahwa input telah diproses oleh aplikasi. |

## Kesimpulan

Keputusan navigasi dan interaksi dibuat untuk menjaga alur penggunaan aplikasi inventaris tetap jelas, memudahkan pengguna berpindah halaman, dan membantu memastikan input transaksi memenuhi aturan validasi.
