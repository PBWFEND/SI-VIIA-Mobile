# Model Data — Perpustakaan Kampus

**Nama:** Nazwa Aulia Rachma  
**NIM:** 230660221104

## Entitas dan kebutuhan

| Entitas | Field | Tipe data | Kebutuhan yang dipenuhi |
|---|---|---|---|
| `Buku` | `id` | `int` | Kunci unik untuk F-01, F-02, F-03, F-07 |
| `Buku` | `judul` | `String` | Pencarian dan detail buku — F-01, F-02 |
| `Buku` | `penulis` | `String` | Pencarian dan detail buku — F-01, F-02 |
| `Buku` | `kategori` | `String` | Penyaringan dan detail koleksi — F-01, F-02 |
| `Buku` | `status` | `String` | Status ketersediaan — F-03 dan pembaruan pustakawan — F-07 |
| `Buku` | `rak` | `String` | Lokasi fisik pada detail buku — F-02 |

## Sumber nilai

| Field | Sumber nilai | Penjelasan |
|---|---|---|
| `id` | Sistem | Dibuat oleh penghitung lokal `_nextId` dan tidak diambil dari posisi daftar, sehingga tetap unik ketika item dihapus. |
| `judul` | Form | Diisi pustakawan saat membuat atau memperbarui data buku. |
| `penulis` | Form | Diisi dari informasi bibliografi pada form tambah buku. |
| `kategori` | Form | Dipilih dari konteks koleksi pada form tambah buku. |
| `status` | Form dan aksi update | Nilai awal berasal dari form; perubahan berikutnya dipilih melalui menu ubah status. |
| `rak` | Form | Diisi berdasarkan lokasi fisik buku pada rak perpustakaan. |

## Hubungan dengan CRUD

- **Create:** form menghasilkan objek `Buku` baru dengan `id` unik.
- **Read:** `ListView.builder` membaca seluruh objek dari state `_daftarBuku`.
- **Update:** status buku diganti dengan objek baru pada posisi yang ditemukan oleh `indexWhere` berdasarkan `id`.
- **Delete:** setelah konfirmasi `AlertDialog`, `removeWhere` menghapus objek dengan `id` yang dipilih.
