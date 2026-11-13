# Tugas 5: Prototype UI/UX - SI Perpustakaan

Dokumen ini berisi implementasi rancangan antarmuka (UI/UX) untuk SI Perpustakaan. Tahapan meliputi penyusunan *Information Architecture*, perancangan *wireframe*, dan penulisan kode purwarupa layar utama dengan Flutter (Material 3).

**Refleksi:**
Bagian yang paling sulit dipertahankan konsistensinya adalah bentuk dan tata letak penanda status ketersediaan antara sketsa wireframe awal dengan kode Flutter. Saat diimplementasikan, membatasi ukuran *container* status di dalam *trailing* `ListTile` agar tidak bergeser saat teks judul terlalu panjang memerlukan penyesuaian ekstra yang tidak terpikirkan saat menggambar kotak di wireframe. Hal ini menyadarkan saya bahwa desain *low-fidelity* sering kali mengabaikan kendala *overflow* pada layar perangkat nyata.

**Deklarasi penggunaan AI:** Gemini — membantu menyusun draf tabel keputusan UI, kerangka Information Architecture, dan struktur kode `Material 3` dasar; hasilnya disesuaikan dan di-review kembali oleh penulis.