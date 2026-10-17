# Dokumen Kebutuhan dan User Flow
**Nama**: Amelia Putri Latifah  
**NIM**: 230660221101  
**Domain**: Sistem Absensi Organisasi

## 1. Deskripsi Aplikasi
Aplikasi **PresenGo (Sistem Absensi Organisasi)** dirancang untuk memfasilitasi pencatatan kehadiran kegiatan keanggotaan. Masalah utama yang dihadapi pengguna pada proses bisnis saat ini adalah rentannya praktik "titip absen" menggunakan tautan web dari jarak jauh serta tingginya beban kerja pengurus dalam merekap data secara manual. Solusi ini dibangun dalam bentuk aplikasi *mobile* karena anggota membutuhkan akses presensi instan sambil bergerak (*konteks bergerak*) di lokasi acara (baik di lapangan maupun di dalam ruangan), serta memanfaatkan fitur perangkat keras ponsel seperti GPS dan kamera untuk memastikan kehadiran fisik secara valid.

## 2. User Persona

**Persona 1 — Budi — Anggota Divisi**
* **Nama dan peran**: Salwa — Anggota biasa yang berpartisipasi dalam kegiatan.
* **Tujuan**: Melakukan pencatatan kehadiran (*check-in*) kegiatan secara cepat tanpa mengantre.
* **Kendala**: Sering kesulitan mendapatkan sinyal internet yang stabil di beberapa ruang kelas atau lapangan kampus.
* **Perangkat dan konteks**: *Smartphone* Android, digunakan sambil berjalan atau berdiri sesaat sebelum kegiatan dimulai.
* **Frekuensi penggunaan**: 2-3 kali seminggu, menyesuaikan jadwal rapat atau program kerja.

**Persona 2 — Citra — Pengurus (BPH/Sekretaris)**
* **Nama dan peran**: Rizka — Sekretaris organisasi pengelola kegiatan.
* **Tujuan**: Memantau tingkat kehadiran anggota dan mendapatkan data rekap presensi instan tanpa menghitung manual.
* **Kendala**: Sibuk mengurus teknis acara sehingga tidak memiliki waktu untuk mengabsen anggota satu per satu.
* **Perangkat dan konteks**: *Smartphone* atau Tablet, digunakan pada meja panitia saat acara berlangsung.
* **Frekuensi penggunaan**: 1-2 kali seminggu setiap kali ada penyelenggaraan kegiatan resmi.

## 3. Kebutuhan Fungsional

| ID | Rumusan Kebutuhan | Terkait Persona |
| :--- | :--- | :--- |
| F-01 | Anggota dapat melihat daftar jadwal kegiatan untuk mengetahui jadwal terdekat. | Persona 1 |
| F-02 | Anggota dapat memindai *QR code* acara untuk melakukan *check-in* kehadiran fisik. | Persona 1 |
| F-03 | Anggota dapat melihat riwayat kehadiran bulanan untuk memantau tingkat keaktifan. | Persona 1 |
| F-04 | Pengurus dapat membuat jadwal kegiatan baru agar langsung tampil di beranda anggota. | Persona 2 |
| F-05 | Pengurus dapat memantau daftar hadir anggota secara seketika untuk mengukur kuota peserta. | Persona 2 |
| F-06 | Anggota dapat mengirimkan form izin ketidakhadiran untuk memberitahukan alasan absensi. | Persona 1 |

## 4. Kebutuhan Nonfungsional

| ID | Kategori | Rumusan | Kriteria Terukur |
| :--- | :--- | :--- | :--- |
| NF-01 | Kinerja | Waktu respons sistem untuk memvalidasi *QR code* harus cepat agar tidak terjadi antrean. | Proses *check-in* selesai dalam waktu maksimal 3 detik setelah pemindaian berhasil. |
| NF-02 | Kegunaan | Alur navigasi pengajuan izin ketidakhadiran harus ringkas agar pengguna tidak kebingungan. | Proses pengajuan izin selesai maksimal dalam 4 langkah klik dari halaman utama. |

## 5. Prioritas Fitur (MoSCoW)

| Prioritas | ID Kebutuhan | Alasan |
| :--- | :--- | :--- |
| Must have | F-01, F-02, F-04, F-05 | Merupakan inti dari proses bisnis absensi; tanpa fitur melihat jadwal, membuat jadwal, *check-in* *QR code*, dan memantau kehadiran, masalah "titip absen" dan rekap manual (tujuan aplikasi) tidak terpecahkan. |
| Should have | F-03 | Penting bagi anggota (Persona 1) untuk mengevaluasi diri agar tidak terkena sanksi absensi, namun sistem absen dasar tetap bisa berjalan tanpanya. |
| Could have | F-06 | Pengajuan izin bagus untuk kelengkapan administrasi, namun untuk saat ini anggota masih bisa menitipkan izin secara manual ke kontak pengurus (Persona 2). |
| Won't have (saat ini) | Fitur Ekspor Rekap Excel | Penundaan karena proses ekspor data besar lebih nyaman dan lazim dilakukan melalui *Dashboard Admin* versi Web Desktop, sehingga di luar lingkup prioritas *mobile* saat ini. |

## 6. Pemetaan Kebutuhan ke Antarmuka

| ID Kebutuhan | Rumusan (ringkas) | Prioritas | Halaman yang Memenuhi | Widget yang Direncanakan (P3) |
| :--- | :--- | :--- | :--- | :--- |
| F-01 | Melihat jadwal kegiatan | Must | Halaman Utama (Jadwal) | `Scaffold`, `Column`, `ListView.builder`, `Card`, `Row` |
| F-02 | *Check-in* via QR Code | Must | Halaman Pemindai QR | `Scaffold`, `Stack`, `Positioned`, `Align` |
| F-04 | Membuat jadwal baru | Must | Halaman Form Kegiatan | `Scaffold`, `Padding`, `Column`, `Row` |
| F-05 | Memantau daftar hadir | Must | Halaman Detail Peserta | `Scaffold`, `Column`, `ListView.builder`, `ListTile` |
| F-03 | Melihat riwayat kehadiran | Should | Halaman Profil/Riwayat | `Scaffold`, `Column`, `ListView`, `Padding` |
| F-06 | Form izin tidak hadir | Could | Halaman Pengajuan Izin | `Scaffold`, `Padding`, `Column` |

## 7. Identitas Alur User Flow
* **Nama alur**: Anggota melakukan *check-in* kehadiran kegiatan.
* **Aktor**: Salwa (Anggota Divisi).
* **Tujuan alur**: Sistem mencatat Budi telah hadir secara fisik dan tiket bukti hadir muncul di layar.