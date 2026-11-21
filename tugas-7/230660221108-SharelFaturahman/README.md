# Tugas 7 — MVP Awal dengan Data Lokal

**Sharel Faturahman · 230660221108 · SI-VIIA**

TaskCampus meneruskan domain tugas akademik pada Tugas 1–6. MVP menyediakan tambah tugas, daftar dan filter mata kuliah, ubah judul/mata kuliah/tenggat/status, serta hapus dengan konfirmasi; data tersimpan selama sesi aplikasi, tanpa package tambahan.

## Berkas

| Berkas | Isi |
|---|---|
| model-data.md | Entitas, sumber nilai, aturan ID, kebutuhan dan cakupan persistensi |
| crud-lokal.dart | Kode Flutter lengkap |
| catatan-keputusan-data.md | Keputusan model, ID, CRUD, persistensi, validasi dan feedback |
| screenshot-daftar.png | Placeholder putih, menunggu screenshot Anda setelah tambah berhasil |
| screenshot-hapus.png | Placeholder putih, menunggu screenshot dialog konfirmasi hapus |

## Menjalankan melalui CMD

```cmd
cd /d "D:\KULIAH\semester 7\sharel\web_flutter"
jalankan.cmd
```

Kode aktif berada di lib/main-tugas-7.dart, dipanggil oleh lib/main.dart. Hentikan proses lama dengan q sebelum menjalankan ulang. Kode halaman web sama dengan crud-lokal.dart; data yang dimasukkan akan kembali ke dua data awal ketika aplikasi dimuat ulang.

## Mengambil bukti sendiri

1. Tekan Tambah Tugas, isi judul, pilih mata kuliah, isi tenggat seperti 18/12/2026 23:59, lalu Simpan. Ambil seluruh jendela Chrome ketika tugas baru terlihat dan ganti screenshot-daftar.png.
2. Tekan Ubah pada tugas yang dipilih, ubah isian atau status, lalu Simpan untuk menguji Update.
3. Tekan Hapus pada satu kartu; saat dialog Hapus tugas? terlihat, ambil seluruh jendela Chrome dan ganti screenshot-hapus.png.
4. Tekan Batal untuk memeriksa data tetap ada, atau Hapus pada dialog untuk menyetujui penghapusan.

Kedua PNG saat ini kosong sesuai pilihan pengguna; keduanya belum menjadi bukti CRUD. Pengujian kode tidak mengambil screenshot otomatis.

## Refleksi

Bagian paling sulit saya pertahankan konsistensinya adalah identitas tugas ketika daftar difilter karena posisi tampilan dapat berbeda dari posisi data asli. Saya memakai ID yang tetap untuk mencari objek saat Update dan Delete agar tindakan mengenai tugas yang benar. Saya juga memisahkan field tersimpan dari ringkasan yang dihitung supaya model tetap sesuai kebutuhan tanpa menggandakan data.

Deklarasi penggunaan AI: ChatGPT/Codex — membantu menyusun model, kode CRUD, dokumentasi dan pengujian; penulis perlu meninjau serta merumuskan ulang hasil bantuan sebelum pengumpulan.
