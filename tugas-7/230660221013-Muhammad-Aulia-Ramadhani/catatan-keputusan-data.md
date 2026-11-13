# Catatan Keputusan Data — Pemesanan Kantin Kampus

| Keputusan | Pilihan Anda | Alasan (merujuk kebutuhan) |
| :--- | :--- | :--- |
| **Field model** | Encapsulated Class `PesananKantin` dengan kalkulasi getter `totalHarga` | Memenuhi kebutuhan F-01 dan F-03 untuk menyajikan ringkasan pesanan beserta total biaya yang diperbarui secara presisi. |
| **Kunci data (`id`)** | String unik format `PESAN-<timestamp>` | Menjamin identifikasi data yang unik pada operasi `indexWhere` (Update) dan `removeWhere` (Delete) tanpa mengandalkan urutan indeks array yang dapat bergeser. |
| **Operasi CRUD per kebutuhan** | Create (Form modal), Read (ListView), Update (Penggantian objek & toggle status), Delete (Konfirmasi dialog) | Memenuhi kebutuhan F-02 (Input & Ubah kustomisasi pesanan), F-04 (Update status real-time), dan pembersihan transaksi. |
| **Keputusan persistensi** | Memory-based State Management (`List` pada `State<StatefulWidget>` dengan `setState`) | Memenuhi batasan MVP Tugas 7 tanpa dependensi eksternal, fokus pada manipulasi mutabilitas state lokal aplikasi secara reaktif. |