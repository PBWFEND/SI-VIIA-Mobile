# Catatan Keputusan Data

## Tugas 7 — MVP Awal dengan Data Lokal
### Aplikasi Pengelolaan Surat Masuk UKM

Dokumen ini berisi keputusan perancangan dan pengelolaan data pada aplikasi. Keputusan dibuat berdasarkan dokumen kebutuhan Tugas 4 dan melanjutkan hasil Tugas 5 (UI) serta Tugas 6 (navigasi dan form).

## 1. Tabel Keputusan Data

| Keputusan | Pilihan | Alasan berdasarkan kebutuhan |
|---|---|---|
| Field model | Model `SuratMasuk` memiliki field `id`, `judul`, `pengirim`, dan `status`; semua `final` dan `required`. | `judul` mendukung F-01 (mencatat surat). `pengirim` mendukung F-02 (asal surat diketahui). `status` mendukung F-06 dan F-07 (menandai dan melihat status pemeriksaan). Field `final` menjaga data tidak berubah tanpa disengaja. |
| Kunci data (`id`) | `String` unik yang dibuat sistem saat surat ditambahkan (`DateTime.now().microsecondsSinceEpoch`). | `id` dipakai untuk menemukan surat yang diperbarui atau dihapus, sehingga operasi tetap tepat sasaran walaupun posisi data berubah akibat penghapusan atau pencarian. Hal ini mendukung F-01, F-03, F-04, dan F-06. |
| Operasi CRUD per kebutuhan | Create untuk F-01; Read untuk F-03 dan F-04; Update untuk F-06; Delete sebagai fitur pengelolaan data tambahan. | Setiap kebutuhan Must have yang melibatkan data dipenuhi minimal satu operasi. Delete tidak berasal dari Tugas 4, tetapi diperlukan agar surat yang salah catat dapat dihapus. |
| Keputusan persistensi | Penyimpanan in-memory dengan `List<SuratMasuk>`; `shared_preferences` belum dipakai. | Sesuai batas cakupan Tugas 7, CRUD dilakukan pada List tanpa package tambahan. Data kembali ke data awal setelah aplikasi dimulai ulang. Persistensi menjadi pengembangan lanjutan. |
| Status surat | Dua pilihan: Belum diperiksa dan Sudah diperiksa. Surat baru selalu berstatus Belum diperiksa. | Sesuai Tugas 4 (F-06 dan F-07): sekretaris dapat menandai surat yang sudah diperiksa dan membedakannya dari yang belum. |
| Bentuk antarmuka | Tambah, edit, detail, dan konfirmasi hapus ditampilkan sebagai dialog pada satu halaman daftar. | Alur CRUD menjadi lebih singkat bagi pengguna dengan sesi penggunaan singkat. Navigasi antarhalaman pada Tugas 6 (`/detail`, `/form`) berfungsi sebagai prototipe alur, dan fungsinya diwujudkan sebagai dialog pada Tugas 7. |
| Hak akses | Dua peran simulasi: Pengurus (melihat dan menambah) dan Sekretaris (melihat, menambah, mengedit, menghapus, mengubah status). | Mengikuti persona Tugas 4: anggota/pengurus menyampaikan informasi surat, sedangkan sekretaris mengelola pemeriksaan surat (F-06). |
| Kebutuhan backend | Notifikasi surat baru, unggah foto atau file surat, data bersama antar perangkat, dan autentikasi peran tidak dipenuhi CRUD lokal. | Kebutuhan tersebut membutuhkan layanan di luar perangkat dan dicatat sebagai kandidat backend untuk Minggu 9–11. |

## 2. Keputusan Pengelolaan State

Data surat disimpan dalam `List<SuratMasuk>` pada `State` dari `StatefulWidget`. Setiap aksi yang mengubah data dibungkus `setState` agar tampilan sinkron dengan data.

- **Create:** form tambah surat divalidasi (judul dan pengirim wajib diisi), lalu surat baru ditambahkan ke daftar. Mendukung F-01.
- **Read:** daftar ditampilkan dengan `ListView.builder`, detail ditampilkan dalam dialog. Mendukung F-03 dan F-04.
- **Update:** posisi surat dicari dengan `indexWhere` berdasarkan `id`, lalu objek lama diganti objek baru yang memuat judul, pengirim, dan status terbaru. Mendukung F-06.
- **Delete:** surat dihapus dengan `removeWhere` berdasarkan `id` setelah pengguna menyetujui dialog konfirmasi.

## 3. Keputusan Field dan Sumber Nilai

| Field | Tipe data | Sumber nilai | Kebutuhan terkait |
|---|---|---|---|
| `id` | `String` | Dibuat sistem saat surat ditambahkan | Pendukung Update dan Delete |
| `judul` | `String` | Diisi pengguna melalui form | F-01 |
| `pengirim` | `String` | Diisi pengguna melalui form | F-02 |
| `status` | `String` | Nilai awal dari sistem; diubah Sekretaris melalui dropdown saat edit | F-06 dan F-07 |

## 4. Batasan dan Pengembangan

Data belum bertahan setelah aplikasi ditutup. Pengembangan berikutnya adalah persistensi dengan `shared_preferences` dan, pada Minggu 9–10, pengambilan data dari REST API. Dengan backend, `id` dibuat oleh database dan peran pengguna berasal dari autentikasi.

## 5. Kesimpulan

Model data dan operasi CRUD dirancang dari kebutuhan Tugas 4. Penggunaan `id` unik, `StatefulWidget`, `setState`, dan penyimpanan in-memory membuat aplikasi dapat mencatat, menampilkan, memperbarui status, dan menghapus surat secara lokal, sementara kebutuhan yang membutuhkan layanan di luar perangkat dicatat sebagai kandidat backend.