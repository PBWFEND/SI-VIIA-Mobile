# Catatan Keputusan Navigasi

| Keputusan | Pilihan Anda | Alasan (merujuk IA/kebutuhan) |
| :--- | :--- | :--- |
| **Nama route** | Format path web (contoh: `/`, `/detail`, `/reservasi`) | Mudah diingat, standar untuk pemetaan route di Flutter (sesuai materi navigasi deklaratif), dan konsisten dengan tata letak Information Architecture. |
| **Data antarlayar** | `Map<String, String>` dari Katalog ke Detail | Memanfaatkan argumen agar layar detail tidak perlu memuat ulang data (menjaga kinerja NF-01) karena informasinya sudah ada di daftar katalog. |
| **Validator tiap field** | Wajib diisi (tidak null/kosong) & batas karakter NIM | Memastikan data peminjam (F-03) yang diserahkan ke pustakawan (Budi) valid sehingga tidak memperlambat pelayanan di meja administrasi. |
| **Feedback tiap aksi** | `SnackBar` setelah form *submit* | Memberi kepastian *real-time* kepada pengguna bahwa reservasi diproses sistem tanpa menutupi layar seperti *Dialog*, lalu mereset posisi secara mulus (pop). |