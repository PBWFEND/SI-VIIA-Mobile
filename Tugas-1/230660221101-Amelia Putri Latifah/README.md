# Tugas 1: Identifikasi Kebutuhan Aplikasi Bergerak
Nama: Amelia Putri Latifah
NPM: 230660221101
Domain Sistem: Sistem Absensi Organisasi

# 2.1 Deskripsi Kegiatan
Sistem Absensi Organisasi ditunjukan untuk anggota organisasi sebagai pengguna utama dan pengurus (Badan Pengurus Harian atau Anggota Departemen) sebagai pengguna lain. Masalah nyata pada proses bisnis saat ini adalah presensi kegiatan yang sering kali menggunakan kertas fisik atau form daring, yang rentan terhadap manipulasi "titip absen" serta merepotkan pengurus saat harus merekap data kehadiran secara manual setelah acara selesai. Solusi ini diwujudkan dalam bentuk aplikasi *mobile* karena sangat sesuai dengan karakteristik **konteks bergerak**, di mana kegiatan organisasi sering diadakan di berbagai lokasi berbeda (baik *indoor* maupun *outdoor*) sehingga anggota memiliki mobilitas tinggi, serta karakteristik **sesi penggunaan singkat**, yang memungkinkan anggota membuka aplikasi hanya dalam hitungan detik untuk melakukan *check-in* kehadiran instan tanpa mengganggu jalannya kegiatan.

# 2.2 Diagram Arsitektur
*(Catatan: File ekspor diagram arsitektur berupa PNG dan MMD terlampir di folder tugas).*

# 2.3 Tabel Kebutuhan

| No. | Permintaan | Pengguna | Karakteristik Mobile yang Terkait | Fitur Aplikasi | Materi Pemenuh |
|---|---|---|---|---|---|
| 1 | Melihat jadwal kegiatan dan rapat organisasi terdekat | Anggota | **Layar kecil**: Informasi jadwal harus ditampilkan dengan padat, ringkas, dan mudah di-*scroll*. | Halaman Daftar Kegiatan (List & Card UI) | UI/UX & Navigasi (Minggu 3-4) |
| 2 | Melakukan konfirmasi kehadiran (*check-in*) pada saat acara | Anggota | **Sesi penggunaan singkat**: Pengguna butuh aksi cepat dengan satu sentuhan tanpa mengisi form panjang. | Tombol *Check-in* Cepat / Form Presensi | REST API & Validasi (Minggu 5-6) |
| 3 | Melihat riwayat persentase kehadiran bulanan meski kuota habis | Anggota | **Konektivitas terbatas**: Harus bisa melihat histori data absensi terakhir saat sedang *offline*. | Halaman Riwayat Kehadiran (SQLite / *Local Storage*) | Data Lokal (Minggu 7-8) |
| 4 | Mendapatkan pengingat 1 jam sebelum jadwal kegiatan dimulai | Anggota | **Konteks bergerak**: Butuh distraksi positif agar tidak lupa saat beraktivitas di tempat lain. | Fitur *Push Notification* Lokal | Fitur Perangkat (Minggu 11-12) |
| 5 | Memvalidasi kehadiran otomatis berdasarkan titik koordinat acara | Anggota | **Variasi perangkat**: Menggunakan sensor perangkat bawaan untuk mengambil *geotagging*. | Fitur Deteksi Lokasi (GPS) / *Geofencing* | Fitur Perangkat (Minggu 11-12) |
| 6 | Mengelola data master anggota dan mengekspor rekap absensi ke Excel | Pengurus | *Tidak relevan untuk tugas aplikasi mobile mahasiswa* | **Di luar lingkup (backend SI / Web Admin Dashboard)** | *Di luar lingkup mobile* |

# 2.5 Refleksi
Fitur perangkat yang paling relevan untuk domain Sistem Absensi Organisasi ini adalah layanan lokasi (GPS). Fitur ini digunakan untuk memvalidasi koordinat *check-in* pengguna, sehingga sistem dapat memastikan bahwa anggota benar-benar berada secara fisik di titik lokasi kegiatan yang telah ditentukan pengurus. Penerapan validasi lokasi ini sangat efektif untuk mencegah praktik kecurangan seperti "titip absen" dari jarak jauh yang selama ini menjadi kelemahan utama pada sistem presensi berbasis tautan web.