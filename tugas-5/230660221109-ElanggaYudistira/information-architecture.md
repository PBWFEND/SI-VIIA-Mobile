# Information Architecture - MoneyTrack Mahasiswa

## Inventaris Layar

| ID Layar | Nama Layar | Kebutuhan |
|---|---|---|
| L-01 | Dashboard Keuangan | F-01 |
| L-02 | Tambah Transaksi | F-02 |
| L-03 | Riwayat Transaksi | F-03 |
| L-04 | Detail Transaksi | F-04, F-05 |

## Diagram IA

```mermaid
flowchart TD
A[MoneyTrack Mahasiswa]
A --> B[Dashboard Keuangan - F-01]
A --> C[Tambah Transaksi - F-02]
A --> D[Riwayat Transaksi - F-03]
D --> E[Detail Transaksi - F-04 F-05]
```

## Alasan Layar Utama

Dashboard Keuangan dipilih sebagai layar utama karena memenuhi kebutuhan Must Have yaitu melihat kondisi keuangan dan menjadi pusat aktivitas pengguna.
