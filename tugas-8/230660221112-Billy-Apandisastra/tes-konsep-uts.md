# Tes Konsep UTS — [Billy apandisastra] [230660221112]

## Soal 1 — Konsep Aplikasi Bergerak dalam SI
1. **Karakteristik**: Portabilitas (dapat diakses kapan saja dan di mana saja).
   **Contoh penerapan**: Mahasiswa tidak perlu datang ke kampus; mereka bisa mengajukan surat dari tempat kos atau saat bepergian langsung dari *smartphone*.
2. **Karakteristik**: Fungsionalitas Pemberitahuan Instan (*Push Notifications*).
   **Contoh penerapan**: Aplikasi dapat mengirimkan notifikasi *real-time* ke perangkat mahasiswa segera setelah surat keterangan selesai dicetak oleh admin.
3. **Karakteristik**: Kontekstualitas (integrasi perangkat keras, misal kamera).
   **Contoh penerapan**: Mahasiswa dapat menggunakan kamera HP untuk memotret dan mengunggah dokumen syarat pengajuan (seperti KTM) langsung dari aplikasi tanpa perlu *scanner*.

## Soal 2 — Dasar Pemrograman Dart
- **`List<String>` daftarSurat = []**: Mendeklarasikan dan menginisialisasi memori lokal berupa array (*list*) kosong yang hanya bisa menyimpan tipe data teks (*string*).
- **Parameter `String jenis`**: Nilai input (argumen) bertipe teks yang diterima oleh fungsi, mewakili jenis surat yang ingin ditambahkan.
- **`jenis.isEmpty`**: Metode validasi untuk mengecek apakah input *string* tersebut kosong atau tidak berisi karakter sama sekali.
- **`return` pada kondisi error**: Berfungsi menghentikan eksekusi blok fungsi secara langsung agar kode di bawahnya (proses penambahan data) tidak dijalankan jika data tidak valid.
- **`daftarSurat.add(jenis)`**: Memasukkan/menambahkan data `jenis` baru ke urutan paling akhir di dalam array `daftarSurat`.
- **Perulangan `for`**: Mekanisme untuk mengulang eksekusi kode sebanyak jumlah item di dalam `daftarSurat`, biasanya digunakan untuk merender data ke antarmuka atau mencetak log.

**Kesalahan umum bila validasi `isEmpty` dihapus:** Sistem akan mengizinkan penyimpanan *string* kosong (`""`). Di layar UI, ini akan menghasilkan baris *list* kosong/blank yang membingungkan pengguna dan bisa merusak tata letak antarmuka.

## Soal 3 — Struktur Flutter dan Widget
- **`MaterialApp`**: Widget *root* (akar) yang membungkus seluruh aplikasi, mengatur tema global (`ThemeData`), dan sistem navigasi (*routing*).
- **`Scaffold`**: Menyediakan kerangka layout dasar Material Design untuk satu layar, tempat menaruh AppBar, body, atau FloatingActionButton.
- **`AppBar`**: Menampilkan bilah aplikasi di bagian atas layar untuk judul, menu, dan aksi sekunder.
- **`Column`**: Menyusun kumpulan *widget* turunannya (*children*) secara vertikal dari atas ke bawah.
- **`Text`**: Menampilkan konten berupa teks dengan *style* tertentu pada layar.
- **`ListView.builder`**: Merender daftar elemen yang bisa di-*scroll* secara dinamis dan efisien (hanya merender item yang terlihat di layar).

**Masalah bila `ListView.builder` di dalam `Column` tanpa `Expanded`:**
**Penyebab:** Terjadi *error* `Unbounded height` (tinggi tak terbatas). `Column` memberikan ruang vertikal tak terhingga kepada anak-anaknya, sementara `ListView` berusaha memakan semua ruang yang tersedia. Keduanya mengalami konflik perhitungan ruang.
**Perbaikan:** Bungkus `ListView.builder` dengan widget `Expanded` agar `ListView` hanya mengambil sisa ruang kosong yang pasti pada `Column`.

## Soal 4 — Analisis Kebutuhan dan User Flow
**Klasifikasi dan prioritas:**
| No. | Permintaan | Fungsional/Nonfungsional | Prioritas MoSCoW | Alasan |
|:---:|:-----------|:-------------------------|:----------------:|:-------|
| 1   | "Saya ingin mengajukan surat..." | Fungsional | Must Have | Merupakan fitur inti; aplikasi gagal mencapai tujuan utamanya jika fitur ini tidak ada. |
| 2   | "Saya ingin melihat status..." | Fungsional | Must Have | Mahasiswa wajib mengetahui tindak lanjut suratnya agar tidak perlu datang ke loket. |
| 3   | "Saya ingin menerima notifikasi..." | Fungsional | Should Have | Sangat membantu (proaktif), namun sistem tetap berfungsi baik dengan cek status manual (reaktif). |

**User flow untuk kebutuhan Must:**
1. Pengguna membuka aplikasi dan masuk ke Halaman Beranda.
2. Pengguna memilih menu "Ajukan Surat Baru".
3. Sistem menampilkan Halaman Form Pengajuan.
4. Pengguna mengisi form dan menekan "Kirim".
5. Sistem memvalidasi form (jika gagal, tampilkan pesan error, kembali ke langkah 3).
6. Sistem menyimpan data, menampilkan *SnackBar* "Pengajuan Berhasil", lalu mengalihkan ke Halaman Riwayat.
7. Pengguna melihat status pengajuan terbarunya di daftar riwayat.

## Soal 5 — UI/UX Mobile
1. **Prinsip**: Desain ramah sentuhan (Touch Targets).
   **Keputusan desain**: Menggunakan `ListTile` yang lebar menutupi layar sebagai tombol (*tappable area*) untuk setiap opsi surat, bukan sekadar teks kecil.
   **Alasan**: Jari manusia tidak sepresisi *mouse*. Area sentuh yang besar mencegah pengguna salah menekan jenis surat.
2. **Prinsip**: Minimalisme kognitif (menghindari layar penuh sesak).
   **Keputusan desain**: Hanya menampilkan nama surat dan ikon singkat pada daftar, menyembunyikan detail deskripsi di halaman berikutnya.
   **Alasan**: Ukuran layar HP terbatas; pengguna mencari informasi dengan pola *scanning* visual yang cepat.
3. **Prinsip**: Umpan balik yang jelas (Clear Feedback).
   **Keputusan desain**: Memberikan transisi efek riak (*ripple effect*) dari Material Design dan *SnackBar* bawah saat surat berhasil dipilih.
   **Alasan**: Penggunaan mobile sering dilakukan terburu-buru, sistem harus segera meyakinkan pengguna bahwa aksi sentuhannya telah direkam.

## Soal 6 — Navigasi dan Interaksi
**Metode navigasi dan kapan digunakan:**
- **`push`**: Menambahkan *route* langsung menggunakan `MaterialPageRoute`. Digunakan bila aplikasi sangat sederhana dan tidak menggunakan arsitektur *Named Routes*.
- **`pushNamed`**: Berpindah halaman berdasarkan nama string (contoh: `/form`). Digunakan di aplikasi terstruktur untuk maju dari daftar surat ke form pengajuan.
- **`pop`**: Menghapus layar aktif saat ini. Digunakan untuk kembali ke halaman sebelumnya setelah form pengajuan sukses disimpan atau saat membatalkan.

**Pengiriman data jenis surat ke halaman form:**
Data jenis surat dilempar dengan menyematkannya di dalam properti `arguments` pada fungsi `Navigator.pushNamed(context, '/form', arguments: jenisSurat)`. Halaman form kemudian menangkapnya dengan `ModalRoute.of(context)?.settings.arguments`.

**Feedback setelah form dikirim:**
Menggunakan widget `ScaffoldMessenger.of(context).showSnackBar()`. *SnackBar* ini dipanggil tepat sebelum atau sesudah `Navigator.pop(context)` untuk memberikan notifikasi pop-up sementara di bawah layar tanpa menghalangi UI utama.

## Soal 7 — Model Data dan State
**Mengapa setiap field bersifat `final`**: Untuk memastikan *immutability* (data tidak dapat diubah seenaknya dari luar). Pembaruan state harus dilakukan dengan membuat instansi objek baru agar Flutter dapat memantau perubahannya secara konsisten.
**Mengapa `id` wajib ada**: Sebagai kunci penanda (identifier) unik agar sistem tahu data spesifik mana yang harus diperbarui (*Update*) atau dihapus (*Delete*) tanpa tertukar dengan data yang isinya mirip.

**Perbedaan StatelessWidget dan StatefulWidget**:
`StatelessWidget` adalah layar pasif yang UI-nya tidak pernah berubah setelah digambar. `StatefulWidget` adalah layar aktif yang memiliki objek *State* untuk merender ulang UI secara dinamis saat ada perubahan variabel.
**Halaman daftar menggunakan**: `StatefulWidget`.
**Alasan**: Halaman daftar akan mengalami penambahan atau penghapusan data secara *real-time* saat pengguna mengajukan atau menghapus surat.

**Fungsi `setState`**: Memberitahu *framework* Flutter bahwa ada data yang berubah di memori, sehingga metode `build()` harus dijalankan ulang untuk memperbarui tampilan di layar.
**Apa yang terjadi bila data ditambah tanpa `setState`**: Data di dalam variabel List memori lokal akan bertambah, tetapi UI aplikasi tidak akan berubah atau tidak memunculkan data baru tersebut di layar.

## Soal 8 — CRUD Lokal
| Operasi | Method List / mekanisme |
|:--------|:------------------------|
| Create  | `daftar.add(objekBaru)` |
| Read    | Iterasi menggunakan `ListView.builder` berdasarkan `daftar.length` |
| Update  | Mencari indeks dengan `daftar.indexWhere`, lalu menimpa (`daftar[indeks] = objekBaru`) |
| Delete  | Menghapus spesifik menggunakan `daftar.removeWhere((item) => item.id == id)` |

**Mengapa `id` digunakan sebagai kunci update dan delete:** Karena `id` bersifat tetap dan selalu melekat pada satu objek data spesifik di mana pun data itu berada di dalam *list*.
**Konsekuensi bila index digunakan sebagai kunci:** Jika terjadi pengurutan (*sorting*) atau penghapusan data sebelumnya, posisi elemen di dalam array akan bergeser. Menghapus menggunakan indeks statis bisa menyebabkan data yang salah sasaran ikut terhapus atau diedit.

## Soal 9 — Persistensi Data Lokal
**Perbedaan in-memory dan persistensi:**
In-memory menyimpan data di RAM; data akan hilang sepenuhnya saat aplikasi ditutup (hanya untuk sesi aktif). Persistensi (contoh: `shared_preferences`) menulis data ke disk fisik *smartphone*; data tetap bertahan meski aplikasi ditutup paksa dan dibuka kembali.

**Mengapa operasi `shared_preferences` asinkron (`Future`):** Proses membaca/menulis data ke disk perangkat membutuhkan waktu (*I/O delay*). Pendekatan asinkron mencegah layar UI menjadi *freeze* (macet) sambil menunggu proses selesai.
**Apa yang terjadi bila `await` diabaikan:** Kode di baris bawahnya akan langsung dieksekusi sebelum penyimpanan/pembacaan data selesai. Ini dapat menimbulkan *bug* NullPointer atau data tidak sinkron.

**Contoh situasi in-memory sudah cukup:** Menyimpan daftar filter pencarian aktif atau keranjang pilihan sementara sebelum masuk ke form final.
**Contoh situasi persistensi mutlak diperlukan:** Menyimpan token login akun (*session*), preferensi tema (gelap/terang), atau riwayat data peminjaman agar pengguna tidak perlu *login* atau memuat ulang data dari awal setiap membuka aplikasi.

## Soal 10 — Integrasi Konsep Lintas Pertemuan
**1. Arsitektur:**
Aplikasi mobile (Flutter) bertindak sebagai antarmuka *front-end* yang menyimpan data lokal *in-memory* (sementara waktu saat di-*run*). Data ini merepresentasikan model REST yang nantinya akan berinteraksi dengan *backend* Sistem Informasi perpustakaan kampus via API.
**2. Kebutuhan & Alur:**
Dua kebutuhan Must have: Mencari buku (F-01) dan Reservasi Buku (F-02).
Alur pengguna: Buka aplikasi -> Pilih buku di katalog -> Klik detail buku -> Klik reservasi -> Isi form nama dan NIM -> Submit dan sistem mencatat data reservasi.
**3. Struktur Komponen:**
Menggunakan arsitektur *Named Routes*: `/` untuk layar `KatalogBuku` (berisi `ListView`), `/detail` untuk spesifikasi buku, dan `/reservasi` untuk `FormReservasi`.
**4. Data & State:**
Definisi model `Buku`: `id` (String), `judul` (String), `kategori` (String), `status` (String).
Operasi dikelola melalui `StatefulWidget` di layar utama; *Create* dilakukan dengan fungsi yang menerima parameter dari rute `/reservasi` yang memanggil `setState` untuk melakukan `.add()` ke `List<Reservasi>`, dan *Read* dilakukan dengan `ListView.builder` yang membaca list tersebut.