# Tes Konsep UTS — Nazwa Aulia Rachma 230660221104

> Draf jawaban dengan bantuan AI. Dokumen ini menjawab Soal 1–10, tetapi tidak memenuhi ketentuan tes yang harus dikerjakan mandiri tanpa AI dan referensi. Penggunaan AI dijelaskan secara terbuka pada akhir dokumen.

## Soal 1 — Konsep Aplikasi Bergerak dalam SI (CPMK-1)

1. **Portabilitas dan akses saat berpindah tempat.** Ponsel biasanya dibawa mahasiswa sehingga layanan dapat digunakan di sela kegiatan kuliah tanpa mencari komputer desktop. Pada pengajuan surat, mahasiswa dapat memilih surat keterangan aktif kuliah dan mengisi formulir dari ponselnya sebelum datang ke kampus. Hal ini mengurangi kunjungan ke loket hanya untuk mengambil dan menyerahkan formulir.

2. **Integrasi dengan kemampuan perangkat.** Aplikasi mobile dapat memanfaatkan kamera dan pemilih berkas untuk melampirkan dokumen pendukung. Sebagai contoh, apabila administrasi meminta foto kartu mahasiswa, mahasiswa dapat mengambil foto lalu meninjaunya sebelum mengirim pengajuan. Akses kamera harus meminta izin dan lampiran tetap perlu divalidasi oleh sistem.

3. **Pemberitahuan yang mendukung penggunaan singkat.** Mahasiswa tidak perlu terus membuka halaman status untuk mengetahui perkembangan surat. Ketika petugas mengubah status menjadi siap diambil, layanan backend dapat mengirim notifikasi ke ponsel, dan mahasiswa membuka detail pengajuan untuk melihat jadwal pengambilan. Fitur ini mengurangi pemeriksaan berulang dan kemungkinan mahasiswa melewatkan informasi.

Ketiga karakteristik tersebut sesuai dengan kegiatan mahasiswa yang sering berpindah lokasi. Sebagian kemampuan juga dapat disediakan oleh web mobile atau PWA; alasan memilih aplikasi mobile adalah kesesuaiannya dengan perangkat dan kebiasaan pengguna, bukan karena web sama sekali tidak mampu menyediakannya. Pengiriman pengajuan dan pembaruan status tetap memerlukan koneksi ke layanan kampus.

## Soal 2 — Dasar Pemrograman Dart (CPMK-1)

- **`List<String> daftarSurat = []`:** membuat daftar kosong yang setiap elemennya harus berupa `String`. Daftar ini menyimpan nama jenis surat, misalnya surat keterangan aktif kuliah, sehingga nilai bertipe lain tidak dapat dimasukkan begitu saja dalam kode yang diperiksa tipenya.
- **Parameter `String jenis`:** menerima jenis surat yang diberikan pemanggil fungsi. Parameter membuat fungsi dapat dipakai kembali untuk beberapa pilihan surat tanpa menuliskan satu nama surat secara permanen di dalam fungsi.
- **`jenis.isEmpty`:** memeriksa apakah panjang teks adalah nol. Pemeriksaan ini menjadi validasi awal agar pengajuan tidak memiliki jenis surat kosong. Teks berisi spasi masih dianggap tidak kosong; jika diperlukan, gunakan pemeriksaan terhadap `jenis.trim()`.
- **`return` pada kondisi error:** menghentikan eksekusi fungsi saat input tidak valid sehingga perintah penambahan di bawahnya tidak dijalankan. Pada fungsi `void`, `return;` hanya keluar dari fungsi dan tidak mengembalikan nilai data; ini juga tidak sama dengan melempar exception.
- **`daftarSurat.add(jenis)`:** menambahkan nilai `jenis` ke akhir daftar yang dapat bertambah ukurannya. Pada kasus ini, pilihan surat yang lolos validasi menjadi satu elemen baru.
- **Perulangan `for`:** mengunjungi elemen daftar secara berurutan untuk diproses, misalnya menampilkan seluruh nama surat yang telah ditambahkan. Dengan perulangan, kode tidak perlu menuliskan perintah cetak terpisah untuk setiap elemen.

**Kesalahan umum bila validasi `isEmpty` dihapus:** nilai `''` tetap sah sebagai `String`, sehingga dapat masuk ke daftar walaupun tidak bermakna sebagai jenis surat. Akibatnya, tampilan dapat memiliki baris kosong dan petugas tidak mengetahui surat yang sebenarnya diminta. Pemeriksaan tipe saja tidak cukup untuk memastikan isi teks memenuhi kebutuhan layanan.

## Soal 3 — Struktur Flutter dan Widget (CPMK-1)

| Widget | Fungsi pada halaman daftar surat |
|:-------|:--------------------------------|
| `MaterialApp` | Menyediakan struktur aplikasi Material, tema, serta konfigurasi halaman atau route agar tampilan dan navigasi konsisten. |
| `Scaffold` | Menyediakan kerangka satu halaman dengan tempat untuk `appBar`, `body`, dan komponen halaman lainnya. |
| `AppBar` | Menampilkan judul seperti “Daftar Surat” dan aksi halaman agar konteks pengguna jelas. |
| `Column` | Menyusun sapaan, petunjuk, dan area daftar secara vertikal. |
| `Text` | Menampilkan informasi seperti judul surat, persyaratan singkat, atau status pengajuan. |
| `ListView.builder` | Membentuk daftar yang dapat digulir dengan item dibangun saat diperlukan, sehingga sesuai untuk jumlah jenis surat yang dapat bertambah. |

**Masalah:** `ListView.builder` yang menjadi anak non-flex langsung dari `Column` dapat menimbulkan error `Vertical viewport was given unbounded height`.

**Penyebab:** `Column` memberikan tinggi tidak terbatas kepada anak non-flex saat layout, sedangkan viewport daftar membutuhkan batas tinggi untuk menentukan area gulirnya.

**Perbaikan:** dalam `Scaffold.body` yang memiliki tinggi terbatas, bungkus daftar dengan `Expanded(child: ListView.builder(...))` agar memakai sisa ruang setelah judul dan petunjuk. Jika desain membutuhkan tinggi tetap, `SizedBox(height: ...)` juga dapat memberi batas. `Expanded` tetap membutuhkan induk dengan tinggi terbatas, sehingga bukan solusi untuk setiap susunan scrollable. Penjelasan batas layout ini sesuai [dokumentasi error Flutter](https://docs.flutter.dev/testing/common-errors).

## Soal 4 — Analisis Kebutuhan dan User Flow (CPMK-2)

### Klasifikasi dan prioritas

| No. | Permintaan | Fungsional/Nonfungsional | Prioritas MoSCoW | Alasan |
|:---:|:-----------|:-------------------------|:----------------:|:-------|
| 1 | Mengajukan surat keterangan aktif kuliah. | Fungsional | Must have | Ini layanan inti yang menggantikan formulir manual; tanpa kemampuan mengirim pengajuan, tujuan aplikasi tidak tercapai. |
| 2 | Melihat status pengajuan. | Fungsional | Must have | Mahasiswa perlu mengetahui apakah pengajuan diterima, diproses, perlu diperbaiki, atau siap diambil tanpa bertanya ke loket. |
| 3 | Menerima notifikasi ketika surat siap diambil. | Fungsional | Should have | Notifikasi meningkatkan kenyamanan, tetapi versi awal masih dapat dipakai dengan memeriksa status secara langsung. |

Ketiga permintaan merupakan kebutuhan fungsional karena menjelaskan kemampuan yang dilakukan sistem. Kebutuhan nonfungsional menyatakan mutu atau batasan layanan, misalnya batas waktu respons dan perlindungan akses data pengajuan; ketiganya tidak secara langsung menyebut ukuran mutu tersebut. Prioritas di atas merupakan keputusan untuk MVP layanan pengajuan, sehingga notifikasi dapat ditambahkan setelah pengajuan dan status berfungsi.

### User flow untuk kebutuhan Must

1. Mahasiswa membuka aplikasi dan masuk menggunakan akun kampus.
2. Mahasiswa memilih jenis surat keterangan aktif kuliah dari daftar layanan.
3. Sistem menampilkan form, persyaratan, dan data identitas yang perlu diperiksa.
4. Mahasiswa melengkapi tujuan pengajuan dan lampiran yang diminta, lalu menekan Kirim.
5. Sistem memvalidasi input; jika ada kesalahan, pesan muncul pada field terkait dan mahasiswa memperbaikinya sebelum mengirim ulang.
6. Jika valid dan pengiriman berhasil, sistem membuat pengajuan dengan ID unik serta status awal “Diajukan”, lalu menampilkan konfirmasi; jika pengiriman gagal, sistem mempertahankan input dan menawarkan coba lagi.
7. Mahasiswa membuka detail status menggunakan ID pengajuan dan melihat perkembangan sampai “Siap diambil”, kemudian mengikuti petunjuk pengambilan surat.

## Soal 5 — UI/UX Mobile (CPMK-2)

1. **Prinsip: hierarki informasi untuk layar kecil.** Keputusan desainnya adalah daftar satu kolom dengan nama jenis surat sebagai teks utama, persyaratan singkat sebagai teks pendukung, serta pencarian di atas daftar. Dari 20 jenis surat, mahasiswa dapat mencari kata “aktif” untuk menemukan layanan yang diperlukan tanpa membaca semua rincian sekaligus. Informasi lengkap ditampilkan setelah pilihan dibuka agar daftar tetap mudah dipindai.

2. **Prinsip: interaksi sentuh yang mudah dan pencegahan salah tekan.** Keputusan desainnya adalah membuat seluruh baris surat dapat diketuk, memberi jarak antaraksi, dan menampilkan tombol utama “Ajukan surat” dengan label yang jelas. Aksi membatalkan pengajuan dipisahkan dari aksi mengirim serta meminta konfirmasi. Alasannya, jari kurang presisi dibandingkan penunjuk mouse dan kesalahan pada pengajuan administrasi menambah pekerjaan mahasiswa maupun petugas.

3. **Prinsip: efisiensi sesi singkat dan feedback yang jelas.** Keputusan desainnya adalah menyimpan pilihan pencarian selama pengguna masih berada dalam alur, menyediakan akses ke pengajuan terakhir, dan menampilkan status dengan teks beserta penanda visual. Saat mengirim, tombol menunjukkan proses dan tidak menerima pengiriman berulang, kemudian sistem menampilkan konfirmasi atau pesan gagal yang bisa ditindaklanjuti. Mahasiswa dapat menyelesaikan satu urusan dalam waktu singkat dan tidak harus menebak apakah pengajuan sudah terkirim.

## Soal 6 — Navigasi dan Interaksi (CPMK-2)

### Metode navigasi dan kapan digunakan

- **`Navigator.push`:** menambahkan halaman ke atas tumpukan route dengan objek route, misalnya `MaterialPageRoute`. Metode ini sesuai ketika halaman tujuan dibuat langsung dan data dikirim melalui konstruktor halaman. Sebagai alternatif navigasi bernama, daftar dapat membuka form dengan konstruktor yang menerima jenis surat.
- **`Navigator.pushNamed`:** membuka halaman berdasarkan nama yang terdaftar, misalnya `/form-pengajuan` atau `/detail-status`. Untuk rancangan tiga halaman ini, `MaterialApp` memakai `initialRoute: '/daftar'` dan peta `routes` yang berisi ketiganya agar pemanggilan tujuan konsisten.
- **`Navigator.pop`:** menutup route paling atas dan kembali ke halaman sebelumnya. Tombol Batal di form kembali ke daftar; pengiriman yang berhasil juga dapat memakai `pop(context, pengajuanBaru)` untuk mengembalikan hasil form kepada daftar.

### Pengiriman data jenis surat ke form

Ketika mahasiswa memilih surat, daftar memanggil `Navigator.pushNamed(context, '/form-pengajuan', arguments: jenisSuratTerpilih)`. Nilainya dapat berupa objek `JenisSurat` yang memiliki ID dan nama layanan, sehingga form tidak perlu menebak pilihan berdasarkan posisi daftar. Pada form, `ModalRoute.of(context)?.settings.arguments` dibaca lalu diperiksa dengan `is JenisSurat`. Jika null atau tipenya salah, tampilkan pesan pilihan surat tidak tersedia dan jalan kembali, bukan melakukan cast tanpa pemeriksaan. Parameter `arguments` memang diteruskan melalui `RouteSettings`, sesuai [dokumentasi `pushNamed`](https://api.flutter.dev/flutter/widgets/Navigator/pushNamed.html).

### Feedback setelah form dikirim

Form memakai `GlobalKey<FormState>` dan validator field. Jika `validate()` gagal, pengguna tetap di form dan melihat pesan pada field yang perlu diperbaiki. Jika valid, pengajuan dibuat atau dikirim, lalu form mengembalikan objek hasil kepada daftar melalui `pop`. Daftar yang menunggu hasil memeriksa bahwa layar masih terpasang, memperbarui state, dan menampilkan `SnackBar` berisi konfirmasi serta ID pengajuan. Setelah itu mahasiswa dapat mengetuk pengajuan tersebut untuk membuka `/detail-status` dengan arguments pengajuan; kegagalan kirim harus menampilkan pesan gagal dan mempertahankan input.

## Soal 7 — Model Data dan State (CPMK-3)

**Mengapa field bersifat `final`:** nilai field ditetapkan sekali saat objek `PengajuanSurat` dibuat sehingga tidak berubah tanpa sengaja melalui assignment berikutnya. Ketika status berubah, aplikasi mengganti objek dengan objek baru yang mempertahankan ID dan membawa status baru; pola ini membuat perubahan lebih mudah ditelusuri. `final` tidak berarti semua objek bersarang otomatis tidak dapat berubah, misalnya isi suatu `List` yang direferensikan field `final` masih dapat dimutasi. Makna penetapan sekali ini sesuai [dokumentasi variabel Dart](https://dart.dev/language/variables).

**Mengapa `id` wajib ada:** ID membedakan pengajuan meskipun mahasiswa mengajukan jenis surat yang sama lebih dari sekali. Operasi membuka detail, memperbarui status, dan menghapus draf memakai ID agar mengenai pengajuan yang benar. Nilai `final` tidak otomatis membuat ID unik; pembentuk ID tetap harus menjamin keunikan dalam kumpulan data.

**Perbedaan widget:** `StatelessWidget` tidak mengelola mutable state sendiri, walaupun tampilannya tetap dapat dibangun ulang ketika konfigurasi atau dependensinya berubah. `StatefulWidget` memiliki objek `State` terpisah yang dapat menyimpan data yang berubah selama layar digunakan. Untuk latihan dengan data dimiliki oleh layar daftar pengajuan, `StatefulWidget` sesuai karena daftar bertambah, berubah status, atau berkurang akibat aksi pengguna. Perbedaan ini dijelaskan pada [dokumentasi widget Flutter](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html).

**Fungsi `setState`:** menjalankan perubahan state secara sinkron dan memberi tahu Flutter agar menjadwalkan pembangunan ulang tampilan yang terkait. Contohnya, penambahan pengajuan ke daftar dilakukan dalam callback `setState` agar item baru terlihat. Jika daftar diubah tanpa pemberitahuan tersebut, datanya tetap berubah di memori, tetapi tampilan belum tentu segera ikut berubah dan mungkin baru berubah ketika ada rebuild lain. Callback `setState` tidak dibuat `async`; operasi asinkron diselesaikan terlebih dahulu, lalu perubahan state dilakukan saat layar masih aktif. Perilaku ini sesuai [dokumentasi `setState`](https://api.flutter.dev/flutter/widgets/State/setState.html).

## Soal 8 — CRUD Lokal (CPMK-3)

| Operasi | Method List / mekanisme | Contoh pada pengajuan surat |
|:--------|:------------------------|:---------------------------|
| Create | `daftarPengajuan.add(pengajuanBaru)` dalam `setState`. | Form valid menghasilkan objek dengan ID unik, kemudian objek ditambahkan ke daftar. |
| Read | Akses `daftarPengajuan[index]` atau iterasi; `ListView.builder` membangun tampilan dari daftar tersebut. | Mahasiswa membaca jenis surat dan status setiap pengajuan. Read tidak harus mengubah state. |
| Update | Cari dengan `indexWhere((item) => item.id == id)`, periksa hasil tidak sama dengan `-1`, lalu ganti elemen dengan objek baru dalam `setState`. | Status sebuah pengajuan berubah dari “Diajukan” menjadi “Diproses” sambil mempertahankan ID. |
| Delete | Setelah pengguna menyetujui `AlertDialog`, jalankan `removeWhere((item) => item.id == id)` dalam `setState`. | Mahasiswa menghapus draf yang dibatalkan; menekan Batal pada dialog tidak mengubah daftar. |

**Mengapa ID dipakai sebagai kunci:** identitas suatu pengajuan harus tetap sama meskipun posisinya berubah. `indexWhere` menggunakan ID untuk menemukan posisi terbaru, dan hasil `-1` harus ditangani ketika data sudah tidak ada. `removeWhere` menghapus semua elemen yang cocok, sehingga keunikan ID penting agar satu operasi tidak menghapus beberapa record sekaligus. Perilaku kedua method dijelaskan dalam [dokumentasi `indexWhere`](https://api.dart.dev/dart-core/List/indexWhere.html) dan [dokumentasi `removeWhere`](https://api.dart.dev/dart-core/List/removeWhere.html).

**Konsekuensi bila index menjadi kunci permanen:** misalnya daftar awal berisi A, B, C dan B berada pada index 1. Setelah A dihapus, index 1 menunjuk C; aksi yang masih menyimpan angka 1 dapat mengubah atau menghapus C. Pengurutan dan penyaringan juga dapat mengubah hubungan posisi terhadap data. Karena itu, simpan ID sebagai identitas, lalu cari posisi saat operasi benar-benar dijalankan.

## Soal 9 — Persistensi Data Lokal (CPMK-3)

**Perbedaan in-memory dan persistensi:** daftar dalam `State` berada di memori proses; ketika aplikasi dihentikan, data tersebut hilang kecuali disimpan di tempat lain. Persistensi menyimpan data di luar memori proses sehingga dapat dibaca kembali saat aplikasi dibuka. `shared_preferences` cocok untuk nilai sederhana seperti pilihan tema, bukan sebagai database transaksi pengajuan resmi. Penyimpanan model kompleks memerlukan representasi yang didukung, misalnya teks JSON.

**Mengapa memakai `Future`:** akses penyimpanan platform dapat membutuhkan waktu sehingga penyelesaiannya dilaporkan melalui hasil asinkron. `await` menunggu hasil pada alur fungsi tersebut tanpa menghentikan seluruh antarmuka. Penjelasan ini sesuai [panduan asinkron Dart](https://dart.dev/libraries/async/async-await). Tidak semua getter paket selalu asinkron: API `SharedPreferences` lama membaca cache secara sinkron setelah inisialisasi, sedangkan `SharedPreferencesAsync` memakai pemanggilan asinkron ke penyimpanan platform.

**Jika `await` diabaikan saat menyimpan:** pemanggilan penyimpanan tetap dimulai, tetapi kode berikutnya berjalan sebelum hasil diketahui. Aplikasi dapat terlalu cepat menampilkan sukses, membaca nilai sebelum operasi selesai, atau tidak menangani kegagalan dengan benar. Hal itu tidak berarti penyimpanan pasti gagal. Bahkan setelah `await`, paket ini tidak menjamin setiap penulisan telah tahan terhadap penghentian mendadak, sehingga tidak sesuai untuk data kritis. Batasan tersebut dijelaskan pada [dokumentasi resmi `shared_preferences`](https://pub.dev/packages/shared_preferences).

**In-memory sudah cukup:** pilihan filter daftar atau data sementara dalam demo CRUD satu sesi yang memang boleh hilang saat aplikasi ditutup.

**Persistensi diperlukan:** pilihan tema yang harus tetap berlaku setelah aplikasi dibuka ulang dapat memakai preferences. Riwayat pengajuan resmi juga harus bertahan, tetapi memerlukan database atau backend yang sesuai agar tidak hilang, dapat diaudit, dan dapat diakses petugas; preferences tidak dijadikan satu-satunya sumber data tersebut.

## Soal 10 — Integrasi Konsep Lintas Pertemuan (CPMK-1 s.d. CPMK-3)

### 1. Arsitektur

Rancangan Perpustakaan Kampus terdiri atas aplikasi Flutter sebagai antarmuka mahasiswa, penyimpanan lokal untuk preferensi atau draf, dan backend Sistem Informasi sebagai sumber data resmi buku serta peminjaman. Aplikasi berkomunikasi dengan backend melalui REST API untuk membaca katalog dan mengirim pengajuan. Pada MVP awal, repository lokal berisi daftar di memori dapat menggantikan layanan tersebut untuk latihan, tetapi belum menjadi sistem peminjaman bersama.

Backend memeriksa identitas mahasiswa, ketersediaan buku, serta aturan peminjaman sebelum mengonfirmasi transaksi. Cache katalog dapat membantu pembacaan saat koneksi terganggu, tetapi stok yang tersimpan lokal tidak menjamin buku masih tersedia. Draf offline baru disebut peminjaman berhasil setelah backend menerima dan mengonfirmasinya.

### 2. Kebutuhan dan alur

- **Must have pertama:** mahasiswa dapat mencari buku dan membaca detail serta ketersediaannya untuk menentukan buku yang dibutuhkan.
- **Must have kedua:** mahasiswa dapat mengajukan peminjaman buku tersedia dan membaca catatan peminjamannya agar hasil pengajuan dapat ditelusuri.

Alur pengguna: buka katalog → cari judul → pilih buku → periksa detail dan ketersediaan → buka form peminjaman → isi serta validasi data → kirim → lihat konfirmasi dan riwayat. Jika buku tidak tersedia, pengajuan tidak dilanjutkan; jika form tidak valid, pengguna memperbaiki field terkait; jika kirim gagal, input dipertahankan dan belum ditandai berhasil.

### 3. Struktur komponen

`MaterialApp` menetapkan tema dan route `/katalog`, `/detail-buku`, `/form-peminjaman`, serta `/riwayat`. Halaman katalog memakai `Scaffold`, `AppBar`, kolom pencarian, dan `Expanded` yang membungkus `ListView.builder`. Item membuka detail dengan arguments objek atau ID buku yang diperiksa tipenya, kemudian tombol Pinjam membuka form untuk buku tersebut.

Form menggunakan `Form`, `GlobalKey<FormState>`, validator nama atau identitas mahasiswa, serta validator durasi sesuai aturan layanan. Controller dibersihkan pada `dispose`. `Navigator.pushNamed` digunakan untuk maju, `Navigator.pop` untuk kembali atau mengembalikan hasil form, dan `SnackBar` memberi konfirmasi atau pesan kegagalan. Data bersama katalog dan riwayat dimiliki state pada tingkat yang dapat diakses kedua halaman atau dikembalikan melalui hasil route, bukan disalin menjadi beberapa daftar yang saling tidak terhubung.

### 4. Data dan state

Model `Buku` memiliki field `final` dan konstruktor dengan parameter `required` berikut:

| Field | Tipe | Fungsi |
|:------|:-----|:-------|
| `id` | `String` | Identitas unik buku. |
| `judul` | `String` | Nama buku untuk pencarian dan tampilan. |
| `penulis` | `String` | Informasi penulis dan pencarian. |
| `kategori` | `String` | Pengelompokan katalog. |
| `rak` | `String` | Lokasi pengambilan buku. |
| `stokTersedia` | `int` | Jumlah eksemplar yang dapat dipinjam; nilainya tidak negatif. |

Transaksi memakai model `Peminjaman` tersendiri dengan `id`, `bukuId`, `mahasiswaId`, `tanggalPinjam`, `jatuhTempo`, dan `status`. Relasi melalui `bukuId` menghubungkan transaksi dengan katalog; meminjam membuat catatan peminjaman baru, bukan membuat buku baru.

Pada MVP lokal, state menyimpan `List<Buku>` dan `List<Peminjaman>`. **Create** dilakukan setelah form valid dan stok masih tersedia: dalam satu perubahan `setState`, tambahkan objek peminjaman ber-ID unik dan ganti objek buku dengan stok dikurangi satu. Jatuh tempo dihitung dari tanggal pinjam dan durasi yang dipilih. **Read** pada katalog dan riwayat menggunakan daftar pada state untuk membangun item; riwayat menampilkan buku terkait, status, serta jatuh tempo. Karena field model `final`, pembaruan stok mengganti objek berdasarkan ID. Pada versi terhubung backend, perubahan transaksi dan stok harus divalidasi secara atomik oleh server agar dua mahasiswa tidak meminjam eksemplar terakhir secara bersamaan.

## Deklarasi penggunaan AI dan referensi

Deklarasi penggunaan AI: ChatGPT — menyusun draf jawaban Soal 1–10 dan memeriksa penjelasan Dart/Flutter terhadap dokumentasi resmi yang ditautkan. Draf ini tidak dinyatakan sebagai jawaban yang dikerjakan mandiri oleh mahasiswa dan belum memenuhi larangan bantuan AI serta referensi pada aturan tes konsep UTS.
