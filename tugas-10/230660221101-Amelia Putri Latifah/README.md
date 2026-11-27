# Tugas 10 — Integrasi Data dan Proses Bisnis (PresenGo)

- **Nama:** Amelia Putri Latifah
- **NIM:** 230660221101
- **Kelas:** SI-VIIA
- **Domain SI:** Sistem Absensi Organisasi (PresenGo)

## Endpoint dan Metode HTTP
- `GET https://jsonplaceholder.typicode.com/users` — mengambil data pemohon/anggota (`DataPengguna`).
- `GET https://jsonplaceholder.typicode.com/posts` — mengambil data jadwal/pengajuan kegiatan (`DataKegiatanApi`).
- `GET https://jsonplaceholder.typicode.com/comments` — digunakan sebagai data simulasi ruang/sesi kegiatan (`DataRuangSimulasi`).

## Pemetaan Field JSON ke Model Dart
| Model Dart | Field JSON Sumber | Field Model | Nilai Default / Penyesuaian |
| :--- | :--- | :--- | :--- |
| `DataPengguna` | `id`, `name`, `email` | `id`, `nama`, `email` | `0`, `'Anggota Tanpa Nama'`, `'-'` |
| `DataKegiatanApi` | `id`, `userId`, `title`, `body` | `id`, `userId`, `roomId`, `judul`, `keterangan`, `status` | `roomId` dihitung siklik dari `id`; `status` dipetakan ke `StatusJadwal` |
| `DataRuangSimulasi` | `id`, `name` | `id`, `namaRuang`, `waktuSesi` | Dipetakan ke daftar ruang & sesi waktu organisasi |
| `DataJadwalTerintegrasi` | Gabungan 3 model | `id`, `userId`, `namaPemohon`, `namaKegiatan`, `lokasiRuang`, `waktu`, `status` | Dicocokkan menggunakan `userId` dan `roomId` |

## Identifier Penghubung & Penggunaan `Future.wait`
- **Identifier:** `userId` menghubungkan `DataKegiatanApi` dengan `id` pada `DataPengguna`, sedangkan `roomId` menghubungkan data kegiatan dengan `DataRuangSimulasi`.
- **`Future.wait`:** Ketiga request (`GET /users`, `GET /posts`, `GET /comments`) tidak saling bergantung sehingga dijalankan paralel melalui `Future.wait` agar total waktu tunggu lebih singkat dibandingkan request berurutan.

## Batasan API Simulasi
Endpoint publik `jsonplaceholder.typicode.com` bersifat simulasi/dummy sehingga tidak memiliki entitas asli ruang organisasi atau kolom status persetujuan khusus, sehingga pemetaan ruang dan status disesuaikan pada lapisan model/service.

## Cara Menjalankan
```powershell
flutter pub get
flutter analyze
flutter run -d chrome