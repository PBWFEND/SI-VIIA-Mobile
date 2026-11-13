# Tugas 7: MVP Awal dengan Data Lokal — Pemesanan Kantin Kampus Mobile

**Nama:** Muhammad Aulia Ramadhani  
**NIM:** 230660221013  
**Kelas:** SI-VIIA-Mobile  
**Domain SI:** Pemesanan Kantin Kampus  

---

### Deskripsi Tugas
Tugas ini mengimplementasikan MVP (Minimum Viable Product) awal berbasis data lokal menggunakan Flutter StatefulWidget. Aplikasi mendukung operasi CRUD lengkap (Create, Read, Update, Delete) pada entitas `PesananKantin` yang terhubung secara reaktif dengan antarmuka pengguna melalui pemanggilan `setState`.

---

### Refleksi
Bagian yang paling sulit dipertahankan konsistensinya adalah memastikan bahwa kunci unik `id` terhubung secara tepat pada logika pencarian `indexWhere` saat pembaruan data dan `removeWhere` saat penghapusan data. Selain itu, menyelaraskan tipe data pada model `PesananKantin` dengan field input form serta perhitungan otomatis `totalHarga` memerlukan penanganan state yang cermat. Kedisiplinan ini sangat krusial agar manipulasi data pada daftar lokal selalu merefleksikan perubahan antarmuka secara konsisten tanpa menimbulkan kebingungan data.

---

### Deklarasi Penggunaan AI
Deklarasi penggunaan AI: ChatGPT — membantu memberikan kerangka dasar manajemen state `List` pada `StatefulWidget` serta contoh sintaks `showModalBottomSheet`; hasilnya disesuaikan dan dirumuskan ulang secara mandiri oleh penulis.