# Tugas 11 — Integrasi Fitur Perangkat (Sistem Informasi Perpustakaan Kampus)

- **Nama:** Nisa Rahmawati
- **NIM:** 230660221023
- **Kelas:** SI-VIIA
- **Studi Kasus:** Sistem Informasi Perpustakaan Kampus — Fitur Unggah Dokumen Administrasi (KTM / Surat Bebas Pustaka / Bukti Denda)

## 1. Analisis Kebutuhan Fitur Perangkat

| Aspek Analisis | Keterangan |
|---|---|
| **Fitur Perangkat yang Dipilih** | **File Picker** (Akses Penyimpanan / Dokumen Perangkat) |
| **Aktor yang Menggunakan** | Mahasiswa (Anggota Perpustakaan) dan Petugas Administrasi Perpustakaan |
| **Tujuan pada Proses Bisnis** | Memungkinkan mahasiswa mengunggah berkas digital persyaratan administrasi perpustakaan (Scan KTM untuk aktivasi anggota, Surat Keterangan Bebas Pustaka untuk yudisium, atau Bukti Pembayaran Denda) langsung dari perangkat tanpa harus datang ke loket fisik. |
| **Data Keluaran Fitur** | Objek `BerkasPerpustakaanModel` yang memuat `namaFile` (`String`), `ekstensi` (`PDF/JPG/PNG`), `ukuranBytes` (`int`), `waktuDipilih` (`DateTime`), serta data biner `bytes` (`Uint8List`) untuk pratinjau dan pengiriman ke server. |
| **Permission yang Diperlukan** | - **Web (Chrome):** Menggunakan Browser File System / `<input type="file">` melalui interaksi klik langsung pengguna (tanpa manifest khusus).<br>- **Android:** `READ_EXTERNAL_STORAGE` (Android $\le$ 12) atau `READ_MEDIA_IMAGES` / Storage Access Framework (Android 13+). |
| **Target Platform Verifikasi** | Flutter Web (Google Chrome) |
| **Konsekuensi Batal / Permission Ditolak** | - **Pengguna membatalkan dialog file:** Service mengembalikan `null`; UI menutup indikator loading, mempertahankan berkas yang sebelumnya sudah terpilih (jika ada), dan menampilkan notifikasi ringan (*SnackBar*).<br>- **Permission ditolak:** Service melempar `PermissionBerkasException`; UI menampilkan kartu peringatan izin akses disertai tombol **Coba Kembali**. |

## 2. Dependency pada `pubspec.yaml`

```yaml
dependencies:
  flutter:
    sdk: flutter
  file_picker: ^8.1.2