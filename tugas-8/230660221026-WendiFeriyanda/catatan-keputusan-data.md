# Catatan Keputusan Data — SI RAKUS

## Identitas

| Keterangan | Data |
|---|---|
| Nama | Wendi Feriyanda |
| NIM | 230660221026 |
| Program Studi | Sistem Informasi |
| Mata Kuliah | Pemrograman Aplikasi Bergerak (PAB) |
| Aplikasi | SI RAKUS (Sistem Rak Kampus) |

## Keputusan Data

| Keputusan | Pilihan | Alasan |
|---|---|---|
| Field model | `id`, `judul`, `penulis`, `penerbit`, `tahunTerbit`, `kategori`, `ringkasan`, dan `stok` | Field diturunkan dari F-01, F-02, F-03, F-04, dan F-08. F-05 dan F-06 tidak dimasukkan karena merupakan data peminjaman pribadi, bukan atribut buku. |
| Kunci data (`id`) | `String` unik yang dibuat sistem | Update dan Delete mencari objek berdasarkan ID, bukan posisi kartu/index yang dapat berubah setelah daftar disaring atau dihapus. |
| Status ketersediaan | Dihitung dari `stok` | Jika `stok > 0`, status “Tersedia”; jika `stok == 0`, status “Stok habis”. Dengan demikian, status tidak disimpan terpisah dan tidak mudah berbeda dari jumlah stok. |
| Create | Form menambahkan objek `DataBuku` ke `List` dengan `setState` | Menjadi latihan penambahan record lokal dan mempertahankan konsistensi field model. |
| Read | `ListView.builder` membaca `List<DataBuku>` dari state | Mendukung tampilan katalog F-01; pencarian berdasarkan judul/penulis mendukung F-02 dan filter kategori mendukung F-08. |
| Update | Mengganti objek berdasarkan hasil `indexWhere` pada ID yang sama | Perubahan data contoh, misalnya stok, dapat ditampilkan kembali tanpa mengubah identitas record. |
| Delete | Dialog `AlertDialog`, lalu `removeWhere` berdasarkan ID | Konfirmasi mencegah penghapusan tidak sengaja dan ID memastikan record yang tepat dihapus. |
| Keputusan persistensi | In-memory menggunakan `List` pada `State`; belum memakai `shared_preferences` | Cakupan tugas minimal adalah CRUD lokal tanpa package tambahan. Konsekuensinya data kembali ke data awal saat aplikasi dijalankan ulang. |

## Batasan Interpretasi

Data yang ditambahkan, diubah, atau dihapus pada prototype merupakan dataset contoh untuk latihan CRUD. Operasi tersebut tidak mengubah katalog resmi perpustakaan dan bukan implementasi F-07 (pengelolaan data koleksi petugas), karena F-07 ditetapkan *Won't have* pada aplikasi mobile mahasiswa.

Data buku belum diambil dari Libsys atau backend. Peminjaman aktif dan riwayat peminjaman juga tidak dimasukkan ke model `DataBuku`; keduanya membutuhkan entitas dan sumber data tersendiri.

## Refleksi

Bagian yang perlu saya jaga konsistensinya adalah hubungan antara field model dan kebutuhan fungsional karena setiap atribut harus memiliki alasan penggunaan yang jelas. Saya juga perlu memastikan operasi Update dan Delete menggunakan ID yang sama agar perubahan tidak mengenai buku lain ketika urutan daftar berubah. Data CRUD pada tugas ini masih disimpan dalam memori sehingga perubahan hanya berlaku selama aplikasi berjalan dan belum menjadi perubahan katalog resmi perpustakaan.

## Deklarasi Penggunaan AI

Deklarasi penggunaan AI: ChatGPT — membantu meninjau hubungan field model dengan kebutuhan Tugas 4, menjelaskan pola CRUD menggunakan `setState`, `indexWhere`, `removeWhere`, dan `AlertDialog`, serta memberi kerangka kode untuk dipelajari; penulis perlu menyelesaikan bagian TODO, menjalankan pengujian, dan menyesuaikan hasil akhir.
