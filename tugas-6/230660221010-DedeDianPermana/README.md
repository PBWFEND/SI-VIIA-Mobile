\# Tugas 6 — Navigation Flow dan Interaksi



\*\*Nama:\*\* Dede Dian Permana  

\*\*NIM:\*\* 230660221010  

\*\*Kelas:\*\* SI-VIIA  

\*\*Mata Kuliah:\*\* Pemrograman Aplikasi Bergerak  

\*\*Nama Aplikasi:\*\* SiRuang Kampus  

\*\*Domain:\*\* Sistem Informasi Peminjaman Ruang Kelas



\## Deskripsi



Tugas ini mengembangkan prototipe SiRuang Kampus dengan menambahkan navigasi ant halaman dan interaksi formulir. Aplikasi memiliki Halaman Daftar Ruangan, Halaman Detail dan Jadwal Ruangan, serta Halaman Formulir Peminjaman. Navigasi menggunakan `MaterialApp`, `initialRoute`, `routes`, `Navigator.pushNamed`, dan `Navigator.pop`. Data ruangan dikirim melalui `arguments`, sedangkan formulir menggunakan validasi untuk memastikan kolom wajib telah diisi. Setelah formulir valid dikirim, aplikasi menampilkan `SnackBar` sebagai umpan balik simulasi.



\## Daftar Berkas



\- `navigation-flow.md` — dokumentasi route dan diagram navigasi.

\- `form-interaksi.dart` — implementasi navigasi, pengiriman data ruangan, dan validasi formulir.

\- `screenshot-alur.png` — bukti halaman detail ruangan dibuka melalui navigasi dari daftar.

\- `screenshot-feedback.png` — bukti umpan balik `SnackBar` setelah formulir dikirim.

\- `catatan-keputusan-navigasi.md` — catatan keputusan desain navigasi dan interaksi.



\## Refleksi



Bagian tersulit dalam tugas ini adalah menjaga konsistensi nama route, nama halaman, dan alur navigasi antara dokumentasi dengan kode program. Saya menggunakan pengiriman data melalui `arguments` serta validasi formulir agar informasi ruangan dan data peminjaman dapat ditangani dengan lebih terstruktur. Tugas ini membantu saya memahami navigasi ant halaman, pengelolaan input, dan pemberian umpan balik kepada pengguna dalam aplikasi Flutter.



\## Deklarasi Penggunaan AI



Saya menggunakan ChatGPT sebagai alat bantu untuk memahami instruksi tugas, menyusun dokumentasi, dan membantu penulisan kode. Saya tetap perlu memeriksa, menjalankan, dan memahami kode serta hasil implementasi sebelum mengumpulkan tugas.

