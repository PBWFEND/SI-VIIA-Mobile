# Tugas 6 — Navigation Flow dan Interaksi TaskCampus

**Sharel Faturahman · 230660221108 · SI-VIIA**

Tugas 6 menghubungkan **Daftar Tugas**, **Detail Tugas**, dan **Form Tambah Tugas** dari IA Tugas 5. Mahasiswa dapat menambahkan tugas pribadi dengan validasi (F-02), membuka detail dan menyimpan status (F-03), serta melihat atau menyaring tugas di daftar (F-01, F-04). Perubahan data disimpan selama sesi aplikasi berjalan.

| Berkas | Isi |
|---|---|
| `navigation-flow.md` | Tabel route, diagram Mermaid, dan alasan memilih rute awal. |
| `form-interaksi.dart` | Kode Flutter lengkap dengan `main()` dan API bawaan Flutter. |
| `screenshot-alur.png` | Bukti detail tugas yang dibuka dari daftar. |
| `screenshot-feedback.png` | Bukti daftar tugas dan SnackBar setelah form berhasil dikirim. |
| `catatan-keputusan-navigasi.md` | Keputusan tentang rute, data, validasi, feedback, dan kembali. |

## Menjalankan

Gunakan folder web khusus yang sudah tersedia:

```cmd
cd /d "D:\KULIAH\semester 7\sharel\web_flutter"
jalankan.cmd
```

`lib/main.dart` menjadi pintu masuk yang menjalankan kode pada `lib/main-tugas-6.dart`. Kode halaman tersebut disamakan dengan `form-interaksi.dart` pada folder pengumpulan ini. Biarkan CMD tetap terbuka selama aplikasi digunakan; ketik `q` untuk berhenti.

Jika masih ada proses Flutter lama, hentikan dengan `q` lalu jalankan kembali perintah di atas agar Chrome memuat kode terbaru.

## Menampilkan feedback untuk screenshot

1. Pada Daftar Tugas, tekan **Tambah Tugas** untuk membuka formulir.
2. Isi **Judul tugas**, pilih **Mata kuliah**, lalu isi tanggal dengan format `DD/MM/YYYY` dan jam dengan format `HH:MM`. Tanggal dan jam juga dapat dipilih melalui ikon kalender dan jam.
3. Tekan **Simpan**. Jika ada field belum valid, pesan muncul pada field tersebut dan formulir tetap terbuka.
4. Setelah seluruh isian valid dan tugas tidak duplikat, aplikasi kembali ke Daftar Tugas. Tugas baru muncul paling atas dan SnackBar **Tugas berhasil ditambahkan.** tampil di bawah selama 15 detik.
5. Ambil screenshot seluruh jendela Chrome saat pesan terlihat, lalu simpan sebagai `screenshot-feedback.png`. Tombol **Tutup** dapat digunakan untuk menutup pesan lebih awal.

Untuk `screenshot-alur.png`, buka satu kartu tugas dari daftar dan ambil screenshot saat judul, mata kuliah, serta tenggat yang dipilih terlihat pada Detail Tugas.

Kedua PNG yang sudah ada tidak diganti otomatis pada perbaikan ini. Ambil ulang sendiri bila diperlukan agar bukti pengumpulan menunjukkan kode terbaru.

## Perilaku feedback

Pesan keberhasilan muncul setelah hasil simpan diterima oleh daftar pada frame berikutnya. Pesan sebelumnya ditutup terlebih dahulu agar konfirmasi terbaru tidak mengantre. Form kosong atau tugas duplikat menampilkan kesalahan pada field dan tidak menampilkan konfirmasi berhasil; menutup form lewat panah kembali juga tidak menambahkan tugas.

## Verifikasi perbaikan

Pemeriksaan kode Flutter lulus tanpa masalah. Tujuh pengujian interaksi lulus untuk pembukaan form dan kembali, validator form kosong, penyimpanan dan feedback, penutupan otomatis setelah 15 detik, tampilan ponsel 390 × 844, pengiriman data ke detail, serta penolakan duplikat dengan isian tetap tersedia.

Pengujian langsung pada Chrome juga memastikan tombol Tambah membuka form, pengiriman tugas valid kembali ke daftar, pesan berhasil masih terlihat setelah enam detik, dan tombol Tutup bekerja. Pengujian ini tidak mengambil screenshot otomatis.

## Refleksi

Bagian yang paling sulit saya samakan adalah aliran data saat membuka dan menutup Form Tambah Tugas, karena jenis data yang dikirim berbeda pada kedua arah. Form menerima daftar tugas yang sudah tercatat untuk memeriksa duplikat dan hanya mengembalikan satu objek Tugas setelah validasi berhasil. Saya mencocokkan nama rute, jenis data, dan waktu kemunculan SnackBar di diagram, kode, dan catatan keputusan agar alur simpan dapat ditelusuri dari awal sampai akhir.

Deklarasi penggunaan AI: ChatGPT/Codex — membantu memperbaiki peluncur, menyamakan kode web dan pengumpulan, memperjelas feedback, serta menyiapkan pengujian interaksi. Penulis perlu meninjau kode, menguji kembali alur, dan merumuskan ulang refleksi sebelum pengumpulan.
