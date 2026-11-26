# Analisis Kebutuhan Fitur Perangkat — PresenGo (Pertemuan 11)

- **Fitur Perangkat Dipilih:** Kamera & Galeri / File Gambar (`image_picker`)
- **Aktor:** Anggota / Pengurus Organisasi pada aplikasi PresenGo
- **Tujuan Proses Bisnis:** Melampirkan bukti visual kehadiran atau kondisi kegiatan organisasi secara langsung pada alur pencatatan presensi/kegiatan agar verifikasi kehadiran lebih akurat.
- **Data Keluaran:** Objek `XFile` (memuat path/URL berkas, nama file, tipe MIME, serta ukuran byte setelah validasi format dan batas 5 MB).
- **Permission & Konsekuensi:** Memerlukan izin akses kamera/galeri/media sesuai platform; jika ditolak, aplikasi menampilkan informasi izin yang jelas tanpa crash serta menyediakan tombol **Coba Lagi**; jika pengguna membatalkan (`null`), aplikasi mempertahankan lampiran yang sudah ada sebelumnya.
- **Target Platform & Batasan:** Diverifikasi menggunakan Flutter Web (`flutter run -d chrome`); akses kamera langsung pada browser web bergantung pada dukungan kamera perangkat dan izin situs di browser, sedangkan konfigurasi `AndroidManifest.xml` / `Info.plist` disesuaikan saat pengujian di perangkat Android/iOS.