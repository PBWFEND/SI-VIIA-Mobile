# Tugas 5 — Prototype UI/UX

**Nama aplikasi:** Perpustakaan Kampus  
**Nama:** Nazwa Aulia Rachma  
**NIM:** 230660221104  
**Domain:** Sistem informasi perpustakaan

## Deskripsi

Tugas ini menerjemahkan kebutuhan Tugas 4 menjadi information architecture, wireframe low fidelity, dan implementasi layar utama Flutter. Layar utama yang dibuat adalah **Beranda / Cari buku**, dengan ringkasan jumlah koleksi, daftar buku, status ketersediaan, satu aksi utama, dan keadaan kosong yang dapat dipulihkan.

## Berkas

- `information-architecture.md` — inventaris layar, diagram IA, dan alasan layar utama.
- `wireframe.png` — wireframe low fidelity dua layar dengan anotasi kebutuhan.
- `halaman-utama.dart` — implementasi layar utama tanpa `Navigator`.
- `screenshot-halaman.png` — bukti hasil halaman yang dijalankan.
- `catatan-keputusan-ui.md` — keputusan visual dan keterlacakan ke Tugas 4.

## Cara menjalankan

Salin `halaman-utama.dart` sebagai `lib/main.dart` pada proyek Flutter, lalu jalankan:

```bash
flutter run -d chrome
```

## Refleksi

Bagian yang paling sulit dipertahankan konsistensinya adalah keadaan kosong karena wireframe harus menunjukkan kondisi itu sementara screenshot utama perlu menampilkan daftar buku. Saya menyamakan keputusan tersebut dengan membuat cabang `daftarBuku.isEmpty` sehingga daftar dan keadaan kosong berasal dari widget yang sama di kode. Catatan keputusan kemudian merujuk langsung pada `daftarBuku.isEmpty`, `ListView.builder`, dan `FloatingActionButton.extended` agar hubungan antara rancangan dan implementasi dapat diperiksa.

## Deklarasi penggunaan AI

Deklarasi penggunaan AI: ChatGPT — membantu meninjau keterlacakan IA, wireframe, keputusan UI/UX, dan struktur widget Flutter; hasilnya dirumuskan ulang oleh penulis.


