\# Model Data — SiRuang Kampus



\*\*Nama:\*\* Dede Dian Permana  

\*\*NIM:\*\* 230660221010  

\*\*Kelas:\*\* SI-VIIA  

\*\*Domain:\*\* Sistem Informasi Peminjaman Ruang Kelas



\## 1. Entitas Peminjaman



Entitas Peminjaman digunakan untuk menyimpan informasi pengajuan penggunaan ruangan oleh mahasiswa. Data ini menjadi dasar untuk menampilkan daftar peminjaman, melakukan perubahan data, dan menghapus pengajuan pada aplikasi SiRuang Kampus.



| Field | Tipe Data | Kebutuhan yang Dipenuhi | Sumber Nilai |

|---|---|---|---|

| id | String | F-03, F-04, F-05 | Dibuat oleh sistem sebagai identitas unik setiap peminjaman. |

| namaRuangan | String | F-01, F-03 | Dipilih pengguna dari daftar ruangan. |

| kategori | String | F-01 | Diambil dari data ruangan yang tersedia pada sistem. |

| tanggal | String | F-03 | Diisi pengguna melalui formulir peminjaman. |

| waktu | String | F-03 | Diisi pengguna melalui formulir peminjaman. |

| tujuan | String | F-03 | Diisi pengguna untuk menjelaskan alasan peminjaman. |

| status | String | F-04, F-05 | Ditentukan oleh sistem dengan nilai awal Menunggu. |



\## 2. Hubungan Field dengan Kebutuhan



Model data Peminjaman disusun berdasarkan dokumen kebutuhan Tugas 4. Field namaRuangan dan kategori mendukung informasi ruangan pada F-01. Field tanggal, waktu, dan tujuan digunakan untuk memenuhi proses pengajuan peminjaman pada F-03.



Field id digunakan sebagai identitas unik agar setiap data dapat diperbarui dan dihapus dengan tepat. Field status digunakan untuk mendukung kebutuhan F-04 dan F-05 dalam menampilkan kondisi pengajuan peminjaman.



\## 3. Sumber Nilai Data



Sumber nilai data dibagi menjadi tiga kategori. Pertama, nilai yang berasal dari pengguna, yaitu nama ruangan, tanggal, waktu, dan tujuan yang dimasukkan melalui formulir. Kedua, nilai yang berasal dari sistem, yaitu id unik dan status awal peminjaman. Ketiga, kategori ruangan berasal dari data ruangan yang telah disediakan oleh aplikasi.



\## 4. Pengelolaan Data



Data peminjaman dikelola sementara menggunakan List pada State aplikasi Flutter. Operasi Create dilakukan dengan menambahkan objek baru, Read dilakukan dengan menampilkan isi List, Update dilakukan dengan mengganti objek berdasarkan id, dan Delete dilakukan dengan menghapus objek berdasarkan id setelah pengguna memberikan konfirmasi.

