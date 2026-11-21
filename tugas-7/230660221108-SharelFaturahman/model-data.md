# Model Data — TaskCampus

Sharel Faturahman · 230660221108 · SI-VIIA

## Entitas dan sumber nilai

Entitas utama adalah Tugas. Mata kuliah dan status memakai pilihan tetap; keduanya tidak memerlukan entitas CRUD terpisah pada MVP ini.

| Entitas | Field | Tipe Dart | Sumber nilai | Kebutuhan |
|---|---|---|---|---|
| Tugas | id | int, final | Penghitung berurutan pada State, tidak diisi pengguna | Identitas stabil untuk F-03/F-05 dan penghapusan Tugas 7 |
| Tugas | judul | String, final | Form tambah/ubah, dirapikan, 1–100 karakter | F-01/F-02 |
| Tugas | mataKuliah | String, final | Pilihan form dari daftar mata kuliah | F-01/F-02/F-04 |
| Tugas | tenggat | DateTime, final | Form DD/MM/YYYY HH:MM yang divalidasi | F-01/F-02/F-05 |
| Tugas | status | String, final | Sistem memberi Belum dimulai saat tambah; pilihan form saat ubah | F-01/F-03 |

## Aturan identitas dan konsistensi

ID awal 1 dan 2 disediakan sistem bersama data awal; ID berikutnya dimulai dari 3, bertambah hanya setelah Create berhasil, dan tidak dipakai ulang setelah Delete selama sesi yang sama. Update mempertahankan ID dengan mengganti objek menggunakan indexWhere; Delete memakai removeWhere berdasarkan ID. Filter menghasilkan tampilan turunan dan tidak mengubah identitas data asli.

Tenggat lampau diperbolehkan sesuai Tugas 4, tetapi tanggal mustahil dan jam di luar 00:00–23:59 ditolak. Kombinasi judul tanpa spasi pinggir dan tanpa membedakan kapitalisasi, mata kuliah, serta tenggat hingga menit harus unik; objek yang sedang diedit dikecualikan dari pemeriksaan duplikat.

## Cakupan kebutuhan

Create mendukung F-02, Read mendukung F-01/F-04, dan Update mendukung F-03/F-05. Koreksi judul/mata kuliah dan Delete adalah perluasan pemeliharaan catatan untuk memenuhi CRUD Tugas 7; keduanya belum dinyatakan sebagai kebutuhan tersendiri pada Tugas 4, sehingga tidak diberi ID F fiktif. Jumlah tugas dan jumlah selesai dihitung dari State sebagai ringkasan F-09; keduanya bukan field tersimpan. Seluruh tugas pada MVP ini merupakan data pribadi satu pengguna selama sesi; tidak ada pemodelan akun atau akses koordinator yang belum dibutuhkan.

## Persistensi

Data hanya disimpan di memori State tanpa package tambahan. Muat ulang halaman atau menjalankan ulang aplikasi mengembalikan dua data awal; ID unik berlaku selama satu sesi dan tidak dimaksudkan sebagai identitas lintas sesi.
