# Tugas 6 — Navigation Flow dan Interaksi

**Nama aplikasi:** Perpustakaan Kampus  
**Nama:** Nazwa Aulia Rachma  
**NIM:** 230660221104  
**Domain:** Sistem informasi perpustakaan

## Deskripsi

Tugas ini menghubungkan layar dari Tugas 5 menjadi alur navigasi yang dapat digunakan untuk membuka detail buku, mengisi form peminjaman, kembali ke layar sebelumnya, dan menerima feedback melalui `SnackBar`. Implementasi menggunakan `initialRoute`, peta `routes`, `Navigator.pushNamed`, `Navigator.pop`, pemeriksaan tipe arguments, serta validasi form bawaan Flutter.

## Berkas

- `navigation-flow.md` — daftar route, diagram maju/kembali, dan data antarlayar.
- `form-interaksi.dart` — implementasi Flutter lengkap dengan route dan form.
- `screenshot-alur.png` — bukti layar detail terbuka dengan data buku terkirim.
- `screenshot-feedback.png` — bukti `SnackBar` setelah form dikirim.
- `catatan-keputusan-navigasi.md` — keputusan route, data, validator, dan feedback.

## Cara menjalankan

Salin `form-interaksi.dart` sebagai `lib/main.dart` pada proyek Flutter, lalu jalankan:

```bash
flutter run -d chrome
```

## Refleksi

Bagian yang paling sulit dipertahankan konsistensinya adalah nama route dan bentuk arguments karena keduanya harus sama dari diagram sampai pemanggilan `pushNamed`. Saya mengatasinya dengan memakai empat route yang sama persis dan mengirim `Map<String, String>` dari daftar buku ke detail lalu ke form. Catatan keputusan kemudian merujuk langsung pada validator, `Navigator.pop`, dan `SnackBar` agar setiap keputusan dapat dicocokkan dengan perilaku kode.

## Deklarasi penggunaan AI

Deklarasi penggunaan AI: ChatGPT — membantu meninjau kecocokan route, pemeriksaan arguments, validasi form, dan kelengkapan bukti visual; hasilnya dirumuskan ulang oleh penulis.
