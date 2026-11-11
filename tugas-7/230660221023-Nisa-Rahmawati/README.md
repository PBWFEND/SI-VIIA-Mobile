# Tugas 7 — MVP Awal dengan Data Lokal (Sistem Informasi Perpustakaan Kampus)

**Nama:** Nisa Rahmawati  
**NPM:** 230660221023  
**Kelas:** SI-VIIA  
**Mata Kuliah:** Pemrograman Aplikasi Bergerak  

---

## Deskripsi Tugas
Tugas 7 mengimplementasikan MVP (Minimum Viable Product) awal berbasis data lokal *in-memory* pada domain Sistem Informasi Perpustakaan Kampus. Aplikasi ini mendukung operasi CRUD lengkap (Create, Read, Update, Delete) untuk entitas Katalog Buku yang dikelola dalam *state* `StatefulWidget` menggunakan `setState` dan disajikan secara dinamis melalui `ListView.builder`.

---

## Berkas Tugas
1. `model-data.md` — Rincian entitas data buku, tipe, kebutuhan, dan sumber nilai.
2. `crud-lokal.dart` — Kode implementasi model data dan UI CRUD transaksi peminjaman/katalog buku di Flutter.
3. `catatan-keputusan-data.md` — Matriks keputusan struktur data, kunci utama, dan persistensi.
4. `screenshot-daftar.png` — Tangkapan layar tampilan daftar buku hasil operasi tambah.
5. `screenshot-hapus.png` — Tangkapan layar tampilan dialog konfirmasi hapus data buku.

---

## Refleksi
Bagian yang paling sulit dipertahankan konsistensinya adalah menyelaraskan struktur model data `Buku` dengan antarmuka formulir input dan alur pembaruan state (`setState`) pada fungsi *update* dan *delete*. Penulis harus memastikan bahwa objek buku yang diperbarui via bottom sheet menggantikan objek lama secara tepat menggunakan metode `copyWith` tanpa mengubah nilai `id` asli. Pengalaman ini memperkuat pemahaman mengenai manajemen state lokal serta keandalan manipulasi list pada Dart.

---

## Deklarasi Penggunaan AI
Deklarasi penggunaan AI: ChatGPT & Gemini — Digunakan sebagai asisten diskusi untuk membantu perancangan struktur dokumen markdown dan formulasi fungsi `copyWith` serta `indexWhere` pada kode katalog perpustakaan. Seluruh perancangan UI, pengujian operasi CRUD, dan penulisan dokumen diselesaikan secara mandiri oleh penulis.