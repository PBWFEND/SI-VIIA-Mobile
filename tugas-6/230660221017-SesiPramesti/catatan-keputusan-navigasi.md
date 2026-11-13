# Catatan Keputusan Navigasi — SI-FASKAM

## 1. Identitas Aplikasi

- **Nama Aplikasi:** SI-FASKAM
- **Nama Sistem:** Sistem Informasi Pengaduan Fasilitas Kampus
- **Aktor:** Mahasiswa
- **Tujuan:** Memudahkan mahasiswa dalam menyampaikan pengaduan terkait fasilitas kampus serta melihat informasi pengaduan.

## 2. Keputusan Navigasi

### A. Penamaan Route

Aplikasi menggunakan named route agar perpindahan antarhalaman lebih terstruktur dan mudah dikelola.

Route yang digunakan:

| Route | Halaman |
|---|---|
| `/` | Beranda / Daftar Pengaduan |
| `/form` | Formulir Pengaduan |
| `/konfirmasi` | Konfirmasi Pengaduan |
| `/detail` | Detail Pengaduan |

Penggunaan named route dipilih agar setiap halaman memiliki alamat navigasi yang jelas dan konsisten.

### B. Penentuan Initial Route

Halaman Beranda (`/`) dipilih sebagai initial route karena merupakan halaman pertama yang diakses mahasiswa ketika membuka aplikasi.

Pada halaman ini, mahasiswa dapat melihat daftar pengaduan yang tersedia, mencari pengaduan, serta memulai proses pembuatan pengaduan baru.

### C. Pengiriman Data Antarhalaman

Pengiriman data antarhalaman menggunakan mekanisme `arguments` pada Navigator.

Data pengaduan dikirim dari halaman Formulir menuju halaman Konfirmasi dan diteruskan ke halaman Detail.

Data yang dikirim meliputi informasi pengaduan seperti ID, kategori, deskripsi, tanggal, dan status sesuai model data yang digunakan dalam aplikasi.

Pemeriksaan tipe data dilakukan menggunakan operator `is` untuk memastikan bahwa data yang diterima sesuai dengan tipe model pengaduan. Jika data tidak sesuai atau bernilai null, aplikasi menampilkan pesan bahwa data pengaduan tidak tersedia.

### D. Penggunaan Navigator.pushNamed dan Navigator.pop

`Navigator.pushNamed()` digunakan untuk membuka halaman baru, seperti ketika mahasiswa memilih tombol Buat Pengaduan atau melihat detail pengaduan.

`Navigator.pop()` digunakan untuk kembali ke halaman sebelumnya. Pada proses pengiriman pengaduan, hasil pengaduan dapat dikembalikan ke halaman sebelumnya agar data dapat ditampilkan pada daftar pengaduan.

### E. Validasi Formulir

Validasi dilakukan menggunakan `Form` dan `GlobalKey<FormState>`.

Setiap kolom input memiliki validator untuk memastikan data yang dimasukkan tidak kosong dan sesuai dengan ketentuan.

Validasi diperlukan agar mahasiswa tidak dapat mengirim pengaduan dengan informasi yang belum lengkap.

### F. Pengelolaan TextEditingController

`TextEditingController` digunakan untuk mengambil dan mengelola isi input pada formulir.

Controller diakhiri masa penggunaannya melalui method `dispose()` ketika halaman tidak lagi digunakan. Hal ini dilakukan untuk menghindari penggunaan resource yang tidak diperlukan.

### G. Feedback kepada Pengguna

Aplikasi menggunakan `SnackBar` untuk memberikan informasi kepada mahasiswa setelah melakukan tindakan tertentu, seperti ketika pengaduan berhasil ditambahkan atau ketika data formulir belum lengkap.

Feedback dipilih karena mudah dipahami dan dapat memberikan informasi tanpa harus membuka halaman tambahan.

## 3. Alur Navigasi Utama

1. Mahasiswa membuka aplikasi dan masuk ke halaman Beranda.
2. Mahasiswa memilih tombol Buat Pengaduan.
3. Aplikasi menampilkan halaman Formulir Pengaduan.
4. Mahasiswa mengisi kategori, lokasi, dan deskripsi pengaduan sesuai komponen formulir yang tersedia.
5. Aplikasi melakukan validasi terhadap data yang dimasukkan.
6. Jika data valid, aplikasi menampilkan halaman Konfirmasi Pengaduan.
7. Mahasiswa dapat melihat detail pengaduan.
8. Mahasiswa dapat kembali ke halaman sebelumnya menggunakan tombol Kembali.

## 4. Kesimpulan

Keputusan navigasi pada SI-FASKAM dibuat untuk menghasilkan alur penggunaan aplikasi yang sederhana, terstruktur, dan mudah dipahami mahasiswa. Penggunaan named route, pengiriman data melalui arguments, validasi formulir, serta feedback melalui SnackBar membantu memastikan interaksi antarhalaman berjalan dengan baik.