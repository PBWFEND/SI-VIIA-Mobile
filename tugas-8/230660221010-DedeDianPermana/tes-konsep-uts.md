# Tes Konsep UTS — Dede Dian Permana (230660221010)

## Soal 1 — Konsep Aplikasi Bergerak dalam SI

Tiga karakteristik aplikasi bergerak yang cocok untuk pengajuan surat keterangan mahasiswa adalah:

1. **Mobilitas dan akses di mana saja.** Aplikasi mobile dapat digunakan melalui smartphone tanpa harus datang langsung ke loket administrasi. Contohnya, mahasiswa dapat mengajukan surat keterangan aktif kuliah dari rumah atau tempat lain sehingga lebih menghemat waktu dan tenaga.
2. **Interaksi menggunakan layar sentuh dan fitur perangkat.** Aplikasi mobile mendukung interaksi sentuh serta penggunaan kamera dan penyimpanan berkas. Contohnya, mahasiswa dapat mengisi formulir dan mengunggah foto kartu mahasiswa sebagai dokumen pendukung langsung melalui smartphone.
3. **Konektivitas dan notifikasi.** Aplikasi mobile dapat terhubung dengan server melalui internet dan memberikan pemberitahuan kepada pengguna. Contohnya, mahasiswa menerima notifikasi ketika pengajuan surat telah disetujui atau siap diambil.

Solusi mobile lebih tepat karena proses pengajuan dan pengecekan surat dapat dilakukan secara fleksibel tanpa bergantung pada komputer desktop atau kehadiran langsung di loket administrasi.

## Soal 2 — Dasar Pemrograman Dart

- **List<String> daftarSurat = []:** Membuat sebuah daftar kosong yang hanya dapat menyimpan data bertipe String. Penggunaan tipe data ini menjaga agar seluruh data jenis surat memiliki tipe yang konsisten.
- **Parameter String jenis:** Menerima masukan berupa teks dari pemanggil fungsi. Parameter ini digunakan untuk menerima nama jenis surat yang akan ditambahkan ke dalam daftar.
- **jenis.isEmpty:** Memeriksa apakah teks yang dimasukkan kosong. Validasi ini diperlukan agar pengguna tidak dapat menambahkan jenis surat tanpa nama.
- **return pada kondisi error:** Menghentikan proses fungsi ketika ditemukan input yang tidak valid. Dengan demikian, program tidak melanjutkan proses penambahan data yang salah.
- **daftarSurat.add(jenis):** Menambahkan data jenis surat yang sudah lolos validasi ke bagian akhir List. Operasi ini termasuk proses Create dalam pengelolaan data.
- **Perulangan for:** Membaca setiap elemen dalam daftar satu per satu, misalnya untuk menampilkan seluruh jenis surat pada halaman aplikasi.

**Kesalahan umum bila validasi isEmpty dihapus:** pengguna dapat memasukkan teks kosong sehingga daftar memiliki data tanpa nama surat. Hal tersebut dapat membingungkan pengguna dan menyebabkan data yang ditampilkan menjadi tidak sesuai.

## Soal 3 — Struktur Flutter dan Widget

- **MaterialApp:** Menyediakan struktur utama aplikasi berbasis Material Design, termasuk konfigurasi tema, judul aplikasi, dan navigasi.
- **Scaffold:** Menyediakan kerangka dasar halaman, seperti AppBar dan body sebagai tempat menampilkan konten.
- **AppBar:** Menampilkan bagian atas halaman yang biasanya berisi judul dan tombol navigasi.
- **Column:** Menyusun beberapa widget secara vertikal, misalnya judul halaman, informasi singkat, dan daftar surat.
- **Text:** Menampilkan informasi berbentuk teks, seperti nama surat, keterangan, dan status pengajuan.
- **ListView.builder:** Menampilkan kumpulan data secara dinamis dan efisien karena item dibuat sesuai kebutuhan tampilan. Widget ini cocok untuk menampilkan banyak jenis surat.

**Masalah bila ListView.builder berada langsung di dalam Column tanpa Expanded:**

**Penyebab:** Column tidak memberikan batas tinggi yang jelas kepada ListView, sedangkan ListView membutuhkan ukuran tinggi tertentu untuk melakukan scrolling. Akibatnya dapat muncul error *Vertical viewport was given unbounded height*.

**Perbaikan:** Bungkus ListView.builder menggunakan Expanded atau Flexible agar mendapatkan batas ruang yang tersedia. Alternatif lainnya adalah menggunakan CustomScrollView apabila halaman membutuhkan beberapa bagian yang dapat digulir bersama.

## Soal 4 — Analisis Kebutuhan dan User Flow

Ketiga permintaan pada soal termasuk kebutuhan fungsional karena menjelaskan tindakan atau layanan yang harus disediakan oleh sistem. Kebutuhan nonfungsional lebih berkaitan dengan kualitas sistem, seperti keamanan, kecepatan, dan kemudahan penggunaan.

| No. | Permintaan | Fungsional/Nonfungsional | Prioritas MoSCoW | Alasan |
|:---:|---|---|:---:|---|
| 1 | Mengajukan surat keterangan aktif kuliah | Fungsional | Must | Merupakan fungsi utama aplikasi untuk menggantikan proses pengajuan surat secara manual. |
| 2 | Melihat status pengajuan | Fungsional | Must | Mahasiswa perlu mengetahui perkembangan pengajuan tanpa harus datang langsung ke loket. |
| 3 | Menerima notifikasi saat surat siap diambil | Fungsional | Should | Notifikasi mempermudah penyampaian informasi, tetapi pengguna masih dapat memeriksa status melalui aplikasi. |

**User flow untuk kebutuhan Must:**

1. Mahasiswa membuka aplikasi layanan pengajuan surat.
2. Sistem menampilkan halaman utama dan daftar jenis surat.
3. Mahasiswa memilih Surat Keterangan Aktif Kuliah.
4. Sistem menampilkan formulir pengajuan surat.
5. Mahasiswa mengisi data yang diperlukan.
6. Sistem memvalidasi data. Jika belum lengkap, sistem menampilkan pesan kesalahan. Jika lengkap, mahasiswa dapat mengirim pengajuan.
7. Sistem menyimpan data pengajuan dan menampilkan nomor serta status pengajuan kepada mahasiswa.

## Soal 5 — UI/UX Mobile

1. **Keterbacaan pada layar kecil.**  
   **Keputusan desain:** Menggunakan Card atau ListTile untuk menampilkan nama surat, deskripsi singkat, dan informasi penting dengan susunan yang konsisten.  
   **Alasan:** Layar smartphone memiliki ukuran terbatas sehingga informasi perlu disusun secara sederhana agar mahasiswa mudah menemukan satu dari 20 jenis surat.

2. **Interaksi sentuh yang nyaman.**  
   **Keputusan desain:** Menggunakan tombol dan item daftar dengan area sentuh yang cukup besar, sekitar 48 dp, serta jarak antaritem yang memadai.  
   **Alasan:** Area sentuh yang sesuai mengurangi kemungkinan salah tekan dan memudahkan pengguna mengoperasikan aplikasi menggunakan jari.

3. **Efisiensi penggunaan.**  
   **Keputusan desain:** Menambahkan fitur pencarian atau filter kategori pada bagian atas daftar surat.  
   **Alasan:** Mahasiswa biasanya menggunakan aplikasi untuk menyelesaikan kebutuhan tertentu dalam waktu singkat. Fitur pencarian membantu menemukan jenis surat tanpa harus menggulir seluruh daftar.

## Soal 6 — Navigasi dan Interaksi

**Metode navigasi dan kapan digunakan:**

- **push:** Digunakan untuk membuka halaman baru dan menyimpan halaman sebelumnya dalam navigation stack. Contohnya, dari halaman daftar surat menuju halaman form pengajuan.
- **pushNamed:** Digunakan untuk berpindah halaman berdasarkan nama route yang telah didaftarkan pada MaterialApp. Cara ini memudahkan pengelolaan navigasi ketika aplikasi memiliki banyak halaman.
- **pop:** Digunakan untuk menutup halaman yang sedang aktif dan kembali ke halaman sebelumnya, misalnya setelah pengguna membatalkan pengisian formulir.

**Pengiriman data jenis surat ke halaman form:**

Data jenis surat dapat dikirim melalui parameter konstruktor ketika halaman daftar memanggil Navigator.push. Misalnya, ketika mahasiswa memilih Surat Keterangan Aktif Kuliah, nama surat tersebut dikirim ke halaman form melalui parameter `jenisSurat`. Dengan demikian, halaman form dapat langsung menampilkan jenis surat yang dipilih tanpa meminta pengguna memilih ulang.

**Feedback setelah form dikirim:**

Sebelum data dikirim, sistem melakukan validasi untuk memastikan seluruh kolom wajib sudah diisi. Jika terdapat kesalahan, aplikasi menampilkan pesan validasi pada bagian yang belum benar. Jika pengajuan berhasil disimpan, aplikasi menampilkan SnackBar dengan pesan "Pengajuan surat berhasil dikirim" dan dapat mengarahkan mahasiswa ke halaman detail status.

## Soal 7 — Model Data dan State

**Mengapa setiap field bersifat final:**  
Field final membuat nilai pada objek PengajuanSurat tidak dapat diubah secara langsung setelah objek dibuat. Hal ini menjaga konsistensi data dan mengurangi perubahan yang tidak disengaja. Jika data perlu diperbarui, aplikasi dapat membuat objek baru dengan nilai yang sudah diperbaiki.

**Mengapa id wajib ada:**  
ID digunakan sebagai identitas unik untuk membedakan setiap data pengajuan. ID diperlukan agar proses update dan delete dapat dilakukan pada data yang tepat meskipun posisi data dalam daftar berubah.

**Perbedaan StatelessWidget dan StatefulWidget:**  
StatelessWidget digunakan untuk tampilan yang tidak menyimpan perubahan state secara lokal. StatefulWidget digunakan untuk tampilan yang datanya dapat berubah selama aplikasi berjalan dan membutuhkan pembaruan tampilan.

**Halaman daftar menggunakan: StatefulWidget.**

**Alasan:**  
Halaman daftar pengajuan lebih tepat menggunakan StatefulWidget karena data dapat bertambah, berubah, atau dihapus melalui interaksi pengguna. Dengan demikian, aplikasi dapat memperbarui daftar ketika terjadi perubahan data.

**Fungsi setState:**  
setState digunakan untuk memberi tahu Flutter bahwa terdapat perubahan pada state sehingga Flutter melakukan rebuild terhadap tampilan yang berkaitan dengan perubahan tersebut.

**Apa yang terjadi bila data ditambah tanpa setState:**  
Data mungkin berhasil ditambahkan ke dalam List di memori, tetapi tampilan tidak langsung diperbarui karena Flutter tidak diberi tahu mengenai perubahan tersebut. Akibatnya, pengguna belum tentu dapat melihat data baru sampai terjadi rebuild berikutnya.

## Soal 8 — CRUD Lokal

CRUD merupakan empat operasi dasar untuk mengelola data dalam aplikasi, yaitu Create, Read, Update, dan Delete.

| Operasi | Method List / mekanisme |
|:---|:---|
| Create | `add()` atau `insert()` untuk menambahkan data baru ke dalam List. |
| Read | Membaca data melalui List, perulangan, atau `ListView.builder` untuk menampilkan daftar. |
| Update | `indexWhere()` untuk mencari posisi data berdasarkan ID, kemudian mengganti objek menggunakan `list[index] = dataBaru`. |
| Delete | `removeWhere()` untuk menghapus data berdasarkan kondisi tertentu, misalnya ID. |

**Mengapa id digunakan sebagai kunci update dan delete:**  
ID digunakan karena setiap data memiliki identitas unik dan tetap meskipun urutan daftar berubah. Dengan ID, aplikasi dapat menemukan data yang tepat ketika melakukan perubahan atau penghapusan.

**Konsekuensi bila index digunakan sebagai kunci:**  
Index dapat berubah ketika data ditambahkan, dihapus, atau diurutkan. Akibatnya, aplikasi berisiko mengubah atau menghapus data yang salah karena posisi data tidak selalu tetap. Oleh karena itu, ID lebih tepat digunakan sebagai identitas data, sedangkan index hanya menunjukkan posisi sementara dalam List.

## Soal 9 — Persistensi Data Lokal

**Perbedaan in-memory dan persistensi:**  
In-memory merupakan penyimpanan data sementara di dalam memori aplikasi, misalnya menggunakan List atau state. Data tersebut dapat hilang ketika aplikasi ditutup atau proses aplikasi dihentikan. Sementara itu, persistensi menggunakan package shared_preferences memungkinkan data sederhana disimpan pada perangkat sehingga masih dapat dibaca ketika aplikasi dibuka kembali.

**Mengapa operasi shared_preferences asinkron (Future):**  
Operasi shared_preferences bersifat asinkron karena proses membaca dan menyimpan data membutuhkan akses ke media penyimpanan perangkat. Future memungkinkan proses tersebut berjalan tanpa harus memblokir aktivitas utama aplikasi sehingga tampilan tetap responsif.

**Apa yang terjadi bila await diabaikan:**  
Jika await tidak digunakan, program dapat melanjutkan proses berikutnya sebelum penyimpanan selesai. Akibatnya, ketika aplikasi langsung ditutup atau data dibaca kembali terlalu cepat, perubahan yang diharapkan mungkin belum tersedia. Oleh karena itu, await digunakan untuk menunggu penyelesaian operasi asinkron.

**Contoh situasi in-memory sudah cukup:**  
Penyimpanan in-memory cukup untuk prototipe CRUD atau daftar pilihan surat yang hanya digunakan sementara selama pengguna mengisi formulir dan tidak perlu dipertahankan setelah aplikasi ditutup.

**Contoh situasi persistensi mutlak diperlukan:**  
Persistensi diperlukan untuk menyimpan riwayat pengajuan surat, nomor pengajuan, dan status yang perlu tetap tersedia ketika mahasiswa membuka aplikasi kembali. Untuk data transaksi yang kompleks dan digunakan banyak pengguna, penyimpanan backend atau database lebih tepat daripada hanya mengandalkan shared_preferences.

## Soal 10 — Integrasi Konsep Lintas Pertemuan

Rancangan aplikasi yang dibuat adalah **SiPustaka Kampus**, yaitu aplikasi mobile untuk membantu mahasiswa mencari buku, melihat ketersediaan, dan melakukan peminjaman buku di perpustakaan kampus.

### 1. Arsitektur

Aplikasi SiPustaka Kampus menggunakan arsitektur client-server. Aplikasi mobile yang dibuat menggunakan Flutter berperan sebagai client untuk menampilkan katalog dan menerima pengajuan peminjaman. Backend Sistem Informasi Perpustakaan menyediakan REST API untuk memproses permintaan dan mengelola data pada database.

Penyimpanan lokal digunakan untuk menyimpan data sementara atau informasi sederhana yang diperlukan aplikasi. Sementara itu, database backend menyimpan data resmi seperti informasi buku, data mahasiswa, ketersediaan buku, dan transaksi peminjaman. Komunikasi antara aplikasi dan backend dilakukan menggunakan HTTP dengan format JSON sehingga data dapat dikelola secara terpusat.

### 2. Kebutuhan & Alur

**Dua kebutuhan Must Have:**

1. Mahasiswa dapat melihat dan mencari katalog buku beserta informasi judul, penulis, kategori, dan ketersediaannya. Fitur ini wajib karena menjadi kebutuhan utama untuk menemukan buku yang ingin dipinjam.
2. Mahasiswa dapat mengajukan peminjaman buku yang tersedia melalui aplikasi. Fitur ini wajib karena merupakan fungsi utama sistem untuk mempermudah proses peminjaman.

**Alur pengguna dari membuka aplikasi hingga tugas selesai:**

1. Mahasiswa membuka aplikasi SiPustaka Kampus.
2. Sistem menampilkan halaman utama dan katalog buku.
3. Mahasiswa mencari atau memilih buku yang diinginkan.
4. Sistem menampilkan detail buku dan status ketersediaannya.
5. Mahasiswa menekan tombol Pinjam jika buku tersedia.
6. Sistem menampilkan form peminjaman untuk diperiksa dan dilengkapi.
7. Mahasiswa mengirim formulir peminjaman.
8. Sistem memvalidasi data dan memeriksa ketersediaan buku. Jika buku tidak tersedia, sistem menampilkan pesan bahwa peminjaman tidak dapat dilakukan.
9. Jika data valid dan buku tersedia, sistem menyimpan transaksi dan menampilkan informasi bahwa peminjaman berhasil.

### 3. Struktur Komponen

**Halaman katalog:**  
Halaman katalog menggunakan Scaffold sebagai kerangka utama, AppBar untuk menampilkan judul aplikasi, TextField untuk pencarian, serta ListView.builder untuk menampilkan daftar buku. Setiap buku ditampilkan menggunakan Card atau ListTile yang berisi judul, penulis, kategori, dan status ketersediaan.

**Halaman form peminjaman:**  
Halaman form menggunakan Scaffold, AppBar, Form, TextFormField, dan ElevatedButton. Form digunakan untuk menerima data peminjaman, sedangkan TextFormField digunakan untuk mengisi informasi yang diperlukan. Validasi dilakukan untuk memastikan data lengkap sebelum dikirim.

**Navigasi antarhalaman:**  
Navigator.push digunakan untuk berpindah dari halaman katalog menuju halaman detail atau form peminjaman. Data buku yang dipilih dikirim melalui parameter konstruktor agar form mengetahui buku yang akan dipinjam. Navigator.pop digunakan untuk kembali ke halaman sebelumnya setelah proses selesai atau dibatalkan.

### 4. Data & State

**Definisi model data Buku:**

```dart
class Buku {
  final String id;
  final String judul;
  final String penulis;
  final String kategori;
  final bool tersedia;

  Buku({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.kategori,
    required this.tersedia,
  });
}
```

Penjelasan field:

- `id`: Identitas unik setiap buku.
- `judul`: Nama atau judul buku.
- `penulis`: Nama penulis buku.
- `kategori`: Kelompok atau jenis buku.
- `tersedia`: Menunjukkan apakah buku dapat dipinjam.

**Cara operasi Create dan Read dikelola dalam state:**

Operasi Create dilakukan ketika mahasiswa mengajukan peminjaman buku. Sistem membuat objek transaksi peminjaman baru, kemudian menambahkannya ke dalam List menggunakan method `add()` di dalam `setState()`. Dengan demikian, tampilan dapat diperbarui setelah data baru ditambahkan.

Operasi Read digunakan untuk membaca dan menampilkan katalog buku serta riwayat peminjaman. Data yang tersimpan dalam List ditampilkan menggunakan ListView.builder sehingga setiap buku dan transaksi dapat ditampilkan secara dinamis.

