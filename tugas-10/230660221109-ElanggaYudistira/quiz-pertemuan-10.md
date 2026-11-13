# Quiz Pertemuan 10 — Integrasi Data dan Proses Bisnis

## Soal 1 — Integrasi Data

Integrasi data adalah proses menggabungkan data dari dua atau lebih sumber menjadi satu informasi yang dapat dipakai oleh fitur aplikasi. Pada project ini, endpoint pengguna menyediakan nama, email, dan organisasi pemohon, sedangkan endpoint pengajuan menyediakan judul pengajuan, status, dan userId. Identifier yang menghubungkan keduanya adalah userId pada DataPengajuan yang dicocokkan dengan id pada DataPengguna, sehingga satu kartu daftar dapat menampilkan nama pemohon dan data pengajuannya.

## Soal 2 — Future.wait

Future.wait digunakan ketika beberapa request tidak saling bergantung. GET /users dan GET /posts pada Tugas 10 dapat dijalankan secara paralel karena masing-masing dapat diminta tanpa menunggu hasil endpoint lain; proses berikutnya baru berjalan setelah kedua Future selesai. Request harus dijalankan berurutan jika request kedua memerlukan hasil request pertama, misalnya login harus mengembalikan token sebelum token itu dipakai untuk GET pengajuan, atau endpoint detail membutuhkan id yang baru diperoleh dari request pertama.

## Soal 3 — Model dan fromJson

Model DataPengajuan membutuhkan field id sebagai identitas pengajuan, userId sebagai penghubung ke pengguna, judul sebagai nama pengajuan, status sebagai tahap proses, dan deskripsi sebagai keterangan. Factory fromJson membaca key JSON lalu memberi nilai cadangan dengan operator ??, misalnya id menjadi 0, userId menjadi 0, judul menjadi Pengajuan tanpa judul, status menjadi Diproses atau Menunggu, dan deskripsi menjadi Deskripsi tidak tersedia. Cara ini membuat response parsial tidak langsung menyebabkan null error pada halaman.

## Soal 4 — Service Layer

Service layer bertanggung jawab atas URL endpoint, method HTTP, timeout, status code, decoding JSON, pembuatan model, dan penggabungan data. Widget bertanggung jawab atas state halaman dan tampilan loading, sukses, kosong, error, serta retry. Penggabungan tidak ditulis langsung di build karena build dapat dipanggil berkali-kali; jika request dan logika bisnis berada di sana, request dapat berulang, kode sulit diuji, dan tanggung jawab presentasi bercampur dengan akses data.

## Soal 5 — Status Halaman

Halaman integrasi perlu menangani state loading saat request berjalan, success saat daftar gabungan tersedia, empty saat request berhasil tetapi hasilnya tidak memiliki item, dan error saat request atau parsing gagal. Tombol Coba Lagi diperlukan pada error untuk mengulang proses integrasi. Data kosong harus dibedakan dari error karena data kosong merupakan respons valid yang berarti belum ada pengajuan, sedangkan error berarti aplikasi tidak memperoleh data dan pengguna perlu mencoba lagi atau memeriksa koneksi.
