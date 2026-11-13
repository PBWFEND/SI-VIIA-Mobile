# Tes Konsep UTS — Muhammad Aulia Ramadhani 230660221013

## Soal 1 — Konsep Aplikasi Bergerak dalam SI
1. **Karakteristik: Mobilitas (Akses Kapan Saja & Di Mana Saja)**
   **Contoh penerapan:** Mahasiswa dapat mengajukan surat keterangan dari tempat kos atau saat di jalan tanpa harus datang ke loket administrasi kampus secara fisik pada jam kerja.
2. **Karakteristik: Pemanfaatan Fitur Perangkat (Push Notification)**
   **Contoh penerapan:** Aplikasi dapat mengirimkan notifikasi *real-time* langsung ke layar HP mahasiswa saat surat sudah selesai dicetak dan siap diambil.
3. **Karakteristik: UI/UX Berbasis Sentuhan untuk Sesi Singkat**
   **Contoh penerapan:** Mahasiswa dapat memilih jenis surat dan mengisi form pengajuan hanya dengan beberapa ketukan (tap) di layar dalam waktu kurang dari 2 menit.

## Soal 2 — Dasar Pemrograman Dart
- **`List<String> daftarSurat = []`**: Mendeklarasikan sebuah variabel koleksi (array) kosong yang hanya bisa menampung data bertipe teks (String) untuk menyimpan daftar surat.
- **Parameter `String jenis`**: Variabel inputan pada fungsi `tambahSurat` yang menerima teks jenis surat dari luar fungsi.
- **`jenis.isEmpty`**: Pengecekan kondisi (validasi) apakah string jenis surat kosong (tidak ada karakternya).
- **`return` pada kondisi error**: Menghentikan eksekusi fungsi secara langsung agar kode di bawahnya tidak dijalankan jika terjadi error (validasi gagal).
- **`daftarSurat.add(jenis)`**: Menambahkan data `jenis` yang valid ke elemen paling akhir dari `daftarSurat`.
- **Perulangan `for`**: Melakukan iterasi berdasarkan indeks (dari 0 hingga sebelum panjang list) untuk mencetak seluruh isi daftar surat ke konsol secara berurutan.

**Kesalahan umum bila validasi `isEmpty` dihapus:** 
Sistem akan menyimpan data string kosong (`""`) ke dalam `daftarSurat`. Hal ini menyebabkan daftar dipenuhi oleh data sampah/kosong (blank) yang merusak integritas antarmuka saat ditampilkan.

## Soal 3 — Struktur Flutter dan Widget
- **`MaterialApp`**: Widget root (akar) pembungkus aplikasi yang mengonfigurasi tema, navigasi dasar, dan standar material design secara global.
- **`Scaffold`**: Menyediakan kerangka dasar visual halaman material, mencakup area untuk AppBar, Body, dan FloatingActionButton.
- **`AppBar`**: Menampilkan bilah navigasi di bagian atas layar sebagai penunjuk konteks halaman (judul aplikasi/halaman).
- **`Column`**: Widget layout untuk menyusun children (anak-anak widget) di dalamnya secara vertikal dari atas ke bawah.
- **`Text`**: Widget dasar untuk menampilkan karakter/teks (label) pada antarmuka.
- **`ListView.builder`**: Widget scrollable yang membuat daftar item secara efisien (*lazy loading*) hanya pada bagian yang terlihat di layar.

**Masalah bila `ListView.builder` di dalam `Column` tanpa `Expanded`:**
**Penyebab:** `Column` tidak membatasi tinggi secara bawaan, sedangkan `ListView` mencoba mengambil ruang vertikal sebesar-besarnya (tak terhingga). Pertentangan ini memicu error *Unbounded Height / RenderFlex overflow*.
**Perbaikan:** Bungkus `ListView.builder` dengan widget `Expanded` agar list mengambil *sisa* ruang vertikal yang tersedia di dalam `Column`.

## Soal 4 — Analisis Kebutuhan dan User Flow
**Klasifikasi dan prioritas:**
| No. | Permintaan | Fungsional/Nonfungsional | Prioritas MoSCoW | Alasan |
|:---:|:-----------|:-------------------------|:----------------:|:-------|
| 1 | "Saya ingin mengajukan surat." | Fungsional | Must | Ini adalah inti (core) utama aplikasi; tanpa ini aplikasi tidak berguna. |
| 2 | "Saya ingin melihat status pengajuan." | Fungsional | Must | Pengguna wajib tahu apakah pengajuan diterima, diproses, atau ditolak untuk transparansi. |
| 3 | "Menerima notifikasi saat siap." | Fungsional | Should | Fitur penting untuk kenyamanan ekstra, tetapi sistem masih bisa berjalan manual via cek status (No. 2). |

**User flow untuk kebutuhan Must (Mengajukan Surat):**
1. Buka aplikasi dan masuk ke halaman "Daftar Pengajuan".
2. Ketuk tombol / Floating Action Button "+ Ajukan Surat".
3. Sistem mengarahkan ke halaman "Form Pengajuan".
4. Pilih jenis surat dari *dropdown* dan lengkapi data yang diperlukan.
5. Ketuk tombol "Kirim Pengajuan".
6. Sistem memvalidasi input. Jika sukses, data tersimpan.
7. Sistem mengarahkan kembali ke halaman "Daftar Pengajuan", menampilkan data baru dengan status "Menunggu".

## Soal 5 — UI/UX Mobile
1. **Prinsip: Ukuran Target Sentuh (Touch Target Area)**
   **Keputusan desain:** Menggunakan `ListTile` atau `Card` dengan padding minimal 16px sehingga seluruh area kartu bisa diklik.
   **Alasan:** Jari manusia memiliki luas permukaan sentuh; ukuran *hitbox* minimal 44x44 atau 48x48 dp mencegah *miss-click*.
2. **Prinsip: Hierarki Visual (Visual Hierarchy)**
   **Keputusan desain:** Nama surat dicetak tebal (bold), sedangkan status menggunakan label warna (misal: kuning untuk diproses, hijau untuk selesai).
   **Alasan:** Sesi mobile sangat singkat. Mata pengguna harus bisa langsung memindai (*scan*) informasi paling penting (nama dan status) dalam hitungan detik.
3. **Prinsip: Minimalisme Input Kognitif**
   **Keputusan desain:** Daripada menampilkan banyak ikon asing, gunakan tombol "Ajukan" yang jelas terlihat, atau posisikan 20 surat dalam *list* vertikal dengan fitur pencarian (*search bar*).
   **Alasan:** Menghindari beban kognitif pada layar kecil agar pengguna tidak bingung mencari surat tertentu.

## Soal 6 — Navigasi dan Interaksi
**Metode navigasi dan kapan digunakan:**
- **`push` / `pushNamed`**: Digunakan dari halaman daftar saat pengguna mengetuk tombol "Ajukan" untuk menumpuk halaman "Form Pengajuan" di atas halaman daftar.
- **`pop`**: Digunakan pada "Form Pengajuan" setelah tombol "Kirim" diklik dan data tersimpan, untuk menutup halaman form dan kembali (mundur) ke halaman daftar.

**Pengiriman data ke halaman form:**
Jika menekan tombol "Edit/Lihat", objek jenis surat (misal `PengajuanSurat`) dikirimkan melalui konstruktor (parameter *class*) halaman form, yaitu `FormPengajuan(suratLama: dataSurat)`.

**Feedback setelah form dikirim:**
Setelah `Navigator.pop(context)` dieksekusi, gunakan `ScaffoldMessenger.of(context).showSnackBar()` untuk memunculkan pesan singkat (Toast/Snackbar) bertuliskan "Pengajuan berhasil dikirim!" di layar daftar.

## Soal 7 — Model Data dan State
**Mengapa setiap field bersifat final:** Agar objek yang terbentuk bersifat kekal (*immutable*). Perubahan pada Flutter direpresentasikan dengan membuat objek/*instance* baru, bukan memanipulasi variabel pada objek lama, sehingga State Management dapat mendeteksi perubahan (*diffing*) secara akurat.
**Mengapa id wajib ada:** Digunakan sebagai identifier mutlak/unik pada operasi Update dan Delete agar data tidak tertukar, mengingat atribut seperti "jenis" atau "tanggal" bisa saja sama.

**Perbedaan StatelessWidget dan StatefulWidget:**
`StatelessWidget` layout-nya statis (hanya digambar sekali saat dimuat). `StatefulWidget` memiliki memori internal (`State`) yang bisa merender ulang UI bila datanya berubah.
**Halaman daftar menggunakan:** StatefulWidget.
**Alasan:** Karena halaman daftar perlu memperbarui UI (menambah/menghapus baris) secara langsung ketika *list* pengajuan lokal berubah nilainya.

**Fungsi setState:** Memberitahu *framework* Flutter bahwa ada data yang berubah di dalam `State`, sehingga fungsi `build()` perlu dipanggil ulang untuk menggambar UI terbaru.
**Bila data ditambah tanpa setState:** Data akan sukses masuk ke dalam memori variabel `List`, tetapi layar (UI) tidak akan memunculkan data baru tersebut karena tidak ada perintah *render* ulang.

## Soal 8 — CRUD Lokal
| Operasi | Method List / mekanisme |
|:--------|:------------------------|
| **Create**  | `List.add(objekBaru)` di dalam `setState`. |
| **Read**    | Menampilkan `List` menggunakan `ListView.builder`. |
| **Update**  | Mencari indeks dengan `List.indexWhere`, lalu menimpa elemennya: `list[index] = objekRevisi;` |
| **Delete**  | Menghapus elemen menggunakan `List.removeWhere((item) => item.id == idHapus);` |

**Mengapa id digunakan sebagai kunci update dan delete:** ID selalu melekat secara absolut pada data tersebut di manapun posisinya.
**Konsekuensi bila index digunakan:** Jika data urutan 0 dihapus, data indeks 1 akan turun menjadi 0. Jika ada proses asinkron atau urutan di-*sort*, penghapusan berdasarkan *index* dapat berujung pada penghapusan atau pengubahan data yang salah sasaran.

## Soal 9 — Persistensi Data Lokal
**Perbedaan in-memory dan persistensi:** In-memory menyimpan data di RAM (volatile) sehingga lenyap saat aplikasi ditutup/restart. Persistensi menyimpan data di penyimpanan fisik perangkat (*disk*) menggunakan `shared_preferences` atau SQLite sehingga tetap ada meski aplikasi *force-close*.

**Mengapa shared_preferences asinkron (Future):** Karena proses menulis/membaca penyimpanan memori fisik/SD Card memakan waktu (I/O operation). Framework tidak boleh memblokir UI saat menunggu proses ini selesai.
**Bila await diabaikan:** Baris kode selanjutnya akan tereksekusi sebelum data selesai disimpan (menimbulkan *race condition*). Jika langsung membaca data sesaat setelahnya, bisa jadi data tersebut masih kosong.

**Situasi in-memory cukup:** Menampung teks yang sedang diketik di kolom *search*, indeks tab/bottom navigation aktif, atau keranjang belanja sementara sebelum *checkout*.
**Situasi persistensi mutlak diperlukan:** Menyimpan token sesi *login* JWT, tema aplikasi (Dark/Light mode), dan pengaturan bahasa pengguna agar tidak perlu *login* atau mengatur ulang tema tiap kali aplikasi dibuka.

## Soal 10 — Integrasi Konsep Lintas Pertemuan
1. **Arsitektur:** Aplikasi Mobile bertindak sebagai *Client*. State internal/UI menerima input, yang kemudian disimpan di penyimpanan lokal (sebagai *cache* MVP awal). Ke depannya, interaksi ini diteruskan lewat REST API ke *Backend Sistem Informasi* Perpustakaan (Server dan Database).
2. **Kebutuhan & Alur:** 
   - **Dua Must Have:** 1) Meminjam buku, 2) Melihat riwayat/daftar peminjaman.
   - **Alur pengguna:** Buka aplikasi -> Masuk "Katalog Buku" -> Ketuk salah satu buku -> Masuk "Form Peminjaman" -> Pilih durasi -> Klik "Pinjam" -> Kembali ke Katalog/Daftar -> Lihat data peminjaman dengan status "Dipinjam".
3. **Struktur Komponen:** Halaman Katalog menggunakan `Scaffold` dengan daftar grid/list. Saat item diklik, `Navigator.push` mengirimkan `idBuku` memanggil halaman Form Peminjaman. Setelah form selesai, `Navigator.pop` dijalankan.
4. **Data & State:**
   - **Model Data:** `class BukuPinjam { final String id; final String judul; final String tanggalPinjam; final String status; }`
   - **State Manajemen:** Data ditampung pada `List<BukuPinjam> daftarPinjam` di State halaman utama. **Create** ditangani dengan `setState(() => daftarPinjam.add(bukuBaru))` saat *form return*, dan **Read** merender `daftarPinjam` pada list view.