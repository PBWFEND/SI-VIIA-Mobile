# Tugas 9 — Konsumsi REST API MoneyTrack

## Identitas

- **Nama:** Elangga Yudistira
- **NIM:** 230660221109
- **Kelas:** SI-VIIA
- **Aplikasi:** MoneyTrack Mahasiswa

## Isi folder

- service-api.dart — model TransaksiApi dan service GET/POST.
- halaman-api.dart — halaman Flutter untuk kondisi loading, sukses, error, retry, dan form POST.
- catatan-integrasi-api.md — endpoint, struktur model, dan strategi error.
- screenshot-loading.png — indikator loading saat GET berlangsung.
- screenshot-sukses.png — data transaksi berhasil ditampilkan.
- screenshot-error.png — pesan error dan tombol Coba Lagi.

## Cara menjalankan

Salin service-api.dart dan halaman-api.dart ke folder lib pada proyek Flutter, lalu tambahkan dependency http dengan perintah flutter pub add http. Setelah itu jalankan flutter run -d chrome.

Proyek runnable yang dipakai untuk mengambil screenshot tersedia di folder tugas_9_web pada repository lokal.

## Deklarasi penggunaan AI

Deklarasi penggunaan AI: ChatGPT — membantu menyusun service HTTP, parsing JSON, penanganan timeout dan status code, antarmuka loading/sukses/error, serta dokumentasi; kode, pengujian, dan hasil screenshot diperiksa serta diverifikasi oleh penulis.

## Refleksi

Bagian tersulit adalah memahami alur asynchronous karena UI harus menunjukkan loading sebelum Future GET selesai. Parsing JSON juga membutuhkan perhatian agar field yang null memakai nilai cadangan dan tidak membuat widget gagal dibangun. Penanganan error menjadi penghubung antara kegagalan jaringan, pesan yang informatif, dan tombol Coba Lagi yang dapat mengulang permintaan.
