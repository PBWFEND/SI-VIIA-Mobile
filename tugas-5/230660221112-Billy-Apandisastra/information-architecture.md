# Information Architecture: SI Perpustakaan Mobile

## 1. Inventaris Layar
Berdasarkan pemetaan kebutuhan pada Tugas 4:
*   **Halaman Katalog Buku (Layar Utama):** Memenuhi F-01 (Mencari data buku).
*   **Halaman Detail Buku (Layar Pendukung):** Memenuhi F-02 (Melihat detail) dan F-03 (Reservasi peminjaman).
*   **Halaman Riwayat Pinjam (Layar Pendukung):** Memenuhi F-04 (Melihat riwayat tenggat waktu).

## 2. Diagram IA
mermaid
flowchart TD
A[Halaman Katalog Buku / Pencarian] --> B[Halaman Detail Buku]
A --> C[Halaman Riwayat Pinjam]

## 3. Alasan Layar Utama
Halaman Katalog Buku dipilih sebagai layar utama karena secara langsung memenuhi kebutuhan *Must have* (F-01) yaitu pencarian status ketersediaan buku di rak. Halaman ini adalah titik awal (entry point) bagi anggota perpustakaan sebelum mereka dapat melakukan melihat detail, reservasi, maupun memantau riwayat.