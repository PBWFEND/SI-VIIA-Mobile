# TES KONSEP UTS — MILESTONE M4

**Nama:** Ade Yusup Maulana  
**NIM:** 230660221009  
**Kelas:** SI-VIIA  
**Mata Kuliah:** Pemrograman Berbasis Framework

---

## Petunjuk Pengerjaan

Jawablah 10 pertanyaan esai sesuai pemahaman sendiri berdasarkan materi Pertemuan 1–7.

**Catatan:** Jawaban harus dikerjakan secara mandiri tanpa bantuan AI, browser, catatan, atau referensi lain selama pengerjaan tes, sesuai ketentuan UTS.

---

## Daftar Pertanyaan

### 1. Konsep Aplikasi Mobile

Aplikasi mobile adalah aplikasi yang bisa dipakai lewat perangkat seperti HP atau tablet untuk membantu aktivitas penggunanya. Karena bisa dibawa ke mana-mana, aplikasi ini bisa diakses kapan saja dan di mana saja. Aplikasi mobile juga biasanya memakai fitur bawaan perangkat, seperti kamera, GPS, dan notifikasi, jadi penggunaannya lebih praktis.

Dari cara pembuatannya, aplikasi mobile ada tiga jenis. Pertama, aplikasi native, yaitu aplikasi yang dibuat khusus untuk satu platform, misalnya Android atau iOS, sehingga performanya lebih bagus. Kedua, aplikasi berbasis web, yaitu aplikasi yang dibuka lewat browser tanpa harus diinstal. Ketiga, aplikasi hybrid atau cross-platform, yaitu aplikasi yang dibuat dengan satu kode program tapi bisa jalan di beberapa platform, contohnya Flutter dan React Native.

### 2. Bahasa Pemrograman Dart

Dart adalah bahasa pemrograman yang dipakai Flutter untuk membuat aplikasi. Bahasa ini dibuat oleh Google dan cara penulisan kodenya mirip Java atau JavaScript, jadi lebih gampang dipelajari kalau sudah pernah belajar pemrograman. Dengan Dart, kita bisa bikin aplikasi mobile, web, dan desktop dari satu kode program.

Dart juga punya fitur hot reload, jadi kalau ada perubahan kode, hasilnya langsung kelihatan di aplikasi tanpa harus dijalankan ulang dari awal. Hal ini bikin proses pembuatan aplikasi jadi lebih cepat.

### 3. Flutter dan Widget

Flutter adalah framework buatan Google yang dipakai untuk membuat aplikasi, baik mobile, web, maupun desktop, dari satu kode program. Bahasa pemrogramannya pakai Dart.

Di Flutter, semua yang muncul di layar disebut widget. Widget ini komponen penyusun tampilan aplikasi, misalnya teks (Text), tombol (ElevatedButton), gambar (Image), dan tata letak seperti Row dan Column. Widget bisa disusun bertingkat, jadi satu widget bisa berisi widget lain sampai membentuk satu halaman utuh.

Widget ada dua jenis, yaitu StatelessWidget untuk tampilan yang tidak berubah, dan StatefulWidget untuk tampilan yang bisa berubah, misalnya angka pada counter yang bertambah saat tombol ditekan.

### 4. Struktur Project Flutter

Struktur project Flutter adalah susunan folder dan file yang dipakai untuk mengatur kode, tampilan, dan kebutuhan aplikasi supaya lebih rapi dan gampang dikelola. Pas bikin project baru, Flutter otomatis membuatkan struktur ini.

Beberapa folder dan file yang utama:

lib/: tempat menulis kode program. Di dalamnya ada main.dart sebagai file utama yang pertama kali dijalankan.
android/ dan ios/: berisi pengaturan khusus untuk menjalankan aplikasi di Android dan iOS.
assets/: tempat menyimpan gambar, font, atau file pendukung lain (folder ini dibuat sendiri kalau dibutuhkan).
test/: tempat menulis kode untuk menguji aplikasi.
pubspec.yaml: file pengaturan project, misalnya untuk menambah package, gambar, dan font.

Jadi, dengan struktur yang rapi, kita lebih mudah mencari file, menambah fitur, dan mengatur isi aplikasi.

### 5. Analisis Kebutuhan Pengguna

Analisis kebutuhan pengguna adalah proses mencari tahu apa saja yang dibutuhkan pengguna sebelum aplikasi dibuat. Tujuannya supaya aplikasi yang dibuat benar-benar sesuai dengan kebutuhan pengguna dan tidak ada fitur yang terlewat atau malah tidak terpakai.

Cara mengumpulkan kebutuhan ini bisa lewat beberapa metode, misalnya wawancara, kuesioner, observasi langsung, dan melihat sistem atau aplikasi yang sudah ada. Dari hasil itu, kebutuhan dibagi jadi dua, yaitu kebutuhan fungsional (fitur apa saja yang harus ada, misalnya login atau cetak laporan) dan kebutuhan non-fungsional (hal pendukung seperti tampilan yang mudah dipakai, aplikasi cepat, dan data aman).

Jadi, dengan analisis kebutuhan yang baik, pengembangan aplikasi bisa lebih terarah dan hasil akhirnya lebih bermanfaat buat penggunanya.

### 6. User Flow

User flow adalah urutan langkah yang dilakukan pengguna saat memakai aplikasi, mulai dari pertama kali membuka aplikasi sampai tujuannya tercapai. Biasanya digambarkan dalam bentuk diagram alur supaya gampang dilihat dan dipahami.

Fungsi user flow adalah membantu kita membayangkan bagaimana pengguna berpindah dari satu halaman ke halaman lain, jadi alur aplikasi bisa dibuat lebih jelas dan tidak membingungkan. Dengan begitu, kalau ada langkah yang terlalu panjang atau ribet, bisa diperbaiki sebelum aplikasi dibuat.

Jadi, user flow penting dibuat di tahap perancangan supaya aplikasi lebih mudah dipakai dan sesuai dengan kebiasaan penggunanya.

### 7. UI/UX

UI (User Interface) adalah hal yang berkaitan dengan tampilan aplikasi, seperti warna, tombol, ikon, jenis huruf, dan tata letak halaman. Sementara UX (User Experience) adalah pengalaman yang dirasakan pengguna saat memakai aplikasi, misalnya apakah aplikasinya gampang dipakai, alurnya jelas, dan nyaman dari awal sampai selesai.

Keduanya saling berhubungan. UI yang bagus tapi alurnya membingungkan tetap bikin pengguna kesulitan, begitu juga sebaliknya. Jadi, aplikasi yang baik itu tampilannya menarik (UI) dan juga enak dipakai (UX).

### 8. Navigasi dan Interaksi

Navigasi adalah cara mengatur perpindahan dari satu halaman ke halaman lain di dalam aplikasi, misalnya lewat menu, tombol, atau tab di bagian bawah layar. Di Flutter, perpindahan halaman biasanya memakai Navigator.push() untuk pindah ke halaman baru dan Navigator.pop() untuk kembali ke halaman sebelumnya.

Sementara interaksi adalah respons aplikasi terhadap tindakan yang dilakukan pengguna, misalnya saat menekan tombol, mengisi form, atau menggeser layar. Contohnya, ketika tombol ditekan, aplikasi bisa menampilkan pesan, mengubah angka, atau membuka halaman lain.

Keduanya sama-sama penting karena navigasi yang jelas bikin pengguna tidak tersesat, dan interaksi yang responsif bikin aplikasi terasa nyaman dipakai.

### 9. Pengelolaan Data Lokal

Pengelolaan data lokal adalah proses menyimpan dan mengelola data langsung di perangkat pengguna, jadi data tetap bisa dipakai walaupun tidak ada koneksi internet. Data ini tersimpan di HP dan tidak perlu diambil dari server setiap kali aplikasi dibuka.

Di Flutter, ada beberapa cara yang biasa dipakai. shared_preferences dipakai untuk data kecil dan sederhana, misalnya pengaturan tema atau status login. SQLite (lewat package sqflite) dipakai untuk data yang lebih banyak dan terstruktur dalam bentuk tabel, seperti daftar catatan atau data pasien. Selain itu ada juga penyimpanan berbentuk file untuk menyimpan data seperti gambar atau dokumen.

Kelebihannya, aplikasi jadi lebih cepat dibuka dan bisa dipakai secara offline. Kekurangannya, data hanya ada di satu perangkat, jadi kalau aplikasinya dihapus atau HP hilang, data bisa ikut hilang kalau tidak ada cadangan.

### 10. CRUD dan Persistence

CRUD adalah empat operasi dasar dalam mengelola data, yaitu Create (menambah data baru), Read (menampilkan atau membaca data), Update (mengubah data yang sudah ada), dan Delete (menghapus data). Contohnya di aplikasi catatan: bikin catatan baru itu Create, melihat daftar catatan itu Read, mengedit isi catatan itu Update, dan menghapus catatan itu Delete.

Sementara persistence adalah kemampuan aplikasi untuk menyimpan data secara permanen, jadi data tidak hilang waktu aplikasi ditutup atau HP dimatikan. Kalau tidak ada persistence, data cuma tersimpan sementara di memori dan hilang begitu aplikasi ditutup. Di Flutter, persistence biasanya dibuat pakai shared_preferences atau SQLite (sqflite).

Jadi, CRUD mengatur apa yang bisa dilakukan terhadap data, sedangkan persistence memastikan hasilnya tetap tersimpan.