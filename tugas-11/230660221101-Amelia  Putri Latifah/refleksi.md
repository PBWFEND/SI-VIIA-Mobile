# Refleksi Pembelajaran — Tugas 11 (PresenGo)

## Alasan Teknis Pemilihan Fitur
Fitur kamera/galeri (`image_picker`) dipilih untuk mendukung proses pencatatan bukti kehadiran kegiatan organisasi pada PresenGo secara ringkas dan terstandar melalui objek `XFile` dengan pembatasan ukuran/resolusi (`maxWidth`, `imageQuality`, batas 5 MB).

## Kesulitan & Penanganan Lifecycle / Permission
Membedakan nilai `null` akibat pembatalan pengguna dari kondisi `permissionDitolak` atau *exception* `image_picker` menjadi bagian penting agar pembatalan tidak dianggap kegagalan sistem dan state lampiran sebelumnya tetap terjaga.

## Deklarasi Penggunaan AI
Deklarasi penggunaan AI: Gemini — membantu menyusun struktur `FotoPresensiService`, penanganan state halaman, serta draf dokumen pengujian dan refleksi; seluruh kode dan pengujian diverifikasi langsung oleh penulis.