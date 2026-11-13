# Tugas 7 — MVP Awal dengan Data Lokal SI RAKUS

## Identitas

| Keterangan | Data |
|---|---|
| Nama | Wendi Feriyanda |
| NIM | 230660221026 |
| Program Studi | Sistem Informasi |
| Mata Kuliah | Pemrograman Aplikasi Bergerak (PAB) |
| Aplikasi | SI RAKUS (Sistem Rak Kampus) |

## Deskripsi

Tugas ini mengembangkan prototype SI RAKUS dengan model data buku dan pengelolaan data lokal. Implementasi menggunakan `StatefulWidget`, `setState`, dan operasi CRUD pada `List<DataBuku>`. Data yang dipakai merupakan dataset contoh untuk pembelajaran, bukan katalog resmi perpustakaan.

## Daftar Berkas

- `model-data.md` — entitas, field, tipe data, kebutuhan terkait, dan sumber nilai.
- `crud-lokal.dart` — kerangka implementasi model dan CRUD lokal Flutter.
- `catatan-keputusan-data.md` — alasan pemilihan field, ID, operasi CRUD, dan penyimpanan.
- `screenshot-daftar.png` — bukti daftar setelah penambahan data.
- `screenshot-hapus.png` — bukti dialog konfirmasi penghapusan.

## Refleksi

Bagian yang paling sulit bagi saya adalah menjaga agar field pada model benar-benar sesuai dengan kebutuhan fungsional yang sudah ditetapkan. Saya perlu memastikan operasi tambah, ubah, dan hapus menggunakan ID unik agar data yang diubah tetap tepat meskipun urutan daftar berubah. Saya juga memahami bahwa penyimpanan in-memory hanya mempertahankan data selama aplikasi berjalan sehingga belum dapat dianggap sebagai penyimpanan permanen.

## Deklarasi Penggunaan AI

Deklarasi penggunaan AI: ChatGPT — membantu meninjau keterkaitan model dengan kebutuhan, menjelaskan konsep CRUD, dan menyediakan kerangka kode pembelajaran; bagian TODO, pengujian, serta penyesuaian akhir dilakukan oleh penulis.

## Status Pengerjaan

- [x] Dokumen model data disiapkan.
- [x] Kerangka CRUD dan form disiapkan.
- [ ] Selesaikan TODO Update dan Delete.
- [ ] Jalankan dan uji seluruh operasi CRUD.
- [ ] Ambil `screenshot-daftar.png` setelah Create dan Read berjalan.
- [ ] Ambil `screenshot-hapus.png` saat AlertDialog konfirmasi tampil.
- [ ] Jalankan `flutter analyze` dan periksa kembali hasilnya.
