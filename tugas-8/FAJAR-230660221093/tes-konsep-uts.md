# Tes Konsep UTS — FAJAR NIM 230660221093

Halo Pak/Bu, ini jawaban Tes Konsep UTS saya untuk mata kuliah Pemrograman Aplikasi Bergerak. Saya mengerjakannya sendiri dengan berpatokan pada materi Pertemuan 1–7 dan project yang saya bangun selama ini. Di setiap soal saya berusaha tidak hanya menyebut istilah, tetapi juga menjelaskan alasan di baliknya dan kaitannya dengan studi kasus. Kalau ada bagian yang kurang tepat, saya terbuka untuk dikoreksi saat sesi evaluasi.

---

## Soal 1 — Konsep Aplikasi Bergerak dalam SI

Untuk layanan pengajuan surat keterangan, solusi mobile lebih cocok daripada web desktop karena tiga karakteristik berikut.

1. **Karakteristik: Mobilitas dan ketersediaan kapan saja.**
   Aplikasi mobile ada di saku pengguna, jadi tidak terikat pada komputer di ruangan tertentu.
   Contoh penerapan: mahasiswa bisa mengajukan surat keterangan aktif kuliah dari kos atau saat menunggu kelas, tanpa harus datang ke loket dan mengantre. Pengajuan yang tadinya makan waktu setengah hari cukup dilakukan beberapa menit.

2. **Karakteristik: Konektivitas dan notifikasi langsung ke perangkat.**
   Perangkat mobile selalu dibawa dan bisa menerima pemberitahuan secara real time.
   Contoh penerapan: saat surat sudah selesai diproses, mahasiswa menerima notifikasi "Surat siap diambil". Mereka tidak perlu bolak-balik ke kampus untuk mengecek, dan loket pun tidak dibanjiri pertanyaan "sudah jadi belum?".

3. **Karakteristik: Interaksi personal dan sentuh dengan layar yang ringkas.**
   Aplikasi mobile dirancang untuk sesi singkat, satu tangan, dan tugas yang terfokus. Perangkat juga bersifat pribadi sehingga data pengguna (misalnya NIM dan riwayat pengajuan) bisa tersimpan di perangkatnya.
   Contoh penerapan: form pengajuan dibuat pendek dengan jenis surat sudah terisi otomatis, dan tombol "Ajukan" besar sehingga mudah ditekan jempol. Riwayat pengajuan tersimpan di perangkat sehingga tidak perlu mengisi ulang data diri tiap kali.

---

## Soal 2 — Dasar Pemrograman Dart

- **`List<String> daftarSurat = []`**: membuat variabel bertipe daftar (list) yang hanya boleh berisi `String`, dan awalnya kosong. Daftar ini menjadi tempat menyimpan jenis surat. Tipe `String` memastikan Dart menolak data yang bukan teks sejak sebelum program dijalankan.
- **Parameter `String jenis`**: data masukan yang diberikan ke fungsi `tambahSurat`. Dengan parameter, fungsi bisa dipakai berulang untuk jenis surat yang berbeda-beda tanpa mengubah isi fungsinya.
- **`jenis.isEmpty`**: properti bawaan `String` yang bernilai `true` bila teks tidak punya karakter sama sekali. Ini dipakai sebagai validasi dasar agar data kosong tidak masuk.
- **`return` pada kondisi error**: menghentikan eksekusi fungsi saat itu juga. Setelah pesan error dicetak, `return` mencegah baris `daftarSurat.add(jenis)` ikut dijalankan, sehingga data yang tidak valid tidak tersimpan.
- **`daftarSurat.add(jenis)`**: menambahkan `jenis` ke akhir list. Inilah operasi "simpan" pada kode ini, dan panjang list otomatis bertambah satu.
- **Perulangan `for`**: menelusuri list dari indeks 0 sampai `length - 1`. Pada tiap putaran, kode mencetak nomor urut (`i + 1`, karena indeks mulai dari 0 tetapi penomoran untuk pengguna mulai dari 1) beserta isi surat pada indeks tersebut.

**Kesalahan umum bila validasi `isEmpty` dihapus:** string kosong akan ikut tersimpan ke daftar. Akibatnya, `tampilkanSurat()` mencetak baris bernomor tetapi tanpa nama surat, misalnya "3. ". Pada aplikasi sungguhan, ini muncul sebagai item kosong di daftar atau pengajuan surat tanpa jenis, yang membingungkan pengguna dan petugas, dan bisa merusak proses berikutnya yang mengandalkan nilai tersebut.

---

## Soal 3 — Struktur Flutter dan Widget

- **`MaterialApp`**: widget akar yang membungkus seluruh aplikasi dan menyediakan fondasi Material Design, seperti tema, sistem navigasi/route, dan pengaturan `home` sebagai halaman pertama.
- **`Scaffold`**: kerangka dasar satu halaman. Ia menyediakan tempat untuk `appBar`, `body`, dan elemen standar lain seperti tombol mengambang atau `SnackBar`.
- **`AppBar`**: bilah judul di bagian atas halaman. Di sini isinya "Daftar Surat" supaya pengguna tahu sedang berada di halaman mana, dan nantinya bisa memuat tombol kembali atau aksi.
- **`Column`**: menyusun widget anak secara vertikal dari atas ke bawah. Di sini ia menumpuk teks petunjuk di atas, lalu daftar di bawahnya.
- **`Text`**: menampilkan teks statis, yaitu "Pilih jenis surat" sebagai instruksi singkat bagi pengguna.
- **`ListView.builder`**: membuat daftar yang bisa di-scroll dan membangun item hanya saat dibutuhkan (lazy). Ini efisien untuk data banyak, seperti 20 jenis surat, karena tidak semua item dibuat sekaligus.

**Masalah bila `ListView.builder` ditempatkan langsung di dalam `Column` tanpa `Expanded`:** aplikasi menampilkan error layout, biasanya berbunyi "Vertical viewport was given unbounded height", dan daftar tidak tampil.

**Penyebab:** `Column` memberi anak-anaknya ruang vertikal yang tidak dibatasi (unbounded), sedangkan `ListView` secara bawaan ingin mengisi tinggi sebanyak mungkin. Flutter tidak bisa menentukan tinggi `ListView` karena ia meminta tinggi tak terhingga.

**Perbaikan:** bungkus `ListView.builder` dengan `Expanded` agar ia hanya mengambil sisa ruang yang tersedia di bawah `Text`:

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

Alternatif lainnya adalah `shrinkWrap: true`, tetapi itu kurang efisien untuk daftar panjang karena semua item dihitung sekaligus.

---

## Soal 4 — Analisis Kebutuhan dan User Flow

Klasifikasi dan prioritas:

| No. | Permintaan | Fungsional/Nonfungsional | Prioritas MoSCoW | Alasan |
|:---:|:-----------|:-------------------------|:----------------:|:-------|
| 1 | Mengajukan surat keterangan aktif kuliah | Fungsional (fitur yang harus dilakukan sistem) | **Must** | Ini tujuan utama aplikasi. Tanpa fitur ini aplikasi tidak menyelesaikan masalah antrean di loket. |
| 2 | Melihat status pengajuan | Fungsional (menampilkan data pengajuan) | **Must** | Tanpa status, mahasiswa tidak tahu perkembangan pengajuannya dan akan kembali mengecek ke loket. |
| 3 | Menerima notifikasi saat surat siap diambil | Fungsional, dengan sisi nonfungsional (ketepatan waktu dan keandalan pengiriman) | **Should** | Sangat membantu, tetapi aplikasi tetap berguna tanpanya karena status masih bisa dicek manual. Notifikasi juga butuh backend dan layanan push yang baru bisa dikerjakan setelah integrasi API. |

Kebutuhan nonfungsional yang melekat pada ketiganya (diturunkan dari kualitas yang diharapkan):

| Kebutuhan nonfungsional | Prioritas | Alasan singkat |
|:------------------------|:---------:|:---------------|
| Kemudahan penggunaan: form dapat diselesaikan kurang dari 2 menit | Must | Pengguna mobile cenderung tidak sabar dan sesinya singkat. |
| Respons aplikasi cepat saat membuka daftar dan status | Should | Memengaruhi kenyamanan, tetapi bukan syarat fungsi inti. |
| Keamanan data pribadi mahasiswa | Should | Penting, namun pada tahap MVP lokal belum ada data sensitif yang dikirim. |

User flow untuk kebutuhan *Must* (mengajukan surat dan melihat status):

1. Mahasiswa membuka aplikasi dan langsung melihat halaman daftar jenis surat.
2. Mahasiswa memilih "Surat Keterangan Aktif Kuliah".
3. Aplikasi membuka halaman form dengan jenis surat sudah terisi otomatis.
4. Mahasiswa mengisi data yang diminta (misalnya keperluan surat); aplikasi memvalidasi isian.
5. Mahasiswa menekan tombol "Ajukan"; data disimpan dan muncul `SnackBar` bahwa pengajuan berhasil.
6. Aplikasi kembali ke daftar, atau mahasiswa membuka halaman status pengajuan.
7. Mahasiswa melihat pengajuannya muncul dengan status "Diajukan" pada detail status.

---

## Soal 5 — UI/UX Mobile

1. **Prinsip: Ukuran layar kecil, jadi tampilkan hanya yang penting.**
   Keputusan desain: tiap item daftar hanya memuat nama surat, status (berupa label kecil), dan satu tombol "Ajukan". Keterangan panjang dipindah ke halaman detail. Daftar memakai `ListView.builder` dengan satu kolom, bukan tabel lebar.
   Alasan: layar ponsel sempit, sehingga informasi yang terlalu padat sulit dibaca dan memaksa zoom. Dengan 20 item, tampilan yang ringkas membuat pengguna cepat memindai daftar.

2. **Prinsip: Interaksi sentuh, jadi target sentuh harus cukup besar dan jaraknya cukup.**
   Keputusan desain: tinggi tiap baris dan tombol dibuat minimal sekitar 48 dp, dengan jarak antar item yang jelas. Tombol aksi diletakkan di sisi kanan item dan seluruh baris bisa diketuk untuk membuka detail.
   Alasan: jari lebih besar dan kurang presisi dibanding kursor. Target yang kecil atau berdempetan menyebabkan salah tekan, misalnya mengajukan surat yang salah.

3. **Prinsip: Sesi penggunaan singkat, jadi tugas utama harus bisa dicapai dengan sedikit langkah.**
   Keputusan desain: daftar surat menjadi halaman pertama, jenis surat otomatis terbawa ke form, dan setelah pengajuan ada umpan balik langsung lewat `SnackBar`. Status surat diberi label dan warna berbeda agar terbaca sekilas.
   Alasan: mahasiswa biasanya membuka aplikasi sebentar di sela aktivitas. Semakin sedikit ketukan dan semakin jelas umpan baliknya, semakin kecil kemungkinan mereka meninggalkan proses di tengah jalan.

---

## Soal 6 — Navigasi dan Interaksi

**Metode navigasi dan kapan digunakan:**

- **`push`**: menaruh halaman baru di atas halaman saat ini dengan langsung memberi objek halamannya, misalnya `Navigator.push(context, MaterialPageRoute(builder: (_) => FormPage(jenis: jenis)))`. Saya pakai dari halaman daftar ke halaman form karena perlu mengirim data lewat konstruktor.
- **`pushNamed`**: berpindah halaman berdasarkan nama route yang sudah didaftarkan di `MaterialApp`, misalnya `Navigator.pushNamed(context, '/status')`. Cocok untuk halaman yang dibuka dari banyak tempat atau saat jumlah halaman bertambah, karena alamat halaman terkumpul di satu tempat. Data bisa dikirim lewat parameter `arguments`.
- **`pop`**: menutup halaman saat ini dan kembali ke halaman sebelumnya. Saya pakai setelah form berhasil dikirim, atau saat pengguna ingin kembali. `pop` juga bisa membawa hasil balik ke halaman sebelumnya.

**Pengiriman data jenis surat ke halaman form:** halaman form dibuat sebagai widget yang menerima `jenis` lewat konstruktor (`FormPage({required this.jenis})`). Saat pengguna menekan tombol "Ajukan" pada sebuah item, halaman daftar memanggil `Navigator.push` sambil mengisi `jenis` dengan nama surat yang dipilih. Dengan begitu form langsung tahu jenis surat mana yang sedang diajukan tanpa harus diketik ulang.

**Feedback setelah form dikirim:** pertama form divalidasi (`validator` pada `TextFormField`, dicek lewat `formKey.currentState!.validate()`). Jika valid, data disimpan, lalu ditampilkan `SnackBar` melalui `ScaffoldMessenger.of(context).showSnackBar(...)` berisi pesan seperti "Pengajuan berhasil dikirim". Setelah itu aplikasi kembali ke daftar dengan `Navigator.pop`. Jika tidak valid, pesan error muncul di bawah kolom yang bermasalah sehingga pengguna tahu apa yang harus diperbaiki.

---

## Soal 7 — Model Data dan State

**Mengapa setiap field bersifat `final`:** supaya objek `PengajuanSurat` tidak berubah setelah dibuat (immutable). Data pengajuan yang sudah tercatat tidak boleh berubah secara tidak sengaja dari bagian kode mana pun, sehingga perilaku aplikasi lebih mudah diprediksi dan bug lebih mudah dilacak. Bila data perlu diubah (misalnya status), yang dilakukan adalah membuat objek baru dengan nilai baru lalu menggantikan yang lama di daftar. Sifat immutable ini juga memungkinkan konstruktor `const`, yang lebih hemat memori.

**Mengapa `id` wajib ada:** `id` adalah identitas unik tiap pengajuan. Field lain tidak bisa dijadikan pengenal karena bisa sama; misalnya dua pengajuan "Surat Keterangan Aktif Kuliah" dengan jenis yang sama. Dengan `id`, sistem tahu persis pengajuan mana yang ditampilkan, diubah, atau dihapus. `id` juga akan tetap relevan saat data nanti disinkronkan dengan backend.

**Perbedaan StatelessWidget dan StatefulWidget:** `StatelessWidget` tampilannya hanya ditentukan oleh data yang diberikan saat dibuat dan tidak punya data internal yang berubah. `StatefulWidget` punya objek `State` yang menyimpan data yang bisa berubah selama aplikasi berjalan, dan tampilannya dapat digambar ulang ketika data itu berubah.

**Halaman daftar menggunakan: `StatefulWidget`.**
**Alasan:** isi daftar pengajuan berubah saat pengguna menambah, mengubah, atau menghapus data. List data tersebut disimpan di dalam `State`, dan tampilan harus diperbarui setiap kali list berubah. `StatelessWidget` tidak bisa melakukannya karena tidak punya state yang dapat berubah.

**Fungsi `setState`:** memberi tahu Flutter bahwa data di dalam `State` sudah berubah sehingga widget perlu dibangun ulang (`build` dipanggil lagi) dan layar diperbarui. Perubahan data dilakukan di dalam callback-nya, contohnya:

```dart
setState(() {
  daftarPengajuan.add(pengajuanBaru);
});
```

**Bila data ditambah tanpa `setState`:** list di memori memang bertambah, tetapi layar tidak berubah karena Flutter tidak tahu harus menggambar ulang. Pengguna menekan "Ajukan" dan tidak melihat apa-apa di daftar. Data baru baru tampak ketika ada hal lain yang memicu rebuild, sehingga perilakunya terlihat tidak konsisten.

---

## Soal 8 — CRUD Lokal

| Operasi | Method List / mekanisme |
|:--------|:------------------------|
| Create  | `add()` untuk menambahkan objek baru ke daftar, dibungkus `setState`. |
| Read    | Membaca isi list dan menampilkannya, biasanya lewat `ListView.builder` dengan `itemCount: daftar.length` dan akses `daftar[index]`; bisa juga `where()` untuk memfilter atau `firstWhere()` untuk mencari satu data berdasarkan `id`. |
| Update  | Mencari posisi data dengan `indexWhere((p) => p.id == id)`, lalu menggantikan objek lama dengan objek baru pada posisi itu (`daftar[i] = dataBaru`), dibungkus `setState`. |
| Delete  | `removeWhere((p) => p.id == id)` untuk menghapus data yang `id`-nya cocok, dibungkus `setState`. |

**Mengapa `id` digunakan sebagai kunci update dan delete:** `id` bersifat unik dan tetap melekat pada data, apa pun yang terjadi pada urutan daftar. Dengan `id`, operasi selalu mengenai data yang dimaksud.

**Konsekuensi bila index digunakan sebagai kunci:** posisi data di daftar bisa bergeser, misalnya karena ada data yang dihapus, ditambahkan di awal, difilter, atau diurutkan ulang. Index yang tadinya menunjuk satu pengajuan bisa menunjuk pengajuan lain. Akibatnya, pengguna bisa tanpa sengaja mengubah atau menghapus pengajuan yang salah. Kesalahan seperti ini sulit dilacak karena aplikasinya sendiri tidak error, hanya datanya yang keliru.

---

## Soal 9 — Persistensi Data Lokal

**Perbedaan in-memory dan persistensi:** penyimpanan in-memory berarti data hanya ada di RAM selama aplikasi berjalan, misalnya `List<PengajuanSurat>` pada state. Begitu aplikasi ditutup atau di-restart, datanya hilang. Persistensi dengan `shared_preferences` menyimpan data ke penyimpanan perangkat (berbentuk pasangan kunci–nilai), sehingga data tetap ada setelah aplikasi ditutup dan dibuka lagi. Untuk menyimpan list objek, biasanya objek diubah dulu menjadi JSON/teks (misalnya dengan `jsonEncode`), lalu disimpan sebagai `String` atau `List<String>`.

**Mengapa operasi `shared_preferences` asinkron (`Future`):** karena membaca dan menulis ke penyimpanan perangkat adalah operasi I/O yang butuh waktu, tidak instan seperti mengakses variabel di memori. Jika dilakukan secara sinkron, aplikasi akan "membeku" menunggu proses selesai karena thread utama yang menggambar UI ikut tertahan. Dengan `Future`, proses berjalan di latar dan UI tetap responsif.

**Apa yang terjadi bila `await` diabaikan:** kode berikutnya langsung jalan sebelum proses simpan selesai. Dampaknya bisa berupa data yang belum tersimpan ketika dibaca lagi (kondisi balapan/race condition), aplikasi mengira data sudah aman padahal belum, atau galat penyimpanan tidak tertangkap oleh `try/catch`. Jika aplikasi ditutup tepat pada saat itu, data bisa hilang. Karena itu fungsi penyimpan perlu ditandai `async` dan memanggil `await prefs.setString(...)`.

**Contoh situasi in-memory sudah cukup:** isi kolom pencarian atau filter yang sedang dipilih, data sementara saat form sedang diisi, atau prototipe/demo di mana kehilangan data setelah ditutup tidak jadi masalah.

**Contoh situasi persistensi mutlak diperlukan:** riwayat pengajuan surat mahasiswa yang harus tetap ada setiap kali aplikasi dibuka, draf form yang belum selesai agar tidak perlu mengisi ulang, atau preferensi/sesi pengguna (misalnya tetap login), karena hilangnya data ini langsung merugikan pengguna.

---

## Soal 10 — Integrasi Konsep Lintas Pertemuan

Studi kasus: aplikasi peminjaman buku untuk unit perpustakaan kampus.

### 1. Arsitektur

Aplikasi memakai pola client–server dengan tiga bagian:

```text
[ Aplikasi Mobile (Flutter) ]  <--HTTP/REST-->  [ Backend Sistem Informasi Perpustakaan ]
     |  UI + state (setState)                          |  REST API + logika bisnis
     |                                                 |
[ Penyimpanan lokal (shared_preferences) ]         [ Database (buku, anggota, peminjaman) ]
```

- **Aplikasi mobile** adalah antarmuka pengguna: menampilkan katalog, menerima input peminjaman, dan menyimpan state.
- **Penyimpanan lokal** menyimpan data yang perlu bertahan di perangkat, seperti riwayat peminjaman terakhir, draf, dan preferensi, sehingga aplikasi tetap bisa menampilkan data meski koneksi buruk.
- **Backend SI** adalah sumber data utama (katalog dan stok buku, data anggota, catatan peminjaman resmi) yang diakses lewat REST API. Pada tahap UTS ini bagian backend belum dihubungkan dan masih disimulasikan dengan data lokal; integrasinya dilakukan pada milestone berikutnya.

### 2. Kebutuhan dan Alur

**Dua kebutuhan *Must have*:**
1. Anggota dapat melihat dan mencari katalog buku beserta ketersediaannya.
2. Anggota dapat meminjam buku yang tersedia melalui form peminjaman.

**Alur pengguna dari membuka aplikasi hingga tugas selesai:**
1. Anggota membuka aplikasi dan langsung melihat halaman katalog buku.
2. Anggota mencari atau menelusuri daftar lalu memilih buku yang tersedia.
3. Aplikasi membuka form peminjaman dengan judul buku sudah terisi.
4. Anggota mengisi data peminjaman (misalnya tanggal pengambilan), lalu aplikasi memvalidasi isian.
5. Anggota menekan "Pinjam"; data disimpan dan muncul `SnackBar` konfirmasi.
6. Aplikasi kembali ke katalog dan peminjaman tercatat pada halaman riwayat.

### 3. Struktur Komponen

Struktur widget utama:

```text
MaterialApp
 └─ Scaffold (Halaman Katalog)
     ├─ AppBar(title: Text('Katalog Buku'))
     └─ body: Column
         ├─ Text('Pilih buku untuk dipinjam')
         └─ Expanded
             └─ ListView.builder  → item: judul, penulis, status ketersediaan, tombol "Pinjam"

Scaffold (Halaman Form Peminjaman)
 ├─ AppBar(title: Text('Form Peminjaman'))
 └─ body: Form → TextFormField (dengan validator) + ElevatedButton('Pinjam')
```

- Halaman katalog adalah `StatefulWidget` karena isi daftarnya bisa berubah. `ListView.builder` dibungkus `Expanded` agar tidak error di dalam `Column`.
- Navigasi: dari katalog ke form memakai `Navigator.push` sambil mengirim data buku yang dipilih lewat konstruktor halaman form. Setelah peminjaman berhasil, form memanggil `Navigator.pop` untuk kembali ke katalog. Halaman riwayat dibuka dengan `Navigator.pushNamed('/riwayat')`.

### 4. Data dan State

Model data `Buku` (immutable dan punya `id`, sama seperti prinsip pada Soal 7):

```dart
class Buku {
  const Buku({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.tersedia,
  });

  final String id;
  final String judul;
  final String penulis;
  final bool tersedia;
}
```

Catatan peminjaman dimodelkan terpisah agar riwayat bisa menyimpan siapa meminjam apa dan kapan:

```dart
class Peminjaman {
  const Peminjaman({
    required this.id,
    required this.idBuku,
    required this.judulBuku,
    required this.tanggalPinjam,
  });

  final String id;
  final String idBuku;
  final String judulBuku;
  final String tanggalPinjam;
}
```

**Pengelolaan operasi di dalam state:** halaman katalog/riwayat adalah `StatefulWidget` yang menyimpan `List<Buku> daftarBuku` dan `List<Peminjaman> riwayat` di dalam `State`.

- **Create (meminjam):** setelah form valid, dibuat objek `Peminjaman` baru dengan `id` unik, lalu ditambahkan ke `riwayat` di dalam `setState`. Status buku terkait diperbarui menjadi tidak tersedia dengan mengganti objek `Buku` lama (berdasarkan `id`) dengan objek baru yang `tersedia`-nya `false`. Karena memakai `setState`, tampilan katalog dan riwayat langsung diperbarui.

  ```dart
  setState(() {
    riwayat.add(peminjamanBaru);
    final i = daftarBuku.indexWhere((b) => b.id == buku.id);
    daftarBuku[i] = Buku(
      id: buku.id, judul: buku.judul,
      penulis: buku.penulis, tersedia: false,
    );
  });
  ```

- **Read (melihat riwayat):** halaman riwayat membaca list `riwayat` dan menampilkannya dengan `ListView.builder` (`itemCount: riwayat.length`). Data riwayat bisa disimpan ke `shared_preferences` dengan `await` agar tetap ada saat aplikasi dibuka kembali.
