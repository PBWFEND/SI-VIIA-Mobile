# Refleksi Pembelajaran — Tugas 10 (PresenGo)

## 1. Bagian Integrasi Data yang Paling Sulit
Menyelaraskan *identifier* antar-endpoint (`userId` dan `roomId`) serta memastikan setiap *field* JSON memiliki *type casting* aman (`as num?`, `as String?`) dan nilai *default* agar tidak gagal saat *parsing* respons dari API simulasi.

## 2. Penanganan Response Kosong atau Error
Kondisi error (gagal jaringan, *timeout*, *status code* non-200, atau *format exception*) dipisahkan dari kondisi data kosong (`list.isEmpty` saat respons sukses): error menampilkan pesan yang ramah beserta tombol **Coba Lagi**, sedangkan data kosong menampilkan informasi bahwa belum ada jadwal yang tercatat.

## 3. Alasan Pemisahan Service dan Widget
Memisahkan logika HTTP, *Future.wait*, *parsing* JSON, dan penggabungan data ke dalam `IntegrasiPresenGoService` membuat widget halaman tetap fokus pada pengelolaan *state* UI (`loading`, `sukses`, `kosong`, `error`) serta memudahkan perawatan dan pengujian kode.

## Deklarasi Penggunaan AI
Deklarasi penggunaan AI: Gemini — membantu menyusun struktur model relasional, penggabungan data dengan `Future.wait`, penanganan *state* halaman, serta draf dokumentasi; seluruh kode dan pengujian di browser diverifikasi langsung oleh penulis.