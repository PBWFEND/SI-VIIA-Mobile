# Tugas 10 — Integrasi Data dan Proses Bisnis SI RAKUS

## 1. Deskripsi

Tugas ini menerapkan integrasi dua endpoint REST API pada prototipe SI RAKUS. Aplikasi mengambil data pengguna dari endpoint `/users` dan data aktivitas simulasi dari endpoint `/posts`, kemudian menggabungkannya berdasarkan identifier `users.id` dan `posts.userId`.

**Batasan penting:** API yang digunakan adalah JSONPlaceholder untuk latihan. Data `/posts` bukan transaksi peminjaman buku, bukan data mahasiswa kampus, dan tidak terhubung dengan Libsys. Karena itu, tampilan aplikasi menyebutnya sebagai aktivitas simulasi, bukan riwayat peminjaman sebenarnya.

## 2. Endpoint dan Metode HTTP

| Data | Metode | URL | Kegunaan |
|---|---|---|---|
| Pengguna | GET | `https://jsonplaceholder.typicode.com/users` | Mengambil ID, nama, dan email pengguna simulasi |
| Aktivitas | GET | `https://jsonplaceholder.typicode.com/posts` | Mengambil aktivitas contoh yang mempunyai `userId` |

Kedua request tidak saling bergantung, sehingga dapat dijalankan secara bersamaan menggunakan `Future.wait`.

## 3. Pemetaan Field JSON ke Model Dart

### Model `DataPengguna`

| Key JSON | Field Dart | Tipe | Nilai pengganti |
|---|---|---|---|
| `id` | `id` | `int` | `0` |
| `name` | `nama` | `String` | `Tanpa Nama` |
| `email` | `email` | `String` | `-` |

### Model `DataAktivitasSimulasi`

| Key JSON | Field Dart | Tipe | Nilai pengganti |
|---|---|---|---|
| `id` | `id` | `int` | `0` |
| `userId` | `userId` | `int` | `0` |
| `title` | `judulAktivitas` | `String` | `Tanpa Judul` |
| `body` | `deskripsiAktivitas` | `String` | `-` |

### Model gabungan `RiwayatSimulasiRingkas`

| Sumber | Field model gabungan | Keterangan |
|---|---|---|
| `posts.id` | `id` | ID aktivitas simulasi |
| `posts.userId` | `userId` | Identifier penghubung |
| `users.name` | `namaPengguna` | Nama pemilik aktivitas |
| `users.email` | `emailPengguna` | Email pengguna simulasi |
| `posts.title` | `judulAktivitas` | Judul aktivitas |
| `posts.body` | `deskripsiAktivitas` | Deskripsi aktivitas |

## 4. Identifier dan Aturan Penggabungan

Penggabungan dilakukan dengan mencocokkan:

```text
users.id == posts.userId
```

Contoh: jika sebuah aktivitas mempunyai `userId` bernilai `10`, service mencari pengguna dengan `id` bernilai `10`. Nama dan email pengguna tersebut kemudian digabungkan dengan judul serta deskripsi aktivitas untuk membentuk `RiwayatSimulasiRingkas`.

Jika pengguna dengan ID yang cocok tidak ditemukan, aplikasi menggunakan nilai pengganti `Pengguna tidak ditemukan` dan email `-`.

## 5. Alur Integrasi

1. Halaman `HalamanIntegrasi` memanggil `IntegrasiService.ambilDataTerintegrasi()`.
2. Service mengirim GET ke `/users` dan `/posts` secara bersamaan menggunakan `Future.wait`.
3. Response JSON diperiksa dan diubah menjadi `DataPengguna` serta `DataAktivitasSimulasi`.
4. Service mencocokkan `posts.userId` dengan `users.id`.
5. Data hasil penggabungan dibentuk menjadi `RiwayatSimulasiRingkas`.
6. Halaman menampilkan hasil, atau menampilkan loading, empty, dan error sesuai kondisi.

Diagram lengkap terdapat pada [`diagram-integrasi.md`](diagram-integrasi.md).

## 6. Struktur Folder

```text
lib/
├── main.dart
├── halaman_integrasi.dart
├── models/
│   ├── data_pengguna.dart
│   ├── data_aktivitas_simulasi.dart
│   └── riwayat_simulasi_ringkas.dart
└── services/
    └── integrasi_service.dart
```

## 7. Cara Menjalankan

Pastikan Flutter SDK sudah terpasang dan dependency `http` tercantum pada `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0
```

Jalankan perintah berikut dari folder utama proyek Flutter (folder yang berisi `pubspec.yaml`):

```bash
flutter pub get
flutter analyze
flutter run -d chrome
```

## 8. Status Pengujian yang Sudah Dilaporkan

| Pemeriksaan | Hasil | Bukti/catatan |
|---|---|---|
| `flutter pub get` | Berhasil | Terminal menampilkan `Got dependencies` |
| `flutter analyze` | Berhasil | Terminal menampilkan `No issues found!` |
| Aplikasi berjalan di Chrome | Berhasil | Screenshot sukses integrasi tersedia di `bukti-pengujian/screenshot-sukses-integrasi.png` |
| GET `/users` dan `/posts` | Terlihat berhasil | Data pengguna dan aktivitas tampil pada screenshot |
| Pencocokan `userId` | Terlihat berhasil | Kartu menampilkan `Terhubung melalui userId: 10` |
| Loading | Belum ada screenshot | Ambil bukti saat request masih berlangsung |
| Empty | Belum diuji/dibuktikan | Uji response daftar kosong |
| Error dan tombol coba lagi | Belum diuji/dibuktikan | Uji endpoint salah/offline, lalu tekan Coba Lagi |

Bukti yang tersedia hanya membuktikan kondisi sukses yang terlihat pada screenshot. Jangan menyatakan kondisi loading, empty, error, atau retry telah berhasil diuji sebelum pengujiannya dilakukan dan bukti diambil.

## 9. Batasan API Simulasi

- JSONPlaceholder menyediakan data contoh, bukan backend perpustakaan.
- Data pengguna bukan identitas mahasiswa sebenarnya.
- Data `posts` hanya dipakai untuk mensimulasikan data aktivitas yang terhubung dengan pengguna.
- Aplikasi belum terintegrasi dengan Libsys dan belum menampilkan riwayat peminjaman buku nyata.
- Endpoint simulasi tidak mewakili aturan proses bisnis peminjaman buku, stok, atau transaksi perpustakaan.

## 10. Deklarasi Penggunaan AI

ChatGPT digunakan sebagai asisten pembelajaran untuk membantu menjelaskan konsep REST API, `Future.wait`, pemetaan identifier, dan penyusunan dokumentasi. Kode dan hasil pengujian tetap perlu diperiksa serta dipahami oleh penulis sebelum dikumpulkan.

## 11. Refleksi

Baca dan sesuaikan refleksi pada [`refleksi.md`](refleksi.md) dengan pengalaman pengerjaan yang benar-benar dialami.

## 12. Dokumen Pendamping

- [`diagram-integrasi.md`](diagram-integrasi.md) — diagram alur integrasi dan relasi identifier.
- [`refleksi.md`](refleksi.md) — draf refleksi dan deklarasi penggunaan AI; sesuaikan dengan pengalaman pengerjaan sebenarnya.
- [`quiz-pertemuan-10-jawaban.md`](quiz-pertemuan-10-jawaban.md) — pengerjaan dan jawaban Quiz Pertemuan 10.
