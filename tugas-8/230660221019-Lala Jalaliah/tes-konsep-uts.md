# Jawaban UTS — Pemrograman Aplikasi Bergerak

**Nama:** Lala Jalaliah
**NIM:** 230660221019
**Kelas:** SI-VIIA 

---

## Soal 1 — Konsep Aplikasi Bergerak dalam SI (CPMK-1)

1. **Karakteristik: Portabilitas dan ketersediaan kapan saja.**
   Contoh penerapan: mahasiswa mengajukan surat keterangan aktif kuliah dari kos pada malam hari lewat ponsel, tanpa datang ke loket dan mengantre.

2. **Karakteristik: Notifikasi push dan konektivitas langsung.**
   Contoh penerapan: mahasiswa menerima notifikasi "Surat siap diambil" meskipun aplikasi tidak sedang dibuka, sehingga tidak perlu bolak-balik mengecek ke loket.

3. **Karakteristik: Akses ke fitur perangkat (kamera, file, penyimpanan lokal).**
   Contoh penerapan: mahasiswa memotret KTM atau dokumen pendukung dengan kamera dan melampirkannya ke pengajuan. Draf formulir juga dapat disimpan lokal agar tidak hilang bila koneksi terputus.

---

## Soal 2 — Dasar Pemrograman Dart (CPMK-1)

- **`List<String> daftarSurat = []`:** membuat list kosong bertipe `String` untuk menyimpan nama jenis surat. Tipe generik memastikan hanya `String` yang dapat dimasukkan.
- **Parameter `String jenis`:** input fungsi berupa nama jenis surat yang akan ditambahkan.
- **`jenis.isEmpty`:** properti yang bernilai `true` bila string kosong, dipakai untuk validasi input.
- **`return` pada kondisi error:** menghentikan fungsi lebih awal (dan mengembalikan pesan error) sehingga data tidak valid tidak diproses lebih lanjut.
- **`daftarSurat.add(jenis)`:** menambahkan jenis surat ke akhir list.
- **Perulangan `for`:** mengiterasi setiap elemen list, misalnya untuk menampilkan atau mencetak seluruh jenis surat.

**Kesalahan umum bila validasi `isEmpty` dihapus:** string kosong ikut masuk ke daftar sehingga muncul item kosong atau tanpa nama di tampilan, dan data tidak valid dapat terkirim ke backend.

---

## Soal 3 — Struktur Flutter dan Widget (CPMK-1)

- **`MaterialApp`:** widget akar yang menyediakan tema Material, routing/navigasi, dan konfigurasi dasar aplikasi.
- **`Scaffold`:** kerangka dasar halaman (app bar, body, floating action button, dan sebagainya).
- **`AppBar`:** bilah judul di bagian atas halaman, dapat berisi judul dan tombol aksi.
- **`Column`:** menyusun widget anak secara vertikal.
- **`Text`:** menampilkan teks.
- **`ListView.builder`:** membuat daftar yang dapat di-scroll dan hanya membangun item yang terlihat (lazy), sehingga efisien untuk daftar panjang.

**Masalah bila `ListView.builder` di dalam `Column` tanpa `Expanded`:** muncul error *"Vertical viewport was given unbounded height"* sehingga layout gagal dirender.

**Penyebab:** `Column` memberi anaknya tinggi tak terbatas, sedangkan `ListView` ingin mengisi tinggi sebanyak mungkin, sehingga tingginya tidak dapat dihitung.

**Perbaikan:** bungkus `ListView.builder` dengan `Expanded` (atau `Flexible`), atau gunakan `shrinkWrap: true` bila daftarnya pendek.

---

## Soal 4 — Analisis Kebutuhan dan User Flow (CPMK-2)

**Klasifikasi dan prioritas:**

| No. | Permintaan | Fungsional/Nonfungsional | Prioritas MoSCoW | Alasan |
|:---:|:---|:---|:---:|:---|
| 1 | Mengajukan surat keterangan aktif kuliah | Fungsional | Must | Fungsi inti aplikasi; tanpanya aplikasi tidak berguna dan masalah antrean loket tidak selesai. |
| 2 | Melihat status pengajuan | Fungsional | Should | Penting untuk transparansi, tetapi pengajuan tetap dapat berjalan tanpanya. |
| 3 | Menerima notifikasi saat surat siap diambil | Fungsional | Could | Menambah kenyamanan, tetapi mahasiswa dapat mengecek status secara manual. Memerlukan infrastruktur tambahan (push notification). |

Ketiganya fungsional karena menyatakan fitur yang dilakukan sistem. Kebutuhan nonfungsional yang muncul dari konteks, misalnya aplikasi harus responsif dan mudah digunakan.

**User flow untuk kebutuhan Must (mengajukan surat):**

1. Mahasiswa membuka aplikasi dan login.
2. Mahasiswa memilih menu "Ajukan Surat".
3. Sistem menampilkan daftar jenis surat.
4. Mahasiswa memilih "Surat Keterangan Aktif Kuliah".
5. Mahasiswa mengisi form (keperluan, dan sebagainya).
6. Sistem memvalidasi input; bila tidak valid, tampilkan pesan error dan kembali ke langkah 5.
7. Sistem menyimpan pengajuan dan menampilkan konfirmasi berhasil.

---

## Soal 5 — UI/UX Mobile (CPMK-2)

1. **Prinsip: Keterbacaan dan hierarki konten (ukuran layar kecil).**
   Keputusan desain: tiap item dibuat sebagai kartu/list tile berisi ikon, nama surat (tebal), dan deskripsi singkat; ukuran font minimal 14-16sp.
   Alasan: layar kecil hanya muat sedikit informasi, sehingga hierarki visual membantu pengguna memindai 20 jenis surat dengan cepat.

2. **Prinsip: Target sentuh yang nyaman (interaksi sentuh).**
   Keputusan desain: tinggi tiap item minimal 48dp dengan jarak antaritem yang cukup, seluruh baris dapat diketuk, dan tombol utama diletakkan dalam jangkauan jempol.
   Alasan: jari kurang presisi dibanding kursor, sehingga target kecil mudah salah tekan.

3. **Prinsip: Efisiensi dan minim langkah (sesi penggunaan singkat).**
   Keputusan desain: sediakan kolom pencarian dan pengelompokan kategori di atas daftar, serta alur dari daftar ke form maksimal 2 ketukan.
   Alasan: pengguna mobile biasanya membuka aplikasi sebentar dengan tujuan jelas, sehingga menggulir 20 item tanpa bantuan pencarian membuang waktu.

---

## Soal 6 — Navigasi dan Interaksi (CPMK-2)

**Metode navigasi dan kapan digunakan:**

- **`push`:** menambah halaman baru ke atas tumpukan dengan `MaterialPageRoute`; dipakai saat data dikirim langsung lewat konstruktor (daftar → form).
- **`pushNamed`:** berpindah memakai nama rute yang didaftarkan di `MaterialApp`; cocok untuk aplikasi dengan banyak halaman agar rute terpusat (misalnya form → detail status).
- **`pop`:** menutup halaman saat ini dan kembali ke halaman sebelumnya (setelah form selesai atau saat tombol kembali ditekan), dapat membawa hasil.

**Pengiriman data jenis surat ke halaman form:** lewat parameter konstruktor halaman form, misalnya:

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => FormPengajuan(jenis: jenisTerpilih)),
);
```

Halaman form menerimanya sebagai field `final String jenis`. Alternatifnya, gunakan `pushNamed` dengan `arguments`.

**Feedback setelah form dikirim:** tampilkan `SnackBar` atau dialog "Pengajuan berhasil", lalu `Navigator.pop` atau `pushReplacement` ke halaman detail status. Bila gagal, tampilkan pesan error validasi di bawah field.

---

## Soal 7 — Model Data dan State (CPMK-3)

**Mengapa setiap field bersifat `final`:** objek model menjadi immutable, sehingga datanya tidak berubah tanpa disengaja. Ini membuat perilaku lebih aman dan terprediksi. Untuk mengubah data, dibuat objek baru (misalnya dengan `copyWith`).

**Mengapa `id` wajib ada:** sebagai identitas unik tiap pengajuan, agar objek yang sama dapat dikenali untuk update, delete, dan pencarian, meskipun isi field lain sama atau urutan list berubah.

**Perbedaan StatelessWidget dan StatefulWidget:** `StatelessWidget` tidak memiliki state yang berubah, sehingga tampilannya hanya bergantung pada input yang diterima. `StatefulWidget` memiliki objek `State` yang dapat berubah selama aplikasi berjalan dan memicu build ulang.

**Halaman daftar menggunakan:** StatefulWidget.

**Alasan:** isi daftar berubah (tambah, ubah, hapus) dan UI harus ikut diperbarui.

**Fungsi `setState`:** memberi tahu Flutter bahwa state berubah sehingga method `build` dijalankan ulang dan UI diperbarui.

**Bila data ditambah tanpa `setState`:** data di list memang bertambah, tetapi tampilan tidak diperbarui sampai ada rebuild lain, sehingga data dan UI tidak sinkron.

---

## Soal 8 — CRUD Lokal (CPMK-3)

| Operasi | Method List / mekanisme |
|:--------|:------------------------|
| Create | `add()` atau `insert()` |
| Read | Iterasi dengan `for`/`ListView.builder`, akses `list[i]`, `where()`, `firstWhere()` |
| Update | Cari item dengan `indexWhere((e) => e.id == id)`, lalu ganti `list[index] = dataBaru` |
| Delete | `removeWhere((e) => e.id == id)` atau `removeAt()` |

**Mengapa `id` digunakan sebagai kunci update dan delete:** `id` bersifat unik dan stabil, tidak berubah walaupun urutan, filter, atau jumlah item berubah.

**Konsekuensi bila index digunakan sebagai kunci:** index bergeser setiap kali ada penghapusan, penyisipan, pengurutan, atau penyaringan. Akibatnya data yang salah dapat terubah atau terhapus, terutama saat daftar sedang difilter atau dicari.

---

## Soal 9 — Persistensi Data Lokal (CPMK-3)

**Perbedaan in-memory dan persistensi:** in-memory menyimpan data di RAM sehingga hilang saat aplikasi ditutup atau di-restart. Persistensi dengan `shared_preferences` menyimpan data (pasangan key-value) di penyimpanan perangkat sehingga tetap ada setelah aplikasi ditutup.

**Mengapa operasi `shared_preferences` asinkron (Future):** membaca dan menulis ke penyimpanan perangkat adalah operasi I/O yang lambat. Dengan `Future`, UI tidak membeku selama operasi berjalan.

**Apa yang terjadi bila `await` diabaikan:** kode berlanjut sebelum penyimpanan selesai. Data bisa belum tersimpan saat dibaca kembali (race condition), aplikasi bisa tertutup sebelum data tertulis, dan error tidak tertangkap oleh `try/catch`.

**Contoh situasi in-memory sudah cukup:** data sementara seperti isi input form yang sedang diketik, hasil pencarian, atau state tampilan (tab aktif).

**Contoh situasi persistensi mutlak diperlukan:** data pengguna yang harus bertahan, seperti draf pengajuan surat, sesi login/token, preferensi tema, atau riwayat peminjaman buku.

---

## Soal 10 — Integrasi Konsep Lintas Pertemuan (CPMK-1 s.d. CPMK-3)

**Solusi: aplikasi mobile untuk unit perpustakaan kampus.**

### 1. Arsitektur

Aplikasi mobile Flutter (UI dan logika state) menyimpan cache/data sementara di penyimpanan lokal (`shared_preferences`) agar tetap dapat menampilkan katalog dan draf saat offline. Data utama (katalog, anggota, transaksi peminjaman) berada di backend Sistem Informasi Perpustakaan yang diakses lewat REST API. Aplikasi menyinkronkan data lokal dengan backend ketika terhubung.

### 2. Kebutuhan dan Alur

**Dua kebutuhan Must have:**

1. Mencari dan melihat katalog buku.
2. Meminjam buku.

**Alur pengguna:** buka aplikasi → login → melihat katalog → mencari/memilih buku → membuka detail → menekan "Pinjam" → mengisi form peminjaman (tanggal kembali) → validasi → konfirmasi berhasil → riwayat peminjaman diperbarui.

### 3. Struktur Komponen

`MaterialApp` → `HalamanKatalog` (`Scaffold`, `AppBar`, kolom pencarian, `Expanded` + `ListView.builder` berisi kartu buku) → `FormPeminjaman` (`Scaffold`, `Form` dengan validasi, tombol kirim) → `HalamanRiwayat`.

Navigasi: `Navigator.push` dari katalog ke form dengan mengirim objek `Buku` lewat konstruktor, `pop` setelah sukses, dan `pushNamed('/riwayat')` untuk membuka riwayat.

### 4. Data dan State

**Model data Buku:**

```dart
class Buku {
  final String id;
  final String judul;
  final String penulis;
  final bool tersedia;

  const Buku({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.tersedia,
  });
}
```

Halaman katalog dan riwayat adalah `StatefulWidget` dengan `List<Buku> riwayat`.

- **Create (meminjam):** `setState(() => riwayat.add(buku))`, lalu simpan ke `shared_preferences` dengan `await`.
- **Read (melihat riwayat):** tampilkan `riwayat` dengan `ListView.builder`, dan muat dari penyimpanan lokal di `initState`.