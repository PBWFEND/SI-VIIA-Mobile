# Tugas 1 - Identifikasi Kebutuhan Aplikasi Bergerak

**Nama:** Sharel Faturahman  
**NIM:** 230660221108

## 1. Deskripsi Sistem

TaskCampus merupakan aplikasi bergerak yang digunakan mahasiswa untuk mencatat dan mengelola tugas dari berbagai mata kuliah dalam satu tempat. Pengguna utama aplikasi adalah mahasiswa, yang dapat menambahkan tugas, mengelompokkannya berdasarkan mata kuliah, menentukan tenggat pengumpulan, memperbarui status pengerjaan, serta menerima pengingat deadline. Permasalahan yang hendak ditangani adalah informasi tugas dan tenggat dapat tersebar di catatan pribadi, grup komunikasi, dan platform pembelajaran yang berbeda, sehingga mahasiswa perlu memeriksa beberapa sumber untuk mengetahui tugas yang harus dikerjakan dan progres penyelesaiannya. Aplikasi mobile dipilih karena interaksi sentuh memudahkan mahasiswa memasukkan atau memperbarui informasi melalui form, sesi penggunaan yang singkat mendukung pemeriksaan daftar tugas secara cepat, dan konteks bergerak memungkinkan mahasiswa memantau tenggat di sela aktivitas kampus. Pengingat lokal pada perangkat juga membantu mahasiswa memperoleh pemberitahuan tanpa harus terus-menerus membuka aplikasi.

## 2. Diagram Arsitektur

Alur komunikasi sistem:

`Aplikasi Mobile TaskCampus (Flutter) → HTTP Request (JSON) → Backend SI TaskCampus (REST API) → Database TaskCampus → HTTP Response (JSON) → Aplikasi Mobile TaskCampus`

Diagram menunjukkan dua arah komunikasi. Aplikasi mengirim request untuk mengambil atau mengubah data, sedangkan backend memproses request melalui database dan mengirimkan response kembali ke aplikasi.

Berkas diagram:
- `diagram.png` merupakan hasil visual diagram arsitektur.
- `diagram.mmd` merupakan sumber diagram Mermaid yang dapat diedit.

## 3. Tabel Kebutuhan Sistem

| No. | Permintaan | Pengguna | Karakteristik Mobile yang Terkait | Fitur Aplikasi | Materi Pemenuh |
|:---:|---|---|---|---|---|
| 1 | Mahasiswa dapat melihat ringkasan jumlah tugas, status pengerjaan, dan tugas dengan deadline terdekat. | Mahasiswa | **Sesi penggunaan singkat** dan **layar kecil**. Informasi utama perlu ditampilkan ringkas agar cepat diperiksa melalui layar ponsel. | Dashboard, kartu ringkasan tugas, daftar tugas terdekat, dan filter status. | Minggu 3: Struktur Flutter dan Widget; Minggu 5: UI/UX Mobile; Minggu 6: Navigasi dan Interaksi. |
| 2 | Mahasiswa dapat menambahkan tugas dengan judul, deskripsi, mata kuliah, dan tenggat pengumpulan. | Mahasiswa | **Interaksi sentuh** dan **layar kecil**. Pengisian data dilakukan melalui form dan kontrol yang sesuai untuk perangkat bergerak. | Form tambah tugas, input teks, pilihan mata kuliah, date picker, dan validasi input. | Minggu 6: Navigasi dan Interaksi; Minggu 7: Pengelolaan Data Lokal; Minggu 12: Validasi dan Keamanan Praktis. |
| 3 | Mahasiswa dapat mengelompokkan dan melihat tugas berdasarkan mata kuliah. | Mahasiswa | **Layar kecil** dan **interaksi sentuh**. Kategori dan filter membantu pengguna menemukan tugas tanpa menelusuri seluruh daftar. | Halaman mata kuliah, kategori tugas, filter, dan detail mata kuliah. | Minggu 7: Pengelolaan Data Lokal; Minggu 9: Integrasi REST API; Minggu 10: Integrasi Data dan Proses Bisnis SI. |
| 4 | Mahasiswa dapat menentukan dan memeriksa tenggat pengumpulan tugas berdasarkan tanggal. | Mahasiswa | **Konteks bergerak** dan **sesi penggunaan singkat**. Mahasiswa dapat memeriksa tenggat ketika berpindah tempat atau di sela kegiatan kampus. | Date picker, tampilan kalender, urutan tugas berdasarkan deadline, dan daftar tugas mendatang. | Minggu 5: UI/UX Mobile; Minggu 6: Navigasi dan Interaksi; Minggu 7: Pengelolaan Data Lokal. |
| 5 | Mahasiswa dapat mengubah status tugas menjadi belum dikerjakan, sedang dikerjakan, atau selesai. | Mahasiswa | **Interaksi sentuh** dan **sesi penggunaan singkat**. Perubahan status perlu dilakukan melalui kontrol sederhana dan cepat. | Tombol atau pilihan status, indikator progres, dan pembaruan data tugas. | Minggu 6: Navigasi dan Interaksi; Minggu 7: Pengelolaan Data Lokal. |
| 6 | Mahasiswa dapat menerima pengingat sebelum tenggat pengumpulan tugas. | Mahasiswa | **Konteks bergerak** dan **sesi penggunaan singkat**. Pemberitahuan perangkat membantu pengguna mengetahui deadline tanpa harus membuka aplikasi secara terus-menerus. | Notifikasi lokal, pengaturan waktu pengingat, dan informasi tugas pada notifikasi. | Minggu 11: Fitur Perangkat Sesuai Kebutuhan. |
| 7 | Mahasiswa dapat mengambil dan mengirim data tugas melalui layanan backend. | Mahasiswa | **Konektivitas terbatas**. Request perlu menggunakan pertukaran data yang ringkas serta menyediakan penanganan ketika koneksi gagal. | Integrasi REST API menggunakan HTTP request/response JSON, indikator loading, pesan kesalahan, dan aksi coba lagi. | Minggu 9: Integrasi REST API; Minggu 10: Integrasi Data dan Proses Bisnis SI. |
| 8 | Data tugas dan mata kuliah disimpan, divalidasi, serta disediakan kembali oleh layanan server. | Backend SI | Tidak terkait langsung dengan karakteristik mobile karena proses ini berlangsung pada sisi server. | **Di luar lingkup aplikasi mobile:** pengelolaan database, validasi sisi server, dan pemrosesan endpoint REST API. | Di luar lingkup implementasi aplikasi mobile; merupakan tanggung jawab Backend SI. |

## 4. Refleksi

Fitur perangkat yang paling relevan untuk TaskCampus adalah notifikasi lokal. Notifikasi dapat mengingatkan mahasiswa sebelum tenggat sehingga mereka tidak perlu terus-menerus membuka aplikasi untuk memeriksa jadwal tugas. Fitur ini sesuai dengan pola penggunaan aplikasi bergerak yang sering berlangsung singkat dan membantu mahasiswa tetap memantau kewajiban akademik ketika berpindah tempat di lingkungan kampus.

## 5. Bukti Environment Siap

**Bagian ini belum dilengkapi.** Bukti harus diambil langsung dari laptop yang digunakan untuk mengembangkan aplikasi, bukan menggunakan tangkapan layar dari contoh orang lain.

Tambahkan berkas berikut setelah pengambilan bukti:
- `flutter-doctor/sebelum.png`: tangkapan layar hasil `flutter doctor -v` sebelum perbaikan, sesuai kondisi awal yang benar-benar terjadi.
- `flutter-doctor/sesudah.png`: tangkapan layar hasil `flutter doctor -v` setelah perbaikan.
- `aplikasi.png`: tangkapan layar aplikasi Flutter Counter yang benar-benar berjalan pada web, emulator, atau perangkat fisik.

Jangan sengaja merusak konfigurasi Flutter untuk membuat tanda error. Jika bukti kondisi sebelum perbaikan belum pernah diambil, konfirmasikan kepada dosen bentuk bukti pengganti yang dapat diterima.

## Acuan Materi

Pemetaan minggu pada kolom Materi Pemenuh mengacu pada bagian **SI-VIIA — Sabtu** dalam `TIMELINE.md` repository PAB:
https://github.com/PBWFEND/PAB/blob/main/TIMELINE.md
