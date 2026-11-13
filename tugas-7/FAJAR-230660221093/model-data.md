# Model Data — Glazent.pro

| | |
|:--|:--|
| **Nama** | Fajar |
| **NIM** | 230660221093 |
| **Kelas** | SI-VIIA |
| **Domain** | Usaha mikro jasa — Glazent.pro (glass cleaning & nanocoating) |

---

## 1. Daftar Entitas

Entitas diturunkan dari kebutuhan fungsional pada dokumen kebutuhan Tugas 4.

| Entitas | Kebutuhan yang Dipenuhi | Status pada Tugas 7 |
|:--------|:------------------------|:--------------------|
| **Pesanan** | F-01, F-02, F-04, F-06 | Diimplementasikan pada `crud-lokal.dart` |
| Garansi | F-03 | Belum diimplementasikan — kandidat pengembangan lanjutan |
| FotoBukti | F-05 | Belum diimplementasikan — membutuhkan fitur kamera/file (Pertemuan 11) |

Catatan: daftar tugas harian teknisi (F-04) bukan entitas terpisah, melainkan tampilan dari entitas Pesanan yang berstatus `dijadwalkan`.

## 2. Field Entitas Pesanan (`DataPesanan`)

| Field | Tipe | Kebutuhan | Sumber Nilai | Alasan Diperlukan |
|:------|:-----|:----------|:-------------|:------------------|
| `id` | `String` | F-02, F-06 | Sistem (`DateTime.now().millisecondsSinceEpoch`) | Kunci unik untuk menemukan pesanan saat diubah statusnya atau dihapus |
| `layanan` | `String` | F-01 | Form (field "Jenis Layanan") | Pelanggan menyebutkan layanan yang dipesan, misalnya cleaning kaca rumah atau nanocoating kaca shower |
| `alamat` | `String` | F-01, F-04 | Form (field "Alamat") | Teknisi perlu mengetahui lokasi pekerjaan |
| `tanggal` | `String` | F-01, F-04 | Form (field "Tanggal Layanan") | Pelanggan menyebutkan tanggal yang diinginkan; teknisi perlu mengetahui jadwal kunjungan |
| `status` | `String` | F-02, F-06 | Sistem: bernilai `menunggu` saat pesanan dibuat; berubah menjadi `dijadwalkan` lalu `selesai` melalui aksi Update | Pelanggan memantau progres pesanan; teknisi menandai pekerjaan selesai |

## 3. Penjelasan Sumber Nilai

- **Dari form** — `layanan`, `alamat`, dan `tanggal` diisi pengguna pada halaman Form Pemesanan (F-01), divalidasi tidak boleh kosong atau hanya spasi.
- **Dari sistem** — `id` dibangkitkan otomatis dari waktu saat pesanan dibuat; `status` diberi nilai awal `menunggu` oleh aplikasi, bukan diisi pengguna.
- **Dari perhitungan** — tidak ada pada entitas Pesanan. Entitas Garansi (F-03) kelak membutuhkan field hasil perhitungan (sisa masa garansi dari tanggal pengerjaan), sehingga entitas itu ditunda.
