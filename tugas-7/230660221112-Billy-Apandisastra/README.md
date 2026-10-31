# Tugas 7: MVP Awal dengan Data Lokal - SI Perpustakaan

Proyek ini mengimplementasikan operasi CRUD (Create, Read, Update, Delete) lokal menggunakan `StatefulWidget` di Flutter. Aplikasi mengelola data "Reservasi" secara *in-memory*, di mana pengguna dapat menambah data baru, mengubah status, serta menghapus data dengan peringatan dialog.

**Refleksi:**
Bagian yang paling sulit dipertahankan konsistensinya adalah merancang struktur operasi *Update* menggunakan `indexWhere` karena field model dideklarasikan sebagai `final`. Saya harus membiasakan diri untuk tidak memodifikasi objek secara langsung, melainkan membuat *instance* objek baru dengan nilai yang diperbarui dan menyisipkannya ke indeks yang tepat di dalam list. Pembatasan ini menyadarkan saya pentingnya pendekatan *immutability* dalam pengelolaan *state* Flutter agar perubahan data terdeteksi secara aman dan dapat diprediksi.

**Deklarasi penggunaan AI:** Gemini — membantu menyusun draf tabel model data, memberikan templat kode `crud-lokal.dart` dengan operasi `setState`, serta merangkai kalimat refleksi; kode diuji dan dieksekusi ulang oleh penulis.