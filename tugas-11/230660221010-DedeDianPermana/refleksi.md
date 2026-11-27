# Refleksi Tugas 11 - Integrasi Fitur Perangkat

## 1. Alasan Pemilihan Fitur

Pada tugas ini saya memilih fitur File Picker karena sesuai dengan kebutuhan aplikasi SiRuang Kampus, yaitu sistem informasi peminjaman ruang kelas.

Mahasiswa membutuhkan fitur untuk memilih dokumen pendukung seperti proposal kegiatan atau surat izin ketika mengajukan peminjaman ruangan.

Saya menggunakan package `file_picker` karena dapat membantu aplikasi mengakses pemilih file pada perangkat pengguna. Fitur ini diuji menggunakan Google Chrome pada platform Web.

## 2. Alasan Pemisahan Service dan Widget

Proses pemilihan file dipisahkan ke dalam class `FileService`, sedangkan tampilan dan interaksi pengguna ditempatkan pada `main.dart`.

Pemisahan ini bertujuan agar kode lebih terstruktur dan mudah dikembangkan. Service bertanggung jawab menjalankan proses pemilihan file, sedangkan widget bertanggung jawab menampilkan loading, hasil pemilihan, pembatalan, dan pesan kesalahan.

## 3. Kendala dan Solusi

Kendala yang ditemukan adalah penyesuaian penggunaan package File Picker dengan versi package yang digunakan pada proyek Flutter.

Solusinya adalah menyesuaikan kode dengan versi `file_picker` yang terpasang, yaitu versi `13.4.1`.

Selain itu, dilakukan penyesuaian agar aplikasi dapat membedakan ketika pengguna membatalkan pemilihan file dan ketika terjadi kesalahan saat proses pemilihan.

## 4. Hasil Pengujian

| No. | Skenario | Hasil yang Diharapkan | Hasil Aktual |
|---|---|---|---|
| 1 | Pengguna berhasil memilih file | Nama dan ukuran file ditampilkan | Berhasil diuji di Chrome. Nama dan ukuran file tampil. |
| 2 | Pengguna membatalkan pemilihan file | Aplikasi menampilkan informasi pembatalan dan mempertahankan pilihan sebelumnya | Berhasil diuji di Chrome. Aplikasi menampilkan informasi pembatalan dan tetap mempertahankan dokumen sebelumnya. |
| 3 | Akses pemilihan file ditolak | Aplikasi menampilkan informasi kesalahan dan menyediakan tombol coba lagi | Tidak diuji sebagai penolakan izin terpisah pada Web. Browser menggunakan dialog pemilihan file. |
| 4 | Terjadi kesalahan package atau perangkat | Aplikasi menampilkan pesan kesalahan dan menyediakan tombol coba lagi | Belum diuji dengan simulasi kesalahan. |

**Catatan:** Pengujian dilakukan pada Google Chrome. Platform Web tidak menggunakan mekanisme izin runtime Android seperti kamera atau lokasi untuk pemilihan file melalui dialog browser.

## 5. Kesimpulan

Melalui tugas ini saya memahami cara mengintegrasikan fitur perangkat menggunakan package Flutter, memisahkan service dari widget, menangani proses asynchronous, serta menampilkan kondisi loading, keberhasilan, pembatalan, dan kesalahan.

Fitur File Picker berhasil digunakan untuk memilih dokumen dan menampilkan informasi file pada aplikasi SiRuang Kampus.

## 6. Deklarasi Penggunaan AI

Dalam pengerjaan tugas ini, saya menggunakan ChatGPT sebagai alat bantu untuk memahami instruksi tugas, mempelajari penggunaan package File Picker, membantu menyusun kode, dan memeriksa kesalahan program.

Saya tetap melakukan penyesuaian kode, menjalankan aplikasi, dan menguji fitur secara langsung menggunakan Google Chrome.