# Tugas 7 — MVP MoneyTrack dengan Data Lokal

## Deskripsi

Implementasi MVP awal aplikasi **MoneyTrack Mahasiswa** menggunakan data lokal di memori. Aplikasi menyediakan ringkasan saldo, daftar riwayat transaksi, form tambah/ubah transaksi, serta penghapusan dengan dialog konfirmasi.

## Isi folder

- `model-data.md` — model data, pemetaan kebutuhan Tugas 4, dan sumber nilai setiap field.
- `crud-lokal.dart` — implementasi CRUD Flutter tanpa package tambahan.
- `catatan-keputusan-data.md` — keputusan desain data dan alasan yang merujuk kebutuhan.
- `screenshot-daftar.png` — bukti daftar transaksi setelah data ditambahkan.
- `screenshot-hapus.png` — bukti dialog konfirmasi sebelum transaksi dihapus.

## Cara menjalankan

Salin `crud-lokal.dart` ke `lib/main.dart` pada proyek Flutter kosong, kemudian jalankan:

```bash
flutter run -d chrome
```

Data bersifat lokal di memori selama aplikasi berjalan. Pilihan ini sengaja dipakai untuk MVP Tugas 7 agar fokus penilaian tetap pada model data dan operasi CRUD bawaan Flutter.

## Bukti runtime Flutter Web

Kedua screenshot diambil dari aplikasi ini setelah dijalankan di Flutter Web: screenshot-daftar.png menampilkan hasil tambah transaksi melalui form, sedangkan screenshot-hapus.png menampilkan dialog konfirmasi hapus.

## Deklarasi penggunaan AI

Saya menggunakan AI sebagai coding assistant untuk membantu memeriksa pemetaan kebutuhan Tugas 4 ke model data, menyusun kerangka CRUD Flutter, dan merapikan dokumentasi. Saya meninjau ulang nama field, alur `setState`, kunci `id`, serta menjalankan kode sebelum mengumpulkan hasil.

## Refleksi

Bagian paling sulit adalah menjaga agar field transaksi tetap konsisten antara kebutuhan pencatatan, ringkasan keuangan, dan tampilan riwayat. Saya perlu memastikan operasi ubah dan hapus selalu mencari transaksi berdasarkan `id` unik sehingga perubahan tidak bergantung pada posisi item di daftar. Keputusan memakai data lokal di memori membuat MVP mudah diuji, tetapi persistensi permanen perlu direncanakan pada tugas berikutnya.

