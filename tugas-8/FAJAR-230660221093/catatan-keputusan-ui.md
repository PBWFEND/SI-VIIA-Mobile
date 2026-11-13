# Catatan Keputusan UI/UX — Glazent.pro

| | |
|:--|:--|
| **Nama** | Fajar |
| **NIM** | 230660221093 |
| **Kelas** | SI-VIIA |

---

| Keputusan | Pilihan Anda | Alasan (merujuk kebutuhan/persona/prinsip) |
|:----------|:-------------|:--------------------------------------------|
| Warna benih | `Colors.blue` via `ColorScheme.fromSeed` | Biru dipilih agar kesan bersih dan profesional sesuai citra usaha glass cleaning, dan karena seluruh komponen (Chip, Card, FAB) lahir dari satu benih, warna tetap konsisten di seluruh layar (prinsip **konsistensi**) tanpa perlu diatur ulang per widget |
| Bentuk status | `Chip` berwarna dengan ternary 3 kondisi (menunggu/dijadwalkan/selesai) | Merujuk keluhan Rani (Persona 1, Tugas 4) yang sering lupa status pesanannya (F-02) — status harus dapat dibedakan tanpa membaca teks secara detail, sekaligus menjadi **feedback** langsung atas progres pesanan |
| Posisi aksi utama | `FloatingActionButton.extended` di pojok kanan bawah, label "Pesan Layanan Baru" | F-01 adalah titik masuk paling sering dipakai dari layar ini; FAB dipilih alih-alih tautan teks agar target sentuh memadai (≥48dp, prinsip **target sentuh**) dan tetap terlihat tanpa menggulir, sesuai kebiasaan Rani memesan di sela waktu singkat |
| Hierarki teks | `titleLarge` untuk sapaan, `titleMedium` untuk nama layanan, `bodySmall` redup untuk tanggal | Nama layanan harus lebih menonjol daripada tanggal agar pelanggan cepat mengenali pesanan mana yang dimaksud saat menggulir daftar (prinsip **hierarki visual**) |
| Keadaan kosong | Ikon `inbox_outlined` ukuran besar + teks penjelasan dan ajakan bertindak | Pelanggan baru yang belum pernah memesan tidak boleh melihat layar putih tanpa penjelasan; ikon dan teks memakai warna `colorScheme.outline` yang tetap memiliki kontras cukup terhadap latar (prinsip **keterbacaan dan kontras**) |
