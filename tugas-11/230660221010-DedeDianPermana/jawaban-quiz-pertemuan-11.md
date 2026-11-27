# Jawaban Quiz Pertemuan 11 — Fitur Perangkat Sesuai Kebutuhan

**Mata Kuliah:** Pemrograman Aplikasi Bergerak  
**Pertemuan:** 11  
**CPMK:** CPMK-3  

**Nama:** Dede Dian Permana  
**NIM:** 230660221010  
**Kelas:** SI-VIIA  

## 1. Pemilihan Fitur

Pemilihan fitur perangkat harus disesuaikan dengan kebutuhan pengguna dan proses bisnis aplikasi. Fitur yang dipilih sebaiknya dapat membantu pengguna menyelesaikan aktivitasnya dengan lebih mudah dan efisien.

Contohnya, pada aplikasi **SiRuang Kampus**, saya memilih fitur File Picker. Fitur ini digunakan agar mahasiswa dapat memilih dokumen pendukung, seperti proposal kegiatan atau surat izin, ketika mengajukan peminjaman ruangan. File Picker dipilih karena sesuai dengan proses bisnis peminjaman ruangan yang membutuhkan dokumen pendukung. Dengan fitur ini, pengguna dapat memilih file dari perangkat tanpa harus memasukkan nama dokumen secara manual.

## 2. Permission

Permission diperlukan karena beberapa fitur perangkat membutuhkan izin pengguna untuk mengakses sumber daya tertentu, seperti kamera, lokasi, mikrofon, atau penyimpanan. Izin tersebut bertujuan menjaga privasi dan keamanan data pengguna.

Aplikasi harus menangani beberapa kondisi berikut:

- **Permission diminta:** Aplikasi menjelaskan atau meminta izin sesuai kebutuhan fitur sebelum mengakses sumber daya perangkat.
- **Permission ditolak:** Aplikasi tidak boleh memaksakan akses. Aplikasi perlu memberikan informasi kepada pengguna bahwa fitur tidak dapat digunakan tanpa izin tersebut.
- **Permission tidak tersedia:** Aplikasi harus menampilkan pesan bahwa fitur atau akses tidak tersedia pada perangkat atau platform yang digunakan, kemudian menangani kondisi tersebut agar aplikasi tidak mengalami error.

Pada project SiRuang Kampus yang menggunakan File Picker di Chrome, pemilihan file dilakukan melalui dialog file dari browser sehingga tidak memerlukan permission runtime seperti akses kamera atau lokasi pada perangkat Android.

## 3. Pembatalan Pemilihan

Nilai `XFile?` yang bernilai `null` menunjukkan bahwa pengguna membatalkan proses pemilihan gambar atau tidak memilih file apa pun. Tanda `?` menunjukkan bahwa variabel tersebut dapat berisi objek `XFile` atau nilai `null`.

Aplikasi harus memeriksa nilai tersebut sebelum memproses file. Jika nilainya `null`, aplikasi tidak boleh melanjutkan proses pembacaan atau pengolahan gambar. Sebaiknya aplikasi menampilkan informasi bahwa pemilihan dibatalkan dan mempertahankan data sebelumnya agar tidak terhapus.

Pada project SiRuang Kampus, konsep pembatalan ini juga diterapkan pada File Picker. Jika pengguna membatalkan pemilihan dokumen, aplikasi menampilkan status pembatalan dan tetap mempertahankan dokumen yang sebelumnya sudah dipilih.

## 4. Service Layer

Service layer bertanggung jawab untuk menangani proses yang berhubungan dengan package atau fitur perangkat, seperti membuka pemilih file, mengambil data file, dan mengelola hasil proses tersebut.

Pemanggilan package sebaiknya tidak ditulis langsung di dalam widget karena dapat membuat kode UI menjadi terlalu kompleks dan sulit dipelihara. Dengan service layer, tanggung jawab antara tampilan dan proses pengolahan data menjadi lebih terpisah.

Pada project SiRuang Kampus, saya membuat class `FileService` pada file `file_service.dart`. Class tersebut bertugas menjalankan proses pemilihan file dan mengambil informasi berupa nama serta ukuran file. Sementara itu, widget pada `main.dart` bertugas menampilkan tombol, indikator loading, status, dan informasi file yang dipilih.

Pemisahan ini membuat kode lebih terstruktur, mudah diuji, dan lebih mudah dikembangkan.

## 5. State Fitur Perangkat

State minimal yang perlu ditangani saat menggunakan fitur perangkat meliputi:

1. **Loading:** Menandakan aplikasi sedang menjalankan proses pemilihan atau pengambilan data dari perangkat.
2. **Success:** Menandakan proses berhasil dan data yang diperoleh dapat ditampilkan.
3. **Canceled:** Menandakan pengguna membatalkan proses pemilihan sehingga aplikasi tidak perlu melanjutkan pengolahan file.
4. **Error:** Menandakan terjadi kesalahan saat menjalankan fitur perangkat.
5. **Permission Denied:** Menandakan pengguna menolak izin yang diperlukan oleh fitur tertentu.

Perlakuan untuk setiap kondisi berbeda. Ketika berhasil, aplikasi menampilkan informasi file yang dipilih. Ketika dibatalkan, aplikasi menghentikan proses tanpa menghapus data sebelumnya. Ketika permission ditolak, aplikasi menampilkan pemberitahuan dan tidak melanjutkan akses yang membutuhkan izin tersebut.

Pada project SiRuang Kampus, state tersebut diterapkan sesuai kebutuhan File Picker. Aplikasi menampilkan indikator loading ketika proses berlangsung, nama dan ukuran file ketika berhasil, status pembatalan ketika pengguna membatalkan pemilihan, serta pesan kesalahan jika proses mengalami kegagalan.

## Kesimpulan

Berdasarkan pengerjaan Tugas 11, fitur perangkat harus dipilih sesuai kebutuhan pengguna dan proses bisnis aplikasi. Penggunaan service layer membantu memisahkan proses fitur perangkat dari tampilan, sedangkan pengelolaan state membuat aplikasi lebih aman dan responsif terhadap berbagai kondisi yang mungkin terjadi.