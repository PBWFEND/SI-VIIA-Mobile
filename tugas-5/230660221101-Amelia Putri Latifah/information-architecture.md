# Information Architecture (IA)

## 1. Inventaris Layar
Berikut adalah pemetaan layar berdasarkan kebutuhan fungsional (Tugas 4):
1. **Halaman Utama (Jadwal)** — Memenuhi F-01 (Melihat jadwal kegiatan).
2. **Halaman Pemindai QR** — Memenuhi F-02 (Check-in via QR Code).
3. **Halaman Riwayat Kehadiran** — Memenuhi F-03 (Melihat riwayat kehadiran).
4. **Halaman Pengajuan Izin** — Memenuhi F-06 (Form izin tidak hadir).

## 2. Diagram IA

flowchart TD
    A[Halaman Utama: Jadwal Kegiatan] --> B[Halaman Pemindai QR]
    A --> C[Halaman Riwayat Kehadiran]
    A --> D[Halaman Pengajuan Izin]