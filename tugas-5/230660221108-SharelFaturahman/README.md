# Tugas 5 — Prototype UI/UX TaskCampus

**Sharel Faturahman · 230660221108 · SI-VIIA**

TaskCampus membantu mahasiswa memeriksa judul, mata kuliah, tenggat, dan status tugas pribadi (F-01), serta menyaring daftar berdasarkan mata kuliah (F-04). Prototipe membuka layar **Daftar Tugas** dengan data simulasi. Tombol **Tambah Tugas** menampilkan umpan balik pada layar yang sama dan **Form Tambah Tugas** untuk F-02 ditampilkan dalam wireframe.

| Berkas | Isi |
|---|---|
| `information-architecture.md` | Inventaris layar dari Tugas 4, diagram Mermaid, dan alasan pemilihan layar utama. |
| `wireframe.png` | Wireframe beranotasi untuk Daftar Tugas, keadaan kosong setelah penyaringan, dan Form Tambah Tugas. |
| `halaman-utama.dart` | Kode Flutter untuk layar utama, lengkap dengan fungsi `main()`. |
| `screenshot-halaman.png` | Tampilan utuh Daftar Tugas saat kode berjalan pada pratinjau potret di DartPad. |
| `catatan-keputusan-ui.md` | Enam keputusan desain yang ditautkan ke kebutuhan dan persona Tugas 4. |

## Menjalankan Flutter

Di proyek Flutter yang dipakai untuk Tugas 3, salin isi `halaman-utama.dart` ke `lib/main.dart`. Berkas `main.dart` yang disertakan sebagai salinan memiliki kode yang sama. Buka terminal di folder proyek, lalu jalankan perintah berikut.

```bash
flutter run -d chrome
```

Kode juga dapat ditempel ke `lib/main.dart` pada proyek Flutter di DartPad dan dijalankan dengan **Run**.

## Pemeriksaan prototipe

Pemeriksaan berikut dilakukan pada pratinjau Flutter di DartPad.

| Aksi | Hasil pemeriksaan |
|---|---|
| Buka halaman dengan **Semua mata kuliah** | Empat kartu dan ketiga status tampil. |
| Pilih **Analisis Proses Bisnis** | Hanya **Diagram Proses Bisnis** yang tampil. |
| Pilih **Basis Data** | Jumlah menjadi **0 tugas** dan muncul ikon beserta pesan **Belum ada tugas**. |
| Ketuk **Tambah Tugas** | Muncul pesan singkat di halaman yang sama. |

Untuk memeriksa kondisi awal tanpa data, ganti sementara nilai `_contohTugas` dengan `<Tugas>[]`, lalu jalankan ulang. Kembalikan data contoh setelah pemeriksaan.

## Pengumpulan

Salin folder `tugas-5/230660221108-SharelFaturahman/` ke repository GitHub kelas. Folder tersebut memuat enam berkas pengumpulan.

## Refleksi

Bagian yang paling sulit saya jaga konsistensinya adalah penempatan penyaring dan keadaan kosong pada Daftar Tugas. Saya menempatkan penyaring di atas area daftar pada kedua keadaan agar Ari tetap dapat mengganti mata kuliah saat hasilnya kosong. Urutan judul, mata kuliah, tenggat, dan lencana status saya samakan antara wireframe, kode, dan catatan keputusan agar kartu dapat dipindai dengan cara yang sama.

Deklarasi penggunaan AI: ChatGPT/Codex membantu menyusun struktur IA, wireframe, kode Flutter, dan draf dokumentasi, serta memeriksa tampilan prototipe. Hasilnya perlu ditinjau dan dirumuskan ulang oleh penulis sebelum pengumpulan.
