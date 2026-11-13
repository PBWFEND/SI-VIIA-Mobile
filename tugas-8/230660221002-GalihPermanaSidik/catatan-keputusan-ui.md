# Catatan Keputusan UI/UX: SiLapor Kampus

Persona acuan: Dina, mahasiswa pelapor yang menemukan kerusakan di sela jadwal kuliah dan hanya punya beberapa menit (NF-01), serta mengecek status laporan beberapa kali per minggu (F-03).

| Keputusan | Pilihan Anda | Alasan (merujuk kebutuhan/persona/prinsip) |
|:----------|:-------------|:--------------------------------------------|
| Warna benih | `Colors.teal` lewat `ColorScheme.fromSeed` | Teal netral dan tidak berbenturan dengan warna status. Semua warna turunan satu benih sehingga komponen serasi, dan warna hanya didefinisikan di `ThemeData` (prinsip konsistensi). |
| Bentuk status | `Chip` berwarna dari tema (tertiary, secondary, primary, error) disertai ikon pada tiap status | F-03 menuntut Dina mengenali status sekilas saat mengecek beberapa kali per minggu. Ikon membuat status tetap terbedakan tanpa membaca teks atau mengandalkan warna saja, dan teks memakai warna `on...Container` agar kontras terjaga. |
| Posisi aksi utama | `FloatingActionButton.extended` berlabel "Buat Laporan" di kanan bawah | F-01 adalah tugas utama Dina dan harus terlihat tanpa menggulir. Posisi kanan bawah terjangkau ibu jari, ukurannya melewati target sentuh 48 dp, dan menjadi awal alur yang dibatasi NF-01 (maksimal 6 langkah). |
| Hierarki teks | "Laporan Saya" `titleLarge` tebal, judul kartu `titleMedium`, lokasi dan tanggal `bodySmall` redup (`onSurfaceVariant`) | Dina mencari dulu laporan mana dan statusnya, lalu lokasi dan tanggal sebagai pelengkap. Ukuran diambil dari `textTheme` agar sama di semua layar. |
| Pencarian dan keadaan kosong | Kolom pencarian di atas daftar (F-07); dua keadaan kosong: belum ada laporan, dan tidak ada hasil cocok | Pencarian hanya muncul bila daftar tidak kosong, karena baru berguna saat laporan banyak (alasan Should have pada Tugas 4). Layar tidak pernah putih tanpa penjelasan, dan keadaan belum ada laporan mengarahkan ke F-01. |
