# Tugas 6: Navigation Flow dan Interaksi - SI Perpustakaan

Proyek ini mengimplementasikan alur navigasi aplikasi SI Perpustakaan menggunakan Named Routes di Flutter. Aplikasi ini mencakup perpindahan data antarlayar (arguments), pengelolaan form input dengan `GlobalKey`, validasi isian, dan pemberian umpan balik (*feedback*) menggunakan `SnackBar`.

**Refleksi:**
Bagian yang paling sulit dipertahankan konsistensinya adalah merancang pengiriman data antarlayar antara bagan *navigation flow* dengan implementasi kode teknisnya. Saat menggambar diagram, alur pengiriman data terlihat sangat sederhana, namun pada saat pengodean, saya harus menambahkan blok pemeriksaan tipe data dan penanganan variabel null agar aplikasi tidak mengalami *crash*. Tingkat presisi yang berbeda ini memaksa saya untuk bolak-balik menyinkronkan diagram konseptual dengan batasan teknis yang ada pada Flutter.

**Deklarasi penggunaan AI:** Gemini — membantu menyusun struktur file, draf tabel navigasi dan diagram alur Mermaid, serta menyediakan fondasi koding untuk form dan validasi; hasilnya dirumuskan ulang dan dipelajari oleh penulis.