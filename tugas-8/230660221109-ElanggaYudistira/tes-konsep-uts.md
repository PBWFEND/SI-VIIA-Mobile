# Tes Konsep UTS — Elangga Yudistira (230660221109)

## Soal 1 — Konsep Aplikasi Bergerak dalam SI

Tiga karakteristik aplikasi bergerak yang cocok untuk pengajuan surat keterangan mahasiswa adalah:

1. **Mobilitas dan akses di mana saja.** Mahasiswa dapat membuka aplikasi dari kampus, rumah, atau perjalanan tanpa harus datang ke loket. Contohnya, mahasiswa mengisi pengajuan surat dari ponsel ketika sedang berada di kos.
2. **Interaksi yang sesuai dengan perangkat ponsel.** Layar sentuh, kamera, dan pemilih berkas dapat mempercepat pengisian data. Contohnya, mahasiswa memotret atau mengunggah kartu mahasiswa sebagai lampiran tanpa memindahkan berkas ke komputer.
3. **Notifikasi dan akses kontekstual.** Aplikasi dapat memberi pemberitahuan ketika status pengajuan berubah sehingga mahasiswa tidak perlu berulang kali datang atau menelepon loket. Contohnya, notifikasi dikirim saat surat sudah diverifikasi dan siap diambil.

Solusi mobile lebih tepat untuk kasus ini karena kegiatan pengajuan dan pengecekan status dapat dilakukan segera ketika mahasiswa membutuhkannya, sedangkan aplikasi web desktop lebih bergantung pada ketersediaan komputer dan lokasi tertentu.

## Soal 2 — Dasar Pemrograman Dart

- **List<String> daftarSurat = []:** membuat daftar kosong yang hanya boleh berisi nilai bertipe String, sehingga jenis data surat konsisten sejak awal.
- **Parameter String jenis:** menerima satu nilai teks bernama jenis dari pemanggil fungsi. Tipe String membantu mencegah nilai selain teks masuk ke proses validasi.
- **jenis.isEmpty:** memeriksa apakah teks tidak memiliki karakter. Validasi ini mencegah data kosong dianggap sebagai jenis surat yang sah.
- **return pada kondisi error:** menghentikan fungsi lebih awal ketika input tidak valid. Dengan begitu, baris setelah validasi tidak dijalankan untuk data yang salah.
- **daftarSurat.add(jenis):** menambahkan jenis surat yang sudah lolos validasi ke akhir daftar. Operasi ini merupakan bagian Create pada data lokal.
- **Perulangan for:** membaca setiap elemen daftar satu per satu, misalnya untuk menampilkan semua jenis surat pada halaman daftar.

**Kesalahan umum bila validasi isEmpty dihapus:** pengguna dapat menyimpan string kosong sehingga daftar berisi baris tanpa nama surat. Data tersebut membingungkan pada halaman riwayat dan dapat menyebabkan proses pengajuan berikutnya memakai pilihan yang tidak bermakna.

## Soal 3 — Struktur Flutter dan Widget

- **MaterialApp:** menyediakan struktur dasar aplikasi Material, tema, judul, dan akar navigasi.
- **Scaffold:** menyediakan kerangka satu halaman, seperti area AppBar, body, dan tombol aksi.
- **AppBar:** menampilkan judul halaman dan aksi utama di bagian atas.
- **Column:** menyusun beberapa widget secara vertikal, misalnya judul, ringkasan, dan daftar.
- **Text:** menampilkan teks seperti nama surat, status, atau pesan validasi.
- **ListView.builder:** membuat daftar secara efisien dari data yang tersedia. Item dibuat sesuai kebutuhan sehingga cocok untuk daftar surat yang jumlahnya dapat berubah.

**Masalah bila ListView.builder berada langsung di dalam Column tanpa Expanded:**

**Penyebab:** Column tidak memberi batas tinggi yang cukup kepada ListView, sementara ListView membutuhkan ruang untuk melakukan scrolling. Akibatnya Flutter dapat menampilkan error berupa unbounded height atau overflow.

**Perbaikan:** bungkus ListView.builder dengan Expanded atau Flexible jika Column berada di dalam area yang memiliki tinggi terbatas. Alternatifnya, gunakan satu CustomScrollView atau atur shrinkWrap dan physics ketika daftar memang berada di dalam scrollable lain.

## Soal 4 — Analisis Kebutuhan dan User Flow

Ketiga permintaan pada soal merupakan kebutuhan fungsional karena masing-masing meminta perilaku yang harus dilakukan sistem. Kebutuhan nonfungsional dapat ditambahkan sebagai batas pendukung, misalnya status harus tampil maksimal tiga detik dan notifikasi harus dikirim dalam waktu yang wajar.

| No. | Permintaan | Fungsional/Nonfungsional | Prioritas MoSCoW | Alasan |
|:---:|:-----------|:-------------------------|:----------------:|:-------|
| 1 | Mahasiswa mengajukan surat keterangan aktif kuliah | Fungsional | Must | Ini adalah tujuan utama aplikasi dan tanpa fitur ini masalah loket belum terselesaikan. |
| 2 | Mahasiswa melihat status pengajuan | Fungsional | Must | Status memberi kepastian bahwa pengajuan diterima, diproses, atau perlu diperbaiki. |
| 3 | Mahasiswa menerima notifikasi saat surat siap diambil | Fungsional | Should | Notifikasi sangat membantu mengurangi pengecekan manual, tetapi versi awal masih dapat berjalan dengan halaman status. |

**User flow untuk kebutuhan Must:**

1. Mahasiswa membuka aplikasi.
2. Mahasiswa login atau memilih identitasnya.
3. Mahasiswa memilih menu Pengajuan Surat.
4. Mahasiswa memilih Surat Keterangan Aktif Kuliah.
5. Mahasiswa mengisi data dan melampirkan dokumen yang diminta.
6. Sistem memvalidasi kelengkapan, lalu mahasiswa menekan Kirim.
7. Sistem menyimpan pengajuan dan menampilkan nomor serta status pengajuan.

## Soal 5 — UI/UX Mobile

1. **Keterbacaan pada layar kecil.**  
   **Keputusan desain:** gunakan kartu atau ListTile dengan judul surat, ringkasan status, dan jarak antaritem yang cukup.  
   **Alasan:** hierarki visual membantu mahasiswa memindai daftar 20 jenis surat tanpa membaca paragraf panjang.

2. **Interaksi sentuh yang aman.**  
   **Keputusan desain:** gunakan tombol dan item daftar dengan area sentuh minimal sekitar 48 dp serta jarak yang tidak terlalu rapat.  
   **Alasan:** target yang cukup besar mengurangi salah tekan ketika pengguna memakai ponsel dengan satu tangan.

3. **Efisien untuk sesi singkat.**  
   **Keputusan desain:** sediakan pencarian atau filter kategori di bagian atas dan tampilkan aksi utama secara jelas.  
   **Alasan:** mahasiswa biasanya membuka aplikasi untuk menyelesaikan satu tugas dengan cepat, sehingga tidak perlu menggulir seluruh daftar.

## Soal 6 — Navigasi dan Interaksi

**Metode navigasi dan kapan digunakan:**

- **push:** membuka halaman baru sambil menyimpan halaman sebelumnya pada stack, misalnya dari daftar ke form pengajuan.
- **pushNamed:** membuka halaman berdasarkan nama route yang sudah didaftarkan. Metode ini membantu menjaga nama navigasi konsisten ketika aplikasi memiliki banyak halaman.
- **pop:** menutup halaman aktif dan kembali ke halaman sebelumnya, misalnya setelah form dibatalkan atau berhasil dikirim.

**Pengiriman data jenis surat ke halaman form:** halaman daftar meneruskan objek atau String jenis surat sebagai argument saat memanggil Navigator.push atau Navigator.pushNamed. Halaman form membaca argument tersebut untuk mengisi judul dan memastikan pengajuan dibuat untuk jenis surat yang dipilih.

**Feedback setelah form dikirim:** setelah validasi berhasil dan data disimpan, halaman form dapat menutup dirinya dengan Navigator.pop(context, hasil), kemudian halaman daftar menampilkan SnackBar atau pesan sukses. Jika input belum lengkap, validator pada TextFormField menampilkan pesan di dekat field yang harus diperbaiki.

## Soal 7 — Model Data dan State

**Mengapa setiap field bersifat final:** field final membuat nilai sebuah objek PengajuanSurat tidak berubah secara sembarangan setelah objek dibuat. Immutability ini memudahkan pelacakan perubahan karena pembaruan dilakukan dengan mengganti objek lama menggunakan objek baru yang datanya lengkap.

**Mengapa id wajib ada:** id menjadi identitas unik untuk membedakan dua pengajuan yang mungkin memiliki jenis surat, pemohon, atau tanggal yang sama. Id diperlukan agar operasi update dan delete menargetkan objek yang tepat tanpa bergantung pada posisi item dalam daftar.

**Perbedaan StatelessWidget dan StatefulWidget:** StatelessWidget cocok untuk tampilan yang hanya bergantung pada input dan tidak menyimpan perubahan lokal. StatefulWidget memiliki State yang dapat berubah selama halaman berjalan.

**Halaman daftar menggunakan StatefulWidget.**

**Alasan:** daftar pengajuan berubah ketika pengguna membuat, mengubah, atau menghapus data, sehingga daftar harus disimpan pada State dan dibangun ulang setelah perubahan.

**Fungsi setState:** setState memberi tahu Flutter bahwa data pada State berubah, lalu Flutter menjadwalkan build ulang agar tampilan membaca nilai terbaru.

**Apa yang terjadi bila data ditambah tanpa setState:** objek mungkin memang masuk ke List, tetapi Flutter tidak diberi tahu untuk membangun ulang widget. Akibatnya item baru tidak langsung terlihat sampai ada pemicu build lain.

## Soal 8 — CRUD Lokal

| Operasi | Method List / mekanisme |
|:--------|:------------------------|
| Create | Validasi form lalu List.add atau List.insert di dalam setState. |
| Read | State dibaca oleh ListView.builder atau metode map untuk membangun widget daftar. |
| Update | Cari posisi dengan indexWhere berdasarkan id, lalu ganti objek pada posisi tersebut di dalam setState. |
| Delete | Minta konfirmasi pengguna, lalu gunakan removeWhere dengan kondisi id di dalam setState. |

**Mengapa id digunakan sebagai kunci update dan delete:** id tetap melekat pada objek walaupun daftar diurutkan, difilter, atau item lain dihapus. Dengan id, operasi selalu menunjuk record yang sama.

**Konsekuensi bila index digunakan sebagai kunci:** index dapat berubah setelah penghapusan atau pengurutan. Akibatnya tombol yang semula ditujukan untuk satu data dapat mengubah atau menghapus data lain, terutama ketika daftar sedang difilter.

## Soal 9 — Persistensi Data Lokal

**Perbedaan in-memory dan persistensi:** in-memory menyimpan data hanya pada List atau State selama proses aplikasi berjalan. Data hilang ketika aplikasi ditutup atau dimulai ulang. Persistensi dengan shared_preferences menyimpan nilai sederhana ke penyimpanan perangkat sehingga data dapat dibaca kembali pada sesi berikutnya.

**Mengapa operasi shared_preferences asinkron (Future):** penulisan dan pembacaan berhubungan dengan media penyimpanan, sehingga prosesnya tidak boleh memblokir thread UI. Future memberi tanda bahwa hasil operasi baru tersedia setelah pekerjaan penyimpanan selesai.

**Apa yang terjadi bila await diabaikan:** kode berikutnya dapat berjalan sebelum data benar-benar selesai ditulis. Jika aplikasi langsung ditutup atau halaman membaca data terlalu cepat, nilai lama dapat terbaca atau perubahan belum tersimpan.

**Contoh situasi in-memory sudah cukup:** demo CRUD Tugas 7 atau prototipe form yang hanya perlu diuji dalam satu sesi.

**Contoh situasi persistensi mutlak diperlukan:** aplikasi keuangan seperti MoneyTrack yang harus mempertahankan riwayat transaksi setelah ponsel ditutup, atau aplikasi pengajuan surat yang harus tetap menampilkan status pengajuan pada kunjungan berikutnya.

## Soal 10 — Integrasi Konsep Lintas Pertemuan

1. **Arsitektur:** aplikasi mobile Flutter menjadi antarmuka untuk melihat katalog dan mengajukan peminjaman. State lokal menyimpan daftar buku dan peminjaman sementara agar UI tetap responsif, sedangkan backend Sistem Informasi menyediakan data resmi buku, akun mahasiswa, ketersediaan, dan status peminjaman melalui REST API. Sinkronisasi diperlukan agar jumlah buku yang tampil tidak berbeda dari data perpustakaan.

2. **Kebutuhan & alur:** dua kebutuhan Must Have adalah mahasiswa dapat mencari dan melihat detail buku, serta mahasiswa dapat mengajukan peminjaman buku yang tersedia. Alurnya adalah membuka aplikasi, login, melihat atau mencari katalog, membuka detail buku, menekan Pinjam, mengisi atau memeriksa tanggal pengembalian, mengirim form, menerima feedback sukses, lalu membuka Riwayat untuk membaca status peminjaman.

3. **Struktur komponen:** halaman Katalog menampilkan AppBar, search field, filter, dan ListView.builder. halaman Form Peminjaman menampilkan detail buku, field tanggal, validasi, dan tombol Kirim. Halaman Riwayat menampilkan daftar peminjaman dan detail status. Navigator.push atau pushNamed membuka detail dan form, sedangkan pop mengembalikan hasil peminjaman ke halaman sebelumnya.

4. **Data & state:** model Buku minimal memiliki id String, judul String, penulis String, kategori String, tahunTerbit int, dan tersedia bool. State halaman katalog menyimpan List<Buku> untuk operasi Read. Ketika mahasiswa menekan Pinjam, state dapat menambahkan objek Peminjaman baru melalui setState sebagai bukti Create lokal, lalu halaman Riwayat membaca daftar tersebut dengan ListView.builder sampai data disinkronkan ke backend.
