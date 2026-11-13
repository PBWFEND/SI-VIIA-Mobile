# Model Data SI-FASKAM

## 1. Entitas Data

Entitas utama yang digunakan dalam aplikasi SI-FASKAM adalah Pengaduan Fasilitas Kampus. Entitas ini digunakan untuk menyimpan informasi laporan mahasiswa mengenai fasilitas kampus yang mengalami kerusakan atau membutuhkan perbaikan.

## 2. Struktur Model Data

| No. | Field | Tipe Data | Keterangan | Sumber Nilai |
|---|---|---|---|---|
| 1 | id | String | Identitas unik setiap pengaduan | Sistem |
| 2 | kategori | String | Jenis fasilitas yang dilaporkan | Form pengguna |
| 3 | lokasi | String | Lokasi fasilitas yang bermasalah | Form pengguna |
| 4 | deskripsi | String | Penjelasan mengenai masalah fasilitas | Form pengguna |
| 5 | status | String | Kondisi proses pengaduan | Sistem |

## 3. Penjelasan Field

1. **id:** Digunakan sebagai identitas unik agar setiap pengaduan dapat dibedakan ketika dilakukan perubahan atau penghapusan data.
2. **kategori:** Digunakan untuk mengetahui jenis fasilitas yang dilaporkan mahasiswa.
3. **lokasi:** Menunjukkan tempat fasilitas yang mengalami masalah.
4. **deskripsi:** Berisi penjelasan lebih lengkap mengenai kerusakan atau masalah fasilitas.
5. **status:** Digunakan untuk mengetahui perkembangan pengaduan, yaitu Menunggu, Diproses, atau Selesai.

## 4. Keterkaitan dengan Kebutuhan Aplikasi

Model data ini mendukung kebutuhan utama SI-FASKAM, yaitu mahasiswa dapat membuat pengaduan, melihat daftar pengaduan, mengetahui status pengaduan, serta melihat detail laporan.

Data yang dimasukkan melalui formulir akan disimpan ke dalam List menggunakan StatefulWidget dan setState. Selanjutnya, data dapat dikelola melalui operasi CRUD (Create, Read, Update, Delete).

## 5. Kesimpulan

Model data Pengaduan dibuat agar informasi laporan fasilitas kampus memiliki struktur yang jelas dan konsisten. Setiap field memiliki fungsi masing-masing sehingga memudahkan proses penambahan, penampilan, perubahan, dan penghapusan data pada aplikasi SI-FASKAM.