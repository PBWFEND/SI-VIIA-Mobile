# Tugas 6: Navigation Flow dan Interaksi — Kantin Kampus Mobile

**Nama:** Muhammad Aulia Ramadhani  
**NIM:** 230660221013  
**Domain SI:** Pemesanan Kantin Kampus  

---

### Deskripsi Tugas
Tugas ini mengimplementasikan alur navigasi antarhalaman (*named routes*), pengiriman data *arguments* dengan penanganan *null safety*, validasi formulir interaktif (*FormState* dan *TextEditingController*), serta umpan balik visual (*SnackBar*) pada aplikasi Pemesanan Kantin Kampus.

---

### Refleksi
Bagian yang paling sulit dipertahankan konsistensinya adalah memastikan tipe data *arguments* yang dikirim dari katalog utama selaras dengan pemeriksaan tipe dan penanganan cabang *null* di halaman detail. Selain itu, menyatukan batasan *validator* formulir dengan deskripsi pada catatan keputusan navigasi membutuhkan ketelitian ekstra agar pesan eror yang tampil tetap informatif bagi pengguna. Penyelarasan ini penting agar alur navigasi pada *diagram Mermaid* dapat tereksekusi dengan tepat pada kode Flutter tanpa menimbulkan *runtime exception*.

---

### Deklarasi Penggunaan AI
Deklarasi penggunaan AI: ChatGPT — membantu memberikan contoh sintaks validasi *FormState* dan penanganan *arguments* pada Flutter; hasilnya dirumuskan ulang oleh penulis.