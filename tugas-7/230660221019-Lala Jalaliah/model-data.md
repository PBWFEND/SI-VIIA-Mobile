# Model Data — Pengelolaan Surat Masuk UKM

Dokumen ini menjelaskan model data aplikasi Pengelolaan Surat Masuk UKM pada Tugas 7. Seluruh field diturunkan dari dokumen kebutuhan Tugas 4.

## 1. Daftar Entitas

Aplikasi memiliki satu entitas utama, yaitu **SuratMasuk**. Entitas ini menyimpan informasi satu surat yang dicatat oleh Pengurus UKM dan dikelola oleh Sekretaris UKM.

| Entitas | Field | Tipe Data | Kebutuhan yang Dipenuhi | Sumber Nilai |
|---|---|---|---|---|
| SuratMasuk | `id` | `String` | Pendukung operasi Update dan Delete (F-06 dan pengelolaan data F-01, F-03, F-04) | Sistem |
| SuratMasuk | `judul` | `String` | F-01 — mencatat informasi surat masuk | Form |
| SuratMasuk | `pengirim` | `String` | F-02 — mengisi informasi pengirim surat | Form |
| SuratMasuk | `status` | `String` | F-06 — menandai surat sudah diperiksa; F-07 — melihat status pemeriksaan | Sistem (nilai awal) dan pilihan Sekretaris (saat edit) |

Semua field bersifat `final` dan diwajibkan (`required`) pada konstruktor, sehingga objek surat selalu lengkap dan perubahan data dilakukan dengan membuat objek baru. Model juga memiliki `toString` untuk keperluan pemeriksaan data.

## 2. Alasan Field dan Sumber Nilai

1. **`id`** — diperlukan sebagai identitas unik setiap surat. Nilainya dibuat sistem dengan `DateTime.now().microsecondsSinceEpoch.toString()` saat surat ditambahkan. `id` dipakai sebagai kunci operasi Update (`indexWhere`) dan Delete (`removeWhere`), bukan index daftar, agar operasi tetap mengenai surat yang tepat meskipun posisi data berubah akibat penghapusan atau pencarian.
2. **`judul`** — diperlukan agar surat dapat dikenali dan dicari (F-01, F-05). Nilainya diisi pengguna melalui form tambah atau edit dan wajib diisi.
3. **`pengirim`** — diperlukan agar asal surat diketahui (F-02). Nilainya diisi pengguna melalui form dan wajib diisi.
4. **`status`** — diperlukan agar sekretaris dapat membedakan surat yang sudah dan belum diperiksa (F-06, F-07). Nilai awal surat baru selalu **Belum diperiksa**, ditetapkan sistem. Sekretaris dapat mengubahnya melalui dropdown saat edit. Pilihan status: Belum diperiksa dan Sudah diperiksa, sesuai Tugas 4.

## 3. Keterkaitan Kebutuhan Must have dengan CRUD

| Kebutuhan (Tugas 4) | Prioritas | Operasi CRUD | Keterangan implementasi |
|---|---|---|---|
| F-01 Mencatat informasi surat masuk | Must | Create | Dialog tambah surat; data valid ditambahkan ke `List<SuratMasuk>` dengan `setState` |
| F-03 Melihat daftar surat masuk | Must | Read | `ListView.builder` membaca state |
| F-04 Melihat detail surat | Must | Read | Dialog detail surat |
| F-06 Menandai surat sudah diperiksa | Must | Update | Dialog edit (khusus Sekretaris); objek lama diganti objek baru berdasarkan `id` |

Pendukung lain: F-02 dipenuhi oleh field `pengirim` pada Create dan Update, F-05 oleh pencarian judul atau pengirim pada daftar, F-07 oleh tampilan status pada daftar dan dialog detail untuk semua peran, dan F-08 oleh akses Pengurus ke daftar dan detail. Operasi **Delete** (dengan dialog konfirmasi) adalah fitur pengelolaan data tambahan di luar kebutuhan Tugas 4.

## 4. Kebutuhan yang Tidak Dapat Dipenuhi CRUD Lokal (Kandidat Backend)

| Kebutuhan | Alasan tidak dapat dipenuhi lokal | Rencana |
|---|---|---|
| Surat yang dicatat anggota dapat dilihat sekretaris di perangkat lain | Data lokal hanya ada di satu perangkat | Backend dan database terpusat (Minggu 9–10) |
| Mengunggah file atau foto surat | CRUD lokal hanya menyimpan teks | Penyimpanan file pada backend (Minggu 9–11) |
| Notifikasi saat ada surat baru | Memerlukan layanan yang mengirim pesan antar perangkat | Layanan notifikasi (Minggu 11) |
| Peran pengguna yang sebenarnya | Peran saat ini hanya simulasi dropdown | Autentikasi pengguna pada backend |
| `id` yang unik secara global | `id` lokal hanya unik di satu perangkat | `id` dibuat oleh database backend |

## 5. Perubahan dari Tugas Sebelumnya

| Aspek | Tugas 4–6 | Tugas 7 | Alasan |
|---|---|---|---|
| Bentuk data | `Map<String, String>` | Model `SuratMasuk` dengan `id` | CRUD memerlukan identitas unik dan bentuk data yang seragam |
| Penyimpanan | Data statis di kode | `List<SuratMasuk>` pada `State` | Data dibuat, diubah, dan dihapus oleh pengguna |

## 6. Batasan

Data disimpan dalam memori (`List<SuratMasuk>`) sesuai batas cakupan Tugas 7, sehingga data kembali ke data awal ketika aplikasi dimulai ulang. Persistensi dengan `shared_preferences` menjadi pengembangan lanjutan.