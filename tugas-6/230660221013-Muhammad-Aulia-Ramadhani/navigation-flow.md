# Navigation Flow — Kantin Kampus Mobile

### 1. Daftar Route
Seluruh route diturunkan langsung dari Information Architecture (IA) Tugas 5:

| Nama Route | Layar | Kebutuhan yang Dipenuhi | Status |
| :--- | :--- | :--- | :--- |
| `/` | `HalamanKatalogUtama` | F-01 (Katalog menu), F-03 (Akses pesanan), F-04 (Status realtime) | `initialRoute` |
| `/detail` | `HalamanDetailMenu` | F-02 (Detail porsi & input catatan pesanan khusus) | Route Biasa |
| `/riwayat` | `HalamanRiwayatPesanan` | F-05 (Melihat riwayat transaksi pesanan) | Route Biasa |

---

### 2. Diagram Navigation Flow

```mermaid
graph TD
    A["/ (Katalog Utama)"] -- "pushNamed('/detail', arguments: itemData)" --> B["/detail (Detail Menu & Form)"]
    B -- "pop() (Kembali)" --> A
    B -- "Submit Form + Validasi Success" --> C["SnackBar Feedback"]
    C -- "pop()" --> A


3. Alasan Pemilihan initialRoute
Route / (HalamanKatalogUtama) dipilih sebagai initialRoute karena memenuhi kebutuhan utama (Must have) mahasiswa (F-01 dan F-03) untuk langsung melihat ketersediaan menu kantin secara cepat saat pertama kali membuka aplikasi.