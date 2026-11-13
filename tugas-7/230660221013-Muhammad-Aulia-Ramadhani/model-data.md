# Model Data — Pemesanan Kantin Kampus

### 1. Daftar Entitas Data Utama
Model data ini diturunkan langsung dari dokumen kebutuhan Tugas 4 untuk mendukung entitas utama **PesananKantin**:

| Entitas | Field | Tipe Data | Kebutuhan Dipenuhi | Sumber Nilai |
| :--- | :--- | :--- | :--- | :--- |
| `PesananKantin` | `id` | `String` | F-03, F-04 | **Sistem**: Dihasilkan otomatis (`PESAN-` + timestamp) sebagai kunci unik. |
| `PesananKantin` | `namaPemesan` | `String` | F-03 | **Form**: Diinput oleh mahasiswa pemesan via formulir. |
| `PesananKantin` | `namaMenu` | `String` | F-01, F-02 | **Form**: Dipilih dari daftar katalog menu kantin. |
| `PesananKantin` | `jumlahPorsi` | `int` | F-02 | **Form**: Diinput kuantitas porsi yang ingin dibeli. |
| `PesananKantin` | `hargaSatuan` | `int` | F-01 | **Sistem**: Nilai harga default sesuai menu yang dipilih. |
| `PesananKantin` | `catatan` | `String` | F-02 | **Form**: Diinput opsional (misal: "Pedas sedang, tanpa sayur"). |
| `PesananKantin` | `status` | `String` | F-04 | **Sistem/Form**: Status awal default `"Diproses"`, dapat diubah ke `"Selesai"`. |
| `PesananKantin` | `totalHarga` | `int` | F-01, F-03 | **Perhitungan**: Diperoleh dari kalkulasi `jumlahPorsi * hargaSatuan`. |

---

### 2. Penjelasan Sumber Nilai Field
1. **`id` (Sistem):** Diperlukan sebagai pengenal unik agar operasi pengubahan (*Update*) dan penghapusan (*Delete*) data pesanan spesifik tidak keliru dengan data lain.
2. **`namaPemesan` (Form):** Diperlukan agar pengelola kantin mengenali pemilik pesanan saat makanan diantar/diambil.
3. **`namaMenu` & `hargaSatuan` (Form/Sistem):** Menentukan item kuliner yang dipesan beserta tarif dasar per porsinya.
4. **`jumlahPorsi` & `catatan` (Form):** Menampung detail porsi dan preferensi khusus mahasiswa.
5. **`totalHarga` (Perhitungan):** Kalkulasi otomatis di dalam model agar pengguna melihat kepastian biaya tanpa perlu menghitung manual.
6. **`status` (Sistem):** Menandai tahapan proses pesanan (*Diproses*, *Selesai*) untuk pemantauan *real-time*.