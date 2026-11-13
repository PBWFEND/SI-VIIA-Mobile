# Tugas 6 — Navigation Flow dan Interaksi SI RAKUS

**Nama:** Wendi Feriyanda  
**NIM:** 230660221026  
**Program Studi:** Sistem Informasi  
**Mata Kuliah:** Pemrograman Aplikasi Bergerak (PAB)

## Deskripsi

Tugas ini mengembangkan rancangan SI RAKUS dari Tugas 5 dengan menghubungkan layar melalui named route, mengirim data buku dari katalog ke detail, serta menerapkan form, validasi, dan feedback. Fokus alur utama adalah melihat katalog, membuka detail buku, dan kembali ke katalog, sedangkan form verifikasi akun menjadi simulasi interaksi untuk kebutuhan F-09.

## Daftar berkas

- `navigation-flow.md` — daftar route, diagram alur, pengiriman data, dan alasan initialRoute.
- `form-interaksi.dart` — kerangka implementasi Flutter untuk dikembangkan dan diuji.
- `catatan-keputusan-navigasi.md` — alasan keputusan route, arguments, validator, dan feedback.
- `screenshot-alur.png` — bukti layar Detail Buku terbuka dengan data yang dikirim dari katalog; perlu diambil setelah aplikasi dijalankan.
- `screenshot-feedback.png` — bukti SnackBar setelah form lolos validasi; perlu diambil setelah aplikasi dijalankan.

## Refleksi

Bagian yang paling sulit bagi saya adalah menjaga nama route tetap sama antara diagram navigation flow, peta routes pada Flutter, dan pemanggilan pushNamed karena perbedaan satu karakter dapat menyebabkan route tidak ditemukan. Saya juga perlu memastikan objek buku dikirim dengan tipe yang benar agar layar Detail Buku menampilkan data dari kartu yang dipilih dan tetap aman ketika arguments tidak tersedia. Tantangan lainnya adalah membuat validasi dan feedback yang jelas tanpa menyatakan bahwa akun benar-benar terverifikasi, karena prototype ini belum terhubung dengan backend perpustakaan.

## Deklarasi penggunaan AI

Deklarasi penggunaan AI: ChatGPT — membantu meninjau kesesuaian route dengan IA Tugas 5, menjelaskan pola pengiriman arguments, validasi form, dan feedback; rancangan akhir, penyesuaian kode, serta pengujian dilakukan dan diperiksa kembali oleh penulis.
