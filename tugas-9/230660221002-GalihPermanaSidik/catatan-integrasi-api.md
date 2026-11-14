# Catatan Integrasi API: Tugas 9

Backend SiLapor Kampus belum ada. Rencana endpoint sebenarnya tertulis pada `laporan-progress-uts.md` (bagian 6), sedangkan tugas ini memakai endpoint simulasi JSONPlaceholder pada jalur `/posts`. Semua alamat dan jalur disimpan di satu tempat (`LaporanService` pada `service-api.dart`), sehingga berpindah ke backend sungguhan cukup mengganti host, jalur, dan pemetaan field.

## 1. Endpoint yang Digunakan

| Operasi | Metode HTTP | URL Endpoint | Payload Request |
|:--------|:-----------|:-------------|:----------------|
| Ambil daftar | GET | `https://jsonplaceholder.typicode.com/posts?_limit=10` | Tidak ada body. Query `_limit=10` membatasi 10 data |
| Kirim data baru | POST | `https://jsonplaceholder.typicode.com/posts` | `{"title": "AC di Gedung B, R. 204", "body": "AC bocor dan meneteskan air.", "userId": 1, "status": "Menunggu"}` dengan header `Content-Type: application/json; charset=UTF-8` |

Bentuk response yang diharapkan:

- GET, status `200`: array JSON, tiap elemen berbentuk `{"userId": 1, "id": 1, "title": "...", "body": "..."}`.
- POST, status `201`: objek JSON berisi field yang dikirim ditambah `id` baru dari server. JSONPlaceholder hanya menyimulasikan penyimpanan, jadi data tidak benar-benar tersimpan dan tidak muncul pada GET berikutnya.

Pemetaan ke laporan SiLapor: `title` adalah judul laporan (`"<kategori> di <lokasi>"`, sama dengan getter `judul` pada model Tugas 7), `body` adalah deskripsi kerusakan, dan `userId` bernilai tetap 1 sebagai pengganti identitas pelapor sampai autentikasi dibahas pada Pertemuan 12.

## 2. Struktur Model Data

Model `Laporan` pada `service-api.dart`:

| Field | Tipe Dart | Key JSON | Sumber Nilai |
|:------|:----------|:---------|:-------------|
| `id` | `int` | `"id"` | Server. Nilai pengganti `0` bila tidak ada |
| `judul` | `String` | `"title"` | Server pada GET. Pada POST dibentuk aplikasi dari kategori dan lokasi (form). Nilai pengganti `'Tanpa judul'` |
| `deskripsi` | `String` | `"body"` | Form pada POST, server pada GET. Nilai pengganti `'-'` |
| `status` | `String` | `"status"` | Server bila ada. JSONPlaceholder tidak punya field ini, sehingga aplikasi memakai `'Menunggu'`, status awal pada F-01 |

Semua field memakai pola `json['key'] as Tipe? ?? nilaiPengganti`, jadi response yang tidak lengkap tidak membuat aplikasi error.

Class `LaporanBaru` (kategori, lokasi, deskripsi) adalah data yang dikirim lewat POST dan memiliki `toJson()`. Class ini tidak punya `id` karena `id` dibuat server.

Perbedaan dengan model Tugas 7:

| Aspek | Tugas 7 (data lokal) | Tugas 9 (API) | Alasan |
|:------|:---------------------|:--------------|:-------|
| `id` | `String` dari waktu saat ini | `int` dari server | Server menjadi pemberi id agar unik lintas pengguna |
| Kategori dan lokasi | Dua field terpisah | Digabung ke `judul` | Kontrak simulasi hanya memiliki `title` dan `body`. Field terpisah menunggu backend SiLapor |
| `tanggal`, `fotoTerlampir`, `catatanPenanganan` | Ada | Belum ada | Tidak tersedia pada endpoint simulasi |

## 3. Penanganan Error

Semua pemanggilan HTTP lewat satu helper, `_jalankan`, yang memasang timeout 10 detik dan blok `try-catch`. Helper itu mengubah setiap jenis kegagalan menjadi `ApiException` dengan pesan berbahasa Indonesia. Halaman cukup menangkap satu tipe error dan menampilkan `pesan`-nya, tanpa perlu mengenali `TimeoutException`, `ClientException`, dan seterusnya.

| Kondisi | Cara menangkap | Pesan untuk pengguna |
|:--------|:---------------|:---------------------|
| Server tidak membalas dalam 10 detik | `.timeout(...)` memunculkan `TimeoutException` | Waktu tunggu habis. Periksa jaringan Anda, lalu coba lagi. |
| Tidak ada internet atau alamat tidak terjangkau | `http.ClientException` | Tidak dapat terhubung ke server. Pastikan perangkat terhubung ke internet. |
| Status 400 | Pemeriksaan `statusCode` | Permintaan tidak valid (400). Periksa data yang dikirim. |
| Status 404 | Pemeriksaan `statusCode` | Data laporan tidak ditemukan di server (404). Periksa alamat endpoint. |
| Status 5xx | Pemeriksaan `statusCode` | Server sedang bermasalah (kode ...). Coba lagi beberapa saat lagi. |
| Status lain (bukan 200 pada GET, bukan 201 pada POST) | Pemeriksaan `statusCode` | Server mengembalikan kode yang tidak diharapkan: ... |
| Isi response bukan JSON yang valid | `FormatException` dari `jsonDecode` | Data dari server tidak dapat dibaca (format JSON tidak valid). |
| JSON valid tetapi bentuknya salah (bukan list pada GET, bukan objek pada POST) | Pemeriksaan `is` | Format data dari server tidak sesuai. |
| Kegagalan lain yang tidak terduga | `catch (e)` | Terjadi kegagalan yang tidak terduga, disertai teks error |

Yang tampil di layar:

- **GET gagal:** ikon dan pesan error pada tengah halaman, beserta tombol **Coba Lagi** yang memanggil ulang GET. Pengguna tidak ditinggalkan di layar kosong.
- **POST gagal:** `SnackBar` berisi pesan error. Form tidak dikosongkan dan tombol kirim aktif kembali, sehingga mahasiswa tidak perlu mengetik ulang.

Kegagalan koneksi ditangkap sebagai `http.ClientException`, bukan `SocketException`, karena `dart:io` tidak tersedia di DartPad maupun target web. Pada target web, package `http` melaporkan kegagalan koneksi sebagai `ClientException`.

## 4. Keputusan Teknis

| Keputusan | Pilihan | Alasan |
|:----------|:--------|:-------|
| Lokasi kode HTTP | Hanya di `LaporanService`, tanpa `http.get` atau `http.post` di widget | Halaman fokus pada tampilan, dan alamat serta parsing tidak perlu ditulis ulang bila halaman lain butuh data yang sama |
| Tiga kondisi daftar | Flag `_memuat` dan `_pesanError` pada `State` | Memberi kendali manual untuk tombol Coba Lagi dan `RefreshIndicator`. Setiap `setState` setelah `await` didahului pengecekan `mounted` |
| Tombol kirim | `onPressed: null` selama POST berjalan, disertai indikator dan teks "Mengirim..." | POST tidak idempoten. Dua penekanan beruntun bisa membuat dua laporan ganda, padahal F-04 justru dibuat untuk mencegah laporan ganda |
| Data setelah POST | Laporan balasan server ditambahkan ke daftar, daftar tidak dimuat ulang | JSONPlaceholder tidak menyimpan data, sehingga muat ulang akan menghilangkan laporan yang baru dikirim. Dengan backend sungguhan, daftar dimuat ulang |
| Jumlah data | 10 data lewat `_limit=10` | Pagination di luar cakupan pertemuan ini |

## 5. Kaitan dengan Kebutuhan dan Cara Memicu Tiga Kondisi

| Kebutuhan | Dipenuhi oleh | Status |
|:----------|:--------------|:-------|
| F-03 melihat laporan | GET daftar | Tampil. Status berasal dari default aplikasi karena endpoint simulasi tidak punya status |
| F-01 membuat laporan | POST dari form | Terkirim ke server simulasi |
| F-02, F-04, F-06, F-08 | Belum dihubungkan ke API | Menunggu backend SiLapor dan integrasi pada pertemuan berikutnya |

Memicu tiga kondisi untuk tangkapan layar:

- **Loading:** ubah `jedaSimulasiDetik` pada `LaporanService` menjadi 3, jalankan, lalu tangkap layar saat indikator berputar. Kembalikan ke 0 setelahnya.
- **Sukses:** biarkan `jedaSimulasiDetik` 0, tunggu daftar muncul.
- **Error:** ubah `_endpoint` menjadi `'/postsx'` (server membalas 404), jalankan ulang, dan tangkap layar pesan error. Kembalikan ke `'/posts'` setelahnya.
