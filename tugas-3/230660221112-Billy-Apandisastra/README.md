# Tugas 3 - Aplikasi Perpustakaan

**Domain SI:** Sistem Informasi Perpustakaan

**Deskripsi Halaman:**
Aplikasi ini adalah halaman antarmuka sederhana untuk Sistem Informasi Perpustakaan yang berfungsi menampilkan katalog buku. Halaman ini dibangun menggunakan kerangka kerja Flutter dengan mengombinasikan berbagai widget layout seperti `Column`, `Row`, `Padding`, dan `ListView.builder` untuk menyusun daftar buku statis yang memuat informasi judul, kategori, dan label status ketersediaannya secara terstruktur.

**Refleksi:**
Widget layout yang paling menantang untuk saya rangkai adalah `ListView.builder` karena rentan memicu error *RenderFlex overflow* jika tidak dibungkus dengan `Expanded` saat diletakkan di dalam `Column`. Selain itu, mengatur tata letak teks dan label status di dalam `Row` agar merespons dengan baik pada berbagai ukuran layar juga membutuhkan ketelitian pembagian ruang. Namun, setelah memahami cara kerja hirarki widget dan sifat *constraints* pada Flutter, proses merangkai antarmuka menjadi jauh lebih mudah dipahami dan terprediksi.