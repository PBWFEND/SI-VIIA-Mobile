# Refleksi Tugas 10

Bagian integrasi data yang paling sulit adalah memastikan dua response yang berbeda tetap dapat dipasangkan dengan identifier userId tanpa membuat halaman bergantung pada urutan daftar. Response kosong atau error ditangani sebagai kondisi yang berbeda: data kosong diberi pesan bahwa belum ada pengajuan, sedangkan error diberi detail kegagalan dan tombol Coba Lagi. Service dipisahkan dari widget agar URL, request HTTP, timeout, parsing JSON, dan penggabungan data dapat diuji serta diubah tanpa mencampur logika bisnis ke dalam method build.

Deklarasi penggunaan AI: ChatGPT membantu menyusun draf model, service, UI, dan dokumentasi; penulis memeriksa kode, menjalankan aplikasi, dan memverifikasi hasilnya.
