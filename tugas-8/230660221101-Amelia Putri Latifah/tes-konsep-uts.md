# Tes Konsep UTS — Amelia Putri Latifah 230660221101

## Soal 1 — Konsep Aplikasi Bergerak dalam SI
1. **Karakteristik: Konteks bergerak (*Mobility*).**
   * **Contoh penerapan:** Mahasiswa tidak perlu lagi datang ke gedung administrasi pada jam kerja, tetapi bisa langsung membuka ponsel dan mengajukan formulir surat saat sedang berada di kantin atau dalam perjalanan ke luar kota, sehingga mengurai antrean fisik.
2. **Karakteristik: Akses fitur perangkat keras lokal (*Hardware Access*).**
   * **Contoh penerapan:** Mahasiswa dapat menggunakan kamera bawaan ponsel untuk langsung memfoto dokumen pendukung (seperti KTM atau KHS) sebagai lampiran, tanpa perlu melakukan *scan* dokumen menggunakan *scanner* desktop yang merepotkan.
3. **Karakteristik: Personalisasi dan Notifikasi instan (*Push Notification*).**
   * **Contoh penerapan:** Aplikasi dapat mengirimkan notifikasi *pop-up* ke layar kunci ponsel mahasiswa tepat ketika surat mereka sudah dicetak dan siap diambil, mempercepat siklus informasi dibandingkan mengecek status lewat web secara manual.

## Soal 2 — Dasar Pemrograman Dart
* `List<String> daftarSurat = []`: Mendeklarasikan sebuah variabel koleksi berupa daftar (*array*) kosong yang hanya bisa menyimpan tipe data teks (*String*).
* Parameter `String jenis`: Variabel penyimpan nilai teks yang dilemparkan (dikirim) ke dalam fungsi saat fungsi tersebut dipanggil.
* `jenis.isEmpty`: Mengecek apakah teks tersebut kosong (panjang karakternya 0).
* `return` pada kondisi error: Menghentikan paksa eksekusi fungsi lebih awal agar kode di bawahnya (proses penambahan data) tidak dijalankan jika data yang dimasukkan kosong.
* `daftarSurat.add(jenis)`: Memasukkan/menambahkan teks baru dari parameter `jenis` ke urutan paling belakang dari daftar `daftarSurat`.
* Perulangan `for`: Mengeksekusi blok kode pencetakan (`print`) secara berulang sebanyak jumlah item yang ada di dalam `daftarSurat` secara berurutan.

**Kesalahan umum bila validasi `isEmpty` dihapus:** Sistem akan tetap menyimpan entri "teks kosong" atau spasi ke dalam daftar. Saat `tampilkanSurat` dipanggil, UI akan menampilkan urutan kosong yang merusak tata letak atau menyebabkan galat pembacaan saat mencoba memproses data teks tersebut.

## Soal 3 — Struktur Flutter dan Widget
* `MaterialApp`: Pembungkus utama aplikasi yang mengatur tema global dan konfigurasi *routing* (navigasi).
* `Scaffold`: Kerangka dasar halaman yang menyediakan struktur tata letak UI seperti area *header*, *body*, dan *floating button*.
* `AppBar`: Bilah navigasi/judul di bagian paling atas layar.
* `Column`: *Widget* tata letak yang menyusun anak-anaknya (*children*) secara vertikal berderet dari atas ke bawah.
* `Text`: Menampilkan string teks statis di layar.
* `ListView.builder`: Merender daftar elemen (berbasis gulir/scroll) secara dinamis sesuai jumlah data yang ada di *state* atau *list*.

**Masalah bila `ListView.builder` di dalam `Column` tanpa `Expanded`:** 
* **Penyebab:** *Error* "Unbounded height" akan terjadi. `Column` mencoba memberikan ruang tak terbatas ke bawah, sedangkan `ListView` juga mencoba meminta ruang sebanyak-banyaknya untuk menggulir. Keduanya saling bertabrakan sehingga *layout* hancur.
* **Perbaikan:** Bungkus `ListView.builder` dengan *widget* `Expanded` agar daftar tersebut hanya mengambil sisa ruang spesifik yang masih tersedia di dalam `Column`.

## Soal 4 — Analisis Kebutuhan dan User Flow
**Klasifikasi dan prioritas:**
| No. | Permintaan | Fungsional/Nonfungsional | Prioritas MoSCoW | Alasan |
|:---:|:-----------|:-------------------------|:----------------:|:-------|
| 1 | "Mengajukan surat keterangan aktif" | Fungsional | Must | Ini adalah *core business* aplikasi. Tanpa fitur pengajuan, masalah utama antrean manual tidak terpecahkan. |
| 2 | "Melihat status pengajuan" | Fungsional | Must | Mahasiswa butuh transparansi (kapan harus mengambil). Tanpa ini, akan muncul antrean mahasiswa yang sekadar bertanya status ke loket. |
| 3 | "Menerima notifikasi" | Nonfungsional | Could | Memudahkan pengguna, tetapi sifatnya sekunder. Pengguna masih bisa mengecek manual dengan membuka aplikasi (F-02) tanpa notifikasi otomatis. |

**User flow untuk kebutuhan Must (Mengajukan Surat):**
1. Pengguna berada di Halaman Utama (Daftar Surat).
2. Pengguna mengetuk tombol (FAB) "Ajukan Surat Baru".
3. Sistem membuka Halaman Form Pengajuan.
4. Pengguna mengisi jenis surat ("Aktif Kuliah") dan keperluan.
5. Pengguna mengetuk tombol "Kirim Pengajuan".
6. Sistem memvalidasi kolom; jika kosong, tampilkan peringatan dan kembali ke 4.
7. Jika valid, sistem menyimpan data, menampilkan *SnackBar* "Surat diajukan", lalu kembali (pop) ke Halaman Utama.

## Soal 5 — UI/UX Mobile
1. **Prinsip: Ergonomi Sentuh (*Touch Target*).**
   * **Keputusan desain:** Menggunakan *Card* atau *ListTile* dengan bantalan (*padding*) minimal 48x48 dp untuk setiap jenis surat.
   * **Alasan:** Layar *mobile* sempit dan jempol pengguna tidak presisi. *Touch target* yang lebar mencegah mahasiswa salah tekan/mengajukan surat yang keliru.
2. **Prinsip: Pengurangan Beban Kognitif (*Minimalism*).**
   * **Keputusan desain:** Status pengajuan direpresentasikan dengan *Chip* berwarna (*Ternary color*: Hijau untuk Selesai, Kuning untuk Menunggu), alih-alih teks panjang.
   * **Alasan:** Sesi *mobile* sangat singkat. Pengguna hanya butuh memindai (*scan*) warna dengan cepat sambil berjalan tanpa harus membaca deskripsi status yang panjang.
3. **Prinsip: Aksi Utama yang Jelas (*Call to Action*).**
   * **Keputusan desain:** Tombol "Ajukan" dibuat menonjol (*FloatingActionButton.extended* diletakkan di kanan bawah).
   * **Alasan:** Mudah dijangkau jempol tangan kanan (mayoritas pengguna) tanpa perlu meregangkan jari ke atas layar, mempermudah navigasi satu tangan.

## Soal 6 — Navigasi dan Interaksi
**Metode navigasi dan kapan digunakan:**
* `push`: Menambahkan halaman baru di atas tumpukan secara langsung; berguna untuk navigasi *on-the-fly* di luar *routes* (jarang dipakai dalam standar PAB).
* `pushNamed`: Membuka halaman dengan memanggil nama rute (misal `'/form'`) dari `MaterialApp`. Digunakan untuk masuk ke form pengajuan dari beranda.
* `pop`: Menutup halaman teratas. Digunakan saat pembatalan pengajuan, atau setelah selesai menyimpan form untuk kembali ke daftar.

**Pengiriman data:** Data dari halaman daftar dikirim menggunakan *parameter* `arguments` di dalam metode `pushNamed`. Halaman tujuan menangkapnya dengan memanggil `ModalRoute.of(context)?.settings.arguments` secara *read-only*.

**Feedback form:** Diberikan melalui eksekusi `ScaffoldMessenger.of(context).showSnackBar()` tepat sesudah proses validasi (*true*) dan penyimpanan berhasil, sebelum eksekusi `Navigator.pop()`.

## Soal 7 — Model Data dan State
**Mengapa final & wajib `id`:** Setiap *field* bersifat `final` agar status (nilai objek) tidak berubah diam-diam di luar kontrol CRUD (konsep *immutability*). `id` wajib ada sebagai "KTP" identitas unik. Jika terjadi *Update* atau *Delete*, sistem tahu persis data mana yang dimodifikasi, sekalipun namanya sama dengan entitas lain.

**Perbedaan StatelessWidget & StatefulWidget:**
`StatelessWidget` adalah tampilan statis yang tidak bisa berubah setelah digambar, sedangkan `StatefulWidget` memiliki *State* internal untuk merekam perubahan variabel yang bisa me-*render* ulang layar. 

**Penggunaan:** Halaman daftar pengajuan menggunakan **StatefulWidget**. 
**Alasan:** Karena layar ini menyimpan daftar sementara (`_daftar`). Saat ada surat baru dari form, daftar tersebut harus di-refresh secara *real-time* untuk menampilkan *Card* tambahan.

**Fungsi setState:** Untuk memberi tahu *framework* Flutter bahwa ada data yang dimodifikasi, sehingga Flutter wajib memanggil ulang fungsi `build()` untuk memperbarui antarmuka pengguna.
**Tanpa setState:** List `_daftar` di memori akan bertambah 1 data, tetapi layar ponsel pengguna tidak akan menampilkan kartu surat baru tersebut karena UI-nya tidak disuruh untuk menggambar ulang.

## Soal 8 — CRUD Lokal
| Operasi | Method List / mekanisme |
|:--------|:------------------------|
| Create | `list.add(objekBaru)` lalu `setState` |
| Read | `ListView.builder` mengekstrak `list.length` dan `list[index]` |
| Update | Mencari dengan `indexWhere`, membuat salinan objek dengan nilai baru, lalu `list[index] = objekBaru` |
| Delete | `list.removeWhere((item) => item.id == id)` lalu `setState` |

**Mengapa id digunakan sebagai kunci:** `id` bersifat absolut dan permanen menempel pada objek spesifik. 
**Konsekuensi pakai Index:** *Index* bergeser secara dinamis. Jika ada 3 data (Index 0,1,2) dan Anda menghapus data di Index 1, maka data lama Index 2 akan bergeser turun menjadi Index 1 yang baru. Operasi selanjutnya pada Index 1 akan menghantam data yang salah sasaran.

## Soal 9 — Persistensi Data Lokal
**Perbedaan:** *In-memory* (List pada RAM) bersifat sementara/menguap; datanya hancur saat RAM dikosongkan (aplikasi ditutup paksa). Persistensi `shared_preferences` menyimpan string JSON secara fisik ke *storage* (memori internal) perangkat, sehingga data bertahan walau HP dimatikan.

**Asinkron (Future):** Karena sistem I/O (*Input/Output*) untuk menulis/membaca penyimpanan fisik memakan durasi yang tidak instan. 
**Tanpa await:** Jika `await` diabaikan, program akan langsung melompat ke baris bawah atau menutup aplikasi sebelum proses penyimpanan *file* selesai ditulis di memori. Akibatnya, data bisa rusak (korup) atau gagal tersimpan.

**Situasi in-memory cukup:** Saat memegang data filter pencarian sementara atau keranjang *form multi-step* yang datanya akan langsung lenyap usai di-*submit* ke server.
**Situasi persistensi mutlak:** Aplikasi *To-Do List* atau *Offline Mode* agar *user* tidak kehilangan data ketikan panjang yang belum sempat terkirim akibat sinyal *blank-spot*.

## Soal 10 — Integrasi Konsep Lintas Pertemuan
1. **Arsitektur:** 
   Aplikasi mobile berfungsi sebagai klien (*Front-end* UI/UX) bagi mahasiswa. Ketika mahasiswa tidak ada sinyal di perpustakaan, data diparkir di *shared_preferences* (penyimpanan lokal). Begitu ada internet, aplikasi mengirim data tersebut ke Backend Sistem Informasi (Server) melalui antarmuka REST API.
2. **Kebutuhan & Alur:** 
   * **Must have:** (1) Mencari dan melihat status buku. (2) Mengisi form peminjaman.
   * **Alur:** User buka aplikasi -> Lihat katalog -> Tap satu buku -> Masuk form peminjaman -> Isi durasi pinjam -> *Submit* (validasi) -> *SnackBar* berhasil -> Kembali ke Katalog.
3. **Struktur Komponen:** 
   * **Katalog:** `Scaffold` -> `ListView.builder` berisi `Card`.
   * **Form:** `Scaffold` -> `Form` (ber-`GlobalKey`) -> `TextFormField` -> `FilledButton`.
   * **Navigasi:** Katalog memakai `Navigator.pushNamed('/form')`, sedangkan Form memanggil `Navigator.pop(context)` pasca *submit*.
4. **Data & State:**
   * **Model:** `DataBuku` terdiri atas: `final String idBuku`, `String judul`, `String pengarang`, dan `String statusPinjam`.
   * **State (CRUD):** 
     * **Create (Meminjam):** Form menghasilkan *object* `DataBuku` baru dan ditambahkan ke dalam list katalog `List<DataBuku>` di RAM menggunakan `setState()`.
     * **Read (Riwayat):** Halaman riwayat membaca list `List<DataBuku>` dan mem-parsingnya ke dalam tata letak `ListView.builder` dengan menyesuaikan warna *Chip* berdasarkan isi `statusPinjam`.