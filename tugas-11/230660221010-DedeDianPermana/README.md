# Tugas 11 - Integrasi Fitur Perangkat

## Identitas
- Nama: Dede Dian Permana
- NIM: 230660221010
- Kelas: SI-VIIA
- Mata Kuliah: Pemrograman Aplikasi Bergerak

## Nama Aplikasi
SiRuang Kampus - Sistem Informasi Peminjaman Ruang Kelas

## 1. Analisis Fitur

Fitur perangkat yang digunakan adalah File Picker untuk memilih dokumen dari perangkat pengguna.

**Aktor:** Mahasiswa.

**Tujuan:** Mahasiswa dapat memilih dokumen pendukung, seperti proposal kegiatan atau surat izin, sebagai lampiran pengajuan peminjaman ruangan.

**Data keluaran:**
- Nama file.
- Ukuran file.
- Informasi file yang dipilih.

**Alur penggunaan:**
1. Mahasiswa membuka halaman lampiran dokumen.
2. Mahasiswa menekan tombol Pilih Dokumen.
3. Aplikasi membuka pemilih file.
4. Mahasiswa memilih dokumen.
5. Aplikasi menampilkan nama dan ukuran dokumen.
6. Jika pemilihan dibatalkan, aplikasi menampilkan informasi pembatalan dan mempertahankan pilihan sebelumnya.

## 2. Dependensi

Package yang digunakan:

- `file_picker: ^13.4.1`

Package ditambahkan melalui bagian dependencies pada `pubspec.yaml`.

## 3. Pemisahan Kode

Kode dipisahkan menjadi dua bagian:

- `lib/main.dart`: menampilkan antarmuka, status loading, hasil pemilihan file, pesan kesalahan, dan tombol coba lagi.
- `lib/services/file_service.dart`: menjalankan proses pemilihan file dan menangani hasil maupun kesalahan.

## 4. Konfigurasi Platform

**Target pengujian: Web (Google Chrome).**

Pada platform Web, File Picker menggunakan pemilih file yang disediakan browser. Pengguna memilih file melalui dialog pemilihan file dari browser.

Pada pengujian Web, aplikasi tidak meminta izin runtime kamera atau lokasi. Pengguna tetap harus memberikan tindakan memilih file melalui dialog browser.

Jika pengguna membatalkan pemilihan file, service mengembalikan nilai `null`. Aplikasi menampilkan informasi pembatalan dan tetap mempertahankan dokumen yang sebelumnya dipilih.

Jika terjadi kesalahan saat proses pemilihan file, aplikasi menampilkan pesan kesalahan dan menyediakan tombol Coba Lagi. Apabila akses pemilihan file tidak dapat dilakukan karena pembatasan browser, kondisi tersebut ditangani sebagai kesalahan.

Platform Android dan iOS belum menjadi target pengujian pada tugas ini. Jika aplikasi dijalankan pada platform tersebut, integrasi perlu diverifikasi kembali sesuai konfigurasi dan kebijakan izin platform masing-masing.

## 5. Cara Menjalankan Aplikasi

1. Pastikan Flutter SDK sudah terpasang.
2. Buka terminal pada folder proyek.
3. Jalankan perintah:

   `flutter pub get`

4. Jalankan pemeriksaan kode:

   `flutter analyze`

5. Jalankan aplikasi pada Chrome:

   `flutter run -d chrome`

6. Tekan tombol Pilih Dokumen untuk membuka pemilih file.

## 6. Keterbatasan

- Pengujian dilakukan pada platform Web menggunakan Google Chrome.
- Pemilihan file hanya menampilkan informasi file yang dipilih.
- File belum diunggah ke server atau disimpan secara permanen.
- Pengujian pada perangkat Android dan iOS belum dilakukan.
- Perilaku pemilih file dapat berbeda sesuai platform dan browser.

## 7. Hasil Pengujian Awal

Pada pengujian menggunakan Google Chrome, halaman File Picker berhasil dibuka dan aplikasi berhasil menampilkan nama serta ukuran file setelah pengguna memilih dokumen.