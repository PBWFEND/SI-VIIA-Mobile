# Tugas 7 — MVP Awal dengan Data Lokal

**Nama:** Lala Jalaliah
**NIM:** 230660221019
**Mata Kuliah:** Pemrograman Aplikasi Bergerak
**Aplikasi:** Pengelolaan Surat Masuk UKM

## Deskripsi

Tugas ini mengembangkan prototipe Tugas 5 dan 6 menjadi MVP awal dengan data lokal. Aplikasi memakai model data `SuratMasuk`, `StatefulWidget`, dan `setState()` untuk menjalankan operasi Create, Read, Update, dan Delete pada `List`. Data disimpan in-memory sehingga kembali ke data awal setelah aplikasi dimulai ulang.

## Refleksi

Bagian yang paling sulit dijaga konsistensinya adalah status surat, karena Tugas 4 hanya mendefinisikan dua status, sedangkan pada model dan CRUD Tugas 7 status dikembangkan menjadi tiga agar tahap pemeriksaan lebih jelas. Kebutuhan F-06 pada Tugas 6 baru berupa rancangan di halaman detail, sehingga pada Tugas 7 harus diwujudkan sebagai operasi Update lewat dialog edit yang memakai `id` sebagai kunci. Karena itu, `model-data.md` dan `catatan-keputusan-data.md` diperbarui setiap kali bentuk data atau operasi CRUD berubah agar setiap field dan operasi tetap dapat ditelusuri ke kebutuhan Tugas 4.

## Deklarasi Penggunaan AI

Deklarasi penggunaan AI: ChatGPT — membantu memahami kode dan menyusun dokumentasi; Claude — membantu merapikan dokumentasi (model-data.md, catatan-keputusan-data.md, dan README) agar konsisten dengan Tugas 4–6; perbaikan kode, pengujian, dan penjelasan dilakukan serta diverifikasi oleh penulis.