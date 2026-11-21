# Catatan Keputusan Data — TaskCampus

Sharel Faturahman · 230660221108 · SI-VIIA

| Keputusan | Pilihan | Alasan merujuk kebutuhan |
|---|---|---|
| Field model | Tugas memiliki id, judul, mataKuliah, tenggat, status; semua final, konstruktor required dan toString tersedia. | Isi daftar F-01, pencatatan F-02, status F-03, dan tenggat F-05 mempunyai sumber yang jelas. |
| Kunci data | ID integer berurutan pada State; tidak berubah saat Update dan tidak dipakai ulang setelah Delete dalam sesi yang sama. | Update F-03/F-05 dan penghapusan tetap menyasar objek yang benar ketika daftar difilter atau diurutkan kembali. |
| Operasi CRUD per kebutuhan | Create dari form; Read ListView.builder; Update mengganti objek melalui indexWhere; Delete removeWhere berdasarkan id sesudah AlertDialog disetujui. | F-01/F-02/F-03/F-05 terpenuhi; Delete dan koreksi judul/mata kuliah merupakan perluasan Tugas 7 yang dijelaskan pada model-data.md. |
| Keputusan persistensi | List pada State, tanpa penyimpanan permanen atau package tambahan. | Memenuhi batas materi MVP lokal; data kembali ke kondisi awal setelah muat ulang dan keterbatasan ini ditampilkan pada halaman. |
| Validasi | Judul 1–100 karakter, mata kuliah dari pilihan, tenggat valid, duplikat ditolak dengan mengecualikan ID yang sedang diedit. | Menjaga aturan F-02 dan mencegah Update F-05 membentuk tugas identik. |
| Pembatalan dan feedback | Batal atau menutup dialog tidak mengubah data; setiap perubahan berhasil menampilkan SnackBar 15 detik dengan Tutup. | Pengguna memahami hasil tindakan dan dapat menyiapkan screenshot sendiri. |
