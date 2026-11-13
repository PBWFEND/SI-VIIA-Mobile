# TES KONSEP UTS
## PEMROGRAMAN APLIKASI BERGERAK (PAB)

**Nama:** Sesi Prasmesti  
**NIM:** 230660221017  
**Program Studi:** Sistem Informasi  
**Kelas:** SI-VIIA  
**Proyek:** SI-FASKAM

---

## Soal 1 — Konsep Aplikasi Bergerak dalam SI (CPMK-1)

**1. Karakteristik: Mobilitas dan fleksibilitas**

Contoh penerapan: Mahasiswa dapat mengajukan surat keterangan aktif kuliah melalui smartphone dari mana saja tanpa harus datang langsung ke loket administrasi kampus.

**2. Karakteristik: Aksesibilitas yang mudah**

Contoh penerapan: Aplikasi dapat dibuka melalui smartphone sehingga mahasiswa bisa mengisi formulir pengajuan surat dengan lebih praktis tanpa harus menggunakan komputer desktop.

**3. Karakteristik: Pemanfaatan fitur perangkat mobile**

Contoh penerapan: Aplikasi dapat memanfaatkan kamera untuk mengunggah dokumen persyaratan dan notifikasi untuk memberi informasi ketika surat sudah selesai diproses.

---

## Soal 2 — Dasar Pemrograman Dart (CPMK-1)

- **List<String> daftarSurat = []:** Digunakan untuk membuat List kosong yang hanya dapat menyimpan data berbentuk String. List ini digunakan untuk menampung jenis surat yang diajukan mahasiswa.
- **Parameter String jenis:** Digunakan untuk menerima masukan berupa teks yang berisi jenis surat yang ingin ditambahkan ke dalam daftar.
- **jenis.isEmpty:** Digunakan untuk memeriksa apakah teks jenis surat kosong atau tidak.
- **return pada kondisi error:** Digunakan untuk menghentikan proses fungsi ketika terjadi kesalahan, misalnya pengguna belum mengisi jenis surat.
- **daftarSurat.add(jenis):** Digunakan untuk menambahkan jenis surat baru ke dalam List.
- **Perulangan for:** Digunakan untuk membaca atau menampilkan setiap data surat yang tersimpan di dalam List secara berurutan.

**Kesalahan umum bila validasi isEmpty dihapus:**

Jika validasi isEmpty dihapus, pengguna dapat memasukkan data kosong ke dalam daftar surat. Hal ini dapat menyebabkan data menjadi tidak lengkap, membingungkan pengguna, dan mengganggu proses pengelolaan pengajuan surat.

---

## Soal 3 — Struktur Flutter dan Widget (CPMK-1)

- **MaterialApp:** Merupakan widget utama yang mengatur konfigurasi aplikasi, seperti tema, judul, dan navigasi halaman.
- **Scaffold:** Digunakan sebagai kerangka dasar halaman yang menyediakan bagian seperti AppBar, body, dan FloatingActionButton.
- **AppBar:** Merupakan bagian atas halaman yang menampilkan judul aplikasi atau nama halaman.
- **Column:** Digunakan untuk menyusun beberapa widget secara vertikal dari atas ke bawah.
- **Text:** Digunakan untuk menampilkan tulisan, seperti judul halaman, nama surat, dan keterangan lainnya.
- **ListView.builder:** Digunakan untuk menampilkan daftar surat secara dinamis berdasarkan jumlah data yang tersedia. Widget ini cocok untuk daftar panjang karena item dibuat sesuai kebutuhan tampilan.

**Masalah bila ListView.builder di dalam Column tanpa Expanded:**

Widget dapat mengalami error seperti *Vertical viewport was given unbounded height*, yaitu ListView tidak mendapatkan batas tinggi yang jelas.

**Penyebab:**

Column tidak secara otomatis memberikan batas tinggi kepada ListView. Akibatnya, ListView tidak mengetahui ruang maksimal yang dapat digunakannya.

**Perbaikan:**

Menggunakan widget Expanded untuk membatasi ListView agar mengisi ruang kosong yang tersedia di dalam Column. Alternatifnya, dapat menggunakan Flexible atau memberikan tinggi tertentu menggunakan SizedBox.

---

## Soal 4 — Analisis Kebutuhan dan User Flow (CPMK-2)

### Klasifikasi dan Prioritas MoSCoW

| No. | Permintaan | Fungsional/Nonfungsional | Prioritas MoSCoW | Alasan |
|---|---|---|---|---|
| 1 | Mengajukan surat keterangan aktif kuliah | Fungsional | Must | Merupakan fungsi utama aplikasi karena mahasiswa harus bisa mengajukan surat secara online. |
| 2 | Melihat status pengajuan | Fungsional | Must | Mahasiswa perlu mengetahui apakah pengajuan masih menunggu, sedang diproses, atau sudah selesai. |
| 3 | Menerima notifikasi saat surat siap diambil | Fungsional | Should | Notifikasi membantu memberikan informasi kepada mahasiswa, tetapi pengajuan dan pengecekan status masih dapat dilakukan tanpa fitur ini. |

Ketiga permintaan tersebut termasuk kebutuhan fungsional karena menjelaskan fungsi yang harus disediakan aplikasi. Contoh kebutuhan nonfungsional adalah aplikasi mudah digunakan, aman, dan memiliki waktu respons yang cepat.

### User Flow untuk Kebutuhan Must

1. Mahasiswa membuka aplikasi pengajuan surat.
2. Mahasiswa memilih menu pengajuan surat.
3. Aplikasi menampilkan daftar jenis surat yang tersedia.
4. Mahasiswa memilih surat keterangan aktif kuliah.
5. Mahasiswa mengisi formulir dan melengkapi persyaratan.
6. Mahasiswa menekan tombol Kirim dan sistem memvalidasi data.
7. Jika data valid, sistem menyimpan pengajuan dan menampilkan konfirmasi bahwa pengajuan berhasil dikirim.

Jika data belum lengkap, aplikasi menampilkan pesan kesalahan dan mahasiswa diminta melengkapi formulir.

---

## Soal 5 — UI/UX Mobile (CPMK-2)

**1. Prinsip: Desain responsif dan sederhana**

**Keputusan desain:** Menggunakan tampilan daftar surat berbentuk Card atau ListTile yang disusun secara vertikal.

**Alasan:** Ukuran layar smartphone terbatas sehingga informasi perlu disusun secara rapi agar mudah dibaca dan tidak membuat tampilan terlalu penuh.

**2. Prinsip: Kemudahan interaksi sentuh**

**Keputusan desain:** Menggunakan tombol dengan ukuran yang cukup besar, jarak antartombol yang sesuai, serta ikon yang mudah dikenali.

**Alasan:** Pengguna smartphone berinteraksi menggunakan sentuhan jari sehingga tombol harus mudah ditekan dan tidak menyulitkan pengguna.

**3. Prinsip: Efisiensi dan kemudahan penggunaan**

**Keputusan desain:** Menyediakan kolom pencarian dan kategori surat agar mahasiswa dapat menemukan jenis surat yang dibutuhkan dengan cepat.

**Alasan:** Pengguna biasanya membuka aplikasi dalam waktu singkat. Dengan pencarian, mahasiswa tidak perlu menggulir seluruh 20 jenis surat secara manual.

---

## Soal 6 — Navigasi dan Interaksi (CPMK-2)

### Metode Navigasi dan Kapan Digunakan

- **push:** Digunakan untuk membuka halaman baru di atas halaman sebelumnya. Contohnya, dari halaman daftar menuju formulir pengajuan atau halaman detail.
- **pushNamed:** Digunakan untuk berpindah halaman menggunakan nama route yang sudah didaftarkan, misalnya `/form` atau `/detail`. Metode ini memudahkan pengelolaan navigasi aplikasi yang memiliki banyak halaman.
- **pop:** Digunakan untuk kembali ke halaman sebelumnya atau menutup halaman yang sedang terbuka. Metode ini juga dapat mengirimkan data kembali ke halaman sebelumnya.

### Pengiriman Data Jenis Surat ke Halaman Form

Data jenis surat dapat dikirim dari halaman daftar ke halaman formulir melalui parameter pada constructor widget atau melalui arguments jika menggunakan Named Routes.

Contohnya, ketika mahasiswa memilih surat keterangan aktif kuliah, aplikasi mengirimkan nilai tersebut ke halaman formulir. Selanjutnya, halaman formulir menerima data dan menampilkan jenis surat yang dipilih agar mahasiswa tidak perlu memilihnya kembali.

### Feedback Setelah Form Dikirim

Setelah mahasiswa menekan tombol kirim, aplikasi melakukan validasi terhadap data formulir. Jika data belum lengkap, aplikasi menampilkan pesan kesalahan. Jika data berhasil dikirim dan disimpan, aplikasi menampilkan halaman konfirmasi atau SnackBar yang memberitahukan bahwa pengajuan berhasil dikirim.

---

## Soal 7 — Model Data dan State (CPMK-3)

**Mengapa setiap field bersifat final:**

Field dibuat final agar nilai atribut tidak dapat diubah secara langsung setelah objek dibuat. Dengan demikian, data menjadi lebih konsisten dan perubahan dilakukan melalui pembuatan objek baru atau metode seperti copyWith().

**Mengapa id wajib ada:**

ID digunakan sebagai identitas unik setiap data pengajuan. Dengan adanya ID, aplikasi dapat membedakan satu pengajuan dengan pengajuan lainnya, terutama ketika melakukan proses edit dan hapus.

**Perbedaan StatelessWidget dan StatefulWidget:**

- StatelessWidget adalah widget yang tampilannya tidak memiliki state yang berubah selama widget tersebut digunakan.
- StatefulWidget adalah widget yang memiliki state dan dapat memperbarui tampilannya ketika data atau kondisi berubah.

**Halaman daftar menggunakan: StatefulWidget.**

**Alasan:**

Halaman daftar pengajuan menggunakan StatefulWidget karena data dapat berubah ketika pengguna menambahkan, mengedit, menghapus, atau mengubah status pengajuan. Tampilan harus diperbarui agar sesuai dengan kondisi data terbaru.

**Fungsi setState():**

setState() digunakan untuk memberi tahu Flutter bahwa terdapat perubahan state sehingga widget perlu dibangun ulang untuk menampilkan data terbaru.

**Apa yang terjadi bila data ditambah tanpa setState():**

Data mungkin sudah masuk ke dalam List, tetapi tampilan aplikasi tidak langsung diperbarui. Akibatnya, pengguna belum melihat data baru sampai terjadi proses pembangunan ulang widget karena hal lain.

---

## Soal 8 — CRUD Lokal (CPMK-3)

| Operasi | Method List / Mekanisme |
|---|---|
| Create | add() atau insert() untuk menambahkan data baru. |
| Read | Mengakses List, misalnya melalui for, map(), atau ListView.builder. |
| Update | Mencari data berdasarkan ID menggunakan indexWhere(), kemudian mengganti objek pada index yang ditemukan. |
| Delete | Menggunakan removeWhere() untuk menghapus data berdasarkan ID. |

**Mengapa ID digunakan sebagai kunci update dan delete:**

ID digunakan karena setiap data memiliki identitas unik dan tetap. Dengan menggunakan ID, aplikasi dapat menemukan data yang benar meskipun posisi data di dalam List berubah.

**Konsekuensi bila index digunakan sebagai kunci:**

Jika menggunakan index, aplikasi berisiko mengubah atau menghapus data yang salah ketika urutan List berubah akibat penambahan atau penghapusan data. Index menunjukkan posisi data, bukan identitas tetap suatu data.

Contohnya, jika data pertama dihapus, posisi data kedua akan bergeser menjadi index pertama. Oleh karena itu, ID lebih aman digunakan untuk mengidentifikasi data.

---

## Soal 9 — Persistensi Data Lokal (CPMK-3)

**Perbedaan in-memory dan persistensi menggunakan shared_preferences:**

- **In-memory:** Data disimpan sementara di memori selama aplikasi berjalan. Data dapat hilang ketika aplikasi ditutup atau dimulai ulang.
- **SharedPreferences:** Data disimpan secara lokal pada perangkat sehingga nilai yang disimpan dapat dibaca kembali setelah aplikasi dibuka ulang. Package ini cocok untuk data sederhana seperti pengaturan aplikasi, preferensi pengguna, atau status tertentu.

**Mengapa operasi shared_preferences asinkron (Future):**

Karena proses membaca dan menulis data melibatkan operasi penyimpanan perangkat yang tidak sebaiknya menghambat proses utama aplikasi. Oleh sebab itu, operasi tersebut menggunakan Future agar proses lain tetap dapat berjalan.

**Apa yang terjadi bila await diabaikan:**

Program tidak menunggu proses penyimpanan selesai sebelum melanjutkan ke instruksi berikutnya. Akibatnya, proses lain yang langsung membaca data dapat berjalan terlalu cepat, dan kesalahan penyimpanan juga dapat tidak ditangani dengan benar.

**Contoh situasi in-memory sudah cukup:**

Ketika membuat prototype aplikasi atau latihan CRUD sederhana yang hanya membutuhkan data sementara selama aplikasi berjalan, seperti contoh SI-FASKAM pada tahap awal pengembangan.

**Contoh situasi persistensi mutlak diperlukan:**

Ketika aplikasi menyimpan data penting seperti pengajuan surat mahasiswa, riwayat peminjaman buku, atau transaksi yang harus tetap tersedia meskipun aplikasi ditutup dan dibuka kembali.

Catatan: shared_preferences cocok untuk data sederhana, bukan sebagai database utama untuk menyimpan data transaksi yang kompleks.

---

## Soal 10 — Integrasi Konsep Lintas Pertemuan (CPMK-1 s.d. CPMK-3)

### 1. Arsitektur

Aplikasi mobile perpustakaan kampus digunakan oleh mahasiswa untuk melihat katalog buku dan melakukan peminjaman. Aplikasi terhubung dengan backend Sistem Informasi Perpustakaan melalui REST API.

Penyimpanan lokal dapat digunakan untuk menyimpan preferensi pengguna atau cache data katalog agar informasi tertentu tetap dapat ditampilkan dengan lebih cepat. Backend bertugas mengelola data utama seperti informasi buku, jumlah stok, data mahasiswa, dan transaksi peminjaman.

### 2. Kebutuhan dan Alur

**Dua kebutuhan Must Have:**

1. Mahasiswa dapat melihat katalog buku beserta informasi judul, penulis, dan ketersediaan buku.
2. Mahasiswa dapat mengajukan peminjaman buku dan mendapatkan informasi bahwa pengajuan berhasil dikirim.

**Alur Pengguna:**

1. Mahasiswa membuka aplikasi perpustakaan.
2. Aplikasi menampilkan halaman katalog buku.
3. Mahasiswa memilih buku yang ingin dipinjam.
4. Aplikasi menampilkan detail buku.
5. Mahasiswa menekan tombol Pinjam dan mengisi formulir peminjaman.
6. Mahasiswa mengirim formulir dan aplikasi memvalidasi data.
7. Sistem menyimpan pengajuan peminjaman dan menampilkan konfirmasi berhasil.

### 3. Struktur Komponen

**Halaman Katalog:**

- Menampilkan daftar buku menggunakan ListView.builder.
- Menyediakan kolom pencarian buku.
- Menampilkan informasi judul, penulis, dan ketersediaan buku.
- Menyediakan tombol untuk melihat detail dan melakukan peminjaman.

**Halaman Form Peminjaman:**

- Menampilkan informasi buku yang dipilih.
- Menyediakan formulir data peminjaman.
- Memiliki validasi agar data yang wajib diisi tidak kosong.
- Menyediakan tombol Kirim Peminjaman.

**Navigasi Antarhalaman:**

Navigasi dapat menggunakan Navigator.push() untuk berpindah dari katalog ke formulir peminjaman. Setelah formulir berhasil dikirim, aplikasi dapat menampilkan halaman konfirmasi. Navigator.pop() dapat digunakan untuk kembali ke halaman sebelumnya.

### 4. Data dan State

**Definisi Model Data Buku:**

| Field | Tipe Data | Keterangan |
|---|---|---|
| id | String | Identitas unik buku |
| judul | String | Nama atau judul buku |
| penulis | String | Nama penulis buku |
| kategori | String | Kategori buku |
| status | String | Ketersediaan buku |

**Cara Operasi Create dan Read Dikelola dalam State:**

- **Create (meminjam):** Ketika mahasiswa mengirim formulir peminjaman, aplikasi membuat data peminjaman baru dan mengirimkannya ke backend. Setelah berhasil, state diperbarui agar informasi pengajuan terbaru dapat ditampilkan.
- **Read (melihat riwayat):** Aplikasi mengambil data riwayat peminjaman dari backend melalui REST API, kemudian menampilkan data tersebut pada halaman riwayat menggunakan ListView.builder.

State dikelola menggunakan StatefulWidget dan setState() untuk memperbarui tampilan setelah data berubah. Untuk aplikasi yang sudah terhubung dengan backend, proses pengambilan dan pengiriman data dilakukan secara asinkron menggunakan Future.

