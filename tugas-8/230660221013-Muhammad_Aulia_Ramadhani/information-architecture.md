# Information Architecture (IA) — Kantin Kampus Mobile

### 1. Inventaris Layar
Setiap layar diturunkan langsung dari tabel pemetaan kebutuhan Tugas 4:

* **Layar 1: Katalog Menu & Pesanan Aktif (Layar Utama)**
  * **ID Kebutuhan:** F-01 (Melihat katalog menu makanan & minuman), F-03 (Membuat pesanan baru), F-04 (Memantau status pesanan aktif).
* **Layar 2: Detail Menu & Tambah Catatan (Layar Pendukung)**
  * **ID Kebutuhan:** F-02 (Melihat detail porsi, varian, dan input catatan pesanan khusus).
* **Layar 3: Riwayat Pesanan & Bukti Transaksi (Layar Pendukung)**
  * **ID Kebutuhan:** F-05 (Melihat riwayat transaksi yang pernah dilakukan).
* **Layar 4: Pengaturan Profil & Favorit Lokal (Layar Pendukung)**
  * **ID Kebutuhan:** F-06 (Mengelola menu favorit tersimpan secara lokal).

---

### 2. Diagram Information Architecture

```mermaid
graph TD
    A[Layar 1: Katalog Menu & Pesanan Aktif - Layar Utama] --> B[Layar 2: Detail Menu & Catatan]
    A --> C[Layar 3: Riwayat Pesanan & Bukti Transaksi]
    A --> D[Layar 4: Pengaturan Profil & Favorit]



3. Alasan Pemilihan Layar Utama

Layar Katalog Menu & Pesanan Aktif dipilih sebagai layar utama karena memenuhi kebutuhan Must have paling krusial (F-01 dan F-03), yaitu memungkinkan mahasiswa melihat ketersediaan menu secara cepat dan langsung melakukan transaksi pemesanan pada sesi penggunaan yang singkat saat jam istirahat kuliah.

