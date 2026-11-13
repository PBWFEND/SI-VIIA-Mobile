# Tugas 7 — MVP Awal dengan Data Lokal

| | |
|:--|:--|
| **Nama** | Fajar |
| **NIM** | 230660221093 |
| **Kelas** | SI-VIIA |
| **Domain** | Usaha mikro jasa — Glazent.pro (glass cleaning & nanocoating) |

---

## 1. Deskripsi Singkat

Tugas ini mengubah prototipe Tugas 5–6 menjadi MVP awal yang mengelola data lokal. Model `DataPesanan` (id, layanan, alamat, tanggal, status) disimpan pada `State` layar daftar, dan CRUD lengkap berjalan dari antarmuka: pesanan ditambah lewat form (Create), ditampilkan pada daftar (Read), diubah statusnya dari `menunggu` ke `dijadwalkan` dan `selesai` (Update), serta dihapus dengan konfirmasi (Delete). Lihat [`model-data.md`](model-data.md) untuk model data, [`crud-lokal.dart`](crud-lokal.dart) untuk implementasinya, dan [`catatan-keputusan-data.md`](catatan-keputusan-data.md) untuk alasan tiap keputusan.

## 2. Refleksi

Bagian yang paling sulit saya jaga konsistensinya adalah operasi Delete, karena di dokumen kebutuhan Tugas 4 tidak ada kebutuhan F-xx tentang membatalkan pesanan, padahal materi mewajibkan CRUD lengkap. Saya akhirnya memakai Delete sebagai pembatalan pesanan yang salah isi dan mencatatnya di catatan keputusan data, tetapi saya sadar kebutuhan itu seharusnya sudah ada sejak Tugas 4. Dari sini saya belajar bahwa kebutuhan perlu dipikirkan sampai ke operasi datanya sebelum mulai menulis kode, supaya model data, CRUD, dan dokumen kebutuhan tidak berjalan sendiri-sendiri.

## 3. Deklarasi Penggunaan AI

Deklarasi penggunaan AI: Claude (Anthropic) — membantu menyusun kerangka model data, state, CRUD lokal, dan catatan keputusan data berdasarkan domain Glazent.pro serta layar dari Tugas 5–6 yang sudah disusun penulis; hasilnya dirumuskan ulang oleh penulis.
