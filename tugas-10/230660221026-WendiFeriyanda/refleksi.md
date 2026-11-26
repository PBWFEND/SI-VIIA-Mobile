# Refleksi Tugas 10 — SI RAKUS



## 1. Bagian Integrasi yang Paling Menantang

Bagian yang paling menantang adalah memahami cara menghubungkan data dari dua endpoint yang berbeda. Data pengguna dan data aktivitas memiliki struktur masing-masing, sehingga saya perlu memahami bahwa `users.id` harus dicocokkan dengan `posts.userId` agar nama pengguna yang ditampilkan sesuai dengan aktivitasnya. Penggunaan `Future.wait` membantu menjalankan kedua request secara bersamaan karena keduanya tidak saling bergantung.

## 2. Penanganan Response Kosong dan Error

Response kosong perlu dibedakan dari error karena response kosong berarti request berhasil tetapi tidak ada data yang dapat ditampilkan, sedangkan error berarti proses pengambilan atau pengolahan data mengalami kegagalan. Pada halaman SI RAKUS, kondisi kosong ditampilkan dengan pesan bahwa belum ada data aktivitas, sedangkan kondisi error menampilkan pesan kegagalan dan tombol Coba Lagi.

## 3. Alasan Pemisahan Service dan Widget

Service layer digunakan untuk menempatkan request HTTP, parsing JSON, dan penggabungan data agar tidak bercampur dengan kode tampilan. Widget bertugas menampilkan data serta mengatur respons antarmuka seperti loading, sukses, kosong, dan error. Pemisahan ini membuat kode lebih mudah dibaca, dirawat, dan diuji.

## Deklarasi Penggunaan AI

ChatGPT digunakan sebagai asisten pembelajaran untuk menjelaskan konsep integrasi endpoint, `Future.wait`, identifier, dan membantu menyusun dokumentasi. Saya tetap bertanggung jawab untuk memahami kode, menjalankan aplikasi, memeriksa hasil `flutter analyze`, dan menguji setiap kondisi sebelum pengumpulan.
