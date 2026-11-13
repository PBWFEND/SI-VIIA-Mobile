# Model Data: SiLapor Kampus

ID kebutuhan (F-01 sampai F-10, NF-01 sampai NF-03) mengikuti `dokumen-kebutuhan.md` Tugas 4. Layar mengikuti `information-architecture.md` Tugas 5. Prototype ini hanya mencakup sisi mahasiswa (Dina), jadi hanya ada satu entitas yang disimpan.

## 1. Entitas dan Field

### Entitas `Laporan`

Satu laporan kerusakan fasilitas. Diimplementasikan sebagai class `Laporan` pada `crud-lokal.dart`.

| Field | Tipe | Sumber nilai | Kebutuhan yang dipenuhi |
|:------|:-----|:-------------|:------------------------|
| `id` | `String` | Sistem: `DateTime.now().millisecondsSinceEpoch` saat laporan dibuat (data contoh memakai `L-001` dan seterusnya) | Kunci untuk Update (F-06) dan Delete (F-08); tanpa id, operasi bergantung pada index yang berubah saat data dihapus |
| `kategori` | `String` | Form: pilihan Proyektor, AC, Keran, atau Kursi | F-01; juga dasar F-09 bila layar petugas dibuat kelak |
| `lokasi` | `String` | Form: isian teks | F-01; dipakai F-04 (mencari laporan serupa) dan F-07 (pencarian) |
| `deskripsi` | `String` | Form: isian teks, minimal 10 karakter | F-01; ditampilkan pada detail (F-03) |
| `tanggal` | `String` | Sistem: tanggal hari ini saat laporan dibuat | Tampilan pada daftar (wireframe Tugas 5); dasar urutan terbaru pada F-05 |
| `status` | `String` | Sistem: `Menunggu` saat dibuat. Berubah lewat dialog ubah status (simulasi petugas) | F-01 (status awal), F-03 (menampilkan status), F-06 (mengubah status), F-08 (hanya `Menunggu` yang boleh dibatalkan) |
| `fotoTerlampir` | `bool` | Form: tombol Lampirkan foto, opsional | F-02. Hanya simulasi: yang disimpan penanda ada atau tidak, bukan berkas foto |
| `catatanPenanganan` | `String` | Form dialog ubah status (simulasi petugas); kosong saat laporan dibuat | F-06 (status baru beserta catatan penanganan) |

### Nilai turunan (tidak disimpan)

| Nama | Cara menghitung | Alasan tidak disimpan |
|:-----|:----------------|:----------------------|
| `judul` | `'$kategori di $lokasi'` (getter pada class) | Selalu dapat dihitung dari dua field lain. Menyimpannya membuka peluang judul dan field asalnya berbeda |

### Nilai tetap (bukan entitas)

| Nama | Isi | Dipakai oleh |
|:-----|:----|:-------------|
| Status | Menunggu, Diproses, Selesai, Ditolak | F-03, F-06 |
| Kategori | Proyektor, AC, Keran, Kursi | F-01 |

## 2. Entitas yang Sengaja Tidak Dibuat

| Calon entitas | Alasan |
|:--------------|:-------|
| Pengguna (Dina, Pak Asep) | Tugas 4 tidak memuat kebutuhan masuk akun. NF-03 malah menuntut nama pelapor tidak tampil pada laporan milik pengguna lain, sehingga `Laporan` tidak menyimpan identitas pelapor |
| Foto sebagai berkas | Mengambil dan menyimpan foto memerlukan fitur perangkat yang dipelajari di paruh akhir semester. F-02 berprioritas Should |
| Notifikasi | F-10 berstatus Won't have pada Tugas 4 |

## 3. Peta CRUD ke Kebutuhan

| Kebutuhan | Prioritas | Operasi | Dipenuhi oleh | Keterangan |
|:----------|:----------|:--------|:--------------|:-----------|
| F-01 membuat laporan | Must | Create | `_tambah`, dari `HalamanForm` | Laporan baru berstatus Menunggu dan tampil di paling atas daftar |
| F-02 melampirkan foto | Should | Create (field `fotoTerlampir`), Read pada detail | `HalamanForm`, `HalamanDetail` | Simulasi penanda saja |
| F-03 melihat status | Must | Read | `ListView.builder` pada `HalamanUtama`, `HalamanDetail` | Membaca `_daftar` pada setiap build |
| F-04 laporan serupa | Must | Read | Filter `daftarAda` pada `_kirim`, lalu `HalamanSerupa` | Hanya laporan Menunggu atau Diproses pada lokasi yang sama |
| F-06 ubah status dan catatan | Must | Update | `_ubah` dengan `indexWhere`, dari `_DialogUbahStatus` | Disimulasikan pada perangkat mahasiswa, lihat bagian 4 |
| F-07 mencari laporan | Should | Read | Filter `hasil` pada `HalamanUtama` | Mencocokkan judul (kategori dan lokasi) serta deskripsi |
| F-08 membatalkan laporan | Could | Delete | `_hapus` dengan `removeWhere`, setelah `AlertDialog` | Tombol hanya muncul untuk status Menunggu |

## 4. Kebutuhan yang Tidak Dapat Dipenuhi CRUD Lokal

Data lokal hidup di satu perangkat dan hanya dapat dilihat oleh pemiliknya. Kebutuhan berikut menuntut data yang dipakai bersama oleh Dina dan Pak Asep, sehingga dicatat sebagai kandidat backend (Pertemuan 9 dan 10).

| Kebutuhan | Prioritas | Mengapa tidak cukup dengan data lokal |
|:----------|:----------|:--------------------------------------|
| F-05 daftar laporan masuk | Must | Laporan dari ponsel semua mahasiswa harus terkumpul di satu tempat yang dapat dibuka petugas. Layar petugas belum dibuat pada prototype |
| F-06 ubah status oleh petugas | Must | Status yang diubah petugas harus sampai ke ponsel Dina. Pada prototype, tombol "Ubah status (simulasi petugas)" hanya mengubah data di perangkat yang sama |
| F-09 saring menurut kategori | Could | Bergantung pada layar petugas, sama seperti F-05 |
| F-04 laporan serupa | Must | Pada prototype hanya mendeteksi laporan di perangkat sendiri. Mendeteksi laporan mahasiswa lain memerlukan data bersama |
