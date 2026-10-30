# Model Data MoneyTrack Mahasiswa

Model utama untuk MVP ini adalah **Transaksi**. Satu objek transaksi mewakili satu pemasukan atau pengeluaran yang dicatat mahasiswa.

## Daftar entitas dan field

| Entitas | Field | Tipe data | Sumber nilai | Kebutuhan Tugas 4 |
|---|---|---|---|---|
| Transaksi | `id` | `String` | Dibuat sistem dari waktu saat form disimpan; unik untuk setiap transaksi | F-04, F-05 sebagai kunci ubah dan hapus |
| Transaksi | `nama` | `String` | Diisi pengguna melalui form transaksi | F-02, F-03, F-04 |
| Transaksi | `jumlah` | `int` | Diisi pengguna melalui form dan divalidasi sebagai angka Rupiah positif | F-01, F-02, F-03, F-04 |
| Transaksi | `jenis` | `JenisTransaksi` (`pemasukan`/`pengeluaran`) | Dipilih pengguna melalui dropdown form | F-01, F-02, F-03, F-04 |
| Transaksi | `kategori` | `String` | Diisi pengguna, misalnya Makanan, Transportasi, atau Uang Saku | F-02, F-03, F-04; mengikuti alur “kategori tersedia” |
| Transaksi | `tanggal` | `DateTime` | Dipilih pengguna melalui date picker; data awal memakai tanggal saat ini | F-03, F-04 |
| Transaksi | `catatan` | `String?` | Opsional dari form untuk memberi keterangan tambahan | F-02, F-03, F-04 |

## Nilai turunan

`totalPemasukan`, `totalPengeluaran`, dan `saldo` tidak disimpan sebagai field terpisah. Ketiganya dihitung dari daftar `Transaksi` pada `State`, sehingga ringkasan F-01 selalu mengikuti hasil Create, Update, dan Delete.

## Hubungan dengan kebutuhan

- **F-01:** ringkasan menghitung total pemasukan, total pengeluaran, dan saldo dari state.
- **F-02:** form membuat objek `Transaksi` baru lalu menambahkannya ke state.
- **F-03:** `ListView.builder` membaca state untuk menampilkan riwayat.
- **F-04:** form edit membuat objek dengan `id` lama, lalu objek pada daftar diganti memakai `indexWhere`.
- **F-05:** tombol hapus meminta konfirmasi `AlertDialog`, kemudian menghapus dengan `removeWhere` berdasarkan `id`.

Model ini tidak membuat field admin terpisah karena F-06 berstatus *Could Have* dan belum menjadi bagian MVP pencatatan mahasiswa.
