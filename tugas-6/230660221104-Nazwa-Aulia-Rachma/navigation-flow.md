# Navigation Flow — Perpustakaan Kampus

**Nama:** Nazwa Aulia Rachma  
**NIM:** 230660221104

## Daftar route

| Nama route | Layar | Kebutuhan yang dipenuhi | `initialRoute` |
|---|---|---|---|
| `/` | Beranda / Cari buku | F-01, F-03 | Ya |
| `/detail-buku` | Detail buku | F-02, F-03 | Tidak |
| `/konfirmasi-peminjaman` | Konfirmasi peminjaman | F-04 | Tidak |
| `/pinjaman-aktif` | Pinjaman aktif | F-05 | Tidak |

Nama layar dan kebutuhan mengikuti information architecture Tugas 5 serta pemetaan Tugas 4.

## Diagram alur navigasi

```mermaid
flowchart TD
    A[initialRoute: /\nBeranda / Cari buku] -->|tap buku + arguments Map<String,String>| B[/detail-buku\nDetail buku]
    B -->|Navigator.pushNamed\n+ arguments buku| C[/konfirmasi-peminjaman\nForm peminjaman]
    C -->|Form valid\nsubmit + SnackBar| D[/pinjaman-aktif\nPinjaman aktif]
    B -->|Navigator.pop| A
    C -->|Navigator.pop| B
    D -->|Navigator.pop| C
```

## Alasan `initialRoute`

`/` dipilih sebagai `initialRoute` karena Beranda / Cari buku memenuhi F-01 dan F-03, yaitu dua kebutuhan Must have yang menjadi awal alur peminjaman. Dari daftar tersebut pengguna dapat membuka detail, mengirim form peminjaman F-04, dan melihat hasilnya pada Pinjaman aktif F-05.

## Data antarlayar

- Beranda mengirim satu objek buku berupa `Map<String, String>` melalui `arguments` ke `/detail-buku`.
- Detail meneruskan objek buku yang sama ke `/konfirmasi-peminjaman`.
- Detail dan form memeriksa tipe arguments dengan `is` serta menyediakan cabang null ketika data tidak tersedia.
- Tombol kembali memakai `Navigator.pop` agar pengguna kembali ke layar sebelumnya.
