# Quiz Pertemuan 11
Soal 1 — Pemilihan Fitur
Pemilihan fitur perangkat dilakukan dengan memetakan kebutuhan nyata pada alur proses bisnis dan masalah utama pengguna, lalu menilai apakah fitur tersebut benar-benar mendukung validasi data atau efisiensi alur kerja tanpa menambah beban yang tidak perlu.

Contoh fitur pada PresenGo: Kamera (pengambilan foto bukti kehadiran/kegiatan atau lampiran dokumentasi langsung di lokasi kegiatan).

Alasan teknis & proses bisnis: Pada proses pencatatan kehadiran atau pengajuan/pelaporan kegiatan organisasi di PresenGo, bukti visual langsung di lapangan membantu memverifikasi bahwa pengurus atau anggota benar-benar hadir dan melaksanakan kegiatan pada sesi terkait, sekaligus mempercepat alur pelaporan tanpa harus keluar aplikasi untuk mengambil foto lalu mengunggahnya secara manual.

Soal 2 — Permission
Fitur perangkat memerlukan permission karena akses ke perangkat keras atau data sistem (seperti kamera, galeri/file, lokasi, atau notifikasi) menyangkut keamanan sistem operasi dan privasi pengguna. Sistem operasi mengisolasi akses tersebut sehingga aplikasi tidak dapat membaca atau mengendalikan perangkat secara sembarang tanpa persetujuan eksplisit pengguna dan konfigurasi izin aplikasi.

Kondisi yang harus ditangani aplikasi:

Permission diminta / belum ditentukan (denied / awal): Aplikasi memicu permintaan izin secara terarah dan menampilkan informasi jelas mengapa izin dibutuhkan sebelum atau saat fitur dijalankan, tanpa menghentikan aplikasi secara kasar.

Permission ditolak (denied atau permanentlyDenied / diblokir): Aplikasi menangani penolakan dengan graceful degradation—menampilkan pesan yang mudah dipahami, menonaktifkan atau mengarahkan ulang tindakan fitur perangkat tersebut, serta menyediakan panduan atau tombol menuju pengaturan sistem apabila izin ditolak permanen.

Permission atau fitur tidak tersedia (unavailable / perangkat tidak mendukung): Aplikasi menangkap kondisi perangkat tanpa modul/sensor atau kebijakan sistem yang memblokirnya, lalu memberi tahu pengguna secara jelas dan menjaga bagian lain aplikasi tetap dapat digunakan.

Soal 3 — Pembatalan Pemilihan
Nilai XFile? yang bernilai null ketika pengguna memilih atau mengambil gambar berarti operasi pemilihan/pengambilan berkas dibatalkan oleh pengguna (misalnya menekan tombol back atau membatalkan dialog kamera/galeri) sehingga tidak ada berkas yang dihasilkan atau dikembalikan ke aplikasi.

Cara aplikasi merespons kondisi tersebut:

Aplikasi memeriksa apakah hasil XFile? bernilai null sebelum mengakses properti berkas (path, name, atau readAsBytes()) agar tidak terjadi null check error.

Jika bernilai null, aplikasi memperlakukannya sebagai pembatalan normal (bukan error sistem), mempertahankan data/foto yang sudah ada sebelumnya jika ada, dan menampilkan umpan balik ringan (seperti pesan informasi singkat bahwa pemilihan foto dibatalkan) bila diperlukan.

Soal 4 — Service Layer
Tanggung jawab service layer pada fitur perangkat:

Membungkus pemanggilan package atau plugin perangkat (misalnya kamera atau file/image picker), menangani pengecekan status/permintaan permission, menangkap exception atau error platform/plugin, menormalisasi hasil menjadi objek/model atau status yang bersih, dan menyajikannya ke lapisan UI.

Mengapa pemanggilan package dan pengelolaan permission sebaiknya tidak ditulis langsung di widget:

Menjaga pemisahan tanggung jawab (separation of concerns): widget tetap ringkas dan berfokus merender tampilan serta merespons interaksi pengguna, sementara detail teknis plugin, permission, dan error handling terpusat di satu tempat.

Memudahkan perawatan dan pengujian: jika package diganti, perilaku permission diperbarui, atau fitur dipakai di lebih dari satu halaman PresenGo, perubahan cukup dilakukan di service layer tanpa mengubah banyak widget dan tanpa menumpuk logika asinkron di dalam method build.

Soal 5 — State Fitur Perangkat
State minimal yang perlu dikelola pada fitur perangkat meliputi:

Memproses / Sedang berjalan (_sedangMemproses / loading): saat aplikasi sedang meminta izin atau menunggu hasil dari kamera/perangkat.

Berhasil (misalnya _fileTerpilih != null / data fitur berhasil diperoleh): saat berkas atau data perangkat berhasil diambil dan siap digunakan.

Dibatalkan (hasil null tanpa error): saat pengguna membatalkan pemilihan/pengambilan sebelum selesai.

Permission ditolak / Tidak tersedia (_pesanStatus / flag izin): saat akses perangkat tidak diizinkan atau tidak didukung perangkat.

Error teknis (_pesanError): saat terjadi kegagalan sistem atau exception pada pemanggilan fitur perangkat.

Perbedaan perlakuan untuk kondisi berhasil, dibatalkan, dan permission ditolak:

Berhasil: Menyimpan hasil ke state (misalnya pratinjau foto kehadiran pada PresenGo), membersihkan pesan error/status sebelumnya, dan mengaktifkan alur lanjutan (seperti menyimpan atau melampirkan bukti kehadiran).

Dibatalkan: Tidak memunculkan peringatan kegagalan atau error merah; membiarkan state tetap aman (tetap mempertahankan hasil sebelumnya bila sudah ada) dan cukup memberi informasi bahwa pemilihan dibatalkan.

Permission ditolak: Menghentikan akses ke perangkat secara aman, menampilkan penjelasan mengapa izin dibutuhkan agar fitur dapat berjalan, serta memberikan opsi untuk mencoba kembali atau membuka pengaturan perangkat (bila ditolak permanen) tanpa membuat aplikasi crash.