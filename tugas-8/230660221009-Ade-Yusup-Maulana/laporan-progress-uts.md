# LAPORAN PROGRESS UTS
## Pemrograman Berbasis Framework

### 1. Identitas Mahasiswa

- Nama: Ade Yusup Maulana
- NIM: 230660221009
- Program Studi: Sistem Informasi
- Kelas: SI-VIIA
- Mata Kuliah: Pemrograman Berbasis Framework

### 2. Ringkasan Eksekutif

Aplikasi Penjualan Warung merupakan aplikasi berbasis mobile yang dikembangkan menggunakan Flutter dan bahasa pemrograman Dart. Aplikasi ini dibuat untuk membantu pengelolaan data barang pada warung, meliputi nama barang, harga barang, dan jumlah stok.

Aplikasi telah memiliki fitur tambah, tampil, edit, dan hapus data barang (CRUD). Selain itu, aplikasi menggunakan SharedPreferences untuk menyimpan data secara lokal sehingga data tetap tersedia setelah halaman aplikasi di-refresh.

### 3. Capaian Milestone M1–M3

**M1 – Pengenalan dan Dasar Pengembangan Aplikasi**

- Mengenal konsep aplikasi mobile.
- Mengenal bahasa pemrograman Dart.
- Mengenal framework Flutter.
- Membuat struktur dasar proyek Flutter.

**M2 – Analisis Kebutuhan dan Perancangan**

- Menentukan kebutuhan aplikasi Penjualan Warung.
- Menentukan data yang dikelola, yaitu nama barang, harga, dan stok.
- Merancang alur penggunaan aplikasi.
- Merancang tampilan antarmuka aplikasi.

**M3 – Implementasi dan Pengelolaan Data**

- Membuat tampilan daftar barang.
- Membuat form tambah dan edit barang.
- Menerapkan validasi input.
- Menerapkan navigasi dan interaksi pengguna.
- Mengimplementasikan fitur CRUD.
- Menggunakan SharedPreferences untuk penyimpanan data lokal.

### 4. Matriks Kebutuhan dan Implementasi

| No. | Kebutuhan | Implementasi | Status |
|---|---|---|---|
| 1 | Menampilkan barang | Halaman daftar barang | Selesai |
| 2 | Menambahkan barang | Form tambah barang | Selesai |
| 3 | Mengubah data barang | Form edit barang | Selesai |
| 4 | Menghapus barang | Dialog konfirmasi hapus | Selesai |
| 5 | Validasi input | Validator pada form | Selesai |
| 6 | Penyimpanan lokal | SharedPreferences | Selesai |

### 5. Dokumentasi Screenshot

Dokumentasi aplikasi disertakan dalam folder yang sama dengan laporan ini.

1. `screenshot-daftar.png` – Tampilan daftar barang.
2. `screenshot-form.png` – Tampilan form dengan validasi input.
3. `screenshot-hapus.png` – Dialog konfirmasi penghapusan barang.

### 6. Kendala Teknis dan Solusi

**Kendala 1: TextEditingController digunakan setelah dispose**

Ketika form ditutup, terjadi error karena TextEditingController sudah dihapus tetapi masih digunakan oleh widget.

Solusi: Pengelolaan controller diperbaiki dengan menggunakan StatefulWidget pada form dan menjalankan dispose() pada lifecycle widget yang tepat.

**Kendala 2: Data barang hilang ketika aplikasi di-refresh**

Pada implementasi awal, data hanya disimpan di dalam memori aplikasi.

Solusi: Menggunakan package SharedPreferences untuk menyimpan data barang dalam penyimpanan lokal. Data kemudian dapat dimuat kembali ketika aplikasi dibuka.

### 7. Rencana Pengembangan M5 – REST API

Pada milestone berikutnya, aplikasi direncanakan dikembangkan dengan integrasi REST API agar pengelolaan data tidak hanya bergantung pada penyimpanan lokal.

Rencana pengembangan meliputi:

- Mempelajari konsep REST API.
- Menghubungkan aplikasi Flutter dengan server.
- Mengimplementasikan HTTP GET untuk mengambil data barang.
- Mengimplementasikan HTTP POST untuk menambahkan barang.
- Mengimplementasikan HTTP PUT atau PATCH untuk memperbarui barang.
- Mengimplementasikan HTTP DELETE untuk menghapus barang.
- Menguji komunikasi data antara aplikasi dan server.

### 8. Refleksi

Selama proses pengembangan aplikasi, saya memperoleh pemahaman mengenai penggunaan Flutter dan Dart dalam membangun aplikasi mobile. Saya juga mempelajari penerapan CRUD, validasi form, pengelolaan state, serta penyimpanan data lokal menggunakan SharedPreferences. Beberapa kendala teknis memberikan pengalaman dalam memahami error dan memperbaiki kode program. Pengembangan selanjutnya akan difokuskan pada integrasi REST API agar aplikasi dapat menggunakan data dari server.

### 9. Deklarasi Penggunaan AI

Dalam proses pengerjaan proyek, saya menggunakan ChatGPT sebagai alat bantu untuk memahami konsep pemrograman, menganalisis error, dan membantu memperbaiki kode program. Seluruh kode dan hasil implementasi tetap diperiksa dan diuji secara langsung oleh saya menggunakan Flutter dan Chrome.
