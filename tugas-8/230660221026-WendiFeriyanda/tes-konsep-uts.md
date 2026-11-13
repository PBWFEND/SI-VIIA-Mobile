# TES KONSEP UJIAN TENGAH SEMESTER
## PEMROGRAMAN APLIKASI BERGERAK (PAB)

**Disusun oleh:** Wendi Feriyanda  
**NIM:** 230660221026  
**Kelas:** SI-VIIA  
**Universitas:** Universitas Sebelas April  
**Tahun:** 2026
---
## Soal 1 — Karakteristik Aplikasi Bergerak dalam Sistem Informasi

### 1. Akses fitur bawaan perangkat

**Karakteristik:** Aplikasi mobile dapat mengakses fitur bawaan perangkat seperti kamera, pemindai dokumen (*document scanner*), dan sistem penyimpanan lokal secara mulus tanpa memerlukan perangkat tambahan (seperti scanner terpisah yang biasa dibutuhkan pada komputer desktop).

**Contoh penerapan:** Saat mengajukan surat keterangan aktif kuliah untuk keperluan beasiswa atau tunjangan orang tua, mahasiswa sering kali diminta melampirkan Kartu Tanda Mahasiswa (KTM) atau slip pembayaran SPP terbaru. Melalui aplikasi mobile, mahasiswa dapat langsung memotret dokumen tersebut menggunakan kamera ponsel, melakukan crop otomatis, dan mengunggahnya secara instan ke sistem tanpa harus memindahkan berkas dari kamera ke komputer terlebih dahulu.

### 2. Konektivitas dan notifikasi

**Karakteristik:** Smartphone selalu aktif terhubung dengan jaringan internet (*always-on*) dan dilengkapi sistem notifikasi push yang langsung muncul di layar utama pengguna, membuat komunikasi dua arah menjadi instan tanpa perlu membuka ulang halaman web secara manual (*refresh*).

**Contoh penerapan:** Pada sistem konvensional (datang ke loket atau web desktop), mahasiswa harus bolak-balik memeriksa status pengajuan secara berkala. Dengan aplikasi mobile, ketika petugas administrasi menyetujui surat atau surat keterangan telah selesai dicetak secara digital (berupa *e-certificate* dengan tanda tangan elektronik), sistem akan langsung mengirimkan notifikasi push ke layar ponsel mahasiswa (contoh: "Surat Keterangan Aktif Kuliah Anda telah disetujui dan dapat diunduh"), sehingga efisiensi waktu tercapai secara optimal.

### 3. Portabilitas

**Karakteristik:** Perangkat mobile bersifat portabel dan selalu dibawa oleh pengguna ke mana saja. Hal ini menghilangkan hambatan geografis dan ketergantungan pada perangkat stasioner (seperti komputer lab atau laptop pribadi di meja).

**Contoh penerapan:** Mahasiswa yang sedang berada di luar kampus, dalam perjalanan, atau sedang melaksanakan magang/KKL (Kuliah Kerja Lapangan) tetap dapat mengajukan surat keterangan kapan saja (24/7) langsung dari genggaman tangan mereka. Mereka tidak perlu lagi izin datang ke kampus hanya untuk mengambil formulir fisik dan mengantre di loket administrasi pada jam kerja tertentu.

---

## Soal 2 — Dasar Pemrograman Dart

### 1. Fungsi setiap bagian kode

- **`List<String>`**
  - **Fungsi:** Mendefinisikan sebuah struktur data koleksi (*list*) bernama `daftarSurat` yang secara khusus dibatasi hanya untuk menampung kumpulan elemen data bertipe teks (`String`).
- **Parameter `String jenis`**
  - **Fungsi:** Variabel masukan yang diterima oleh fungsi `tambahSurat` untuk membawa nilai teks (jenis surat) yang dikirim dari luar saat fungsi tersebut dipanggil.
- **`isEmpty`**
  - **Fungsi:** Properti pengecekan bawaan (*getter*) bertipe boolean untuk memeriksa apakah teks di dalam variabel `jenis` sedang dalam keadaan kosong (`""`) atau tidak memiliki karakter.
- **`return` pada kondisi error**
  - **Fungsi:** Menghentikan eksekusi fungsi `tambahSurat` secara langsung ketika kondisi error terpenuhi (saat `jenis` kosong), sehingga baris kode di bawahnya (`add`) tidak akan dijalankan.
- **`add`**
  - **Fungsi:** Metode bawaan kelas `List` di Dart untuk memasukkan elemen baru (`jenis`) ke posisi paling akhir dari *list* `daftarSurat`.
- **Perulangan `for` (*For Loop*)**
  - **Fungsi:** Mengiterasi atau menelusuri seluruh elemen di dalam `daftarSurat` satu per satu dari indeks `0` hingga akhir (`length - 1`) untuk dicetak ke konsol secara berurutan.

### 2. Kesalahan umum jika validasi `isEmpty` dihapus

Jika validasi `jenis.isEmpty` dihapus, kesalahan umum yang akan terjadi adalah **masuknya data kosong (*empty string* / string hampa) ke dalam sistem**.

Ketika fungsi dipanggil tanpa mengisi parameter (misalnya `tambahSurat('')`), program akan tetap mengeksekusi baris `daftarSurat.add(jenis)` tanpa hambatan. Akibatnya:

1. **Pencatatan Data Rusak (*Corrupted Data*):** *List* akan menyimpan data kosong yang ketika dicetak oleh fungsi `tampilkanSurat()` akan memunculkan baris bernomor tanpa isi teks (contoh: `"2. "` saja).
2. **Cacat Logika Aplikasi:** Hal ini merusak integritas data pengajuan surat di sistem administrasi kampus karena entri permohonan yang tidak valid tetap tersimpan sebagai data sah.

---

## Soal 3 — Struktur Flutter dan Widget

### 1. Fungsi setiap widget

- **`MaterialApp`**
  - **Fungsi:** Widget akar (*root widget*) yang membungkus seluruh aplikasi. Widget ini mengonfigurasi komponen dasar material design seperti navigasi dasar, tema warna, lokalisasi, dan pengelolaan *title* aplikasi secara global.
- **`Scaffold`**
  - **Fungsi:** Kerangka dasar tata letak visual standar Material Design (*Material Design layout structure*). Widget ini menyediakan struktur kerangka layar seperti area untuk `appBar`, `body`, `drawer`, `floatingActionButton`, dan bagian bawah layar.
- **`AppBar`**
  - **Fungsi:** Widget bilah aplikasi bagian atas (*header*). Biasanya digunakan untuk menampilkan judul halaman (`'Daftar Surat'`), tombol navigasi kembali, atau ikon aksi (*actions*) di sebelah kanan.
- **`Column`**
  - **Fungsi:** Widget tata letak fleksibel (*flex layout*) yang menyusun anak-anak widgetnya (`children`) secara **vertikal** (dari atas ke bawah).
- **`Text`**
  - **Fungsi:** Widget untuk menampilkan sebaris teks pendek dengan gaya tertentu (seperti label instruksi `'Pilih jenis surat'`).
- **`ListView.builder`**
  - **Fungsi:** Widget penampil daftar gulir (*scrollable list*) yang dibuat secara dinamis dan efisien. Menggunakan pola *lazy loading*, widget ini hanya merender item yang sedang tampak di layar, sehingga sangat optimal untuk daftar data yang panjang atau dinamis.

### 2. Masalah jika `ListView.builder` diletakkan langsung di dalam `Column` tanpa `Expanded`

#### Penyebab masalah (*Conflict Layout*)

Secara bawaan (*default*), `Column` mencoba mengukur ukuran anak-anaknya secara vertikal berdasarkan tinggi alami mereka (*intrinsic height*). Di sisi lain, sebuah `ListView` di dalam Flutter dirancang untuk **mengambil seluruh ruang vertikal yang tersedia** (*unbounded height* / tinggi tak terbatas).

Ketika `ListView.builder` diletakkan langsung di dalam `Column` tanpa pembatas ukuran (seperti `Expanded` atau `Flexible`), Flutter mengalami kebingungan (*layout conflict*):

1. `Column` berkata kepada `ListView`: *"Gunakan tinggi sesuai isi datamu."*
2. `ListView` berkata kepada `Column`: *"Aku butuh ruang seluas mungkin yang tersisa di layar."*

Karena kedua aturan ini saling bertentangan dan tidak ada batasan ukuran pasti yang diberikan, aplikasi akan mengalami *runtime exception* yang memicu layar error merah bertuliskan: **`Vertical viewport was given unbounded height`**.

#### Cara memperbaikinya

Ada dua cara utama untuk mengatasi masalah ini tergantung pada desain UI yang diinginkan:

1. **Menggunakan `Expanded` (paling umum):** Membungkus `ListView.builder` dengan widget `Expanded`. Ini menginstruksikan `Column` agar memberikan seluruh sisa ruang vertikal yang tersisa di layar kepada `ListView.builder`.

   ```dart
   Column(
     children: [
       Text('Pilih jenis surat'),
       Expanded(
         child: ListView.builder(...),
       ),
     ],
   )
   ```

2. **Menggunakan properti `shrinkWrap` dan `physics` (jika daftar pendek):** Jika tinggi daftar menyesuaikan isi datanya dan ingin digulir bersama elemen lain dalam satu halaman, atur `shrinkWrap: true` dan matikan fungsi *scroll* bawaan `ListView` tersebut.

   ```dart
   Column(
     children: [
       Text('Pilih jenis surat'),
       ListView.builder(
         shrinkWrap: true,
         physics: NeverScrollableScrollPhysics(),
         ...,
       ),
     ],
   )
   ```

---

## Soal 4 — Analisis Kebutuhan dan User Flow

### 1. Klasifikasi kebutuhan (fungsional dan nonfungsional)

- **Permintaan 1: “Saya ingin mengajukan surat keterangan aktif kuliah.”**
  - **Klasifikasi:** Kebutuhan fungsional. Sistem harus menyediakan fitur atau layanan inti bagi pengguna untuk mengirim formulir permohonan.
- **Permintaan 2: “Saya ingin melihat status pengajuan saya.”**
  - **Klasifikasi:** Kebutuhan fungsional. Sistem harus menyediakan fitur penelusuran status atau riwayat data pengajuan.
- **Permintaan 3: “Saya ingin menerima notifikasi saat surat siap diambil.”**
  - **Klasifikasi:** Kebutuhan fungsional/nonfungsional. Dari sudut pandang interaksi pengguna, ini merupakan fitur fungsional pemberitahuan otomatis; dari sudut pandang sistem, ini berkaitan dengan keandalan dan responsivitas layanan. Catatan sistem: dikategorikan sebagai kebutuhan fungsional karena melibatkan modul fitur *push notification* atau sistem pesan.

### 2. Penentuan prioritas MoSCoW dan alasannya

| No. | Permintaan | Prioritas MoSCoW | Alasan penentuan prioritas |
|---:|---|---|---|
| 1 | Mengajukan surat keterangan aktif kuliah | **Must have** | Ini adalah inti utama (*core feature*) dari aplikasi. Tanpa fitur pengajuan surat, aplikasi kehilangan fungsi dasarnya untuk mendigitalkan proses administrasi mahasiswa. |
| 2 | Melihat status pengajuan | **Should have** | Fitur yang sangat penting untuk mengurangi kebingungan mahasiswa dan meminimalisir kunjungan fisik atau bertanya langsung ke loket. Namun, jika belum ada di fase awal, pengajuan dasar masih tetap bisa berjalan. |
| 3 | Menerima notifikasi saat surat siap | **Could have** | Fitur peningkatan kenyamanan (*nice-to-have*). Mahasiswa masih bisa mengecek status secara manual melalui fitur nomor 2 jika notifikasi belum tersedia. |

### 3. User flow sederhana untuk kebutuhan Must have (pengajuan surat)

Berikut adalah urutan langkah (*user flow*) yang harus dilalui mahasiswa untuk melakukan pengajuan surat keterangan aktif kuliah:

1. **Buka aplikasi dan login:** Mahasiswa membuka aplikasi mobile kampus dan masuk menggunakan akun NIM/password mahasiswa.
2. **Pilih menu layanan surat:** Pada halaman utama (*dashboard*), mahasiswa memilih menu **“Pengajuan Surat”**.
3. **Pilih jenis surat:** Mahasiswa memilih opsi **“Surat Keterangan Aktif Kuliah”**.
4. **Isi formulir dan unggah lampiran:** Mahasiswa melengkapi data pendukung (seperti keperluan pembuatan surat) dan mengunggah dokumen persyaratan jika diperlukan (misalnya scan KTM).
5. **Konfirmasi dan kirim:** Mahasiswa menekan tombol **“Ajukan Permohonan”**.
6. **Selesai/konfirmasi berhasil:** Sistem menampilkan pesan sukses beserta nomor referensi/tiket pengajuan, dan permohonan masuk ke antrean validasi pihak administrasi kampus.

---

## Soal 5 — UI/UX Mobile

### 1. Keterbacaan dan hierarki visual pada layar kecil (*Visual Hierarchy & Screen Real Estate*)

- **Prinsip UI/UX:** Mengatur tata letak elemen informasi yang padat agar mudah dipindai (*scannable*) di layar ponsel yang terbatas.
- **Keputusan desain:** Menggunakan komponen **`Card`** atau **`ListTile`** yang konsisten untuk setiap item daftar. Susunan informasi di dalamnya dibuat bertingkat: **nama surat** ditempatkan sebagai teks utama yang paling menonjol (ukuran lebih besar/tebal), diikuti oleh **status pengajuan** di bawahnya, serta tombol aksi di bagian samping atau bawah.
- **Alasan:** Dengan 20 jenis surat yang ditampilkan, layar *smartphone* akan cepat terasa penuh. Penggunaan kartu (*card*) memberikan batas visual yang jelas antar-surat, sementara hierarki tipografi membantu mahasiswa mengenali jenis surat dan status pengajuannya dalam hitungan detik tanpa harus membaca seluruh teks secara mendetail.

### 2. Ergonomi dan kenyamanan interaksi sentuh (*Touch Target & Ergonomics*)

- **Prinsip UI/UX:** Memastikan seluruh elemen interaktif (khususnya tombol “Ajukan”) mudah dijangkau dan disentuh oleh jari tanpa risiko salah tekan.
- **Keputusan desain:** Menetapkan ukuran minimum area sentuh tombol aksi atau item daftar sebesar **48 dp**, serta memberikan ruang kosong (*whitespace/padding*) yang memadai antar-item agar tidak terlalu rapat.
- **Alasan:** Interaksi pada perangkat seluler dilakukan menggunakan jari tangan, bukan kursor yang presisi. Ukuran sentuh yang memadai dan jarak antartombol yang longgar mencegah terjadinya *mis-tap* (salah tekan surat lain), sehingga proses pengajuan berjalan mulus dan mengurangi frustrasi pengguna.

### 3. Efisiensi dan kecepatan sesi penggunaan (*Efficiency & Goal-Oriented Design*)

- **Prinsip UI/UX:** Memangkas waktu pencarian karena pengguna aplikasi seluler umumnya memiliki rentang perhatian yang singkat dan ingin tugasnya cepat selesai.
- **Keputusan desain:** Menyematkan **fitur pencarian (*search bar*) atau filter kategori** di bagian paling atas halaman daftar surat.
- **Alasan:** Mahasiswa yang harus melihat 20 jenis surat secara manual akan membuang banyak waktu untuk menggulir (*scrolling*). Fitur pencarian instan memungkinkan pengguna langsung mengetik jenis surat yang diinginkan (misalnya *“aktif kuliah”*), sehingga mereka dapat langsung menemukan menu tujuan dan menekan tombol ajukan dengan sangat efisien.

---

## Soal 6 — Navigasi dan Interaksi

### 1. Implementasi navigasi dengan `Navigator` (`push`, `pushNamed`, `pop`) dan kapan digunakan

Dalam Flutter, `Navigator` bekerja menggunakan konsep tumpukan (*stack*). Halaman baru diletakkan di atas halaman lama (*push*), dan halaman dapat dilepas dari tumpukan untuk kembali ke halaman sebelumnya (*pop*).

- **`Navigator.push()`**
  - **Cara kerja:** Berpindah ke halaman baru dengan memasukkan objek *route* baru (biasanya `MaterialPageRoute`) secara langsung ke dalam tumpukan navigasi.
  - **Kapan digunakan:** Digunakan ketika perlu mengirimkan data/objek secara langsung ke halaman tujuan melalui konstruktor halaman tersebut tanpa harus mendaftarkannya terlebih dahulu di tabel rute global (`routes`).
  - **Contoh kasus:** Berpindah dari Halaman Daftar Surat ke Halaman Form Pengajuan sambil membawa data `jenisSurat` yang dipilih mahasiswa.
- **`Navigator.pushNamed()`**
  - **Cara kerja:** Berpindah ke halaman baru menggunakan nama rute string (misalnya `'/form-pengajuan'`) yang telah didaftarkan sebelumnya di konfigurasi `MaterialApp`.
  - **Kapan digunakan:** Digunakan untuk navigasi statis yang terpusat dan rapi, terutama pada aplikasi skala menengah hingga besar yang memiliki banyak halaman agar kode lebih bersih dan mudah dikelola.
  - **Contoh kasus:** Berpindah dari Halaman Form Pengajuan ke Halaman Detail Status menggunakan rute bernama `'/detail-status'`.
- **`Navigator.pop()`**
  - **Cara kerja:** Menghapus halaman yang sedang aktif saat ini dari tumpukan navigasi, sehingga layar kembali ke halaman sebelumnya (*go back*).
  - **Kapan digunakan:** Digunakan saat proses pada halaman saat ini sudah selesai (misalnya tombol *back* kustom, tombol “Batal”, atau setelah pengguna sukses menekan tombol “Kirim” pada form).
  - **Contoh kasus:** Setelah mahasiswa berhasil mengirim formulir pengajuan surat, aplikasi mengeksekusi `Navigator.pop()` untuk menutup halaman form dan kembali ke halaman daftar atau diarahkan ke halaman detail status.

### 2. Pengiriman data jenis surat dari halaman daftar ke halaman form

Untuk mengirimkan data jenis surat (misalnya **“Surat Keterangan Aktif Kuliah”**) dari halaman daftar ke halaman form, data tersebut disisipkan melalui **parameter konstruktor** pada *widget* halaman tujuan saat `Navigator.push` dipanggil.

**Implementasi kode:**

```dart
// 1. Di Halaman Daftar Surat (saat item ditekan)
ListTile(
  title: Text('Surat Keterangan Aktif Kuliah'),
  onTap: () {
    // Navigasi dengan mengirim data jenis surat
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormPengajuanPage(
          jenisSurat: 'Surat Keterangan Aktif Kuliah',
        ),
      ),
    );
  },
);

// 2. Di Halaman Form Pengajuan (menerima data melalui konstruktor)
class FormPengajuanPage extends StatelessWidget {
  final String jenisSurat;

  // Menangkap data pada konstruktor
  const FormPengajuanPage({Key? key, required this.jenisSurat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form: $jenisSurat')),
      body: Center(
        child: Text('Formulir untuk pengajuan: $jenisSurat'),
      ),
    );
  }
}
```

### 3. Pemberian *feedback* setelah formulir dikirim

Setelah mahasiswa mengisi formulir dan menekan tombol “Kirim”, sistem harus memberikan respons yang jelas agar pengguna mengetahui status tindakan mereka. *Feedback* diberikan melalui kombinasi UI interaktif berikut:

1. **Indikator proses (*Loading State*):** Saat tombol kirim ditekan, tombol berubah menjadi ikon *spinner* (`CircularProgressIndicator`) atau halaman dikunci sementara untuk mencegah klik ganda saat data sedang dikirim ke *server*.
2. **Pesan konfirmasi instan (*Snackbar* atau *Dialog*):** Begitu proses penyimpanan berhasil, tampilkan *Snackbar* di bagian bawah layar atau *Popup Dialog* sukses.
   - **Contoh teks:** “Pengajuan berhasil dikirim! Menunggu validasi admin.”
3. **Navigasi otomatis ke halaman detail status:** Setelah *feedback* visual diberikan (atau bersamaan dengan tertutupnya *dialog* sukses), arahkan pengguna secara otomatis ke Halaman Detail Status menggunakan `Navigator.pushReplacementNamed()` agar mereka bisa memantau perkembangan surat tersebut secara *real-time*.

> **Catatan pengetikan kode:** Pada teks awal yang dikirim, parameter konstruktor tertulis `this.jenisSurzat`, sedangkan field yang dideklarasikan adalah `jenisSurat`. Dalam salinan dokumen ini, typo tersebut dinormalkan menjadi `this.jenisSurat` agar contoh kode konsisten.

---

## Soal 7 — Model Data dan State

### 1. Mengapa setiap field bersifat `final`

Setiap field bersifat `final` karena kelas `PengajuanSurat` dirancang sebagai objek yang **tidak dapat diubah (*immutable*)** setelah instansiasi dibuat. Hal ini menjaga keamanan data agar nilai properti seperti `id`, `jenis`, `tanggal`, dan `status` tidak berubah secara tidak sengaja di tengah eksekusi program, serta mengoptimalkan performa manajemen memori di Flutter.

### 2. Mengapa `id` wajib ada

`id` wajib ada untuk bertindak sebagai **pengenal unik (*unique identifier*)** bagi setiap data pengajuan surat. Tanpa `id`, sistem akan kesulitan membedakan antara satu data pengajuan dengan data pengajuan lainnya—terutama saat melakukan operasi pembaruan (*update*), pencarian (*query*), penghapusan (*delete*), atau pelacakan status (*tracking*).

### 3. Perbedaan `StatelessWidget` dan `StatefulWidget`

- **`StatelessWidget`:** Widget yang bersifat statis; tampilannya tidak akan berubah atau memperbarui diri setelah dirender karena tidak memiliki *state* internal yang dapat dimodifikasi.
- **`StatefulWidget`:** Widget yang bersifat dinamis; memiliki objek *state* terpisah yang dapat berubah sewaktu-waktu, sehingga antarmuka (*UI*) dapat diperbarui secara otomatis ketika terjadi perubahan data atau interaksi pengguna.

### 4. Halaman daftar menggunakan

**`StatefulWidget`**.

### 5. Alasan

Halaman daftar pengajuan surat bersifat dinamis karena data di dalamnya dapat bertambah (ketika mahasiswa mengajukan surat baru), berubah statusnya (dari “Menunggu” menjadi “Selesai”), atau diperbarui secara berkala. Oleh karena itu, dibutuhkan `StatefulWidget` agar tampilan daftar dapat merespons perubahan data tersebut dan melakukan *re-render* secara otomatis di layar.

### 6. Fungsi `setState`

`setState` adalah fungsi khusus di dalam `StatefulWidget` yang berfungsi untuk **memberitahu kerangka kerja Flutter bahwa ada perubahan data internal (*state*)**, sehingga Flutter perlu segera membangun ulang (*rebuild*) tampilan *UI* yang terdampak agar mencerminkan data terbaru.

### 7. Apa yang terjadi bila data ditambah tanpa `setState`

Jika data (misalnya daftar pengajuan surat) ditambah tanpa memanggil `setState`, data baru tersebut **memang berhasil tersimpan di dalam memori atau variabel di balik layar**, tetapi **tampilan antarmuka (*UI*) di layar ponsel tidak akan berubah atau memperbarui diri**. Pengguna tidak akan melihat item baru tersebut muncul pada daftar di aplikasi sampai ada pemicu lain yang memaksa layar untuk melakukan *refresh*.

---

## Soal 8 — Operasi CRUD Lokal

### 1. Tabel operasi CRUD dan method `List` di Flutter

| Operasi | Method `List` / mekanisme |
|---|---|
| **Create** | `add()` atau `insert()` (menambahkan objek pengajuan baru ke dalam *list*). |
| **Read** | Perulangan seperti `for`, `map()`, atau akses langsung menggunakan *index* (`daftar[i]`) untuk menampilkan data. |
| **Update** | Pencarian data berdasarkan `id` lalu mengubah nilai properti objeknya, atau menggunakan sintaks penugasan / `map` / mengganti elemen pada *index* tertentu dengan data baru. |
| **Delete** | `removeWhere()` (menghapus elemen berdasarkan kondisi tertentu, misalnya mencocokkan `id`) atau `removeAt()` (berdasarkan *index*). |

### 2. Alasan `id` digunakan sebagai kunci Update dan Delete

`id` (pengenal unik) digunakan sebagai acuan utama karena `id` bersifat **tetap dan mutlak** bagi setiap data, terlepas dari bagaimana urutan data tersebut ditampilkan di layar.

### 3. Konsekuensi bila index daftar digunakan sebagai kunci

Jika *index* (posisi urutan dalam *list*, misalnya indeks ke-0, ke-1, dan seterusnya) digunakan untuk melakukan *update* atau *delete*, akan timbul risiko fatal ketika data mengalami **pengurutan (*sorting*)**, **pencarian/filter (*filtering*)**, atau **penghapusan data lain**.

**Konsekuensi buruknya:**

1. **Salah ubah / salah hapus (data korup):** Misalkan data A berada di indeks ke-1. Sebelum melakukan aksi *delete*, pengguna mengetikkan kata kunci pencarian sehingga daftar tersaring dan data A bergeser ke indeks ke-0. Jika sistem mengeksekusi perintah hapus berdasarkan *index* (indeks 0), maka sistem akan menghapus data yang **salah** (bukan data A yang dimaksud).
2. **Inkonsistensi state:** *Index* sangat bergantung pada posisi sementara di memori, sehingga tidak aman untuk diandalkan sebagai identitas data permanen.

---

## Soal 9 — Persistensi Data Lokal

### 1. Perbedaan in-memory dan persistensi

- **In-memory:** Penyimpanan data sementara yang hidup di dalam RAM perangkat selama aplikasi aktif berjalan. Jika aplikasi ditutup (*force close*), *restart*, atau sistem mengambil ulang memori, seluruh data akan hilang secara permanen.
- **Persistensi (`shared_preferences`):** Penyimpanan data permanen yang mencatat dan menyimpan data ke dalam penyimpanan fisik perangkat (seperti *flash storage* / *disk* lokal dalam bentuk *key-value pair*), sehingga data tetap aman dan dapat dimuat kembali meskipun aplikasi ditutup atau perangkat dimatikan.

### 2. Mengapa operasi `shared_preferences` asinkron (`Future`)

Operasi baca/tulis ke media penyimpanan fisik perangkat melibatkan proses I/O (*Input/Output*) disk yang kecepatannya lebih lambat dibandingkan akses RAM. Sifatnya dibuat asinkron (`Future`) agar proses penyimpanan tersebut berjalan di latar belakang tanpa memblokir *main thread* (UI thread), sehingga aplikasi tidak mengalami *freeze* atau *lag* saat pengguna berinteraksi dengan layar.

### 3. Apa yang terjadi bila `await` diabaikan

Jika kata kunci `await` diabaikan saat memanggil fungsi penyimpanan (misalnya `prefs.setString(...)`), kode program di bawahnya akan langsung dieksekusi sebelum proses penulisan ke disk benar-benar selesai. Akibatnya, data bisa gagal tersimpan secara utuh, atau aplikasi mencoba membaca data sebelum proses simpan tuntas, yang berpotensi memicu *bug* atau inkonsistensi data.

### 4. Contoh situasi in-memory sudah cukup

Saat membuat aplikasi kalkulator sederhana atau formulir pengisian data sementara (*draft*) yang hanya digunakan dalam satu sesi aktif di layar yang sama dan tidak perlu disimpan untuk penggunaan berikutnya.

### 5. Contoh situasi persistensi mutlak diperlukan

Pada kasus aplikasi layanan kampus ini—seperti menyimpan riwayat pengajuan surat mahasiswa, token autentikasi (*login session*), atau pengaturan tema aplikasi—di mana data wajib tetap ada dan muncul kembali saat mahasiswa membuka aplikasi di lain hari meskipun ponsel sempat dimatikan.

---

## Soal 10 — Integrasi Konsep Lintas Pertemuan

### 1. Arsitektur

- **Aplikasi mobile (Flutter Frontend):** Berfungsi sebagai antarmuka utama yang berinteraksi langsung dengan mahasiswa (menampilkan katalog, form peminjaman, dan riwayat).
- **Penyimpanan lokal (*Local Storage / SharedPreferences*):** Digunakan untuk menyimpan data ringan yang bersifat *offline-first* dan instan, seperti *token session* login mahasiswa agar tidak perlu masuk berulang kali, atau *cache* riwayat peminjaman terakhir.
- **Backend Sistem Informasi (Server & Database Kampus):** Bertindak sebagai pusat pemrosesan logika bisnis, validasi stok buku secara *real-time*, dan penyimpanan data utama perpustakaan. Aplikasi mobile berkomunikasi dengan backend melalui *REST API* (menggunakan protokol HTTP seperti `GET` untuk mengambil katalog dan `POST` untuk mengirim data peminjaman).

### 2. Kebutuhan dan alur

**Dua kebutuhan Must have (prioritas utama):**

1. Mahasiswa dapat melihat daftar katalog buku yang tersedia di perpustakaan.
2. Mahasiswa dapat melakukan peminjaman buku secara digital melalui aplikasi.

**Alur pengguna (*user flow*) dari membuka aplikasi hingga tugas selesai:**

1. Mahasiswa membuka aplikasi seluler dan masuk (*login*) menggunakan akun NIM/password mahasiswa.
2. Sistem menampilkan halaman utama yang berisi **Katalog Buku**.
3. Mahasiswa mencari buku yang diinginkan (bisa memanfaatkan fitur pencarian) lalu mengekliknya untuk melihat detail.
4. Mahasiswa menekan tombol **“Pinjam Buku”**, yang membawa mereka ke halaman **Form Peminjaman** (mengisi tanggal pinjam/kembali).
5. Mahasiswa menekan tombol “Konfirmasi Peminjaman”. Sistem mengirim data ke backend, memperbarui *state* lokal, dan menampilkan pesan sukses serta mengarahkan ke halaman riwayat peminjaman.

### 3. Struktur komponen dan navigasi

**Halaman katalog dan form peminjaman:**

- **Halaman Katalog:** Menggunakan `Scaffold` dengan `AppBar` (judul: “Katalog Buku”) dan `body` berupa `ListView.builder` di dalam `Expanded` untuk menampilkan daftar buku secara dinamis dan efisien. Setiap item dirender menggunakan widget `Card` atau `ListTile`.
- **Halaman Form Peminjaman:** Menggunakan `Scaffold` berisi `Form`, beberapa widget `TextFormField` (untuk input durasi/tanggal), dan tombol aksi “Kirim Peminjaman”.

**Navigasi antarhalaman:**

- Menggunakan **`Navigator.push()`** saat berpindah dari Halaman Katalog ke Halaman Form Peminjaman sambil mengirim data objek buku yang dipilih melalui konstruktor.
- Menggunakan **`Navigator.pop()`** untuk kembali ke halaman sebelumnya atau keluar dari form setelah peminjaman berhasil disimpan.

### 4. Data dan state

**Definisi model data `Buku` (minimal 4 field):**

```dart
class Buku {
  const Buku({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.statusTersedia,
  });

  final String id;
  final String judul;
  final String penulis;
  final bool statusTersedia;
}
```

**Cara operasi Create (meminjam) dan Read (melihat riwayat) dikelola dalam state:**

- **Read (melihat riwayat/katalog):** Dikelola di dalam sebuah `StatefulWidget` menggunakan variabel *list* lokal (`List<Buku> daftarBuku = [...]`). Data dibaca dan dirender ke layar menggunakan perulangan atau `ListView.builder`.
- **Create (meminjam buku):** Ketika mahasiswa berhasil melakukan peminjaman pada *form*, fungsi *Create* dipicu dengan menambahkan data transaksi baru atau mengubah status buku ke dalam *list* state menggunakan method `.add()`. Seluruh perubahan ini dibungkus di dalam blok **`setState(() { ... })`** agar Flutter otomatis memperbarui (*re-render*) tampilan antarmuka secara *real-time* tanpa perlu menutup aplikasi.

---