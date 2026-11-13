# Jawaban Tes Konsep UTS — Pemrograman Aplikasi Bergerak

**Nama:** Nisa Rahmawati  
**NIM:** 230660221023  
**Kelas:** SI-VIIA  
**Domain SI:** Sistem Informasi Perpustakaan Kampus  

---

### Soal 1 — Konsep Aplikasi Bergerak dalam SI (CPMK-1)
Keunggulan aplikasi mobile perpustakaan kampus dibanding web desktop:
1. **Akses Kapan Saja (Ubiquitous Access):** Perangkat mobile selalu dibawa mahasiswa, memungkinkan pengecekan stok buku langsung di kelas.
2. **Integrasi Perangkat (Kamera/Scanner):** Dapat memindai barcode ISBN buku fisik secara langsung menggunakan kamera HP.
3. **Notifikasi Real-time:** Pengiriman notifikasi push pengingat pengembalian buku agar mahasiswa tidak terlambat.

---

### Soal 2 — Dasar Pemrograman Dart (CPMK-1)
* `List<String>`: Koleksi dinamis penampung elemen teks.
* `isEmpty`: Properti boolean untuk memeriksa apakah string bernilai kosong.
* `return`: Menghentikan eksekusi fungsi jika data tidak valid.
* `add`: Method menambahkan elemen baru ke dalam List.
* **Risiko Penghapusan `isEmpty`:** String kosong akan lolos tersimpan, menyebabkan antarmuka merender baris kosong tanpa informasi.

---

### Soal 3 — Struktur Flutter dan Widget (CPMK-1)
* `MaterialApp`: Root penyedia tema visual Material Design.
* `Scaffold`: Kerangka struktur layar (`AppBar`, `Body`, `BottomNavigationBar`).
* `ListView.builder`: Merender daftar item secara efisien (*lazy loading*).
* **Solusi Unbounded Height:** Membungkus `ListView.builder` di dalam `Expanded` jika berada di dalam `Column`.

---

### Soal 4 — Analisis Kebutuhan dan User Flow (CPMK-2)
* **Must:** Menambah buku baru dan melihat status ketersediaan.
* **Should:** Mengubah data buku dan menerima notifikasi pengembalian.
* **User Flow:** Buka App -> Lihat Katalog -> Klik Tambah -> Isi Form -> Simpan -> Feedback SnackBar -> Daftar Terbarui.

---

### Soal 5 — UI/UX Mobile & Web (CPMK-2)
1. **Thumb Zone & Navigasi Bar:** Menempatkan `BottomNavigationBar` dengan 3 ikon akses cepat di bagian bawah layar.
2. **Visual Hierarchy:** Judul buku dicetak tebal dengan penanda warna badge status yang kontras.

---

### Soal 6 — Navigasi dan Interaksi (CPMK-2)
Menggunakan `IndexedStack` untuk berpindah antartab navigasi utama serta komponen `showModalBottomSheet` & `AlertDialog`.

---

### Soal 7 — Model Data dan State (CPMK-3)
Immutability (`final`) mencegah manipulasi data yang tidak sengaja. `StatefulWidget` digunakan karena `List<Buku>` mengalami pembaruan dinamis yang membutuhkan pemanggilan `setState()`.

---

### Soal 8 — CRUD Lokal (CPMK-3)
* **Create:** `list.insert(0, data)`
* **Read:** `ListView.builder`
* **Update:** `list[index] = dataBaru`
* **Delete:** `list.removeWhere((e) => e.id == id)`  
*ID unik digunakan sebagai acuan agar tidak terjadi kesalahan hapus item akibat pergeseran indeks.*

---

### Soal 9 — Persistensi Data Lokal (CPMK-3)
* **In-Memory:** Disimpan di RAM, hilang saat aplikasi ditutup.
* **Persistensi (`shared_preferences`):** Disimpan ke media penyimpanan fisik HP/browser secara asinkron (`await`).

---

### Soal 10 — Integrasi Konsep Lintas Pertemuan (CPMK-1 s.d. CPMK-3)
Arsitektur 4-layer: Layer UI (Widget) -> Layer State (`setState`) -> Model Data (`Buku`) -> Layer Storage (In-Memory/API). Alur data mengalir secara reaktif dari form input menuju penambahan item pada list state utama.