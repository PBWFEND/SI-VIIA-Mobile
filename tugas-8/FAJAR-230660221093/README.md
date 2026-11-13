# UTS — Tes Konsep dan Progress Project (Milestone M4)

| | |
|:--|:--|
| **Nama** | Fajar |
| **NIM** | 230660221093 |
| **Kelas** | SI-VIIA |
| **Domain SI** | Usaha mikro jasa glass cleaning & nanocoating (Glazent.pro) |
| **Judul Aplikasi** | Glazent.pro — Pemesanan & Pelacakan Layanan |

---

## 1. Deskripsi Singkat

Folder ini berisi berkas pengumpulan UTS: jawaban tes konsep, laporan progress project, dan tautan ke artefak Milestone M1–M3 yang sudah dikumpulkan pada Tugas 4–7. Artefak Tugas 4–7 tidak disalin ulang, tetapi ditautkan agar isinya tetap satu sumber.

## 2. Isi Folder

| Berkas | Keterangan |
|:-------|:-----------|
| [`tes-konsep-uts.md`](tes-konsep-uts.md) | Jawaban Soal 1–10 |
| [`laporan-progress-uts.md`](laporan-progress-uts.md) | Laporan progress project mengikuti template Pertemuan 8 |
| `screenshot-daftar.png`, `screenshot-form.png`, `screenshot-hapus.png` | Tangkapan layar yang dipakai pada laporan progress |
| `README.md` | Berkas ini |

## 3. Tautan Artefak M1–M3

| Artefak | Sumber | Berkas Utama |
|:--------|:-------|:-------------|
| Dokumen kebutuhan + user flow (M1) | Tugas 4 | [`dokumen-kebutuhan.md`](../tugas-4/230660221093-Fajar/dokumen-kebutuhan.md), [`user-flow.png`](../tugas-4/230660221093-Fajar/user-flow.png) |
| Prototype UI/UX (M2) | Tugas 5 | [`information-architecture.md`](../tugas-5/230660221093-Fajar/information-architecture.md), [`wireframe.png`](../tugas-5/230660221093-Fajar/wireframe.png), [`halaman-utama.dart`](../tugas-5/230660221093-Fajar/halaman-utama.dart), [`catatan-keputusan-ui.md`](../tugas-5/230660221093-Fajar/catatan-keputusan-ui.md) |
| Navigation flow dan form (M2–M3) | Tugas 6 | [`navigation-flow.md`](../tugas-6/230660221093-Fajar/navigation-flow.md), [`form-interaksi.dart`](../tugas-6/230660221093-Fajar/form-interaksi.dart), [`catatan-keputusan-navigasi.md`](../tugas-6/230660221093-Fajar/catatan-keputusan-navigasi.md) |
| MVP data lokal / CRUD (M3) | Tugas 7 | [`crud-lokal.dart`](../tugas-7/230660221093-Fajar/crud-lokal.dart), [`model-data.md`](../tugas-7/230660221093-Fajar/model-data.md), [`catatan-keputusan-data.md`](../tugas-7/230660221093-Fajar/catatan-keputusan-data.md) |

## 4. Cara Menjalankan MVP

Kode yang didemokan adalah `crud-lokal.dart` (Tugas 7), yang menggabungkan layar dari Tugas 5–6 dan tidak memakai package tambahan.

**Jalur 1 — DartPad:** buka https://dartpad.dev/?template=app, salin seluruh isi `crud-lokal.dart`, lalu tekan Run.

**Jalur 2 — Flutter SDK:** salin `crud-lokal.dart` ke `lib/main.dart` pada project hasil `flutter create`, lalu jalankan `flutter run -d chrome`.

Alur demo mengikuti user flow: tekan "Pesan Layanan Baru", isi form (uji kolom kosong untuk melihat validasi), kirim, lihat daftar bertambah, ketuk kartu, ubah status ("Jadwalkan" lalu "Tandai Selesai"), kemudian hapus pesanan lewat dialog konfirmasi.

## 5. Keterbatasan yang Diketahui

- Data disimpan in-memory sehingga hilang saat aplikasi ditutup; persistensi belum diterapkan.
- Kebutuhan F-03 (riwayat dan garansi), F-05 (foto bukti), dan F-07 (pencarian) belum diimplementasikan; F-04 baru sebagian karena belum ada pemisahan peran.
- Operasi Delete belum memiliki kebutuhan F-xx pada dokumen Tugas 4.

Rincian lengkap tersedia pada [`laporan-progress-uts.md`](laporan-progress-uts.md).
