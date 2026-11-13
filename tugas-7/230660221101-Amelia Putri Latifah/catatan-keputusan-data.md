# Catatan Keputusan Data

| Keputusan | Pilihan Anda | Alasan (merujuk kebutuhan) |
| :--- | :--- | :--- |
| **Field model** | `id`, `nama`, `waktu`, `lokasi`, `status` | Seluruh *field* merepresentasikan informasi minimal yang dibutuhkan anggota untuk menemukan lokasi rapat dan mencatatkan absensi (F-01) serta form buatan pengurus (F-04). |
| **Kunci data (id)** | `String` dari `millisecondsSinceEpoch` | Menjamin setiap jadwal memiliki ID yang unik, sehingga ketika pengurus menghapus jadwal (Delete), aplikasi tidak salah menghapus jadwal lain yang memiliki nama atau jam yang sama. |
| **Operasi CRUD per kebutuhan** | C (F-04), R (F-01, F-05), U (Status Acara), D (Pembatalan Jadwal) | Setiap kebutuhan *Must Have* telah tercakup. C untuk form, R untuk daftar/detail, U untuk mengganti status kegiatan, dan D untuk membatalkan acara yang salah input. |
| **Keputusan persistensi** | In-memory lokal sementara (List pada State) | Sebagai MVP awal, data diletakkan di RAM. Pengurus tidak memerlukan penyimpanan data permanen di sisi klien karena data absensi idealnya akan langsung dihubungkan ke server *backend* (di luar cakupan T7). |