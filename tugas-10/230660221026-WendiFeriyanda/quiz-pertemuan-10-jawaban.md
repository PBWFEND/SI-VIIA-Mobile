# Quiz Pertemuan 10 — Integrasi Data dan Proses Bisnis Sistem Informasi

## Identitas

- **Nama:** Wendi Feriyanda
- **NIM:** 230660221026
- **Program Studi:** Sistem Informasi
- **Kelas:** SI-VIIA

**Mata Kuliah:** Pemrograman Aplikasi Bergerak  
**Pertemuan:** 10  
**CPMK:** CPMK-3  
**Studi kasus:** SI RAKUS — Sistem Rak Kampus

---

## Soal 1 — Integrasi Data

**Pertanyaan:** Jelaskan apa yang dimaksud integrasi data pada aplikasi mobile dan berikan satu contoh dari proses bisnis Sistem Informasi. Sebutkan identifier yang menghubungkan data tersebut.

**Jawaban:**

Integrasi data pada aplikasi mobile adalah proses menghubungkan data yang berasal dari beberapa sumber atau endpoint agar dapat ditampilkan sebagai informasi yang lebih lengkap untuk mendukung satu proses bisnis.

Pada project SI RAKUS, contoh penerapannya adalah mengambil data pengguna dari endpoint `GET /users` dan data aktivitas simulasi dari endpoint `GET /posts`. Kedua data tersebut kemudian digabungkan agar aktivitas dapat ditampilkan bersama nama dan email pengguna yang terkait.

Identifier yang digunakan adalah `users.id` dan `posts.userId`. Service mencocokkan nilai `users.id` dengan `posts.userId`. Contohnya, apabila sebuah aktivitas memiliki `userId = 10`, aplikasi mencari pengguna dengan `id = 10`, lalu menggabungkan nama pengguna tersebut dengan informasi aktivitas.



## Soal 2 — `Future.wait`

**Pertanyaan:** Kapan `Future.wait` digunakan pada integrasi beberapa endpoint? Jelaskan pula kondisi yang mengharuskan request dijalankan secara berurutan.

**Jawaban:**

`Future.wait` digunakan ketika aplikasi perlu menjalankan beberapa proses asynchronous yang tidak saling bergantung. Dengan cara ini, beberapa request dapat dimulai secara bersamaan dan aplikasi menunggu seluruh hasilnya selesai sebelum melanjutkan proses berikutnya.

Pada SI RAKUS, request `GET /users` dan `GET /posts` dapat dijalankan dengan `Future.wait` karena aplikasi dapat meminta daftar pengguna dan daftar aktivitas secara terpisah. Keduanya tidak perlu menunggu hasil satu sama lain untuk mulai dipanggil.

Request harus dijalankan secara berurutan apabila request berikutnya membutuhkan hasil dari request sebelumnya. Contohnya, aplikasi harus mengambil detail pengguna terlebih dahulu untuk memperoleh ID pengguna, kemudian menggunakan ID tersebut untuk meminta aktivitas khusus milik pengguna itu. Dalam kondisi tersebut, request kedua baru dapat dilakukan setelah ID dari request pertama diperoleh.

## Soal 3 — Model dan `fromJson`

**Pertanyaan:** Sebutkan field yang dibutuhkan model `DataPengajuan` untuk menghubungkan pengguna dan pengajuan. Jelaskan cara `fromJson` menangani field yang tidak tersedia pada response.

**Jawaban:**

Berdasarkan contoh model pada materi Pertemuan 10, `DataPengajuan` memiliki field:

| Field | Tipe Dart | Fungsi |
|:--|:--|:--|
| `id` | `int` | Identitas unik pengajuan |
| `userId` | `int` | Menghubungkan pengajuan dengan data pengguna |
| `roomId` | `int` | Menghubungkan pengajuan dengan data ruang |
| `status` | `String` | Menunjukkan status proses pengajuan |

Field yang menjadi penghubung antara pengguna dan pengajuan adalah `userId`, karena nilainya dicocokkan dengan `id` pada model pengguna. `roomId` digunakan untuk menghubungkan pengajuan dengan data ruang.

Pada penerapan SI RAKUS, pola identifier yang sama dapat disesuaikan dengan proses peminjaman, misalnya menggunakan `userId` untuk pengguna dan `bookId` untuk buku. Namun, `bookId` merupakan penyesuaian konsep untuk domain SI RAKUS, bukan field pada contoh `DataPengajuan` di materi.

Factory constructor `fromJson` mengubah `Map<String, dynamic>` dari response JSON menjadi objek model Dart. Jika suatu field tidak tersedia atau bernilai `null`, nilai pengganti dapat diberikan menggunakan operator `??`. Contohnya, `json['status'] as String? ?? 'menunggu'` akan menggunakan nilai `'menunggu'` apabila status tidak tersedia. Untuk identifier numerik, contoh materi menggunakan nilai default seperti `0`.

## Soal 4 — Service Layer

**Pertanyaan:** Jelaskan tanggung jawab service layer dibanding widget pada integrasi data. Mengapa penggabungan data sebaiknya tidak ditulis langsung di dalam widget?

**Jawaban:**

Service layer bertanggung jawab menangani komunikasi dengan API dan pengolahan data. Tugasnya meliputi mengirim HTTP request ke endpoint, memeriksa status code, menangani timeout dan error, mengurai response JSON menjadi model Dart, serta menggabungkan data berdasarkan identifier.

Widget bertanggung jawab menampilkan hasil kepada pengguna. Widget mengatur tampilan loading, daftar data, kondisi kosong, pesan error, dan tombol untuk mencoba kembali. Widget cukup memanggil method pada service, kemudian menampilkan hasil yang dikembalikan.

Penggabungan data sebaiknya tidak ditulis langsung di dalam widget karena dapat membuat kode tampilan terlalu panjang dan mencampur tanggung jawab antarmuka dengan logika pengolahan data. Dengan pemisahan service layer, kode lebih mudah dibaca, digunakan kembali, dirawat, dan diuji. Jika endpoint atau cara penggabungan berubah, perubahan dapat difokuskan pada service tanpa harus mengubah seluruh tampilan.

## Soal 5 — Status Halaman

**Pertanyaan:** Sebutkan state yang perlu ditangani halaman integrasi data. Jelaskan pula mengapa kondisi data kosong perlu dibedakan dari kondisi error.

**Jawaban:**

Halaman integrasi data perlu menangani empat kondisi utama:

1. **Loading:** aplikasi sedang mengirim request dan menunggu response dari endpoint.
2. **Success:** request berhasil dan data hasil integrasi tersedia untuk ditampilkan.
3. **Empty:** request berhasil, tetapi data yang diterima atau hasil penggabungan tidak memiliki item untuk ditampilkan.
4. **Error:** request atau proses pengolahan data gagal, misalnya karena tidak ada koneksi internet, timeout, status HTTP gagal, atau format JSON tidak sesuai.

Kondisi data kosong harus dibedakan dari error karena penyebabnya berbeda. Data kosong berarti komunikasi dengan server berhasil, tetapi server tidak memberikan data yang dapat ditampilkan. Error berarti aplikasi gagal memperoleh atau memproses data. Karena penyebabnya berbeda, pesan kepada pengguna juga harus berbeda. Untuk data kosong, aplikasi dapat menampilkan pesan seperti “Belum ada data aktivitas”. Untuk error, aplikasi menampilkan pesan kegagalan dan tombol “Coba Lagi”.

---

## Ringkasan Konsep yang Digunakan

| Konsep | Penerapan pada SI RAKUS |
|:--|:--|
| Integrasi data | Menggabungkan data `/users` dan `/posts` |
| Identifier | `users.id` dicocokkan dengan `posts.userId` |
| `Future.wait` | Menjalankan kedua GET yang tidak saling bergantung |
| `fromJson` | Mengubah response JSON menjadi model Dart |
| Service layer | Menangani request, parsing, dan penggabungan data |
| State halaman | Loading, success, empty, dan error |

## Batasan Studi Kasus

Implementasi yang diperlihatkan pada project saat ini menggunakan JSONPlaceholder sebagai API simulasi. Data pengguna dan aktivitas bukan data mahasiswa kampus, bukan transaksi peminjaman buku sebenarnya, dan tidak terhubung dengan Libsys. Contoh ini digunakan untuk mempraktikkan konsep integrasi beberapa endpoint sesuai materi Pertemuan 10.
