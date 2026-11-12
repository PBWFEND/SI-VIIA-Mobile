# Tes Konsep UTS — Amelia Oktaviani 230660221127

## Soal 1 — Konsep Aplikasi Bergerak dalam SI

Tiga karakteristik aplikasi bergerak yang menjadikan solusi mobile tepat untuk layanan pengajuan surat keterangan mahasiswa adalah:

**1. Portabilitas dan mobilitas**

Aplikasi mobile dapat digunakan melalui smartphone yang mudah dibawa ke berbagai tempat. Pengguna tidak harus berada di depan komputer atau datang langsung ke loket administrasi.

Contoh penerapan: Mahasiswa dapat membuka aplikasi pengajuan surat melalui smartphone dari rumah, tempat tinggal, atau lingkungan kampus untuk mengajukan surat keterangan aktif kuliah.

**2. Aksesibilitas kapan saja dan di mana saja**

Aplikasi mobile memungkinkan pengguna mengakses layanan selama perangkat memiliki koneksi internet dan layanan tersedia. Hal ini membuat proses pengajuan lebih fleksibel dibandingkan layanan yang hanya dapat dilakukan di loket pada jam operasional tertentu.

Contoh penerapan: Mahasiswa dapat mengisi formulir pengajuan surat pada malam hari tanpa harus menunggu loket administrasi dibuka.

**3. Integrasi dengan fitur perangkat mobile**

Aplikasi mobile dapat memanfaatkan fitur smartphone, seperti kamera, penyimpanan berkas, dan notifikasi. Integrasi tersebut dapat membantu proses pengajuan dan penyampaian informasi kepada mahasiswa.

Contoh penerapan: Mahasiswa dapat memotret atau mengunggah dokumen persyaratan melalui smartphone. Setelah surat selesai diproses, aplikasi dapat mengirimkan notifikasi bahwa surat sudah siap diambil atau diunduh.

## Soal 2 — Dasar Pemrograman Dart

- **List<String> daftarSurat = []:**

  Merupakan deklarasi variabel daftarSurat yang menggunakan tipe data List untuk menyimpan kumpulan data berupa String. Tanda `[]` menunjukkan bahwa list masih kosong ketika pertama kali dibuat. Contohnya, list dapat digunakan untuk menyimpan nama-nama jenis surat yang tersedia.

- **Parameter String jenis:**

  Merupakan parameter pada fungsi yang menerima nilai berupa teks dengan tipe data String. Parameter ini digunakan untuk menerima jenis surat yang dipilih atau dimasukkan oleh pengguna.

- **jenis.isEmpty:**

  Merupakan pemeriksaan untuk mengetahui apakah sebuah String kosong atau tidak. Jika nilainya kosong, hasilnya adalah true. Pemeriksaan ini digunakan untuk memastikan bahwa pengguna tidak mengirimkan data jenis surat yang kosong.

- **return pada kondisi error:**

  Digunakan untuk menghentikan proses fungsi ketika ditemukan kesalahan atau input tidak memenuhi ketentuan. Dengan demikian, program tidak melanjutkan proses penyimpanan data yang tidak valid.

- **daftarSurat.add(jenis):**

  Merupakan method `add()` pada List yang digunakan untuk menambahkan data baru ke bagian akhir daftarSurat. Dalam kasus ini, jenis surat yang sudah dinyatakan valid akan dimasukkan ke dalam list.

- **Perulangan for:**

  Digunakan untuk menjalankan suatu proses secara berulang terhadap setiap elemen dalam kumpulan data. Contohnya, perulangan for dapat digunakan untuk menampilkan seluruh jenis surat yang tersimpan dalam daftarSurat.

**Kesalahan umum bila validasi isEmpty dihapus:**

Jika validasi `isEmpty` dihapus, pengguna dapat mengirimkan data kosong sebagai jenis surat. Akibatnya, list dapat berisi data yang tidak memiliki informasi berguna. Hal tersebut dapat menyebabkan kesalahan ketika data ditampilkan atau diproses lebih lanjut.

## Soal 3 — Struktur Flutter dan Widget

- **MaterialApp:**

  Merupakan widget utama yang menyediakan struktur dasar aplikasi berbasis Material Design. Widget ini mengatur konfigurasi aplikasi, seperti tema, judul, dan navigasi antarhalaman.

- **Scaffold:**

  Menyediakan struktur dasar satu halaman aplikasi, seperti area AppBar, body, dan komponen lainnya. Dengan Scaffold, tampilan halaman dapat disusun secara teratur.

- **AppBar:**

  Merupakan bagian atas halaman yang biasanya digunakan untuk menampilkan judul halaman dan tombol navigasi. Pada aplikasi pengajuan surat, AppBar dapat menampilkan judul "Daftar Surat".

- **Column:**

  Digunakan untuk menyusun beberapa widget secara vertikal dari atas ke bawah. Contohnya, judul halaman dapat ditempatkan di atas daftar jenis surat.

- **Text:**

  Digunakan untuk menampilkan informasi berbentuk teks, seperti judul, nama surat, petunjuk, dan keterangan lainnya.

- **ListView.builder:**

  Digunakan untuk menampilkan daftar data secara dinamis. Widget ini membangun item sesuai kebutuhan berdasarkan jumlah data yang tersedia. Pada halaman daftar surat, widget ini dapat digunakan untuk menampilkan 20 jenis surat.

**Masalah bila ListView.builder berada di dalam Column tanpa Expanded:**

Masalah yang dapat terjadi adalah munculnya error terkait tinggi atau batas ruang yang tidak jelas (*unbounded height*). Hal ini karena Column memberikan ruang vertikal yang tidak terbatas kepada ListView, sedangkan ListView membutuhkan batas tinggi untuk menentukan area penggulirannya.

**Penyebab:**

Column dan ListView sama-sama mengatur tata letak secara vertikal. Ketika ListView berada langsung di dalam Column tanpa batas tinggi yang jelas, Flutter tidak dapat menentukan ruang yang tersedia untuk ListView.

**Perbaikan:**

Gunakan widget Expanded untuk memberikan sisa ruang yang tersedia kepada ListView.

Contoh:

```dart
Column(
  children: [
    const Text('Daftar Jenis Surat'),
    Expanded(
      child: ListView.builder(
        itemCount: daftarSurat.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(daftarSurat[index]),
          );
        },
      ),
    ),
  ],
)
```

Dengan Expanded, ListView mendapatkan batas tinggi yang jelas dan dapat melakukan scrolling dengan baik.

## Soal 4 — Analisis Kebutuhan dan User Flow

**Klasifikasi dan prioritas:**

Ketiga permintaan tersebut termasuk kebutuhan fungsional karena masing-masing menjelaskan fitur atau layanan yang harus disediakan oleh sistem. Tidak ada permintaan nonfungsional yang dinyatakan secara langsung dalam ketiga pernyataan tersebut.

| No. | Permintaan | Fungsional/Nonfungsional | Prioritas MoSCoW | Alasan |
|:---:|:---|:---|:---:|:---|
| 1 | Mengajukan surat keterangan aktif kuliah | Fungsional | Must Have | Merupakan fungsi utama aplikasi. Tanpa fitur ini, mahasiswa tidak dapat melakukan pengajuan surat. |
| 2 | Melihat status pengajuan | Fungsional | Must Have | Mahasiswa membutuhkan informasi perkembangan pengajuan untuk mengetahui apakah permohonan sedang diproses, disetujui, atau ditolak. |
| 3 | Menerima notifikasi saat surat siap diambil | Fungsional | Should Have | Fitur ini membantu mahasiswa mengetahui bahwa surat telah selesai, tetapi informasi tersebut masih dapat diperoleh melalui halaman status pengajuan. |

**User flow untuk kebutuhan Must Have:**

1. Mahasiswa membuka aplikasi pengajuan surat.
2. Mahasiswa melakukan login menggunakan akun yang dimiliki.
3. Mahasiswa memilih menu pengajuan surat.
4. Mahasiswa memilih jenis surat keterangan aktif kuliah.
5. Mahasiswa mengisi formulir dan melengkapi persyaratan.
6. Mahasiswa menekan tombol kirim dan sistem memvalidasi data.
7. Sistem menyimpan pengajuan dan menampilkan konfirmasi bahwa pengajuan berhasil dikirim.

Setelah pengajuan berhasil, mahasiswa dapat membuka halaman status pengajuan untuk melihat perkembangan permohonannya.

## Soal 5 — UI/UX Mobile

Tiga prinsip UI/UX mobile yang perlu diperhatikan pada halaman daftar 20 jenis surat adalah:

**1. Kesederhanaan dan keterbacaan tampilan**

Keputusan desain: Menggunakan tampilan daftar yang sederhana dengan nama surat dan keterangan singkat. Setiap jenis surat ditampilkan dalam bentuk Card atau ListTile.

Alasan: Ukuran layar smartphone relatif terbatas. Tampilan yang sederhana membantu mahasiswa menemukan jenis surat yang dibutuhkan tanpa harus membaca terlalu banyak informasi.

**2. Kemudahan interaksi sentuh**

Keputusan desain: Menggunakan tombol dan area pilihan yang cukup besar serta memberikan jarak antaritem agar mudah disentuh.

Alasan: Pengguna berinteraksi menggunakan jari, bukan mouse seperti pada komputer. Area sentuh yang cukup besar dapat mengurangi kesalahan ketika memilih jenis surat.

**3. Efisiensi penggunaan dan navigasi**

Keputusan desain: Menyediakan fitur pencarian atau kategori surat, serta menggunakan navigasi yang sederhana dari daftar menuju formulir pengajuan.

Alasan: Dengan 20 jenis surat, pengguna mungkin membutuhkan waktu untuk menemukan pilihan yang tepat. Fitur pencarian membantu mempercepat proses dan mengurangi langkah yang tidak diperlukan, terutama ketika pengguna hanya memiliki waktu singkat untuk menggunakan aplikasi.

## Soal 6 — Navigasi dan Interaksi

**Metode navigasi dan kapan digunakan:**

- **push:**

  Digunakan untuk membuka halaman baru dengan memberikan objek Route secara langsung. Contohnya, membuka halaman form pengajuan dari halaman daftar surat menggunakan `MaterialPageRoute`.

- **pushNamed:**

  Digunakan untuk berpindah halaman berdasarkan nama rute yang telah didaftarkan pada MaterialApp. Contohnya, membuka halaman detail status dengan rute `/detail-status`.

- **pop:**

  Digunakan untuk menutup halaman yang sedang terbuka dan kembali ke halaman sebelumnya. Contohnya, kembali dari halaman form ke halaman daftar surat setelah pengguna membatalkan pengajuan.

Contoh alur navigasi:

```dart
// Membuka halaman form menggunakan push
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const HalamanFormPengajuan(),
  ),
);

// Membuka halaman detail status menggunakan pushNamed
Navigator.pushNamed(
  context,
  '/detail-status',
);

// Kembali ke halaman sebelumnya
Navigator.pop(context);
```

**Pengiriman data jenis surat ke halaman form:**

Data jenis surat dapat dikirim melalui constructor ketika menggunakan `Navigator.push`, atau melalui parameter `arguments` ketika menggunakan `Navigator.pushNamed`.

Contoh menggunakan constructor:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => HalamanFormPengajuan(
      jenisSurat: 'Surat Keterangan Aktif Kuliah',
    ),
  ),
);
```

Pada halaman form, data tersebut diterima melalui constructor dan ditampilkan sebagai jenis surat yang sedang diajukan. Dengan demikian, mahasiswa tidak perlu memilih ulang jenis surat.

**Feedback setelah form dikirim:**

Sistem terlebih dahulu memvalidasi data menggunakan `Form` dan `GlobalKey<FormState>`. Jika data belum lengkap, sistem menampilkan pesan kesalahan pada kolom yang perlu diperbaiki. Jika data valid, sistem menyimpan pengajuan dan memberikan umpan balik menggunakan `SnackBar`, misalnya "Pengajuan surat berhasil dikirim".

Feedback diperlukan agar pengguna mengetahui hasil dari tindakan yang telah dilakukan.

## Soal 7 — Model Data dan State

**Mengapa setiap field bersifat final:**

Field pada model `PengajuanSurat` dibuat menggunakan `final` agar nilainya hanya dapat ditetapkan satu kali setelah objek dibuat. Hal ini membantu menjaga konsistensi data dan mencegah perubahan nilai secara langsung yang tidak terkontrol.

Jika terdapat perubahan data, aplikasi dapat membuat objek baru dengan nilai yang telah diperbarui. Pendekatan ini membuat pengelolaan data lebih teratur.

**Mengapa id wajib ada:**

ID digunakan sebagai identitas unik untuk setiap data pengajuan surat. Dengan adanya ID, sistem dapat membedakan satu pengajuan dengan pengajuan lainnya, meskipun memiliki nama mahasiswa atau jenis surat yang sama.

ID juga mempermudah proses pencarian, pembaruan, dan penghapusan data tertentu tanpa bergantung pada posisi data di dalam daftar.

**Perbedaan StatelessWidget dan StatefulWidget:**

- `StatelessWidget` merupakan widget yang tidak memiliki state internal yang berubah selama siklus hidup widget tersebut. Widget ini cocok untuk tampilan yang tidak membutuhkan perubahan data secara langsung.
- `StatefulWidget` merupakan widget yang memiliki state yang dapat berubah selama aplikasi berjalan. Widget ini cocok untuk tampilan yang datanya dapat diperbarui melalui interaksi pengguna.

**Halaman daftar menggunakan StatefulWidget.**

Alasan: Halaman daftar pengajuan perlu menampilkan perubahan data ketika terdapat pengajuan baru, perubahan status, atau penghapusan data. StatefulWidget memungkinkan aplikasi memperbarui tampilan berdasarkan perubahan state.

**Fungsi setState:**

`setState()` digunakan untuk memberi tahu Flutter bahwa terdapat perubahan pada state sehingga widget perlu dibangun ulang (*rebuild*) untuk menampilkan data terbaru.

Contohnya, ketika mahasiswa menambahkan pengajuan baru ke dalam list, `setState()` dipanggil agar daftar pengajuan langsung diperbarui.

**Apa yang terjadi bila data ditambah tanpa setState:**

Data mungkin sudah berubah di dalam variabel List, tetapi tampilan belum tentu diperbarui secara langsung. Hal ini terjadi karena Flutter tidak mendapatkan pemberitahuan bahwa state telah berubah. Akibatnya, pengguna mungkin tidak langsung melihat data baru sampai terjadi proses rebuild karena hal lain.

## Soal 8 — CRUD Lokal

CRUD merupakan empat operasi dasar dalam pengelolaan data, yaitu Create, Read, Update, dan Delete.

| Operasi | Method List / mekanisme |
|:---|:---|
| Create | `add()` untuk menambahkan data baru ke dalam List. |
| Read | Mengakses elemen menggunakan perulangan `for`, `forEach()`, atau `ListView.builder` untuk menampilkan data. |
| Update | Mencari data menggunakan `indexWhere()`, kemudian mengganti elemen pada posisi yang ditemukan menggunakan `list[index] = dataBaru`. |
| Delete | `removeWhere()` untuk menghapus data berdasarkan kondisi tertentu, misalnya ID. |

**Mengapa id digunakan sebagai kunci update dan delete:**

ID digunakan sebagai kunci karena setiap data memiliki identitas unik dan tetap. Dengan menggunakan ID, aplikasi dapat menemukan data yang tepat meskipun urutan elemen di dalam List berubah.

Contohnya, aplikasi dapat mencari pengajuan dengan ID tertentu sebelum memperbarui atau menghapusnya.

**Konsekuensi bila index digunakan sebagai kunci:**

Index menunjukkan posisi data di dalam List, bukan identitas tetap suatu data. Jika terdapat penambahan atau penghapusan elemen, posisi data lainnya dapat berubah.

Akibatnya, aplikasi berisiko memperbarui atau menghapus data yang salah apabila masih menggunakan index lama. Oleh karena itu, ID lebih tepat digunakan sebagai identitas data, sedangkan index hanya digunakan sebagai posisi elemen dalam List.

## Soal 9 — Persistensi Data Lokal

**Perbedaan in-memory dan persistensi:**

In-memory merupakan penyimpanan data sementara di dalam memori aplikasi, misalnya menggunakan List. Data hanya tersedia selama aplikasi berjalan. Ketika aplikasi ditutup atau dimulai ulang, data dapat hilang.

Sementara itu, persistensi menggunakan penyimpanan lokal seperti `shared_preferences` agar data tertentu tetap tersimpan meskipun aplikasi ditutup dan dibuka kembali.

Contohnya, data sementara daftar barang dalam aplikasi Penjualan Warung dapat disimpan menggunakan List, sedangkan pengaturan tema atau preferensi pengguna dapat disimpan menggunakan shared_preferences.

**Mengapa operasi shared_preferences asinkron (Future):**

Operasi penyimpanan dapat membutuhkan waktu karena aplikasi harus berkomunikasi dengan media penyimpanan perangkat. Proses tersebut tidak selalu selesai secara langsung.

Oleh karena itu, operasi seperti membaca dan menyimpan data menggunakan `Future` agar aplikasi dapat menunggu hasil operasi tanpa harus menghentikan seluruh proses aplikasi.

**Apa yang terjadi bila await diabaikan:**

Jika `await` tidak digunakan ketika hasil operasi penyimpanan perlu dipastikan selesai, program dapat melanjutkan proses berikutnya sebelum penyimpanan selesai. Hal ini dapat menyebabkan data belum tersedia ketika langsung dibaca kembali atau proses lain bergantung pada hasil penyimpanan tersebut.

Contoh penggunaan:

```dart
final prefs = await SharedPreferences.getInstance();

await prefs.setString('nama_pengguna', 'Amelia');

final nama = prefs.getString('nama_pengguna');
```

Pada contoh tersebut, `await` memastikan proses mendapatkan instance dan menyimpan data telah selesai sebelum proses berikutnya dijalankan.

**Contoh situasi in-memory sudah cukup:**

In-memory sudah cukup untuk menyimpan data sementara selama demonstrasi aplikasi atau prototipe CRUD lokal sederhana. Contohnya, daftar barang pada aplikasi Penjualan Warung yang digunakan untuk menguji fitur tambah, lihat, edit, dan hapus selama aplikasi berjalan.

**Contoh situasi persistensi mutlak diperlukan:**

Persistensi diperlukan ketika aplikasi harus mempertahankan data penting setelah aplikasi ditutup. Contohnya, aplikasi pengajuan surat mahasiswa harus menyimpan informasi pengajuan agar mahasiswa tetap dapat melihat status permohonan setelah keluar dari aplikasi. Untuk kebutuhan sistem yang digunakan banyak pengguna, data utama juga perlu disimpan pada backend atau database server, bukan hanya shared_preferences.

## Soal 10 — Integrasi Konsep Lintas Pertemuan

**1. Arsitektur**

Aplikasi mobile digunakan sebagai antarmuka bagi mahasiswa untuk mengakses layanan perpustakaan kampus. Aplikasi berkomunikasi dengan backend Sistem Informasi melalui REST API untuk mengambil dan mengirim data.

Penyimpanan lokal digunakan untuk menyimpan data sementara atau informasi tertentu yang diperlukan agar aplikasi lebih responsif. Sementara itu, backend bertanggung jawab mengelola data utama, seperti data buku, akun mahasiswa, dan transaksi peminjaman.

Hubungannya adalah sebagai berikut:

```text
Mahasiswa
    |
    v
Aplikasi Mobile Flutter
    |
    | HTTP Request / Response
    v
Backend Sistem Informasi
    |
    v
Database Perpustakaan

Aplikasi Mobile
    |
    v
Penyimpanan Lokal
```

Dengan arsitektur tersebut, mahasiswa dapat menggunakan aplikasi untuk mencari buku dan melakukan peminjaman, sedangkan pengelolaan data utama dilakukan oleh backend.

**2. Kebutuhan & Alur**

Dua kebutuhan Must Have:

- **F-01: Melihat katalog buku.** Mahasiswa dapat melihat daftar buku beserta judul, penulis, dan ketersediaan buku.
- **F-02: Melakukan peminjaman buku.** Mahasiswa dapat memilih buku yang tersedia dan mengirimkan permintaan peminjaman melalui aplikasi.

Alur pengguna dari membuka aplikasi hingga tugas selesai:

1. Mahasiswa membuka aplikasi perpustakaan dan melakukan login.
2. Mahasiswa masuk ke halaman katalog buku.
3. Mahasiswa mencari dan memilih buku yang ingin dipinjam.
4. Aplikasi menampilkan detail buku dan informasi ketersediaannya.
5. Mahasiswa menekan tombol pinjam dan mengisi formulir peminjaman.
6. Sistem memvalidasi permintaan dan mengirimkannya ke backend.
7. Backend menyimpan transaksi peminjaman dan aplikasi menampilkan konfirmasi bahwa permintaan berhasil dikirim.

**3. Struktur Komponen**

Halaman yang dibutuhkan:

- **Halaman Katalog:** Menampilkan daftar buku menggunakan ListView.builder. Setiap item dapat menampilkan judul, penulis, dan status ketersediaan buku.
- **Halaman Detail Buku:** Menampilkan informasi lengkap buku yang dipilih serta tombol untuk melakukan peminjaman.
- **Halaman Form Peminjaman:** Menampilkan formulir untuk mengisi informasi peminjaman dan mengirimkan permintaan.

Navigasi antarhalaman menggunakan Navigator. `Navigator.push` digunakan untuk membuka halaman detail buku atau formulir peminjaman, sedangkan `Navigator.pop` digunakan untuk kembali ke halaman sebelumnya setelah pengguna selesai atau membatalkan proses.

**4. Data & State**

Model data Buku minimal memiliki empat field sebagai berikut:

```dart
class Buku {
  final String id;
  final String judul;
  final String penulis;
  final String kategori;
  final bool tersedia;

  const Buku({
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
- `kategori`: Kategori buku, misalnya teknologi atau ekonomi.
- `tersedia`: Menunjukkan apakah buku dapat dipinjam.

**Pengelolaan operasi Create dan Read:**

Operasi Create digunakan ketika mahasiswa mengirimkan permintaan peminjaman buku. Data peminjaman dapat dibuat menjadi objek baru, kemudian ditambahkan ke dalam List menggunakan `add()` pada state halaman atau dikirim ke backend melalui REST API.

Operasi Read digunakan untuk menampilkan data buku dan riwayat peminjaman. Data dapat dibaca dari List menggunakan perulangan atau ditampilkan menggunakan ListView.builder.

Untuk memperbarui tampilan setelah terjadi perubahan data lokal, aplikasi menggunakan `setState()`. Jika data berasal dari backend, aplikasi mengambil kembali data melalui REST API dan memperbarui state berdasarkan hasil respons server.

Dengan demikian, aplikasi dapat menampilkan katalog buku, menerima permintaan peminjaman, dan memperlihatkan riwayat transaksi secara terstruktur.