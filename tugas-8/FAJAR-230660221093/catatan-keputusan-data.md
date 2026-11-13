# Catatan Keputusan Data — Glazent.pro

| | |
|:--|:--|
| **Nama** | Fajar |
| **NIM** | 230660221093 |
| **Kelas** | SI-VIIA |

---

## 1. Tabel Keputusan

| Keputusan | Pilihan Anda | Alasan (merujuk kebutuhan) |
|:----------|:-------------|:---------------------------|
| Field model | `id`, `layanan`, `alamat`, `tanggal`, `status` (semua `String`, `final`) | Keempat field selain `id` langsung berasal dari F-01 (isi form pemesanan) dan F-02 (status yang dipantau pelanggan). `tanggal` dibuat `String` agar sesuai input teks bebas pada form; validasi format tanggal belum dilakukan dan dicatat sebagai keterbatasan |
| Kunci data (`id`) | `DateTime.now().millisecondsSinceEpoch.toString()` | Update (F-06) dan Delete harus menemukan pesanan yang tepat. Posisi pada daftar tidak aman dipakai karena berubah saat ada pesanan yang dihapus. Untuk satu perangkat, waktu pembuatan sudah cukup unik; pada backend (Pertemuan 9–10), `id` akan diberikan oleh server |
| Operasi CRUD per kebutuhan | Lihat tabel pada Bagian 2 | Setiap kebutuhan Must have yang melibatkan data harus dipenuhi minimal satu operasi CRUD, dan kebutuhan yang tidak dapat dipenuhi CRUD lokal dicatat sebagai kandidat backend |
| Keputusan persistensi | Tidak diterapkan; data disimpan in-memory pada `List` di `State` | Panduan menyatakan persistensi bersifat opsional. Tanpa `shared_preferences`, kode tetap berjalan di DartPad dan Flutter SDK. Konsekuensinya, data hilang saat aplikasi ditutup. Kebutuhan NF-02 (daftar tetap terbaca saat sinyal lemah) membutuhkan data tersimpan, sehingga persistensi dicatat sebagai pengembangan lanjutan |
| Pola navigasi | Beralih dari route bernama (Tugas 6) ke `MaterialPageRoute` dengan callback melalui konstruktor | Layar daftar menjadi pemilik state, sehingga layar form dan detail perlu menerima fungsi (`onKirim`, `onUbahStatus`, `onHapus`) untuk meminta perubahan data. Pola ini mengikuti materi Pertemuan 7; route bernama pada Tugas 6 tidak dapat membawa callback dengan cara yang sederhana |
| Peran pengguna | Tombol "Jadwalkan" dan "Tandai Selesai" berada pada satu aplikasi tanpa login | Pada Tugas 4, penjadwalan dilakukan pemilik (di luar lingkup aplikasi mobile) dan penandaan selesai dilakukan teknisi (F-06). Prototipe ini menyimulasikan keduanya pada satu perangkat; pemisahan peran membutuhkan autentikasi dan backend |

## 2. Peta CRUD terhadap Kebutuhan

| Kebutuhan | Prioritas | Operasi CRUD | Implementasi pada `crud-lokal.dart` |
|:----------|:----------|:-------------|:------------------------------------|
| F-01 Pelanggan memesan layanan | Must | **Create** | Form Pemesanan memanggil `tambahPesanan` dengan `setState` dan `add` |
| F-02 Pelanggan melihat status pesanan | Must | **Read** | `ListView.builder` membaca `_daftar`; `ChipStatus` menampilkan status |
| F-04 Teknisi melihat daftar tugas harian | Must | **Read** | Daftar yang sama; penyaringan khusus teknisi belum ada |
| F-06 Teknisi menandai pekerjaan selesai | Must | **Update** | `ubahStatus` dengan `indexWhere` dan penggantian objek (`salinDengan`) |
| Pembatalan pesanan yang salah isi | Tidak tercatat sebagai F-xx | **Delete** | `_konfirmasiHapus` dengan `AlertDialog` dan `removeWhere` berdasarkan `id` |

Penjelasan baris Delete: dokumen kebutuhan Tugas 4 tidak memiliki kebutuhan pembatalan pesanan. Operasi Delete tetap diimplementasikan karena materi mewajibkan CRUD lengkap, dan dipakai sebagai pembatalan pesanan yang salah isi, turunan dari F-01. Bila ingin formal, kebutuhan ini perlu ditambahkan pada dokumen Tugas 4 sebagai F-09.

## 3. Kebutuhan yang Tidak Dipenuhi CRUD Lokal

| Kebutuhan | Prioritas | Alasan | Kandidat Pemenuhan |
|:----------|:----------|:-------|:-------------------|
| F-03 Riwayat dan masa garansi | Should | Membutuhkan entitas Garansi dan perhitungan masa berlaku | Entitas baru; data bersama pelanggan dan pemilik, sehingga cocok dengan backend |
| F-05 Unggah foto sebelum/sesudah | Must | Membutuhkan kamera/file dan penyimpanan gambar | Fitur perangkat (Pertemuan 11) dan backend untuk penyimpanan |
| F-07 Cari layanan berdasarkan kategori | Could | Tidak menggunakan data Pesanan | Penyaringan pada katalog layanan |
| F-08 Notifikasi pengingat jadwal | Won't have | Membutuhkan infrastruktur notifikasi | Ditunda sesuai MoSCoW Tugas 4 |
| Data bersama antara pelanggan, pemilik, dan teknisi | — | Data lokal hanya tersimpan di satu perangkat | Backend dan REST API (Pertemuan 9–10) |
