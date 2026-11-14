# Catatan Keputusan Navigasi — Kantin Kampus Mobile

| Keputusan | Pilihan Anda | Alasan (merujuk IA/kebutuhan) |
| :--- | :--- | :--- |
| **Nama route** | `/` dan `/detail` | Menyediakan penamaan terstruktur yang ringkas dan memisahkan alur ringkasan katalog utama (F-01) dengan formulir aksi transaksi spesifik (F-02). |
| **Data antarlayar** | `Map<String, dynamic>` dikirim via `arguments` pada `pushNamed` | Mentransfer identitas, nama, kategori, dan harga menu secara efisien tanpa memerlukan state management eksternal. |
| **Validator tiap field** | Porsi Wajib angka > 0; Catatan opsional maks 100 karakter | Mencegah input kuantitas bernilai invalid/kosong dan membatasi ukuran teks catatan agar efisien dibaca pihak dapur kantin. |
| **Feedback tiap aksi** | `SnackBar` melayang (*floating*) berwarna hijau + tombol kembali otomatis | Memberikan konfirmasi visual langsung (*affordance*) bahwa pesanan telah diterima sistem sebelum pengguna kembali ke halaman utama. |