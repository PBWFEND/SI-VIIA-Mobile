# Catatan Keputusan Data

| Keputusan | Pilihan saya | Alasan yang merujuk kebutuhan |
|---|---|---|
| Field model | `id`, `nama`, `jumlah`, `jenis`, `kategori`, `tanggal`, dan `catatan` opsional pada `Transaksi` | Field langsung mendukung F-01 sampai F-05: identitas transaksi, nilai untuk ringkasan, klasifikasi, riwayat, dan informasi yang dapat diedit. |
| Kunci data (`id`) | `String` unik dari `DateTime.now().microsecondsSinceEpoch` | F-04 dan F-05 memerlukan target transaksi yang stabil; `id` mencegah operasi salah ketika urutan daftar berubah. |
| Operasi CRUD per kebutuhan | Create dari form; Read dengan `ListView.builder`; Update memakai `indexWhere`; Delete memakai `removeWhere` setelah `AlertDialog` | Pola ini membuktikan F-02, F-03, F-04, dan F-05 langsung dari antarmuka pengguna. |
| Ringkasan keuangan | Total pemasukan, total pengeluaran, dan saldo dihitung dari state | F-01 harus selalu mencerminkan data terbaru setelah setiap perubahan CRUD. |
| Sumber data awal | Tiga contoh transaksi lokal di `State` | Daftar langsung terbaca saat aplikasi dibuka sehingga alur Read dapat diuji sebelum pengguna menambah transaksi. |
| Keputusan persistensi | Belum memakai penyimpanan permanen atau package tambahan | Batas Tugas 7 meminta API bawaan Flutter dan fokus MVP; persistensi dapat ditambahkan setelah alur CRUD stabil. |
| Validasi input | Nama, kategori, jumlah positif, dan tanggal wajib diisi | Validasi menjaga transaksi yang masuk tetap dapat dihitung pada F-01 dan ditampilkan pada F-03. |
