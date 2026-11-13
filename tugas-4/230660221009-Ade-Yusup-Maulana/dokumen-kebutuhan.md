\# Tugas 4 — Dokumen Kebutuhan dan User Flow



\## Identitas



\- \*\*Nama:\*\* Ade Yusup Maulana

\- \*\*NIM:\*\* 230660221009

\- \*\*Program Studi:\*\* Sistem Informasi

\- \*\*Mata Kuliah:\*\* Pemrograman Aplikasi Bergerak

\- \*\*Domain:\*\* Sistem Informasi Penjualan dan Transaksi Warung



\## 1. Deskripsi Aplikasi



\*\*PAB — Penjualan Warung\*\* merupakan aplikasi mobile yang dirancang untuk membantu proses penjualan dan pencatatan transaksi pada warung. Permasalahan yang dihadapi adalah proses pencatatan transaksi yang masih dilakukan secara manual sehingga dapat menyebabkan kesalahan pencatatan, transaksi terlewat, dan pemilik warung kesulitan mengetahui informasi penjualan. Aplikasi mobile dipilih karena dapat digunakan secara praktis melalui smartphone sehingga pemilik atau penjaga warung dapat mencatat transaksi dan melihat informasi penjualan dengan lebih mudah saat melakukan aktivitas di warung.



\## 2. User Persona



\### Persona 1 — Pemilik Warung



| Komponen | Keterangan |

|---|---|

| \*\*Nama dan Peran\*\* | Budi — Pemilik Warung |

| \*\*Tujuan\*\* | Mengetahui dan memantau transaksi penjualan serta informasi penjualan warung dengan lebih mudah. |

| \*\*Kendala\*\* | Pencatatan transaksi secara manual dapat menyebabkan transaksi terlewat dan menyulitkan pemeriksaan kembali data penjualan. |

| \*\*Perangkat dan Konteks\*\* | Smartphone Android yang digunakan untuk memantau transaksi ketika berada di warung. |

| \*\*Frekuensi Penggunaan\*\* | Setiap hari untuk memantau transaksi dan informasi penjualan. |



\### Persona 2 — Penjaga/Kasir Warung



| Komponen | Keterangan |

|---|---|

| \*\*Nama dan Peran\*\* | Siti — Penjaga/Kasir Warung |

| \*\*Tujuan\*\* | Mencatat transaksi penjualan dengan cepat dan mengetahui produk yang tersedia ketika melayani pembeli. |

| \*\*Kendala\*\* | Saat warung ramai, pencatatan transaksi secara manual membutuhkan waktu dan berisiko menyebabkan kesalahan atau transaksi tidak tercatat. |

| \*\*Perangkat dan Konteks\*\* | Smartphone Android yang digunakan di area kasir ketika melayani transaksi pembeli. |

| \*\*Frekuensi Penggunaan\*\* | Digunakan setiap hari, terutama setiap kali terjadi transaksi penjualan. |



\## 3. Kebutuhan Fungsional



Kebutuhan fungsional menjelaskan fungsi yang harus dapat dilakukan oleh pengguna pada aplikasi PAB — Penjualan Warung.



| ID | Kebutuhan Fungsional | Aktor | Hasil yang Dapat Diverifikasi |

|---|---|---|---|

| \*\*F-01\*\* | Penjaga/kasir dapat melihat daftar produk beserta harga dan status ketersediaannya. | Penjaga/Kasir | Daftar produk, harga, dan status ketersediaan ditampilkan pada halaman produk. |

| \*\*F-02\*\* | Penjaga/kasir dapat memilih produk yang akan dimasukkan ke dalam transaksi penjualan. | Penjaga/Kasir | Produk yang dipilih masuk ke daftar transaksi. |

| \*\*F-03\*\* | Penjaga/kasir dapat menentukan jumlah produk yang dibeli pelanggan. | Penjaga/Kasir | Jumlah produk dan subtotal transaksi ditampilkan sesuai jumlah yang dipilih. |

| \*\*F-04\*\* | Penjaga/kasir dapat menyimpan transaksi penjualan yang telah selesai. | Penjaga/Kasir | Data transaksi tersimpan dan muncul pada riwayat transaksi. |

| \*\*F-05\*\* | Pemilik warung dapat melihat riwayat transaksi penjualan. | Pemilik Warung | Daftar transaksi yang telah tersimpan dapat ditampilkan kembali. |

| \*\*F-06\*\* | Pemilik warung dapat melihat ringkasan total penjualan berdasarkan transaksi yang tercatat. | Pemilik Warung | Aplikasi menampilkan total penjualan berdasarkan data transaksi yang tersimpan. |



\## 4. Kebutuhan Nonfungsional



| ID | Kategori | Kebutuhan Nonfungsional | Kriteria yang Dapat Diukur |

|---|---|---|---|

| \*\*NF-01\*\* | Kegunaan (Usability) | Aplikasi harus memiliki alur transaksi yang sederhana agar mudah digunakan oleh penjaga/kasir warung. | Proses dari memilih produk sampai menyimpan transaksi dapat diselesaikan maksimal dalam 5 langkah utama. |

| \*\*NF-02\*\* | Kinerja (Performance) | Aplikasi harus dapat menampilkan daftar produk dan riwayat transaksi dengan waktu respons yang cepat. | Daftar produk dan riwayat transaksi ditampilkan dalam waktu maksimal 3 detik pada kondisi penggunaan normal. |



\## 5. Prioritas Fitur MoSCoW



Prioritas fitur ditentukan menggunakan metode MoSCoW untuk menentukan fitur yang harus dikerjakan terlebih dahulu berdasarkan kebutuhan utama pengguna.



| ID | Kebutuhan Ringkas | Prioritas | Alasan |

|---|---|---|---|

| \*\*F-01\*\* | Melihat daftar produk, harga, dan ketersediaan | \*\*Must Have\*\* | Kasir membutuhkan informasi produk sebelum melakukan transaksi penjualan. |

| \*\*F-02\*\* | Memilih produk untuk transaksi | \*\*Must Have\*\* | Pemilihan produk merupakan bagian utama dari proses transaksi penjualan. |

| \*\*F-03\*\* | Menentukan jumlah produk yang dibeli | \*\*Must Have\*\* | Jumlah produk diperlukan untuk menentukan subtotal transaksi dengan benar. |

| \*\*F-04\*\* | Menyimpan transaksi penjualan | \*\*Must Have\*\* | Penyimpanan transaksi diperlukan agar penjualan tercatat dan dapat diperiksa kembali. |

| \*\*F-05\*\* | Melihat riwayat transaksi | \*\*Should Have\*\* | Riwayat transaksi penting untuk membantu pemilik memeriksa penjualan, tetapi proses transaksi utama tetap dapat dilakukan tanpa fitur ini pada tahap awal. |

| \*\*F-06\*\* | Melihat ringkasan total penjualan | \*\*Could Have\*\* | Ringkasan penjualan memberikan informasi tambahan bagi pemilik, tetapi dapat dikembangkan setelah fungsi transaksi utama selesai. |



\## 6. User Flow



User flow berikut menggambarkan alur utama penjaga/kasir dalam melakukan transaksi penjualan, mulai dari membuka aplikasi hingga transaksi berhasil disimpan.



```mermaid

flowchart TD

&#x20;   A(\["Mulai: Kasir membuka aplikasi"]) --> B\["Halaman Utama"]

&#x20;   B --> C\["Buka Daftar Produk"]

&#x20;   C --> D\["Pilih Produk"]

&#x20;   D --> E{"Produk tersedia?"}



&#x20;   E -- "Tidak" --> F\["Tampilkan informasi produk tidak tersedia"]

&#x20;   F --> C



&#x20;   E -- "Ya" --> G\["Masukkan jumlah produk"]

&#x20;   G --> H\["Produk masuk ke daftar transaksi"]

&#x20;   H --> I\["Periksa detail dan total transaksi"]

&#x20;   I --> J{"Data transaksi sudah benar?"}



&#x20;   J -- "Tidak" --> K\["Ubah produk atau jumlah pembelian"]

&#x20;   K --> H



&#x20;   J -- "Ya" --> L\["Simpan transaksi"]

&#x20;   L --> M\["Tampilkan konfirmasi transaksi berhasil"]

&#x20;   M --> N(\["Tujuan tercapai: Transaksi tercatat"])

```



\### Penjelasan User Flow



Alur dimulai ketika penjaga/kasir membuka aplikasi dan masuk ke halaman utama. Kasir membuka daftar produk, memilih produk, kemudian aplikasi memeriksa ketersediaan produk. Jika produk tidak tersedia, aplikasi menampilkan informasi dan pengguna kembali memilih produk. Jika tersedia, kasir memasukkan jumlah produk, memeriksa detail transaksi, dan memastikan data transaksi sudah benar. Jika terdapat kesalahan, kasir dapat mengubah produk atau jumlah pembelian, sedangkan jika data sudah benar transaksi disimpan hingga aplikasi menampilkan konfirmasi bahwa transaksi berhasil tercatat.



\## 7. Pemetaan Kebutuhan ke Antarmuka



| ID | Kebutuhan Ringkas | Prioritas | Halaman yang Memenuhi | Widget yang Direncanakan |

|---|---|---|---|---|

| \*\*F-01\*\* | Melihat daftar produk, harga, dan ketersediaan | Must Have | Halaman Daftar Produk | `Scaffold`, `ListView.builder`, `Card`, `Text` |

| \*\*F-02\*\* | Memilih produk untuk transaksi | Must Have | Halaman Daftar Produk | `ListView.builder`, `Card`, `InkWell` |

| \*\*F-03\*\* | Menentukan jumlah produk yang dibeli | Must Have | Halaman Transaksi | `Column`, `Row`, `Text`, `IconButton` |

| \*\*F-04\*\* | Menyimpan transaksi penjualan | Must Have | Halaman Transaksi | `Column`, `Row`, `ElevatedButton` |

| \*\*F-05\*\* | Melihat riwayat transaksi | Should Have | Halaman Riwayat Transaksi | `Scaffold`, `ListView.builder`, `Card`, `Text` |

| \*\*F-06\*\* | Melihat ringkasan total penjualan | Could Have | Halaman Ringkasan Penjualan | `Scaffold`, `Column`, `Card`, `Text` |



\## 8. Refleksi



Bagian yang paling sulit bagi saya adalah menentukan user flow karena setiap proses harus disusun secara berurutan dan mudah dipahami oleh pengguna. Saya juga harus memastikan setiap titik keputusan memiliki cabang berhasil dan gagal agar alur aplikasi tidak hanya menggambarkan kondisi yang berhasil. Dari tugas ini, saya menjadi lebih memahami bahwa analisis kebutuhan dan user flow perlu dibuat sebelum aplikasi dikembangkan agar fitur yang dibuat sesuai dengan kebutuhan pengguna.



\## 9. Deklarasi Penggunaan AI



Deklarasi penggunaan AI: ChatGPT digunakan untuk membantu menjelaskan struktur kebutuhan fungsional dan nonfungsional, memberikan masukan terhadap penyusunan prioritas MoSCoW, serta membantu memeriksa struktur user flow. Hasil analisis kemudian disesuaikan dan dipahami kembali oleh penulis berdasarkan domain Sistem Informasi Penjualan dan Transaksi Warung.

