# Catatan Keputusan UI/UX — TaskCampus

**Sharel Faturahman · 230660221108 · SI-VIIA**

| Keputusan | Pilihan | Alasan |
|---|---|---|
| Warna benih | Teal `#087F78` melalui `ColorScheme.fromSeed` pada Material 3. | Mempertahankan identitas visual TaskCampus dari Tugas 3. Aksen tema menonjolkan tombol tambah ketika Ari membuka daftar untuk sesi pemeriksaan singkat (F-01, F-02). |
| Bentuk status | Lencana berisi label dan ikon. **Belum dimulai** memakai `surfaceContainerHighest`, **Dikerjakan** memakai `tertiaryContainer`, dan **Selesai** memakai `primaryContainer`. | Ari dapat memahami progres melalui label dan bentuk ikon selain warna. Perbedaan status terlihat langsung pada kartu daftar (F-01). |
| Posisi aksi utama | Tombol **Tambah Tugas** di kanan bawah menggunakan `FloatingActionButton.extended` dengan ikon plus dan teks. | Aksi pencatatan mudah ditemukan dan tetap terjangkau ketika daftar digulir atau masih kosong (F-02, NF-03). |
| Hierarki teks | Judul halaman paling besar. Tiap kartu mengurutkan judul tugas tebal, mata kuliah, lalu tenggat dan status dalam satu baris yang dapat membungkus. | Ari dapat memindai judul terlebih dahulu dan membaca tenggat serta status tanpa membuka halaman detail. Susunan dapat menyesuaikan lebar layar potret (F-01, NF-03). |
| Penyaring mata kuliah | Menu pilihan berlabel **Mata kuliah** berada di atas daftar, dengan **Semua mata kuliah** sebagai pilihan awal dan jumlah hasil di bawahnya. | Ari bisa mempersempit daftar dalam satu langkah dan mengetahui jumlah hasil dari mata kuliah yang dipilih (F-04). |
| Keadaan kosong | Ikon dan pesan **Belum ada tugas** muncul di tengah area daftar. Pesan menyebut mata kuliah ketika penyaring aktif. | Ari mengetahui alasan daftar kosong dan dapat mengganti penyaring atau menemukan aksi pencatatan dari layar yang sama (F-01, F-02, F-04). |
