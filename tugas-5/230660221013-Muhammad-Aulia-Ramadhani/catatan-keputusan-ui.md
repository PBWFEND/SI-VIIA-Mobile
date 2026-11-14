# Catatan Keputusan UI/UX — Kantin Kampus Mobile

Berikut adalah alasan pemilihan elemen desain berdasarkan karakteristik kebutuhan, persona mahasiswa, dan panduan Material Design 3:

| Keputusan | Pilihan Anda | Alasan (merujuk kebutuhan/persona/prinsip) |
| :--- | :--- | :--- |
| **Warna benih (Seed Color)** | `Colors.orange` | Mencerminkan identitas aplikasi kuliner/kantin yang meningkatkan preferensi visual makanan, serta memberikan kontras tinggi pada layar perangkat bergerak sesuai persona mahasiswa. |
| **Bentuk status** | Container berujung membulat (*Pill shape*) dengan variasi warna *Ternary* tema (`tertiaryContainer` & `errorContainer`) | Memudahkan mahasiswa mengenali status ketersediaan menu secara eksplisit dalam sesi penggunaan singkat tanpa memicu eror pemesanan menu yang habis. |
| **Posisi aksi utama** | `FloatingActionButton.extended` di pojok kanan bawah | Mengikuti pola keterjangkauan ibu jari (*thumb zone*) pada perangkat mobile saat konteks bergerak, sehingga aksi utama "Buat Pesanan" cepat diakses. |
| **Hierarki teks** | Pemisahan tegas antara `titleMedium` (Bold untuk nama menu) dan `bodyMedium` (Muted untuk kategori & harga) | Mempercepat *scannability* pengguna saat membaca daftar menu yang panjang pada layar ponsel berukuran terbatas. |